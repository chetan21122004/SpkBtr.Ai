#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";

const srcPath = path.resolve(process.cwd(), "supabase", "backup", "db_cluster-05-12-2025@15-14-28.backup");
const outDir = path.resolve(process.cwd(), "supabase", "backup", "restore");
fs.mkdirSync(outDir, { recursive: true });

const allowedSchemas = new Set(["public", "auth", "storage", "realtime", "supabase_migrations"]);
const denyLine = [
  /^CREATE ROLE\b/i,
  /^ALTER ROLE\b/i,
  /^DROP ROLE\b/i,
  /^CREATE DATABASE\b/i,
  /^ALTER DATABASE\b/i,
  /^DROP DATABASE\b/i,
  /^ALTER DEFAULT PRIVILEGES\b/i,
  /^GRANT\b/i,
  /^REVOKE\b/i,
  /^\\(connect|restrict|unrestrict)\b/i,
  /^CREATE EXTENSION\b/i,
  /^COMMENT ON EXTENSION\b/i
];

const text = fs.readFileSync(srcPath, "utf8");
const lines = text.split(/\r?\n/);

let inPostgres = false;
let done = false;
let section = "schema";
const schema = [];
const data = [];
const post = [];

function isAllowedSchemaLine(line) {
  const m = line.match(/\b(?:SCHEMA|TABLE|FUNCTION|SEQUENCE|TYPE|VIEW|TRIGGER|POLICY|COPY)\s+(?:ONLY\s+)?("?)([a-zA-Z_][a-zA-Z0-9_]*)\1\./i);
  if (!m) return true;
  return allowedSchemas.has(m[2]);
}

function push(line) {
  if (section === "schema") schema.push(line);
  else if (section === "data") data.push(line);
  else post.push(line);
}

for (const raw of lines) {
  const line = raw;
  if (/^\\connect postgres\b/i.test(line)) {
    inPostgres = true;
    continue;
  }
  if (!inPostgres) continue;
  if (/^\\unrestrict\b/i.test(line)) {
    done = true;
    break;
  }
  if (/^-- Data for Name:/i.test(line)) section = "data";
  if (/^-- Name: .*; Type: (SEQUENCE SET|CONSTRAINT|FK CONSTRAINT|INDEX|TRIGGER|POLICY|ROW SECURITY|DEFAULT ACL)\b/i.test(line)) {
    section = "post";
  }

  const trimmed = line.trim();
  if (denyLine.some((re) => re.test(trimmed))) continue;
  if (!isAllowedSchemaLine(line)) continue;
  push(line);
}

if (!done) {
  console.error("Could not locate postgres section boundaries.");
  process.exit(1);
}

fs.writeFileSync(path.join(outDir, "01_schema.sql"), schema.join("\n") + "\n", "utf8");
fs.writeFileSync(path.join(outDir, "02_data.sql"), data.join("\n") + "\n", "utf8");
fs.writeFileSync(path.join(outDir, "03_post_data.sql"), post.join("\n") + "\n", "utf8");
fs.writeFileSync(
  path.join(outDir, "restore_report.txt"),
  `source=${srcPath}\nmode=lossless_line_filter\nschema_lines=${schema.length}\ndata_lines=${data.length}\npost_lines=${post.length}\n`,
  "utf8"
);
console.log("Rebuilt restore files with lossless line filter.");
