-- Basic schema/object checks
SELECT 'public_tables' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

SELECT 'auth_tables' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = 'auth' AND table_type = 'BASE TABLE';

SELECT 'storage_tables' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = 'storage' AND table_type = 'BASE TABLE';

-- Core app table row counts
SELECT 'public.users' AS table_name, COUNT(*) AS rows FROM public.users
UNION ALL
SELECT 'public.sessions' AS table_name, COUNT(*) AS rows FROM public.sessions
UNION ALL
SELECT 'public.messages' AS table_name, COUNT(*) AS rows FROM public.messages
UNION ALL
SELECT 'public.recordings' AS table_name, COUNT(*) AS rows FROM public.recordings;

-- RLS posture for public schema tables
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- Policy counts by schema
SELECT schemaname, COUNT(*) AS policy_count
FROM pg_policies
WHERE schemaname IN ('public', 'auth', 'storage')
GROUP BY schemaname
ORDER BY schemaname;
