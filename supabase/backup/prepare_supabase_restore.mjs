#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";

const backupFileName = "db_cluster-05-12-2025@15-14-28.backup";
const backupPath = path.resolve(process.cwd(), "supabase", "backup", backupFileName);
const outputDir = path.resolve(process.cwd(), "supabase", "backup", "restore");

if (!fs.existsSync(backupPath)) {
  console.error(`Backup not found: ${backupPath}`);
  process.exit(1);
}

fs.mkdirSync(outputDir, { recursive: true });

const src = fs.readFileSync(backupPath, "utf8");
const lines = src.split(/\r?\n/);

const allowedSchemas = new Set(["public", "auth", "storage", "realtime", "supabase_migrations"]);
const deniedSchemaPrefixes = [
  "pg_catalog.",
  "information_schema.",
  "pg_toast.",
  "extensions.",
  "vault."
];

const denyStatement = [
  /^CREATE ROLE\b/i,
  /^ALTER ROLE\b/i,
  /^DROP ROLE\b/i,
  /^CREATE DATABASE\b/i,
  /^ALTER DATABASE\b/i,
  /^DROP DATABASE\b/i,
  /^ALTER DEFAULT PRIVILEGES\b/i,
  /^GRANT\b/i,
  /^REVOKE\b/i,
  /^SET SESSION AUTHORIZATION\b/i,
  /^RESET SESSION AUTHORIZATION\b/i,
  /^ALTER .* OWNER TO\b/i,
  /^COMMENT ON ROLE\b/i,
  /^CREATE EXTENSION\b/i,
  /^COMMENT ON EXTENSION\b/i
];

function hasDeniedSchemaReference(sql) {
  return deniedSchemaPrefixes.some((prefix) => sql.includes(prefix));
}

function statementHasAllowedSchema(sql) {
  return Array.from(allowedSchemas).some(
    (schema) =>
      sql.includes(` ${schema}.`) ||
      sql.includes(` "${schema}".`) ||
      sql.includes(` SCHEMA ${schema}`) ||
      sql.includes(` SCHEMA "${schema}"`)
  );
}

function shouldKeepStatement(sqlRaw) {
  const sql = sqlRaw.trim();
  if (!sql) return false;

  const decisionSql = sql
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0 && !line.startsWith("--"))
    .join("\n");

  if (!decisionSql) return false;
  if (/^\\(connect|restrict|unrestrict)\b/i.test(decisionSql)) return false;
  if (denyStatement.some((re) => re.test(decisionSql))) return false;
  if (/^SET\b/i.test(decisionSql) || /^SELECT pg_catalog\.set_config\b/i.test(decisionSql)) return true;
  if (hasDeniedSchemaReference(decisionSql)) return false;

  const schemaDecl = decisionSql.match(/\bSCHEMA\s+"?([a-zA-Z_][a-zA-Z0-9_]*)"?/);
  if (schemaDecl && !allowedSchemas.has(schemaDecl[1])) return false;

  const objectSchema = decisionSql.match(/\b(?:TABLE|FUNCTION|SEQUENCE|TYPE|VIEW|MATERIALIZED VIEW|POLICY|TRIGGER)\s+(?:ONLY\s+)?("?)([a-zA-Z_][a-zA-Z0-9_]*)\1\./i);
  if (objectSchema && !allowedSchemas.has(objectSchema[2])) return false;

  if (/^CREATE SCHEMA\b/i.test(decisionSql)) {
    return statementHasAllowedSchema(decisionSql);
  }
  return true;
}

function classifySection(currentDataSection, line) {
  if (/^-- Data for Name:/.test(line)) return "data";
  if (
    currentDataSection === "data" &&
    /^-- Name: .*; Type: (SEQUENCE SET|CONSTRAINT|FK CONSTRAINT|INDEX|TRIGGER|POLICY|ROW SECURITY|DEFAULT ACL)\b/.test(
      line
    )
  ) {
    return "post";
  }
  return currentDataSection;
}

let inPostgresDb = false;
let inCopy = false;
let dataSection = "schema";
let current = [];
const outSchema = [];
const outData = [];
const outPost = [];

function pushStatement(stmt) {
  const cleaned = stmt.trim();
  if (!cleaned) return;
  if (!shouldKeepStatement(cleaned)) return;
  if (dataSection === "schema") outSchema.push(cleaned);
  else if (dataSection === "data") outData.push(cleaned);
  else outPost.push(cleaned);
}

for (const line of lines) {
  if (/^\\connect postgres\b/i.test(line)) {
    inPostgresDb = true;
    continue;
  }
  if (!inPostgresDb) continue;
  if (/^\\unrestrict\b/i.test(line)) break;

  dataSection = classifySection(dataSection, line);

  if (/^COPY\s+/i.test(line)) {
    // Keep COPY blocks only for allowed schemas.
    const keepCopy = statementHasAllowedSchema(line) && !hasDeniedSchemaReference(line);
    inCopy = true;
    current = keepCopy ? [line] : [];
    continue;
  }

  if (inCopy) {
    if (current.length > 0) current.push(line);
    if (line === "\\.") {
      inCopy = false;
      if (current.length > 0) {
        const block = current.join("\n");
        pushStatement(block);
      }
      current = [];
    }
    continue;
  }

  if (line.trim().length === 0) {
    if (current.length > 0) current.push(line);
    continue;
  }

  current.push(line);
  if (line.trim().endsWith(";")) {
    pushStatement(current.join("\n"));
    current = [];
  }
}

if (current.length > 0) pushStatement(current.join("\n"));

const schemaSql = `${outSchema.join("\n\n")}\n`;
const dataSql = `${outData.join("\n\n")}\n`;
const postSql = `${outPost.join("\n\n")}\n`;
const fullSql = `${schemaSql}\n${dataSql}\n${postSql}`;

const schemaPath = path.join(outputDir, "01_schema.sql");
const dataPath = path.join(outputDir, "02_data.sql");
const postPath = path.join(outputDir, "03_post_data.sql");
const fullPath = path.join(outputDir, "restore_filtered.sql");
const reportPath = path.join(outputDir, "restore_report.txt");

fs.writeFileSync(schemaPath, schemaSql, "utf8");
fs.writeFileSync(dataPath, dataSql, "utf8");
fs.writeFileSync(postPath, postSql, "utf8");
fs.writeFileSync(fullPath, fullSql, "utf8");
fs.writeFileSync(
  reportPath,
  [
    `source=${backupPath}`,
    `schema_statements=${outSchema.length}`,
    `data_blocks=${outData.length}`,
    `post_data_statements=${outPost.length}`,
    `output_dir=${outputDir}`
  ].join("\n") + "\n",
  "utf8"
);

console.log(`Prepared restore files in: ${outputDir}`);
