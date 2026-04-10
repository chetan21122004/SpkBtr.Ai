# Supabase Restore Artifacts

This folder contains files prepared from `db_cluster-05-12-2025@15-14-28.backup` for a managed Supabase restore.

## Files

- `01_schema.sql` - filtered schema phase
- `02_data.sql` - filtered data phase
- `03_post_data.sql` - constraints/indexes/policies/triggers
- `restore_filtered.sql` - combined file
- `restore_report.txt` - extraction counts
- `run_restore.ps1` - repeatable restore script
- `verify_restore.sql` - post-restore checks

## 1) Regenerate the filtered SQL files

From the repo root:

```powershell
node "supabase/backup/prepare_supabase_restore.mjs"
```

## 2) Run phased restore into the new project

Use your new project's Postgres connection string (from Supabase dashboard).

```powershell
powershell -ExecutionPolicy Bypass -File "supabase/backup/restore/run_restore.ps1" -DatabaseUrl "postgresql://postgres:<PASSWORD>@db.<PROJECT-REF>.supabase.co:5432/postgres?sslmode=require"
```

If `psql` is not on PATH, pass `-PsqlPath` explicitly.

## 3) Manual verification

The script runs `verify_restore.sql` automatically, but you can run it directly:

```powershell
psql "postgresql://postgres:<PASSWORD>@db.<PROJECT-REF>.supabase.co:5432/postgres?sslmode=require" -v ON_ERROR_STOP=1 -f "supabase/backup/restore/verify_restore.sql"
```
