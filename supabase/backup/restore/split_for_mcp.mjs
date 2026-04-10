#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";

const baseDir = path.resolve(process.cwd(), "supabase", "backup", "restore");
const targets = [
  { in: "01_schema.sql", outPrefix: "mcp_schema", maxBytes: 6000 },
  { in: "02_data.sql", outPrefix: "mcp_data", maxBytes: 6000 },
  { in: "03_post_data.sql", outPrefix: "mcp_post", maxBytes: 6000 },
  { in: "verify_restore.sql", outPrefix: "mcp_verify", maxBytes: 6000 }
];

const chunksDir = path.join(baseDir, "mcp_chunks");
fs.mkdirSync(chunksDir, { recursive: true });

function splitStatements(sql) {
  const statements = [];
  let current = [];
  for (const line of sql.split(/\r?\n/)) {
    current.push(line);
    if (line.trim().endsWith(";")) {
      const stmt = current.join("\n").trim();
      if (stmt) statements.push(stmt);
      current = [];
    }
  }
  const tail = current.join("\n").trim();
  if (tail) statements.push(tail);
  return statements;
}

function packChunks(statements, maxBytes) {
  const chunks = [];
  let current = "";
  for (const stmt of statements) {
    const piece = `${stmt}\n\n`;
    const candidate = current + piece;
    if (Buffer.byteLength(candidate, "utf8") > maxBytes && current.trim().length > 0) {
      chunks.push(current.trim() + "\n");
      current = piece;
    } else {
      current = candidate;
    }
  }
  if (current.trim().length > 0) chunks.push(current.trim() + "\n");
  return chunks;
}

for (const t of targets) {
  const inPath = path.join(baseDir, t.in);
  if (!fs.existsSync(inPath)) continue;
  const sql = fs.readFileSync(inPath, "utf8");
  const statements = splitStatements(sql);
  const chunks = packChunks(statements, t.maxBytes);
  chunks.forEach((c, i) => {
    const n = String(i + 1).padStart(3, "0");
    fs.writeFileSync(path.join(chunksDir, `${t.outPrefix}_${n}.sql`), c, "utf8");
  });
}

console.log(`Chunks generated in ${chunksDir}`);
