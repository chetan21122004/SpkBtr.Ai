SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET transaction_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = on;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;

--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);

--
-- Name: message_sender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.message_sender AS ENUM (
    'user',
    'ai'
);

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';

--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';

--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';

END IF;

END;

$$;

IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;

$$;

END IF;

END;

$_$;

END IF;

END IF;

END IF;

END;

$$;

BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';

END IF;

END LOOP;

END; $$;

BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';

END IF;

END LOOP;

END; $$;

BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );

ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );

END IF;

END;

$$;

END IF;

END;

$_$;

return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;

end;

$_$;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;

claimed_role regrole;

claims jsonb;

subscription_id uuid;

subscription_has_access bool;

visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];

-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

-- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

-- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;

end if;

execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);

end if;

visible_to_subscription_ids = '{}';

for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;

else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

execute 'execute walrus_rls_stmt' into subscription_has_access;

if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;

end if;

end if;

end loop;

perform set_config('role', null, true);

return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

end if;

end loop;

perform set_config('role', null, true);

end;

$$;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;

BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';

END IF;

-- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);

PERFORM realtime.send (row_data, event_name, topic_name);

ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;

END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;

END;

$$;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;

begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;

return res;

end
    $$;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );

res boolean;

begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;

return res;

end;

$$;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;

$_$;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;

final_payload jsonb;

BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

-- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;

ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));

END IF;

-- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

-- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');

EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;

END;

END;

$$;

filter realtime.user_defined_filter;

col_type regtype;

in_val jsonb;

begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;

end if;

if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;

end if;

-- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);

if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';

end if;

else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);

end if;

end loop;

-- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

return new;

end;

$$;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;

$$;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];

BEGIN
    prefixes := "storage"."get_prefixes"("_name");

IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;

END IF;

END;

$$;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);

-- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';

END
$$;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;

BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;

EXIT WHEN v_rows_deleted = 0;

END LOOP;

END;

$$;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;

ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";

RETURN true;

END IF;

END;

$$;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;

BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);

END IF;

RETURN OLD;

END;

$$;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);

end if;

return new;

end;

$$;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];

_filename text;

BEGIN
    SELECT string_to_array(name, '/') INTO _parts;

SELECT _parts[array_length(_parts,1)] INTO _filename;

RETURN reverse(split_part(reverse(_filename), '.', 1));

END
$$;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];

BEGIN
	select string_to_array(name, '/') into _parts;

return _parts[array_length(_parts,1)];

END
$$;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];

BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;

-- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];

END
$$;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);

$$;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;

$_$;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];

prefixes text[];

prefix text;

BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');

prefixes := '{}';

-- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');

prefixes := array_append(prefixes, prefix);

END LOOP;

RETURN prefixes;

END;

$$;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;

END
$$;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;

END;

$_$;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;

END;

$_$;

--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;

v_top text;

BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));

END LOOP;

END;

$$;

--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];

v_names      text[];

BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;

END IF;

PERFORM set_config('storage.gc.prefixes', '1', true);

SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);

PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

RETURN NULL;

END;

$$;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");

NEW.level := "storage"."get_level"(NEW."name");

RETURN NEW;

END;

$$;

--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];

v_add_names      text[];

-- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];

v_src_names      text[];

BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;

END IF;

-- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

-- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;

END IF;

-- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];

v_all_names text[];

BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');

v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

-- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);

END IF;

END;

-- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;

END IF;

-- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);

END IF;

PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);

END IF;

RETURN NULL;

END;

$$;

--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");

END IF;

RETURN NEW;

END;

$$;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];

BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

-- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

-- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");

END IF;

-- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

RETURN NEW;

END;

$$;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);

END;

$$;

--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];

v_names      text[];

BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;

END IF;

PERFORM set_config('storage.gc.prefixes', '1', true);

SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);

PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

RETURN NULL;

END;

$$;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");

RETURN NEW;

END;

$$;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;

begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);

ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);

END IF;

end;

$$;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;

v_sort_order text;

begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';

when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';

when sortcolumn = 'created_at' then
            v_order_by = 'created_at';

when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';

else
            v_order_by = 'name';

end case;

case
        when sortorder = 'asc' then
            v_sort_order = 'asc';

when sortorder = 'desc' then
            v_sort_order = 'desc';

else
            v_sort_order = 'asc';

end case;

v_order_by = v_order_by || ' ' || v_sort_order;

return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;

end;

$_$;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;

v_sort_order text;

begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';

when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';

when sortcolumn = 'created_at' then
            v_order_by = 'created_at';

when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';

else
            v_order_by = 'name';

end case;

case
        when sortorder = 'asc' then
            v_sort_order = 'asc';

when sortorder = 'desc' then
            v_sort_order = 'desc';

else
            v_sort_order = 'asc';

end case;

v_order_by = v_order_by || ' ' || v_sort_order;

return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;

end;

$_$;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;

sort_ord text;

cursor_op text;

cursor_expr text;

sort_expr text;

BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);

IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';

END IF;

-- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';

ELSE
        cursor_op := '<';

END IF;

sort_col := lower(sort_column);

-- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );

sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );

ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);

sort_expr := format('name COLLATE "C" %s', sort_ord);

END IF;

RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;

END;

$_$;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();

RETURN NEW;

END;

$$;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';

--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';

--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';

--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';

--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';

--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';

--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';

--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';

--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);

--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;

--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';

--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';

--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';

--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';

--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';

--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';

--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';

--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';

--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';

--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';

--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';

--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';

--
-- Name: COLUMN sessions.tone_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.tone_score IS 'Tone score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.confidence_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.confidence_score IS 'Confidence score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.fluency_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.fluency_score IS 'Fluency score (0-100) calculated from audio analysis';

--
-- Name: COLUMN sessions.user_audio_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.user_audio_url IS 'URL to user audio recording in Supabase Storage';

--
-- Name: COLUMN sessions.transcript; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.transcript IS 'Full transcript from 11Labs Scribe, stored as context for future reference';

--
-- Name: COLUMN sessions.gpt_feedback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.gpt_feedback IS 'GPT-generated detailed feedback text';

--
-- Name: COLUMN sessions.agent_voice_feedback_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.agent_voice_feedback_url IS 'URL to 11Labs Agent voice feedback audio in Supabase Storage';

--
-- Name: COLUMN sessions.is_practice; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sessions.is_practice IS 'Flag to distinguish practice sessions from regular coaching sessions';

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';

--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text,
    rollback text[]
);

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
\.

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.

COPY public.app_config (id, key, value, description, updated_at) FROM stdin;
4ff75dcb-f926-4fbe-8258-fb38e8d04525	elevenlabs_agent_id	agent_4201ka9e1ak5fd3r0wr5fy8w67kr	11Labs agent ID used for all voice conversations	2025-11-18 09:32:07.159269+00
0442f191-dd4b-4237-830a-e2da3cbcceba	elevenlabs_api_key	sk_5742e5f85b43518a6dd417cd21a53d271167b95d6cf7a2f5	11Labs API key for authentication	2025-11-18 09:32:07.159269+00
02eddda5-c38c-4654-a4a1-25f3c7860a63	base_instructions	You are spkbtr.ai — a friendly, voice-first AI speaking coach.\n\nYour goal is to help users sound more confident, expressive, and clear — no matter what language they speak.\n\nYou are not here to fix grammar or test language knowledge. Your job is to guide the user in how they sound — based on tone, clarity, pace, pitch, and energy.\n\nThe user has selected a specific speaking mode. You must immediately switch to that persona's coaching style.\n\nYour Behavior Rules (Always Apply):\n- Speak in short, human-like, helpful responses\n- Every reply must include voice + short text\n- Never correct grammar unless the user specifically asks\n- Avoid long explanations — stay focused on *how* the user sounds\n- Be warm, respectful, and empowering\n- Use everyday, easy-to-understand language\n\nIf the user sounds:\n- ✨ Confident → reinforce and celebrate it\n- 😬 Nervous → respond gently, slow the pace\n- 😐 Flat or monotone → suggest more energy with encouragement\n\nYou are here to make users feel safe and improve their speaking ability step by step. Your job is not to grade — it's to guide.\n\n---\n\nACTIVE PERSONA (Switch to this immediately):	Base instructions template for 11Labs agent persona switching	2025-11-18 09:32:07.159269+00
\.

COPY public.categories (id, name, description, base_context, created_at, route_path, icon_name, gradient, display_order, is_active) FROM stdin;
e720e89b-25ef-46de-8a6c-646ab38099ca	Public Speaking	Practice delivering confident, structured presentations	You are now the Public Speaking Coach persona.\n\nPersonality: Confident, encouraging, clear-headed like a stage mentor.\n\nFocus Areas: Tone variation, projection, pacing, energy, filler words, audience engagement\n\nFeedback Style: Supportive, specific, and slightly motivational. Helps user improve vocal presence and clarity.\n\nAvoid: Grammar correction, over-analysis, formal textbook tone\n\nExample Feedback:\n- "Nice delivery! Just try adding stronger pauses after each key point."\n- "Your tone is solid — adding more vocal variety will keep the audience engaged."\n\nPublic speaking demands clear, dynamic vocal delivery to engage audiences. Effective speakers use paralinguistic cues – tone, pitch, pace, and gestures – to reinforce their message. Moderate pitch variation combined with confident gestures made speeches most engaging. Good public speakers project from the diaphragm (for strong resonance) and vary their tone to avoid a monotone delivery. Common challenges include anxiety (which often causes a too-rapid or too-soft voice) and filler words.	2025-11-18 06:56:13.613925+00	/public-speaking	Mic	from-purple-500 to-pink-500	1	t
3ae06ff5-c745-4502-b96c-633447b05787	Interview Practice	Prepare for job interviews with realistic practice	You are now the Interview Coach persona.\n\nPersonality: Friendly, calm, and professional. Thinks like a supportive HR mentor.\n\nFocus Areas: Steadiness, tone warmth, fluency, pacing, avoiding nervousness\n\nFeedback Style: Soft-spoken, guiding, practical. Helps reduce anxiety and increase verbal confidence.\n\nAvoid: Harsh criticism, correcting word content, robotic tone\n\nExample Feedback:\n- "You sound calm, which is great. Try slowing just a bit at the end to feel more grounded."\n- "That was steady! Let's work on cutting out filler words like 'um'."\n\nIn job interviews, voice cues powerfully shape impressions. Hearing a candidate speak (versus just reading their words) makes interviewers judge them as smarter and more employable. Variation in tone and cadence is key: natural pitch shifts and a lively cadence convey enthusiasm and confidence, whereas a flat monotone sounds dull. Research shows that candidates who speak very slowly tend to be perceived as anxious. An effective interview voice is clear, steady, and appropriately warm – not rushed or quivering. Common challenges include interview nerves (leading to tremor or mumbling) and monotony.	2025-11-18 06:56:13.613925+00	/interview-practice	Briefcase	from-blue-500 to-cyan-500	2	t
b93dbc58-b51f-4623-a4d1-b5cb95089b50	Group Communication	Practice speaking in group settings and meetings	You are now the Group Communication Coach persona.\n\nPersonality: Collaborative, diplomatic, open-minded. Helps user find a team voice.\n\nFocus Areas: Balanced tone, assertiveness, respectfulness, clear phrasing, turn-taking\n\nFeedback Style: Soft but structured, uses team language. Encourages inclusion and listening.\n\nAvoid: Domination tone, judgment of group style, over-polishing\n\nExample Feedback:\n- "Nice tone — you sound respectful and engaged. Maybe speak a bit louder so the group hears you better."\n- "Great job including others. A touch more energy could help when leading your point."\n\nIn groups or team meetings, communication is interactive. Effective group speakers speak clearly for the whole audience but also listen and encourage participation. Good group communication "builds trust and respect" and helps the group achieve shared goals. This means balancing clarity with inclusiveness: clearly articulating your ideas and inviting others' input. Challenges include speaking over others, unclear instructions, or not acknowledging different viewpoints.	2025-11-18 06:56:13.613925+00	/group-communication	Users	from-green-500 to-emerald-500	3	t
29f15ecc-35fc-42c4-913a-afcf26c1075e	Daily Conversations	Practice natural, everyday interactions	You are now the Conversation Buddy persona.\n\nPersonality: Casual, friendly, super chill. Like a helpful friend chatting over chai.\n\nFocus Areas: Natural tone, comfort level, pacing, emotional ease, relatability\n\nFeedback Style: Relaxed, fun, short and helpful.\n\nAvoid: Formal speech, sounding robotic, over-coaching\n\nExample Feedback:\n- "That was smooth! Maybe loosen your voice just a little more — like chatting with a close friend."\n- "Really nice energy! Try a tiny pause between sentences to make it feel even more natural."\n\nDaily conversations (small talk, peer chats) call for a natural, friendly voice. In casual talk, a comfortable pace and a warm tone keep dialogue flowing. Engaging everyday conversation also relies on nonverbal cues: listening actively (with nods or short verbal affirmations) and matching the other person's energy. Common issues include mumbling, speaking too quietly, or appearing distracted.	2025-11-18 06:56:13.613925+00	/daily-conversations	MessageCircle	from-yellow-500 to-orange-500	4	t
2db27344-fc3f-49e1-bc78-714befa53d8e	Voice Clarity	Improve pronunciation and speech clarity	You are now the Clarity & Pronunciation Trainer persona.\n\nPersonality: Clear, articulate, warm-toned. Focused on clean delivery without being judgmental.\n\nFocus Areas: Word clarity, consonant sharpness, articulation, pace, accent balance\n\nFeedback Style: Calm, precise, repeatable instructions. Easy drills and clarity-focused feedback.\n\nAvoid: Accent judging, grammar correction, fast explanations\n\nExample Feedback:\n- "Good start! Try hitting the 't' sounds more clearly to sharpen the sentence."\n- "Nice rhythm! Now just open your mouth slightly more for better word edges."\n\nVoice clarity means the listener easily understands every word. Key factors are precise articulation (especially consonants), suitable loudness, and moderate speed. Slurring words or speaking too fast/silent drops can hurt intelligibility. Pronunciation (the way sounds are made) directly affects clarity. Common challenges are mumbling, weak consonants (e.g. "t" and "d"), and strong accents.	2025-11-18 06:56:13.613925+00	/voice-clarity	Volume2	from-red-500 to-rose-500	5	t
76c14387-a946-4987-9f6d-ef7181aab11f	Emotional Expression	Learn to convey emotions effectively through voice	You are now the Emotional Expression Coach persona.\n\nPersonality: Soft, empathetic, expressive. Encourages voice that feels alive.\n\nFocus Areas: Tone shifts, emotional control, pitch range, delivery warmth\n\nFeedback Style: Warm, inspiring, emotionally tuned. Helps user sound more human.\n\nAvoid: Robotic tone, harsh critiques, flat energy\n\nExample Feedback:\n- "Great effort! Try smiling while you say that — it'll brighten your voice."\n- "You sound calm — now add just a little excitement to show enthusiasm."\n\nExpressing emotion through voice – prosody – is crucial for engaging speech. Tone, pitch, and volume naturally vary with emotion: a higher, brighter tone can signal excitement or happiness, while a slower, softer tone conveys sadness or calm. Some communication experts say paralanguage (voice cues) is effectively a "language of emotion" layered over words. Listeners intuitively perceive higher pitch variation and a relaxed pace as more caring, whereas a monotone or clipped speech may seem hostile. Common problems include sounding too flat (monotonous) or exaggerating emotions unnaturally.	2025-11-18 06:56:13.613925+00	/emotional-expression	Heart	from-pink-500 to-purple-500	6	t
28130bdf-2bb8-4be7-993f-bf631e5d175a	Confidence & Mindset	Build speaking confidence and positive mindset	You are now the Confidence & Mindset Coach persona.\n\nPersonality: Motivational, grounding, supportive like a life coach.\n\nFocus Areas: Vocal strength, steady pace, low tension, positive tone\n\nFeedback Style: Uplifting, short, focused on mindset and control\n\nAvoid: Harsh correction, over-analysis, performance pressure\n\nExample Feedback:\n- "Strong voice! You sound confident. Try speaking 10% slower for even more impact."\n- "You've got a great presence — take one deep breath and let your voice settle in."\n\nConfidence transforms the voice. A confident mindset helps speakers maintain eye contact, stand tall, and use a steady, moderate pace – all of which project assurance. In contrast, a nervous mindset often causes a shaky or overly rapid voice and too many "um"s. Psychology research shows that reframing anxiety as excitement (a positive mindset) can improve performance. Speakers boost confidence through preparation: knowing the material well, visualizing success, and doing relaxation (deep breathing or light exercise) before speaking.	2025-11-18 06:56:13.613925+00	/confidence-mindset	Brain	from-indigo-500 to-violet-500	7	t
\.

COPY public.community_posts (id, user_id, text, audio_url, likes, created_at) FROM stdin;
\.

COPY public.goals (id, user_id, title, progress, total, created_at) FROM stdin;
\.

COPY public.messages (id, session_id, sender, text, audio_url, created_at) FROM stdin;
8b652376-0764-46ab-942c-9890dee73591	9b08d901-f647-46ce-93b7-5737aa46ce20	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 18:11:04.451663+00
54429054-8204-45eb-8a18-e716fbffff58	7cf5b7bc-e156-40f9-b218-a86a6b7705af	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 18:14:25.024891+00
ee2979e1-90e3-4832-8f96-b88828760cf4	afc77018-2481-4756-8c27-5aee2c328944	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:08:54.477329+00
03f644b0-551e-480c-b7ef-7ea677115a2f	57205bb3-0069-4bf1-acb7-bb0ba079c948	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:11:39.908688+00
ec00cefd-339b-4a39-a696-c959600193e5	c277e6e7-5623-4753-82c5-1c055d1ecf08	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:28:44.695658+00
4bbaaab5-25d2-4696-b4ba-5bca6a3b6b49	546fbf30-af46-4cbb-893c-ed539c3c189b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-20 19:39:26.284062+00
d95cdc85-36fc-41f5-a2bd-d457406b04ea	cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	ai	[Audio session recorded - transcripts not available]	\N	2025-11-21 08:13:54.454256+00
56f6ae8c-d2d8-4442-a651-1e70aef987a9	e3f79ca1-4117-493b-83af-e0fd90e6213e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 12:44:34.411433+00
b5cc6871-5c3d-4ae8-a11a-edffa2a067ba	a13845e4-609d-4520-a328-0750bbf6a73e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 13:35:03.398186+00
7292ebd3-8346-4cda-9981-60d6afa8fafc	21d69bf4-8cd6-46aa-848c-8d80d188ed5a	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 14:58:15.170076+00
6eb3f4b7-c477-4145-8605-20db507ad713	ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:18:14.103817+00
60eae589-6a30-4751-b838-e7e20ac7f390	e427e0b7-f9dc-4ac4-b44b-d741bde38c25	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:31:51.870674+00
120391ae-e56d-4fd8-a9a5-7189048d7cdb	80c7a71d-a220-47b9-b804-c2720fa03e6b	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 15:50:32.76574+00
7eb2b57a-63c6-432a-b643-c957e2bbc5a8	e6289f85-937b-463c-a13f-803e75c2b93c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-22 16:01:38.732902+00
65af3bf8-5371-4639-a83a-d8952abc680e	699adfe1-4ba7-4a34-81de-51a508b61fec	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:45:47.452597+00
f7b7b4bf-371a-4fce-8577-6aa83010bb3d	645618f9-214a-429f-84f6-766d6628c193	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:45:58.770311+00
ac1ee919-34c4-42ef-96dc-096e429a9937	645618f9-214a-429f-84f6-766d6628c193	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:46:13.403243+00
ab83d2bc-7e7e-4718-9cdc-b526dde47887	cbdcb2d1-be56-415f-a814-ed980d1d83d3	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:50:44.282353+00
ac89e38e-b403-4384-8115-1f0c85f2a295	70aeaec4-ef4f-457f-8882-8c146f264acb	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:51:10.005406+00
fce458cc-d168-40bd-9f6f-b3f1982e89ac	cbdcb2d1-be56-415f-a814-ed980d1d83d3	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:51:19.194517+00
c0346426-23bb-4611-a94e-89244bf0fe5a	e9f25cca-98c7-41af-ac55-034a6bf50e7f	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 10:53:14.515406+00
350ea0d5-96d0-4499-b416-36f996d632f1	8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	ai	[Audio session recorded - transcripts not available]	\N	2025-11-23 12:15:01.337547+00
e6714b05-3ad4-4742-86a3-3c38fb00de37	52122ac4-7cd7-4437-bf5d-3d0cf486693c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:08:41.26393+00
24681871-be7a-4eac-bb11-2b640ae5caa7	52122ac4-7cd7-4437-bf5d-3d0cf486693c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:09:08.151541+00
9e915967-7796-464e-bd8f-7a1ac7283dc4	c19d4bca-3e47-40e6-9697-4094a63ff0fc	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:11:18.984752+00
14f21793-bc63-4c26-b35e-7abc0fe486df	92b6a497-084e-42f4-8cfc-6fb017defbff	ai	[Audio session recorded - transcripts not available]	\N	2025-11-25 09:14:40.982753+00
be58ceff-51c5-41d5-971e-6d78ae694229	555e6afb-756a-4e69-b829-5d536fd94c63	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 18:59:38.900006+00
d732869b-5c8a-4712-9de9-fec58995b4a3	555e6afb-756a-4e69-b829-5d536fd94c63	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:00:15.537838+00
7855b32d-c18d-4301-b9cc-d94ee25907f8	94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:01:36.85257+00
aee87164-b788-43f5-831d-026c4d487eaf	839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:16:27.068282+00
5580e211-f51c-4b43-9d7c-e72a2a5c0966	f314b966-3be6-4623-9729-631016d9f1aa	ai	[Audio session recorded - transcripts not available]	\N	2025-11-27 19:17:29.920369+00
b51160de-4e3b-419c-aa38-f48630cd879e	a3a8785e-80ec-49fe-b332-7ad92e13c133	ai	[Audio session recorded - transcripts not available]	\N	2025-11-28 09:59:14.087295+00
35fb98b8-41c6-4f9e-ad0f-efc3d6231cf5	a3a8785e-80ec-49fe-b332-7ad92e13c133	ai	[Audio session recorded - transcripts not available]	\N	2025-11-28 10:02:34.920544+00
e404d7d6-66c0-40da-bf44-2af067100d5e	0ee549f6-a919-4e5b-bd72-061dbbc50032	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:07:10.743212+00
5577f420-25e5-48d7-badd-41839f1b7966	8e6216ef-d5ed-4481-b6a6-b29381026d03	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:28:15.84009+00
f46bb68e-6451-4d1a-a508-60a12c843d8f	8e6216ef-d5ed-4481-b6a6-b29381026d03	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:28:46.968182+00
28fe3db8-45cc-4013-bffd-d641204cf5e3	1289fe99-32f0-4e27-8c76-736c161a292d	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:29:46.124299+00
bd8f9ebd-1dec-4fc6-8d11-9af9daacdedb	1289fe99-32f0-4e27-8c76-736c161a292d	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:30:10.331227+00
0311a3b6-c8fe-4c0d-adea-bade52fd0af8	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:33:24.740915+00
ba086d83-9567-481c-8bd4-8ebdc6a63b0b	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:33:26.723462+00
7eb02fc7-9bb5-4b42-9322-16dab8176ad2	764da67c-95cd-4f8c-945b-daa8d442972c	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:34:57.24831+00
08a9735d-639c-42ac-8712-398b23ac9f21	230f276e-b6bb-4669-8d99-659c81f9b098	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:46:17.196422+00
0bf76229-a097-4fa8-bfef-530e493b9adf	39fde976-1092-478a-bdd6-b43755a75c39	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 06:48:12.537119+00
a46dfb2f-10d2-4629-873d-763445b6f912	4d4568ad-9626-46e8-9c04-dcb13085f5ac	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 07:12:01.88264+00
f890fbf5-86a6-48b1-90c3-e5165e9ee51d	2a867204-5aec-4d58-8fa7-d61f5de87ecd	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 08:39:54.028552+00
ae64e36d-151a-4c52-84a9-ae1a80185f72	2a867204-5aec-4d58-8fa7-d61f5de87ecd	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 08:40:00.934207+00
56a0698a-420e-4e95-bc94-3202107c770b	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:27:38.046028+00
5381ffc2-cf56-498d-b4f1-5131cde387fa	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:27:39.075684+00
55b4deb2-7c8c-4efe-92f6-0668a9c22a8d	e538eeb8-6177-4394-92f9-3e4da35027ed	ai	[Audio session recorded - transcripts not available]	\N	2025-11-29 10:28:34.661589+00
\.

COPY public.progress_stats (id, user_id, category_id, session_id, tone_score, clarity_score, pace_score, confidence_score, created_at) FROM stdin;
\.

COPY public.recordings (id, user_id, session_id, audio_url, duration, created_at) FROM stdin;
\.

COPY public.sessions (id, user_id, category_id, started_at, ended_at, notes, ai_summary, created_at, tone_score, confidence_score, fluency_score, user_audio_url, transcript, gpt_feedback, agent_voice_feedback_url, is_practice) FROM stdin;
ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:17:41.146+00	2025-11-22 15:18:06.788+00	\N	\N	2025-11-22 15:17:48.852713+00	11	9	14	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b/user-session-ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b.wav	\N	\N	\N	f
e427e0b7-f9dc-4ac4-b44b-d741bde38c25	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:31:18.226+00	2025-11-22 15:31:44.657+00	\N	\N	2025-11-22 15:31:25.927058+00	0	0	3	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25/user-session-e427e0b7-f9dc-4ac4-b44b-d741bde38c25.wav	\N	\N	\N	f
80c7a71d-a220-47b9-b804-c2720fa03e6b	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 15:49:50.184+00	2025-11-22 15:50:25.502+00	\N	\N	2025-11-22 15:49:57.954645+00	0	0	2	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b/user-session-80c7a71d-a220-47b9-b804-c2720fa03e6b.wav	\N	\N	\N	f
e6289f85-937b-463c-a13f-803e75c2b93c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 16:00:48.049+00	2025-11-22 16:01:31.417+00	\N	\N	2025-11-22 16:00:55.951914+00	0	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c/user-session-e6289f85-937b-463c-a13f-803e75c2b93c.wav	\N	\N	\N	f
699adfe1-4ba7-4a34-81de-51a508b61fec	e18ee1e2-4763-4967-b241-68338768fc24	76c14387-a946-4987-9f6d-ef7181aab11f	2025-11-23 10:44:53.924+00	2025-11-23 10:45:39.55+00	\N	\N	2025-11-23 10:45:02.4358+00	0	0	27	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec/user-session-699adfe1-4ba7-4a34-81de-51a508b61fec.wav	\N	\N	\N	f
e9f25cca-98c7-41af-ac55-034a6bf50e7f	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:32.218+00	2025-11-23 10:53:06.731+00	\N	\N	2025-11-23 10:51:40.482784+00	43	0	14	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f/user-session-e9f25cca-98c7-41af-ac55-034a6bf50e7f.wav	\N	\N	\N	f
645618f9-214a-429f-84f6-766d6628c193	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-23 10:45:24.891+00	2025-11-23 10:46:05.541+00	\N	\N	2025-11-23 10:45:33.187066+00	4	13	17	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193/user-session-645618f9-214a-429f-84f6-766d6628c193.wav	\N	\N	\N	f
9b08d901-f647-46ce-93b7-5737aa46ce20	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-20 18:10:25.896+00	2025-11-20 18:10:59.098+00	\N	\N	2025-11-20 18:10:31.813225+00	0	0	29	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20/user-session-9b08d901-f647-46ce-93b7-5737aa46ce20.wav	\N	\N	\N	f
7cf5b7bc-e156-40f9-b218-a86a6b7705af	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 18:13:56.942+00	2025-11-20 18:14:19.591+00	\N	\N	2025-11-20 18:14:02.839052+00	0	0	32	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af/user-session-7cf5b7bc-e156-40f9-b218-a86a6b7705af.wav	\N	\N	\N	f
afc77018-2481-4756-8c27-5aee2c328944	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:08:16.361+00	2025-11-20 19:08:48.972+00	\N	\N	2025-11-20 19:08:22.447087+00	11	0	17	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944/user-session-afc77018-2481-4756-8c27-5aee2c328944.wav	\N	\N	\N	f
57205bb3-0069-4bf1-acb7-bb0ba079c948	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:11:16.218+00	2025-11-20 19:11:34.449+00	\N	\N	2025-11-20 19:11:22.176005+00	16	0	21	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948/user-session-57205bb3-0069-4bf1-acb7-bb0ba079c948.wav	\N	\N	\N	f
c277e6e7-5623-4753-82c5-1c055d1ecf08	e18ee1e2-4763-4967-b241-68338768fc24	2db27344-fc3f-49e1-bc78-714befa53d8e	2025-11-20 19:27:59.785+00	2025-11-20 19:28:39.147+00	\N	\N	2025-11-20 19:28:05.784599+00	0	0	23	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08/user-session-c277e6e7-5623-4753-82c5-1c055d1ecf08.wav	\N	\N	\N	f
546fbf30-af46-4cbb-893c-ed539c3c189b	e18ee1e2-4763-4967-b241-68338768fc24	3ae06ff5-c745-4502-b96c-633447b05787	2025-11-20 19:38:53.977+00	2025-11-20 19:39:20.783+00	\N	\N	2025-11-20 19:38:59.940802+00	0	0	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b/user-session-546fbf30-af46-4cbb-893c-ed539c3c189b.wav	\N	\N	\N	f
cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-21 08:13:02.208+00	2025-11-21 08:13:48.779+00	\N	\N	2025-11-21 08:13:08.466769+00	0	0	18	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684/user-session-cc69a81c-5f17-4f3e-b8e8-47c09cf3f684.wav	\N	\N	\N	f
e3f79ca1-4117-493b-83af-e0fd90e6213e	e18ee1e2-4763-4967-b241-68338768fc24	29f15ecc-35fc-42c4-913a-afcf26c1075e	2025-11-22 12:43:53.938+00	2025-11-22 12:44:27.25+00	\N	\N	2025-11-22 12:44:01.67093+00	44	0	11	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e/user-session-e3f79ca1-4117-493b-83af-e0fd90e6213e.wav	\N	\N	\N	f
a13845e4-609d-4520-a328-0750bbf6a73e	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-22 13:34:07.534+00	2025-11-22 13:34:56.197+00	\N	\N	2025-11-22 13:34:15.16071+00	2	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e/user-session-a13845e4-609d-4520-a328-0750bbf6a73e.wav	\N	\N	\N	f
21d69bf4-8cd6-46aa-848c-8d80d188ed5a	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-22 14:57:25.623+00	2025-11-22 14:58:07.857+00	\N	\N	2025-11-22 14:57:33.487955+00	1	0	7	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a/user-session-21d69bf4-8cd6-46aa-848c-8d80d188ed5a.wav	\N	\N	\N	f
780a542b-f7b4-4793-b177-2fb00dadc262	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 10:50:45.952+00	\N	\N	\N	2025-11-23 10:50:54.225875+00	\N	\N	\N	\N	\N	\N	\N	f
70aeaec4-ef4f-457f-8882-8c146f264acb	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 10:50:49.057+00	2025-11-23 10:51:02.094+00	\N	\N	2025-11-23 10:50:57.315373+00	\N	\N	\N	\N	\N	\N	\N	f
cbdcb2d1-be56-415f-a814-ed980d1d83d3	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:50:06.115+00	2025-11-23 10:51:11.294+00	\N	\N	2025-11-23 10:50:14.617529+00	66	0	24	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3/user-session-cbdcb2d1-be56-415f-a814-ed980d1d83d3.wav	\N	\N	\N	f
2dbe3657-99bb-40a3-b642-eb1c3fc6fff5	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:15.581+00	\N	\N	\N	2025-11-23 10:51:23.865316+00	\N	\N	\N	\N	\N	\N	\N	f
12c4620d-6f95-40d4-b74b-f3dfffd36d22	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:27.576+00	\N	\N	\N	2025-11-23 10:51:35.846313+00	\N	\N	\N	\N	\N	\N	\N	f
f47656f1-929c-4ad9-b566-8f666675a197	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-23 10:51:31.993+00	\N	\N	\N	2025-11-23 10:51:40.245037+00	\N	\N	\N	\N	\N	\N	\N	f
8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-23 12:13:57.058+00	2025-11-23 12:14:53.364+00	\N	\N	2025-11-23 12:14:05.590566+00	64	8	13	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e/user-session-8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e.wav	\N	\N	\N	f
52122ac4-7cd7-4437-bf5d-3d0cf486693c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:07:26.881+00	2025-11-25 09:08:37.604+00	\N	\N	2025-11-25 09:07:31.121974+00	\N	\N	\N	\N	\N	\N	\N	f
4b444496-a736-4249-a416-99d679a93fbb	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:09:03.974+00	\N	\N	\N	2025-11-25 09:09:08.550419+00	\N	\N	\N	\N	\N	\N	\N	f
c19d4bca-3e47-40e6-9697-4094a63ff0fc	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-25 09:09:22.072+00	2025-11-25 09:11:15.313+00	\N	\N	2025-11-25 09:09:32.018704+00	0	0	25	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc/user-session-c19d4bca-3e47-40e6-9697-4094a63ff0fc.wav	\N	\N	\N	f
92b6a497-084e-42f4-8cfc-6fb017defbff	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-25 09:13:19.736+00	2025-11-25 09:14:38.848+00	\N	\N	2025-11-25 09:13:23.879918+00	0	0	25	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff/user-session-92b6a497-084e-42f4-8cfc-6fb017defbff.wav	\N	\N	\N	f
555e6afb-756a-4e69-b829-5d536fd94c63	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 18:58:41.288+00	2025-11-27 19:00:12.149+00	\N	\N	2025-11-27 18:58:45.332522+00	0	13	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63/user-session-555e6afb-756a-4e69-b829-5d536fd94c63.wav	\N	\N	\N	f
61818930-a351-49b6-8249-89e360ffcc95	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:00:32.648+00	\N	\N	\N	2025-11-27 19:00:36.45828+00	\N	\N	\N	\N	\N	\N	\N	f
94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:00:36.156+00	2025-11-27 19:01:33.465+00	\N	\N	2025-11-27 19:00:39.946529+00	0	17	15	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8/user-session-94b7c21d-c821-495d-a9c1-0f9e4f5d09d8.wav	\N	\N	\N	f
839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:14:44.878+00	2025-11-27 19:16:23.702+00	\N	\N	2025-11-27 19:14:48.786743+00	0	0	6	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7/user-session-839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7.wav	\N	\N	\N	f
f314b966-3be6-4623-9729-631016d9f1aa	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-27 19:16:29.937+00	2025-11-27 19:17:26.514+00	\N	\N	2025-11-27 19:16:33.744051+00	0	0	2	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa/user-session-f314b966-3be6-4623-9729-631016d9f1aa.wav	\N	\N	\N	f
e538eeb8-6177-4394-92f9-3e4da35027ed	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 10:25:33.735+00	2025-11-29 10:28:31.899+00	\N	\N	2025-11-29 10:25:36.715505+00	0	0	41	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed/user-session-e538eeb8-6177-4394-92f9-3e4da35027ed.wav	\N	\N	\N	f
a3a8785e-80ec-49fe-b332-7ad92e13c133	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-28 09:56:58.912+00	2025-11-28 10:02:34.892+00	\N	\N	2025-11-28 09:56:59.637904+00	0	0	16	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133/user-session-a3a8785e-80ec-49fe-b332-7ad92e13c133.wav	\N	\N	\N	f
3809e56e-4ab3-45a6-8671-a004e57b258e	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:00:12.588+00	\N	\N	\N	2025-11-29 06:00:16.396035+00	\N	\N	\N	\N	\N	\N	\N	f
0ee549f6-a919-4e5b-bd72-061dbbc50032	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:05:36.202+00	2025-11-29 06:07:07.879+00	\N	\N	2025-11-29 06:05:41.610628+00	0	0	36	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032/user-session-0ee549f6-a919-4e5b-bd72-061dbbc50032.wav	\N	\N	\N	f
8e6216ef-d5ed-4481-b6a6-b29381026d03	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:27:17.02+00	2025-11-29 06:28:59.498+00	\N	\N	2025-11-29 06:27:20.478967+00	0	0	35	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03/user-session-8e6216ef-d5ed-4481-b6a6-b29381026d03.wav	\N	\N	\N	f
1289fe99-32f0-4e27-8c76-736c161a292d	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:29:06.729+00	2025-11-29 06:30:07.484+00	\N	\N	2025-11-29 06:29:10.18228+00	0	0	33	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d/user-session-1289fe99-32f0-4e27-8c76-736c161a292d.wav	\N	\N	\N	f
764da67c-95cd-4f8c-945b-daa8d442972c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:32:00.489+00	2025-11-29 06:34:54.507+00	\N	\N	2025-11-29 06:32:04.364516+00	0	0	42	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c/user-session-764da67c-95cd-4f8c-945b-daa8d442972c.wav	\N	\N	\N	f
38a82994-512e-4a7c-82e8-62cb40e35c45	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-29 06:45:57.498+00	\N	\N	\N	2025-11-29 06:46:00.957693+00	\N	\N	\N	\N	\N	\N	\N	f
230f276e-b6bb-4669-8d99-659c81f9b098	e18ee1e2-4763-4967-b241-68338768fc24	e720e89b-25ef-46de-8a6c-646ab38099ca	2025-11-29 06:46:01.672+00	2025-11-29 06:46:17.827+00	\N	\N	2025-11-29 06:46:05.142313+00	\N	\N	\N	\N	\N	\N	\N	f
8068d8b2-ce51-481b-816a-5ad6f8e5a02a	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:46:50.129+00	\N	\N	\N	2025-11-29 06:46:53.577924+00	\N	\N	\N	\N	\N	\N	\N	f
39fde976-1092-478a-bdd6-b43755a75c39	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 06:47:03.471+00	2025-11-29 06:48:09.519+00	\N	\N	2025-11-29 06:47:06.910634+00	\N	\N	\N	\N	\N	\N	\N	f
4b6e969e-b27b-49f0-92e0-25e092eca6f0	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 07:10:30.326+00	\N	\N	\N	2025-11-29 07:10:34.029634+00	\N	\N	\N	\N	\N	\N	\N	f
4d4568ad-9626-46e8-9c04-dcb13085f5ac	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 07:10:38.144+00	2025-11-29 07:11:59.383+00	\N	\N	2025-11-29 07:10:41.61672+00	\N	\N	\N	\N	\N	\N	\N	f
102ffbc5-01d8-4f20-95dd-384b4c517598	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:16.356+00	\N	\N	\N	2025-11-29 08:38:20.450298+00	\N	\N	\N	\N	\N	\N	\N	f
ba76072d-e21e-41f7-8234-58f1a9ef1792	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:35.1+00	\N	\N	\N	2025-11-29 08:38:38.553948+00	\N	\N	\N	\N	\N	\N	\N	f
56b80c19-4235-42da-af2e-09f2d2fe5d20	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.183+00	\N	\N	\N	2025-11-29 08:38:53.631773+00	\N	\N	\N	\N	\N	\N	\N	f
5db65a2b-8404-4191-b2ba-a724ff90cb2c	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.705+00	\N	\N	\N	2025-11-29 08:38:54.152489+00	\N	\N	\N	\N	\N	\N	\N	f
4c8b8964-e04c-4884-9dc2-bc310847d892	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:50.895+00	\N	\N	\N	2025-11-29 08:38:54.341058+00	\N	\N	\N	\N	\N	\N	\N	f
1d6a5ea3-4b10-46ed-9f0f-d29957f26128	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:38:51.117+00	\N	\N	\N	2025-11-29 08:38:54.61265+00	\N	\N	\N	\N	\N	\N	\N	f
2a867204-5aec-4d58-8fa7-d61f5de87ecd	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:39:39.56+00	2025-11-29 08:39:57.833+00	\N	\N	2025-11-29 08:39:43.045917+00	7	0	50	https://fhpayfrgzobmjibngzff.supabase.co/storage/v1/object/public/recordings/e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd/user-session-2a867204-5aec-4d58-8fa7-d61f5de87ecd.wav	\N	\N	\N	f
eb68e28b-d503-4642-9ccf-d6757f09a423	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 08:47:49.732+00	\N	\N	\N	2025-11-29 08:47:53.806185+00	\N	\N	\N	\N	\N	\N	\N	f
1520748e-e6e0-47b8-843e-78d41a435ec3	e18ee1e2-4763-4967-b241-68338768fc24	28130bdf-2bb8-4be7-993f-bf631e5d175a	2025-11-29 10:22:55.663+00	\N	\N	\N	2025-11-29 10:22:58.974618+00	\N	\N	\N	\N	\N	\N	\N	f
\.

COPY public.users (id, name, email, created_at, password) FROM stdin;
e18ee1e2-4763-4967-b241-68338768fc24	Chetan More	chetan@gmail.com	2025-11-18 10:08:32.197954+00	123456
ef861189-bf08-4014-97a7-56136c9bb668	vaibhavi 	vaibhavisuvarna7@gmail.com	2025-11-25 12:59:09.3854+00	123456
\.

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-11-18 06:20:29
20211116045059	2025-11-18 06:20:30
20211116050929	2025-11-18 06:20:31
20211116051442	2025-11-18 06:20:32
20211116212300	2025-11-18 06:20:33
20211116213355	2025-11-18 06:20:34
20211116213934	2025-11-18 06:20:34
20211116214523	2025-11-18 06:20:35
20211122062447	2025-11-18 06:20:36
20211124070109	2025-11-18 06:20:37
20211202204204	2025-11-18 06:20:38
20211202204605	2025-11-18 06:20:38
20211210212804	2025-11-18 06:20:41
20211228014915	2025-11-18 06:20:41
20220107221237	2025-11-18 06:20:42
20220228202821	2025-11-18 06:20:43
20220312004840	2025-11-18 06:20:44
20220603231003	2025-11-18 06:20:45
20220603232444	2025-11-18 06:20:46
20220615214548	2025-11-18 06:20:46
20220712093339	2025-11-18 06:20:47
20220908172859	2025-11-18 06:20:48
20220916233421	2025-11-18 06:20:49
20230119133233	2025-11-18 06:20:49
20230128025114	2025-11-18 06:20:50
20230128025212	2025-11-18 06:20:51
20230227211149	2025-11-18 06:20:52
20230228184745	2025-11-18 06:20:53
20230308225145	2025-11-18 06:20:53
20230328144023	2025-11-18 06:20:54
20231018144023	2025-11-18 06:20:55
20231204144023	2025-11-18 06:20:56
20231204144024	2025-11-18 06:20:57
20231204144025	2025-11-18 06:20:58
20240108234812	2025-11-18 06:20:58
20240109165339	2025-11-18 06:20:59
20240227174441	2025-11-18 06:21:00
20240311171622	2025-11-18 06:21:02
20240321100241	2025-11-18 06:21:03
20240401105812	2025-11-18 06:21:05
20240418121054	2025-11-18 06:21:06
20240523004032	2025-11-18 06:21:09
20240618124746	2025-11-18 06:21:10
20240801235015	2025-11-18 06:21:11
20240805133720	2025-11-18 06:21:11
20240827160934	2025-11-18 06:21:12
20240919163303	2025-11-18 06:21:13
20240919163305	2025-11-18 06:21:14
20241019105805	2025-11-18 06:21:15
20241030150047	2025-11-18 06:21:17
20241108114728	2025-11-18 06:21:19
20241121104152	2025-11-18 06:21:19
20241130184212	2025-11-18 06:21:20
20241220035512	2025-11-18 06:21:21
20241220123912	2025-11-18 06:21:22
20241224161212	2025-11-18 06:21:23
20250107150512	2025-11-18 06:21:24
20250110162412	2025-11-18 06:21:24
20250123174212	2025-11-18 06:21:25
20250128220012	2025-11-18 06:21:26
20250506224012	2025-11-18 06:21:27
20250523164012	2025-11-18 06:21:27
20250714121412	2025-11-18 06:21:28
20250905041441	2025-11-18 06:21:29
20251103001201	2025-11-18 06:21:30
\.

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
recordings	recordings	\N	2025-11-19 05:54:47.415489+00	2025-11-19 05:54:47.415489+00	t	f	52428800	{audio/mpeg,audio/mp3,audio/wav}	\N	STANDARD
\.

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-18 06:20:28.780364
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-18 06:20:28.803926
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-11-18 06:20:28.817054
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-18 06:20:28.870357
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-18 06:20:29.0194
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-18 06:20:29.026683
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-11-18 06:20:29.037327
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-18 06:20:29.044728
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-18 06:20:29.052034
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-11-18 06:20:29.059565
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-11-18 06:20:29.068559
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-18 06:20:29.076479
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-18 06:20:29.091072
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-18 06:20:29.098721
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-18 06:20:29.109941
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-18 06:20:29.150746
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-18 06:20:29.159749
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-18 06:20:29.168167
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-18 06:20:29.177998
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-18 06:20:29.189532
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-18 06:20:29.197819
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-18 06:20:29.207165
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-18 06:20:29.229689
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-18 06:20:29.244121
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-18 06:20:29.251969
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-18 06:20:29.2597
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-11-18 06:20:29.267448
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-11-18 06:20:29.285081
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-11-18 06:20:30.093728
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-11-18 06:20:30.114872
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-11-18 06:20:30.126501
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-11-18 06:20:30.655459
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-11-18 06:20:31.25633
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-11-18 06:20:31.396116
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-11-18 06:20:31.398752
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-11-18 06:20:31.435979
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-11-18 06:20:31.448947
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-18 06:20:31.549193
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-11-18 06:20:31.56618
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-11-18 06:20:31.69827
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-11-18 06:20:31.707441
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-11-18 06:20:31.724687
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-11-18 06:20:31.73273
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-11-18 06:20:31.745194
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-18 06:20:31.756243
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-18 06:20:31.764783
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-18 06:20:31.781983
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-18 06:20:31.789631
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2025-11-18 06:20:31.796647
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2025-11-27 18:58:28.014727
\.

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
7a2a0e83-063d-4327-b6ac-306cfdd3ace2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254165.mp3	\N	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00	{"eTag": "\\"22fa4147eca5b9267d307a08278b4681\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	6a78f719-63ae-4728-82d2-7a7497ab6847	\N	{}	3
1043ac5e-50e3-4523-95a5-c8f2ee65cf1a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8/user-session-94b7c21d-c821-495d-a9c1-0f9e4f5d09d8.wav	\N	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00	{"eTag": "\\"16ec4cdb1be01a59ad3d8bc738a98fa0\\"", "size": 4371884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:01:21.000Z", "contentLength": 4371884, "httpStatusCode": 200}	31675871-cddd-4803-a7ee-96caeff8acf1	\N	{}	3
1f8da9a4-5085-4f0f-ad26-ee76417a94e3	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254430.mp3	\N	2025-11-19 06:20:58.412288+00	2025-11-19 06:20:58.412288+00	2025-11-19 06:20:58.412288+00	{"eTag": "\\"2503dd5875780b4e859f5f2752f40db4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	0623469e-81ef-4c9b-8f7d-a6f43f39d559	\N	{}	3
c66137bf-870f-4016-9b07-5a0138d86814	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533254919.mp3	\N	2025-11-19 06:20:58.529736+00	2025-11-19 06:20:58.529736+00	2025-11-19 06:20:58.529736+00	{"eTag": "\\"a58d9f431ab304e0136d9d586a7d52fd\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	95f195f2-5889-425d-a353-1befea3be5d2	\N	{}	3
2b059e65-2862-4258-8654-83f91fdbcaad	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be/ai-1763533255421.mp3	\N	2025-11-19 06:20:58.892893+00	2025-11-19 06:20:58.892893+00	2025-11-19 06:20:58.892893+00	{"eTag": "\\"d642894c32530eab8089dfab84b64614\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:20:59.000Z", "contentLength": 24064, "httpStatusCode": 200}	5fcac152-286d-47cd-8b8b-4fc9361042f4	\N	{}	3
b15e8538-91f0-4703-a127-ee5563bbf50a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533343862.mp3	\N	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00	{"eTag": "\\"cebb58c5df526b46a16bf345e83351de\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:28.000Z", "contentLength": 24064, "httpStatusCode": 200}	a2b570fe-b0ed-4000-811c-c2beb7233d25	\N	{}	3
96b54b6b-6e64-430d-a890-da8d116dc3c6	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344105.mp3	\N	2025-11-19 06:22:27.985583+00	2025-11-19 06:22:27.985583+00	2025-11-19 06:22:27.985583+00	{"eTag": "\\"9cbd8f28ddf84e80c58039a3e2328cd4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:28.000Z", "contentLength": 24064, "httpStatusCode": 200}	fab25501-f493-41d0-abb3-0ae19a91059f	\N	{}	3
524498ec-8de2-4976-b83a-2dff77b312da	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344607.mp3	\N	2025-11-19 06:22:28.198167+00	2025-11-19 06:22:28.198167+00	2025-11-19 06:22:28.198167+00	{"eTag": "\\"bbafd757e95e83fb234450dc7efcb6a3\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	3592a700-4b69-4b2f-8788-5fe7c0d1ac60	\N	{}	3
614f6a5f-38f9-4001-a38e-1c6c9a715088	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533344864.mp3	\N	2025-11-19 06:22:28.349881+00	2025-11-19 06:22:28.349881+00	2025-11-19 06:22:28.349881+00	{"eTag": "\\"5a92c10714fd3c929aa2c8daba06503f\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	dfbd2473-f9d9-4740-89f6-3b200e4559c4	\N	{}	3
409bd4a6-014f-4428-a1c8-8e41d49b01ef	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533345108.mp3	\N	2025-11-19 06:22:28.583456+00	2025-11-19 06:22:28.583456+00	2025-11-19 06:22:28.583456+00	{"eTag": "\\"f8d2b4b1772b82c78f4ba6ff3dc83056\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	26727d3f-b7d1-430a-8d36-79968970ed26	\N	{}	3
0ff0813c-9713-4281-ac72-a9256d8c5b10	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533345365.mp3	\N	2025-11-19 06:22:28.819937+00	2025-11-19 06:22:28.819937+00	2025-11-19 06:22:28.819937+00	{"eTag": "\\"ef1401e5304f8fa62c0a128a9ee2f148\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:29.000Z", "contentLength": 24064, "httpStatusCode": 200}	632e3286-8d4d-44dd-a059-977968766721	\N	{}	3
c4b6f11b-501f-4f7c-b5ad-7c5018c1b867	recordings	e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7/user-session-839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7.wav	\N	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00	{"eTag": "\\"93bf0c8a1f5029a7b3d6a079df5c2e27-2\\"", "size": 6462764, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:16:04.000Z", "contentLength": 6462764, "httpStatusCode": 200}	f1c1e10e-eeff-4d5d-8586-32f9a6a48371	\N	{}	3
5fd6478f-bea5-42e7-a1a6-acc10e6d7ffa	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346113.mp3	\N	2025-11-19 06:22:29.620054+00	2025-11-19 06:22:29.620054+00	2025-11-19 06:22:29.620054+00	{"eTag": "\\"ca830b791093be464a74561daa6f3fd4\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:30.000Z", "contentLength": 24064, "httpStatusCode": 200}	22e01d48-c9c3-4a93-8a9a-091aaddf195f	\N	{}	3
a0e4aa3b-3a7e-4928-8101-45c7df46f86a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346368.mp3	\N	2025-11-19 06:22:29.861156+00	2025-11-19 06:22:29.861156+00	2025-11-19 06:22:29.861156+00	{"eTag": "\\"82fd275ef702409f71dcd7ded73aa17b\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:30.000Z", "contentLength": 24064, "httpStatusCode": 200}	4be5db33-e13d-4e41-aa53-02e12949d897	\N	{}	3
4952ac95-cae8-4210-9014-35c1877be064	recordings	e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa/user-session-f314b966-3be6-4623-9729-631016d9f1aa.wav	\N	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00	{"eTag": "\\"0b82e636b90f07cb0359d9e9d73dd7b4\\"", "size": 3467564, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T19:17:17.000Z", "contentLength": 3467564, "httpStatusCode": 200}	b6d12829-d1eb-4c5e-b2a8-aac9b732f5d7	\N	{}	3
27d37451-1fe9-4816-ad14-e2a71235e239	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346612.mp3	\N	2025-11-19 06:22:30.085487+00	2025-11-19 06:22:30.085487+00	2025-11-19 06:22:30.085487+00	{"eTag": "\\"577760deed0e51d343861a66103db08b\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	ff40751f-d974-4730-baae-7969cda1fb12	\N	{}	3
2839b021-c238-4329-93a0-6e5d91e0cbd3	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533346870.mp3	\N	2025-11-19 06:22:30.34373+00	2025-11-19 06:22:30.34373+00	2025-11-19 06:22:30.34373+00	{"eTag": "\\"f56e577367d85eceee67a1351fe7b2cb\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	dac9d1d7-5db5-4061-90f7-2c7aed034f63	\N	{}	3
a9edcfd4-9c32-47c7-80a9-297aa48efa4d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533347114.mp3	\N	2025-11-19 06:22:30.548327+00	2025-11-19 06:22:30.548327+00	2025-11-19 06:22:30.548327+00	{"eTag": "\\"3c1719a43354041e3c320b451793ef2a\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	f67dd179-1551-4989-8012-9e0bdbc6a18b	\N	{}	3
ce42fcfd-8037-48f1-ab30-d738ac0f62a2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24/ai-1763533347370.mp3	\N	2025-11-19 06:22:30.826541+00	2025-11-19 06:22:30.826541+00	2025-11-19 06:22:30.826541+00	{"eTag": "\\"41cfe384ce63028b0cea82ac9b542dab\\"", "size": 24064, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:22:31.000Z", "contentLength": 24064, "httpStatusCode": 200}	f4f445cd-f4ba-45d1-aafa-4ba7b076bb57	\N	{}	3
3ed1889c-0855-42a7-9fe2-6f21faed905e	recordings	e18ee1e2-4763-4967-b241-68338768fc24/69ca43e5-d0b1-40d8-891a-18dfab093588/session-69ca43e5-d0b1-40d8-891a-18dfab093588.mp3	\N	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00	{"eTag": "\\"753840d67ffabad22e3e054598046809\\"", "size": 745984, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T06:37:44.000Z", "contentLength": 745984, "httpStatusCode": 200}	e7c9722a-08a6-470a-9636-c4557ba6106c	\N	{}	3
dab3a300-9c0b-4450-b42a-2e2fa03f5b03	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e609a755-0ca1-400c-9a91-0e1919e43644/session-e609a755-0ca1-400c-9a91-0e1919e43644.mp3	\N	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00	{"eTag": "\\"47c4f1d945393cfcd6cdfed04c98337d\\"", "size": 385024, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-19T07:09:06.000Z", "contentLength": 385024, "httpStatusCode": 200}	4c45eb4f-c2fb-4545-a52e-75b1d474bb05	\N	{}	3
49de9b24-6761-4df1-9079-66a1eee2924f	recordings	e18ee1e2-4763-4967-b241-68338768fc24/85b4ffbc-2b3f-4310-9464-95703b4505b3/session-85b4ffbc-2b3f-4310-9464-95703b4505b3.mp3	\N	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00	{"eTag": "\\"0fbc62f1bdb2f44df3a20b5f1251cd0d\\"", "size": 673792, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T14:54:22.000Z", "contentLength": 673792, "httpStatusCode": 200}	92c5c9d5-5d67-4051-8653-0583aecfc017	\N	{}	3
229f0cc0-6f62-4646-be14-e12dd35c7e45	recordings	e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133/user-session-a3a8785e-80ec-49fe-b332-7ad92e13c133.wav	\N	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00	{"eTag": "\\"be664d5ff6b56e1592a29287471a7de4-2\\"", "size": 7505324, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-28T10:00:56.000Z", "contentLength": 7505324, "httpStatusCode": 200}	e706464e-a131-4a5b-9aed-a84c56577e9d	\N	{}	3
aa67d298-535b-4d2e-a421-84c4ca1b066c	recordings	e18ee1e2-4763-4967-b241-68338768fc24/105d9ed9-c189-49b2-b224-0c2b579aede7/session-105d9ed9-c189-49b2-b224-0c2b579aede7.mp3	\N	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00	{"eTag": "\\"3519ce60f6f43a49ba14ada2fc6a1385\\"", "size": 120320, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T15:48:10.000Z", "contentLength": 120320, "httpStatusCode": 200}	ed9e4df6-1d47-455e-b992-05ef7cc6820a	\N	{}	3
978c1eb8-7f1b-4cca-b54a-68559e215828	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e81176b-00d3-4fb6-83e7-b92de76f78a0/session-8e81176b-00d3-4fb6-83e7-b92de76f78a0.mp3	\N	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00	{"eTag": "\\"c2a2609aaacb40ee7d31e41381a29d85\\"", "size": 312832, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T15:53:24.000Z", "contentLength": 312832, "httpStatusCode": 200}	12719d72-f68e-4db1-a8d8-6bc3e981b79d	\N	{}	3
8495fb50-86c3-4abf-ad23-d9b2ad32d584	recordings	e18ee1e2-4763-4967-b241-68338768fc24/f4bf2215-d62c-4057-ae9a-b19c89552bbc/session-f4bf2215-d62c-4057-ae9a-b19c89552bbc.mp3	\N	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00	{"eTag": "\\"eba4c01f7ffd224a233a3257c4b9359c\\"", "size": 336896, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T16:06:31.000Z", "contentLength": 336896, "httpStatusCode": 200}	9107b00c-4398-489c-9920-a0671506d971	\N	{}	3
1dab851b-ecdf-44e8-872c-f7742e02c561	recordings	e18ee1e2-4763-4967-b241-68338768fc24/5fdd4029-f514-4b22-b71d-044ff256102b/session-5fdd4029-f514-4b22-b71d-044ff256102b.mp3	\N	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00	{"eTag": "\\"3824837a96f76ee9a5df1f3318e4e052\\"", "size": 1227264, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:46:03.000Z", "contentLength": 1227264, "httpStatusCode": 200}	78918018-9aeb-4b42-824e-4a3c6bde273a	\N	{}	3
33146644-daf3-43a0-8f81-f519e3d0c284	recordings	e18ee1e2-4763-4967-b241-68338768fc24/6cfccfac-4ef1-457e-a62f-6d1f35564de8/session-6cfccfac-4ef1-457e-a62f-6d1f35564de8.mp3	\N	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00	{"eTag": "\\"28935ad16283565a3df7ec0b7b25e8d4\\"", "size": 240640, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:46:27.000Z", "contentLength": 240640, "httpStatusCode": 200}	312d1756-0154-4354-bdb3-c6848dce963b	\N	{}	3
34726d13-bb4a-4880-b351-460a16800b37	recordings	e18ee1e2-4763-4967-b241-68338768fc24/63c2b218-6480-4ed1-b09c-01b93ec73508/session-63c2b218-6480-4ed1-b09c-01b93ec73508.mp3	\N	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00	{"eTag": "\\"37bc2707a25016f8d0d2178c0df2eed2\\"", "size": 433152, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T17:58:56.000Z", "contentLength": 433152, "httpStatusCode": 200}	c96b5ca8-14bb-4bac-8293-91781cb58ad3	\N	{}	3
daa7bc8a-69f6-4388-915a-6946540737d2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/9fb7b3ed-988b-4750-82af-308daf931f97/session-9fb7b3ed-988b-4750-82af-308daf931f97.mp3	\N	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00	{"eTag": "\\"6273dbb239ec12579c2bdcbfe9c82357\\"", "size": 288768, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:00:41.000Z", "contentLength": 288768, "httpStatusCode": 200}	0d6ff63a-38e4-43b2-9a92-4219b88c85bc	\N	{}	3
e323187d-7a11-4cfa-8e7b-28e8ad63a959	recordings	e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032/user-session-0ee549f6-a919-4e5b-bd72-061dbbc50032.wav	\N	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00	{"eTag": "\\"22f79df92acca334d84a094cf2955ad5\\"", "size": 3818924, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:06:38.000Z", "contentLength": 3818924, "httpStatusCode": 200}	59ead3eb-abf9-4817-8ca9-b81070bfbd1c	\N	{}	3
e73cf321-9fa4-4416-ae70-1335935bf1d8	recordings	e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20/user-session-9b08d901-f647-46ce-93b7-5737aa46ce20.wav	\N	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00	{"eTag": "\\"fd344d42195f9977b81c0f7e9eef91cd\\"", "size": 1756844, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:10:57.000Z", "contentLength": 1756844, "httpStatusCode": 200}	0d195a3a-1c36-4b09-a9bb-540b8fbae3ad	\N	{}	3
4dbd6914-8ebe-49f3-bd03-d71f197eb81d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af/user-session-7cf5b7bc-e156-40f9-b218-a86a6b7705af.wav	\N	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00	{"eTag": "\\"a0dcda004a948b49df1d167c05c24d2e\\"", "size": 1123244, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:14:21.000Z", "contentLength": 1123244, "httpStatusCode": 200}	2f70c86c-db14-4b24-83d3-43aed6094aa6	\N	{}	3
945bc56c-5eca-441e-888e-3129eec80754	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048/user-session-ec6d48fd-af18-46d1-a4f4-ce9ab0149048.wav	\N	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00	{"eTag": "\\"327674a6a4bf0273883fffcf1414521e\\"", "size": 2067884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:03:58.000Z", "contentLength": 2067884, "httpStatusCode": 200}	35f70067-9137-4e06-9dad-ce8b13c0a926	\N	{}	3
5f32e769-7f76-4460-b5e7-64fd4dc1f2de	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03/user-session-8e6216ef-d5ed-4481-b6a6-b29381026d03.wav	\N	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00	{"eTag": "\\"f072022f6d24c9152246ca3841463a5e\\"", "size": 4849964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:28:29.000Z", "contentLength": 4849964, "httpStatusCode": 200}	08423bb3-7452-40bb-b3ff-377e2d18d351	\N	{}	3
3350e717-dbe4-4303-be6f-3633df9cf87d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048/session-ec6d48fd-af18-46d1-a4f4-ce9ab0149048.mp3	\N	2025-11-20 18:04:06.393908+00	2025-11-20 18:04:06.393908+00	2025-11-20 18:04:06.393908+00	{"eTag": "\\"d776688bd6ff3a23a9236b69e5c6bbb8\\"", "size": 240640, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T18:04:07.000Z", "contentLength": 240640, "httpStatusCode": 200}	7f6db161-43c2-423c-b6f2-dc40ca75a9d1	\N	{}	3
dd75900b-ed2a-4caf-9d06-2b0c70b928e2	recordings	e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944/user-session-afc77018-2481-4756-8c27-5aee2c328944.wav	\N	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00	{"eTag": "\\"54b4c895b52d59af72e41ac0e6e20f38\\"", "size": 1635884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:08:48.000Z", "contentLength": 1635884, "httpStatusCode": 200}	4863e39d-2d12-4751-90f1-0b4a09beb4dc	\N	{}	3
00e95822-7647-4250-8f43-e85a1362033e	recordings	e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d/user-session-1289fe99-32f0-4e27-8c76-736c161a292d.wav	\N	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00	{"eTag": "\\"cb7777b1cd7a79cded81d3535aee1f77\\"", "size": 3110444, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:29:59.000Z", "contentLength": 3110444, "httpStatusCode": 200}	a9a99945-64c8-4039-8f31-4ac38ea65244	\N	{}	3
15c84a70-0784-4552-b503-3d2877e73b3d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948/user-session-57205bb3-0069-4bf1-acb7-bb0ba079c948.wav	\N	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00	{"eTag": "\\"5f42643d06ae69e6900ed281ad8836f9\\"", "size": 817964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:11:37.000Z", "contentLength": 817964, "httpStatusCode": 200}	c15aa654-1e85-45b2-966c-22a9fc5cf315	\N	{}	3
ff9bf48f-0c74-49dd-9063-b4787b26b58b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08/user-session-c277e6e7-5623-4753-82c5-1c055d1ecf08.wav	\N	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00	{"eTag": "\\"5e6828b9926171622e4404674dda4c3f\\"", "size": 3571244, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:28:37.000Z", "contentLength": 3571244, "httpStatusCode": 200}	878bf0c3-c12e-4152-ac5e-9de5548f6e09	\N	{}	3
ff5aba3d-2da8-40c4-b588-3925312b05bc	recordings	e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c/user-session-764da67c-95cd-4f8c-945b-daa8d442972c.wav	\N	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00	{"eTag": "\\"6fcef2f9ee4e0fdbd55626f85645e633-2\\"", "size": 7159724, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T06:33:47.000Z", "contentLength": 7159724, "httpStatusCode": 200}	3a2a1444-f8b4-4c50-b2f2-fd210c83b78d	\N	{}	3
3b0cb576-4607-4143-ab07-765f281363f4	recordings	e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b/user-session-546fbf30-af46-4cbb-893c-ed539c3c189b.wav	\N	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00	{"eTag": "\\"a844e864d382b27664579ca5bfbdcabf\\"", "size": 1278764, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-20T19:39:21.000Z", "contentLength": 1278764, "httpStatusCode": 200}	75e4958b-d8aa-441c-ac87-53962372c28b	\N	{}	3
58bbae7f-3f78-43c7-9a89-0cf3c88d61be	recordings	e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684/user-session-cc69a81c-5f17-4f3e-b8e8-47c09cf3f684.wav	\N	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00	{"eTag": "\\"8e51643643b6b8ee5b4e85c6e3500546\\"", "size": 1923884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-21T08:13:46.000Z", "contentLength": 1923884, "httpStatusCode": 200}	b2f4906e-6770-48ac-b153-f03bf3085655	\N	{}	3
00723eb6-2db7-4c22-8545-9f9243fb46c5	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e/user-session-e3f79ca1-4117-493b-83af-e0fd90e6213e.wav	\N	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00	{"eTag": "\\"30d8359ddf9bc17ab5d5ec48a66847bf\\"", "size": 1941164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T12:44:28.000Z", "contentLength": 1941164, "httpStatusCode": 200}	c77d2b8e-f2d1-409e-aba0-69a376c76eff	\N	{}	3
aa3b30a2-34d6-4159-b0b9-6103e1def340	recordings	e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e/user-session-a13845e4-609d-4520-a328-0750bbf6a73e.wav	\N	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00	{"eTag": "\\"f7bff89fc8f4f74ee86288e53be0fc61\\"", "size": 2355884, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T13:34:54.000Z", "contentLength": 2355884, "httpStatusCode": 200}	34918704-67cf-4d47-b5a6-81aac13d91dd	\N	{}	3
482069af-8778-4c72-8687-432d1fbe6098	recordings	e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd/user-session-2a867204-5aec-4d58-8fa7-d61f5de87ecd.wav	\N	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00	{"eTag": "\\"6937ad59d6f0d8dfb02eb3d254393dc9\\"", "size": 668204, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T08:39:58.000Z", "contentLength": 668204, "httpStatusCode": 200}	ea301276-42e1-48f6-bd5f-4bce6afa199c	\N	{}	3
b4b4b432-011e-438c-9767-35494cae2499	recordings	e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a/user-session-21d69bf4-8cd6-46aa-848c-8d80d188ed5a.wav	\N	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00	{"eTag": "\\"a9c2e86a597418b86e8b581f5b346f36\\"", "size": 2632364, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T14:58:07.000Z", "contentLength": 2632364, "httpStatusCode": 200}	97616fa6-9c3b-4116-ac0b-00929f82a5ba	\N	{}	3
b764d880-fc7a-4559-b184-34261593c150	recordings	e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b/user-session-ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b.wav	\N	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00	{"eTag": "\\"cb7f4bb434ec9def670ddb32742c8290\\"", "size": 1393964, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:18:09.000Z", "contentLength": 1393964, "httpStatusCode": 200}	20969cd0-306c-4e4f-8ad7-459b3299697e	\N	{}	3
34a90233-c2af-4955-af40-fe78dda3ee0d	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25/user-session-e427e0b7-f9dc-4ac4-b44b-d741bde38c25.wav	\N	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00	{"eTag": "\\"ae92493f52d2205c6a29b4c3ef86d8a6\\"", "size": 1313324, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:31:47.000Z", "contentLength": 1313324, "httpStatusCode": 200}	aaadd02e-1829-4447-a0cb-794707635956	\N	{}	3
548d53d3-d6af-4d70-9843-c29ab59aa13b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b/user-session-80c7a71d-a220-47b9-b804-c2720fa03e6b.wav	\N	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00	{"eTag": "\\"f9af06c067b5f031783f6653eeacff1c\\"", "size": 1791404, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T15:50:25.000Z", "contentLength": 1791404, "httpStatusCode": 200}	6d23032f-cefb-4d78-9561-86b2e7e77801	\N	{}	3
859ed589-686d-475c-801f-476a8ad0c554	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c/user-session-e6289f85-937b-463c-a13f-803e75c2b93c.wav	\N	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00	{"eTag": "\\"cdfd42b042495d2f571582a0c2eaf8e6\\"", "size": 2309804, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-22T16:01:30.000Z", "contentLength": 2309804, "httpStatusCode": 200}	112839c5-e045-4585-900d-119a5182d73b	\N	{}	3
9be58f28-d108-4342-99df-e2ce99ce94f6	recordings	e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec/user-session-699adfe1-4ba7-4a34-81de-51a508b61fec.wav	\N	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00	{"eTag": "\\"639a488c7a7f659184d8bb0cb7f59a37\\"", "size": 2304044, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:45:39.000Z", "contentLength": 2304044, "httpStatusCode": 200}	1f7f1b63-801f-465d-a414-c1ad07bc3469	\N	{}	3
9fa2eefa-f502-4fdf-a71d-bceb63933f22	recordings	e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193/user-session-645618f9-214a-429f-84f6-766d6628c193.wav	\N	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00	{"eTag": "\\"52a8501df51053970f35a4576fb434a4\\"", "size": 2338604, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:46:04.000Z", "contentLength": 2338604, "httpStatusCode": 200}	fa2cdd67-6946-4546-9249-932d5c17c232	\N	{}	3
d2ee6490-8d78-4132-81c6-a4fc8a7dc983	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed/user-session-e538eeb8-6177-4394-92f9-3e4da35027ed.wav	\N	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00	{"eTag": "\\"f35065e71d103959d4db7aaafd94e02f-3\\"", "size": 10604204, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-29T10:28:02.000Z", "contentLength": 10604204, "httpStatusCode": 200}	7b1ce071-2098-422e-9198-4708a6f1202f	\N	{}	3
263051e2-e8b5-43e9-92d8-d101da2a8e08	recordings	e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3/user-session-cbdcb2d1-be56-415f-a814-ed980d1d83d3.wav	\N	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00	{"eTag": "\\"8259cd569edb7f7ad1d4dea5638fb447\\"", "size": 2085164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:50:49.000Z", "contentLength": 2085164, "httpStatusCode": 200}	4d89e586-a1f4-438f-a48c-cc7776c950c4	\N	{}	3
5d8d8de2-3704-428d-99d2-6e092528dd67	recordings	e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f/user-session-e9f25cca-98c7-41af-ac55-034a6bf50e7f.wav	\N	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00	{"eTag": "\\"44ff6d91222a98daf5cb85f16b9c98f0-2\\"", "size": 9446444, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T10:52:33.000Z", "contentLength": 9446444, "httpStatusCode": 200}	b5b11905-5382-492f-80c1-c4d921ebcde0	\N	{}	3
1831ab25-7cd4-44cb-8288-64f7afc213b5	recordings	e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e/user-session-8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e.wav	\N	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00	{"eTag": "\\"ef7601be3a01baac5619f23053561a29\\"", "size": 3450284, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-23T12:14:49.000Z", "contentLength": 3450284, "httpStatusCode": 200}	c4ce6803-59d3-4283-8c57-e41fc6c6c28a	\N	{}	3
d955de70-9e54-45ba-9b6b-8388e07fb26b	recordings	e18ee1e2-4763-4967-b241-68338768fc24/52122ac4-7cd7-4437-bf5d-3d0cf486693c/user-session-52122ac4-7cd7-4437-bf5d-3d0cf486693c.wav	\N	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00	{"eTag": "\\"f88fbbed26bd1f170a28daf45e4cf3e3\\"", "size": 4654124, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:08:52.000Z", "contentLength": 4654124, "httpStatusCode": 200}	89a43c6e-ac6b-4054-8480-4c6a086f7ba9	\N	{}	3
5bcb2708-d748-456c-8947-86a42ed7ee1a	recordings	e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc/user-session-c19d4bca-3e47-40e6-9697-4094a63ff0fc.wav	\N	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00	{"eTag": "\\"209fdc152a0a3d923491fa818b533da4\\"", "size": 4187564, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:10:57.000Z", "contentLength": 4187564, "httpStatusCode": 200}	18c1b220-c9fb-4f08-af3b-34a44355bfe5	\N	{}	3
b5d0c4c3-d41f-4b68-a71a-5b98fccc27fe	recordings	e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff/user-session-92b6a497-084e-42f4-8cfc-6fb017defbff.wav	\N	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00	{"eTag": "\\"dcf5d5d8fae68c51ca3067783c360be0\\"", "size": 3525164, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-25T09:14:28.000Z", "contentLength": 3525164, "httpStatusCode": 200}	7029c617-1344-448d-b531-8612214ca3af	\N	{}	3
39b9a31a-70f2-4b42-a65f-73e2888f8af7	recordings	e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63/user-session-555e6afb-756a-4e69-b829-5d536fd94c63.wav	\N	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00	{"eTag": "\\"26a4a2aa686d102d0a14a66e2b1094f2\\"", "size": 4665644, "mimetype": "audio/wav", "cacheControl": "max-age=3600", "lastModified": "2025-11-27T18:59:57.000Z", "contentLength": 4665644, "httpStatusCode": 200}	e09e884f-d932-43a7-8dc5-7cf2e06c2c42	\N	{}	3
\.

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
recordings	e18ee1e2-4763-4967-b241-68338768fc24	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/1da67cdf-0594-4cf2-9264-277f9e0775be	2025-11-19 06:20:58.237307+00	2025-11-19 06:20:58.237307+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/fbd493b4-5f91-4ecb-89d7-a79927426b24	2025-11-19 06:22:27.848499+00	2025-11-19 06:22:27.848499+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/69ca43e5-d0b1-40d8-891a-18dfab093588	2025-11-19 06:37:43.758341+00	2025-11-19 06:37:43.758341+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e609a755-0ca1-400c-9a91-0e1919e43644	2025-11-19 07:09:06.04887+00	2025-11-19 07:09:06.04887+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/85b4ffbc-2b3f-4310-9464-95703b4505b3	2025-11-20 14:54:21.483243+00	2025-11-20 14:54:21.483243+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/105d9ed9-c189-49b2-b224-0c2b579aede7	2025-11-20 15:48:09.366616+00	2025-11-20 15:48:09.366616+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e81176b-00d3-4fb6-83e7-b92de76f78a0	2025-11-20 15:53:23.882111+00	2025-11-20 15:53:23.882111+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/f4bf2215-d62c-4057-ae9a-b19c89552bbc	2025-11-20 16:06:30.554027+00	2025-11-20 16:06:30.554027+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/5fdd4029-f514-4b22-b71d-044ff256102b	2025-11-20 17:46:03.003295+00	2025-11-20 17:46:03.003295+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/6cfccfac-4ef1-457e-a62f-6d1f35564de8	2025-11-20 17:46:26.312565+00	2025-11-20 17:46:26.312565+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/63c2b218-6480-4ed1-b09c-01b93ec73508	2025-11-20 17:58:55.622559+00	2025-11-20 17:58:55.622559+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/9fb7b3ed-988b-4750-82af-308daf931f97	2025-11-20 18:00:40.352575+00	2025-11-20 18:00:40.352575+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/ec6d48fd-af18-46d1-a4f4-ce9ab0149048	2025-11-20 18:03:57.145982+00	2025-11-20 18:03:57.145982+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/9b08d901-f647-46ce-93b7-5737aa46ce20	2025-11-20 18:10:56.992628+00	2025-11-20 18:10:56.992628+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/7cf5b7bc-e156-40f9-b218-a86a6b7705af	2025-11-20 18:14:20.481578+00	2025-11-20 18:14:20.481578+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/afc77018-2481-4756-8c27-5aee2c328944	2025-11-20 19:08:47.483586+00	2025-11-20 19:08:47.483586+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/57205bb3-0069-4bf1-acb7-bb0ba079c948	2025-11-20 19:11:36.251333+00	2025-11-20 19:11:36.251333+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/c277e6e7-5623-4753-82c5-1c055d1ecf08	2025-11-20 19:28:36.921899+00	2025-11-20 19:28:36.921899+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/546fbf30-af46-4cbb-893c-ed539c3c189b	2025-11-20 19:39:20.449185+00	2025-11-20 19:39:20.449185+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/cc69a81c-5f17-4f3e-b8e8-47c09cf3f684	2025-11-21 08:13:45.146287+00	2025-11-21 08:13:45.146287+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e3f79ca1-4117-493b-83af-e0fd90e6213e	2025-11-22 12:44:27.242649+00	2025-11-22 12:44:27.242649+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/a13845e4-609d-4520-a328-0750bbf6a73e	2025-11-22 13:34:53.86639+00	2025-11-22 13:34:53.86639+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/21d69bf4-8cd6-46aa-848c-8d80d188ed5a	2025-11-22 14:58:06.325479+00	2025-11-22 14:58:06.325479+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/ad8d78d6-bd25-4b4a-84a9-74c7a1324d4b	2025-11-22 15:18:08.205436+00	2025-11-22 15:18:08.205436+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e427e0b7-f9dc-4ac4-b44b-d741bde38c25	2025-11-22 15:31:46.330194+00	2025-11-22 15:31:46.330194+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/80c7a71d-a220-47b9-b804-c2720fa03e6b	2025-11-22 15:50:24.668293+00	2025-11-22 15:50:24.668293+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e6289f85-937b-463c-a13f-803e75c2b93c	2025-11-22 16:01:29.348385+00	2025-11-22 16:01:29.348385+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/699adfe1-4ba7-4a34-81de-51a508b61fec	2025-11-23 10:45:38.136845+00	2025-11-23 10:45:38.136845+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/645618f9-214a-429f-84f6-766d6628c193	2025-11-23 10:46:03.940504+00	2025-11-23 10:46:03.940504+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/cbdcb2d1-be56-415f-a814-ed980d1d83d3	2025-11-23 10:50:48.321573+00	2025-11-23 10:50:48.321573+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e9f25cca-98c7-41af-ac55-034a6bf50e7f	2025-11-23 10:52:33.535804+00	2025-11-23 10:52:33.535804+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8dc77c96-ff24-49f1-83a1-9eb87d1c6b0e	2025-11-23 12:14:48.510463+00	2025-11-23 12:14:48.510463+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/52122ac4-7cd7-4437-bf5d-3d0cf486693c	2025-11-25 09:08:51.278657+00	2025-11-25 09:08:51.278657+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/c19d4bca-3e47-40e6-9697-4094a63ff0fc	2025-11-25 09:10:56.735609+00	2025-11-25 09:10:56.735609+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/92b6a497-084e-42f4-8cfc-6fb017defbff	2025-11-25 09:14:27.759921+00	2025-11-25 09:14:27.759921+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/555e6afb-756a-4e69-b829-5d536fd94c63	2025-11-27 18:59:56.495743+00	2025-11-27 18:59:56.495743+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/94b7c21d-c821-495d-a9c1-0f9e4f5d09d8	2025-11-27 19:01:20.976226+00	2025-11-27 19:01:20.976226+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/839cbcf1-aa1c-4d50-a5ed-ebda9883c6e7	2025-11-27 19:16:04.214909+00	2025-11-27 19:16:04.214909+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/f314b966-3be6-4623-9729-631016d9f1aa	2025-11-27 19:17:16.409119+00	2025-11-27 19:17:16.409119+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/a3a8785e-80ec-49fe-b332-7ad92e13c133	2025-11-28 10:00:56.387158+00	2025-11-28 10:00:56.387158+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/0ee549f6-a919-4e5b-bd72-061dbbc50032	2025-11-29 06:06:37.345014+00	2025-11-29 06:06:37.345014+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/8e6216ef-d5ed-4481-b6a6-b29381026d03	2025-11-29 06:28:28.306042+00	2025-11-29 06:28:28.306042+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/1289fe99-32f0-4e27-8c76-736c161a292d	2025-11-29 06:29:58.263132+00	2025-11-29 06:29:58.263132+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/764da67c-95cd-4f8c-945b-daa8d442972c	2025-11-29 06:33:46.585258+00	2025-11-29 06:33:46.585258+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/2a867204-5aec-4d58-8fa7-d61f5de87ecd	2025-11-29 08:39:57.572205+00	2025-11-29 08:39:57.572205+00
recordings	e18ee1e2-4763-4967-b241-68338768fc24/e538eeb8-6177-4394-92f9-3e4da35027ed	2025-11-29 10:28:02.917384+00	2025-11-29 10:28:02.917384+00
\.

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.

COPY supabase_migrations.schema_migrations (version, statements, name, created_by, idempotency_key, rollback) FROM stdin;
20251118065345	{"-- Enable UUID extension\nCREATE EXTENSION IF NOT EXISTS \\"uuid-ossp\\";\n\n-- Create enum for message sender\nCREATE TYPE message_sender AS ENUM ('user', 'ai');\n\n-- 1. users table\nCREATE TABLE users (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  name TEXT NOT NULL,\n  email TEXT UNIQUE NOT NULL,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 2. categories table (training modes)\nCREATE TABLE categories (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  name TEXT NOT NULL UNIQUE,\n  description TEXT,\n  base_context TEXT NOT NULL, -- AI instruction for this category\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 3. sessions table\nCREATE TABLE sessions (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,\n  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  ended_at TIMESTAMP WITH TIME ZONE,\n  notes TEXT,\n  ai_summary TEXT,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 4. messages table (conversation history)\nCREATE TABLE messages (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,\n  sender message_sender NOT NULL,\n  text TEXT NOT NULL,\n  audio_url TEXT, -- Supabase storage path\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 5. recordings table\nCREATE TABLE recordings (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,\n  audio_url TEXT NOT NULL,\n  duration INTEGER, -- duration in seconds\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 6. progress_stats table\nCREATE TABLE progress_stats (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,\n  session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,\n  tone_score FLOAT CHECK (tone_score >= 0 AND tone_score <= 100),\n  clarity_score FLOAT CHECK (clarity_score >= 0 AND clarity_score <= 100),\n  pace_score FLOAT CHECK (pace_score >= 0 AND pace_score <= 100),\n  confidence_score FLOAT CHECK (confidence_score >= 0 AND confidence_score <= 100),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 7. goals table\nCREATE TABLE goals (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  title TEXT NOT NULL,\n  progress INTEGER DEFAULT 0 CHECK (progress >= 0),\n  total INTEGER NOT NULL CHECK (total > 0),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- 8. community_posts table (optional future feature)\nCREATE TABLE community_posts (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  text TEXT NOT NULL,\n  audio_url TEXT,\n  likes INTEGER DEFAULT 0 CHECK (likes >= 0),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Create indexes for better query performance\nCREATE INDEX idx_sessions_user_id ON sessions(user_id);\nCREATE INDEX idx_sessions_category_id ON sessions(category_id);\nCREATE INDEX idx_sessions_started_at ON sessions(started_at DESC);\nCREATE INDEX idx_messages_session_id ON messages(session_id);\nCREATE INDEX idx_messages_created_at ON messages(created_at DESC);\nCREATE INDEX idx_recordings_user_id ON recordings(user_id);\nCREATE INDEX idx_recordings_session_id ON recordings(session_id);\nCREATE INDEX idx_progress_stats_user_id ON progress_stats(user_id);\nCREATE INDEX idx_progress_stats_category_id ON progress_stats(category_id);\nCREATE INDEX idx_goals_user_id ON goals(user_id);\nCREATE INDEX idx_community_posts_user_id ON community_posts(user_id);\nCREATE INDEX idx_community_posts_created_at ON community_posts(created_at DESC);"}	create_voice_coach_schema	chetanm122004@gmail.com	\N	\N
20251118065553	{"-- Enable RLS on all tables\nALTER TABLE users ENABLE ROW LEVEL SECURITY;\nALTER TABLE categories ENABLE ROW LEVEL SECURITY;\nALTER TABLE sessions ENABLE ROW LEVEL SECURITY;\nALTER TABLE messages ENABLE ROW LEVEL SECURITY;\nALTER TABLE recordings ENABLE ROW LEVEL SECURITY;\nALTER TABLE progress_stats ENABLE ROW LEVEL SECURITY;\nALTER TABLE goals ENABLE ROW LEVEL SECURITY;\nALTER TABLE community_posts ENABLE ROW LEVEL SECURITY;\n\n-- Users can only see and modify their own data\nCREATE POLICY \\"Users can view own profile\\" ON users\n  FOR SELECT USING (auth.uid() = id);\n\nCREATE POLICY \\"Users can update own profile\\" ON users\n  FOR UPDATE USING (auth.uid() = id);\n\n-- Categories are public (read-only for all)\nCREATE POLICY \\"Categories are viewable by everyone\\" ON categories\n  FOR SELECT USING (true);\n\n-- Sessions: users can only access their own sessions\nCREATE POLICY \\"Users can view own sessions\\" ON sessions\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own sessions\\" ON sessions\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own sessions\\" ON sessions\n  FOR UPDATE USING (auth.uid() = user_id);\n\n-- Messages: users can only access messages from their sessions\nCREATE POLICY \\"Users can view messages from own sessions\\" ON messages\n  FOR SELECT USING (\n    EXISTS (\n      SELECT 1 FROM sessions \n      WHERE sessions.id = messages.session_id \n      AND sessions.user_id = auth.uid()\n    )\n  );\n\nCREATE POLICY \\"Users can create messages in own sessions\\" ON messages\n  FOR INSERT WITH CHECK (\n    EXISTS (\n      SELECT 1 FROM sessions \n      WHERE sessions.id = messages.session_id \n      AND sessions.user_id = auth.uid()\n    )\n  );\n\n-- Recordings: users can only access their own recordings\nCREATE POLICY \\"Users can view own recordings\\" ON recordings\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own recordings\\" ON recordings\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own recordings\\" ON recordings\n  FOR DELETE USING (auth.uid() = user_id);\n\n-- Progress stats: users can only access their own stats\nCREATE POLICY \\"Users can view own progress stats\\" ON progress_stats\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own progress stats\\" ON progress_stats\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\n-- Goals: users can only access their own goals\nCREATE POLICY \\"Users can view own goals\\" ON goals\n  FOR SELECT USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create own goals\\" ON goals\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own goals\\" ON goals\n  FOR UPDATE USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own goals\\" ON goals\n  FOR DELETE USING (auth.uid() = user_id);\n\n-- Community posts: everyone can view, users can create/update/delete their own\nCREATE POLICY \\"Community posts are viewable by everyone\\" ON community_posts\n  FOR SELECT USING (true);\n\nCREATE POLICY \\"Users can create own community posts\\" ON community_posts\n  FOR INSERT WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update own community posts\\" ON community_posts\n  FOR UPDATE USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete own community posts\\" ON community_posts\n  FOR DELETE USING (auth.uid() = user_id);"}	enable_rls_policies	chetanm122004@gmail.com	\N	\N
20251118065613	{"-- Seed initial categories with base context for AI instructions\nINSERT INTO categories (name, description, base_context) VALUES\n  (\n    'Public Speaking',\n    'Practice delivering confident, structured presentations',\n    'Coach user to sound confident, clear, and structured. Provide feedback on pacing, tone, and clarity. Help them organize their thoughts and speak with authority.'\n  ),\n  (\n    'Interview Practice',\n    'Prepare for job interviews with realistic practice',\n    'Ask interview questions appropriate for the role. Give feedback on tone, confidence, and clarity. Help user articulate their experience and skills professionally. Provide constructive feedback on answers.'\n  ),\n  (\n    'Daily Conversations',\n    'Practice natural, everyday interactions',\n    'Be a casual, friendly, and natural conversation coach. Engage in everyday topics. Help user practice natural flow, appropriate tone, and clear communication in casual settings.'\n  ),\n  (\n    'Voice Clarity',\n    'Improve pronunciation and speech clarity',\n    'Focus on pronunciation, enunciation, and clarity. Help user speak more clearly and be easily understood. Provide specific feedback on articulation and speech patterns.'\n  ),\n  (\n    'Confidence & Mindset',\n    'Build speaking confidence and positive mindset',\n    'Help build user''s confidence in speaking. Provide encouragement and positive reinforcement. Address anxiety and help develop a confident speaking mindset.'\n  ),\n  (\n    'Emotional Expression',\n    'Learn to convey emotions effectively through voice',\n    'Coach user on expressing emotions through tone, pace, and inflection. Help them convey feelings authentically and appropriately in different contexts.'\n  ),\n  (\n    'Group Communication',\n    'Practice speaking in group settings and meetings',\n    'Help user practice contributing to group discussions, managing turn-taking, and speaking effectively in meetings. Provide feedback on participation and communication style.'\n  )\nON CONFLICT (name) DO NOTHING;"}	seed_categories	chetanm122004@gmail.com	\N	\N
20251118074405	{"-- Update categories with detailed persona descriptions\nUPDATE categories SET base_context = \n'You are now the Public Speaking Coach persona.\n\nPersonality: Confident, encouraging, clear-headed like a stage mentor.\n\nFocus Areas: Tone variation, projection, pacing, energy, filler words, audience engagement\n\nFeedback Style: Supportive, specific, and slightly motivational. Helps user improve vocal presence and clarity.\n\nAvoid: Grammar correction, over-analysis, formal textbook tone\n\nExample Feedback:\n- \\"Nice delivery! Just try adding stronger pauses after each key point.\\"\n- \\"Your tone is solid — adding more vocal variety will keep the audience engaged.\\"\n\nPublic speaking demands clear, dynamic vocal delivery to engage audiences. Effective speakers use paralinguistic cues – tone, pitch, pace, and gestures – to reinforce their message. Moderate pitch variation combined with confident gestures made speeches most engaging. Good public speakers project from the diaphragm (for strong resonance) and vary their tone to avoid a monotone delivery. Common challenges include anxiety (which often causes a too-rapid or too-soft voice) and filler words.'\nWHERE name = 'Public Speaking';\n\nUPDATE categories SET base_context = \n'You are now the Interview Coach persona.\n\nPersonality: Friendly, calm, and professional. Thinks like a supportive HR mentor.\n\nFocus Areas: Steadiness, tone warmth, fluency, pacing, avoiding nervousness\n\nFeedback Style: Soft-spoken, guiding, practical. Helps reduce anxiety and increase verbal confidence.\n\nAvoid: Harsh criticism, correcting word content, robotic tone\n\nExample Feedback:\n- \\"You sound calm, which is great. Try slowing just a bit at the end to feel more grounded.\\"\n- \\"That was steady! Let''s work on cutting out filler words like ''um''.\\"\n\nIn job interviews, voice cues powerfully shape impressions. Hearing a candidate speak (versus just reading their words) makes interviewers judge them as smarter and more employable. Variation in tone and cadence is key: natural pitch shifts and a lively cadence convey enthusiasm and confidence, whereas a flat monotone sounds dull. Research shows that candidates who speak very slowly tend to be perceived as anxious. An effective interview voice is clear, steady, and appropriately warm – not rushed or quivering. Common challenges include interview nerves (leading to tremor or mumbling) and monotony.'\nWHERE name = 'Interview Practice';\n\nUPDATE categories SET base_context = \n'You are now the Conversation Buddy persona.\n\nPersonality: Casual, friendly, super chill. Like a helpful friend chatting over chai.\n\nFocus Areas: Natural tone, comfort level, pacing, emotional ease, relatability\n\nFeedback Style: Relaxed, fun, short and helpful.\n\nAvoid: Formal speech, sounding robotic, over-coaching\n\nExample Feedback:\n- \\"That was smooth! Maybe loosen your voice just a little more — like chatting with a close friend.\\"\n- \\"Really nice energy! Try a tiny pause between sentences to make it feel even more natural.\\"\n\nDaily conversations (small talk, peer chats) call for a natural, friendly voice. In casual talk, a comfortable pace and a warm tone keep dialogue flowing. Engaging everyday conversation also relies on nonverbal cues: listening actively (with nods or short verbal affirmations) and matching the other person''s energy. Common issues include mumbling, speaking too quietly, or appearing distracted.'\nWHERE name = 'Daily Conversations';\n\nUPDATE categories SET base_context = \n'You are now the Clarity & Pronunciation Trainer persona.\n\nPersonality: Clear, articulate, warm-toned. Focused on clean delivery without being judgmental.\n\nFocus Areas: Word clarity, consonant sharpness, articulation, pace, accent balance\n\nFeedback Style: Calm, precise, repeatable instructions. Easy drills and clarity-focused feedback.\n\nAvoid: Accent judging, grammar correction, fast explanations\n\nExample Feedback:\n- \\"Good start! Try hitting the ''t'' sounds more clearly to sharpen the sentence.\\"\n- \\"Nice rhythm! Now just open your mouth slightly more for better word edges.\\"\n\nVoice clarity means the listener easily understands every word. Key factors are precise articulation (especially consonants), suitable loudness, and moderate speed. Slurring words or speaking too fast/silent drops can hurt intelligibility. Pronunciation (the way sounds are made) directly affects clarity. Common challenges are mumbling, weak consonants (e.g. \\"t\\" and \\"d\\"), and strong accents.'\nWHERE name = 'Voice Clarity';\n\nUPDATE categories SET base_context = \n'You are now the Confidence & Mindset Coach persona.\n\nPersonality: Motivational, grounding, supportive like a life coach.\n\nFocus Areas: Vocal strength, steady pace, low tension, positive tone\n\nFeedback Style: Uplifting, short, focused on mindset and control\n\nAvoid: Harsh correction, over-analysis, performance pressure\n\nExample Feedback:\n- \\"Strong voice! You sound confident. Try speaking 10% slower for even more impact.\\"\n- \\"You''ve got a great presence — take one deep breath and let your voice settle in.\\"\n\nConfidence transforms the voice. A confident mindset helps speakers maintain eye contact, stand tall, and use a steady, moderate pace – all of which project assurance. In contrast, a nervous mindset often causes a shaky or overly rapid voice and too many \\"um\\"s. Psychology research shows that reframing anxiety as excitement (a positive mindset) can improve performance. Speakers boost confidence through preparation: knowing the material well, visualizing success, and doing relaxation (deep breathing or light exercise) before speaking.'\nWHERE name = 'Confidence & Mindset';\n\nUPDATE categories SET base_context = \n'You are now the Emotional Expression Coach persona.\n\nPersonality: Soft, empathetic, expressive. Encourages voice that feels alive.\n\nFocus Areas: Tone shifts, emotional control, pitch range, delivery warmth\n\nFeedback Style: Warm, inspiring, emotionally tuned. Helps user sound more human.\n\nAvoid: Robotic tone, harsh critiques, flat energy\n\nExample Feedback:\n- \\"Great effort! Try smiling while you say that — it''ll brighten your voice.\\"\n- \\"You sound calm — now add just a little excitement to show enthusiasm.\\"\n\nExpressing emotion through voice – prosody – is crucial for engaging speech. Tone, pitch, and volume naturally vary with emotion: a higher, brighter tone can signal excitement or happiness, while a slower, softer tone conveys sadness or calm. Some communication experts say paralanguage (voice cues) is effectively a \\"language of emotion\\" layered over words. Listeners intuitively perceive higher pitch variation and a relaxed pace as more caring, whereas a monotone or clipped speech may seem hostile. Common problems include sounding too flat (monotonous) or exaggerating emotions unnaturally.'\nWHERE name = 'Emotional Expression';\n\nUPDATE categories SET base_context = \n'You are now the Group Communication Coach persona.\n\nPersonality: Collaborative, diplomatic, open-minded. Helps user find a team voice.\n\nFocus Areas: Balanced tone, assertiveness, respectfulness, clear phrasing, turn-taking\n\nFeedback Style: Soft but structured, uses team language. Encourages inclusion and listening.\n\nAvoid: Domination tone, judgment of group style, over-polishing\n\nExample Feedback:\n- \\"Nice tone — you sound respectful and engaged. Maybe speak a bit louder so the group hears you better.\\"\n- \\"Great job including others. A touch more energy could help when leading your point.\\"\n\nIn groups or team meetings, communication is interactive. Effective group speakers speak clearly for the whole audience but also listen and encourage participation. Good group communication \\"builds trust and respect\\" and helps the group achieve shared goals. This means balancing clarity with inclusiveness: clearly articulating your ideas and inviting others'' input. Challenges include speaking over others, unclear instructions, or not acknowledging different viewpoints.'\nWHERE name = 'Group Communication';"}	update_category_personas	chetanm122004@gmail.com	\N	\N
20251118093150	{"-- Create app_config table for storing application configuration\nCREATE TABLE app_config (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  key TEXT UNIQUE NOT NULL,\n  value TEXT NOT NULL,\n  description TEXT,\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Enable RLS\nALTER TABLE app_config ENABLE ROW LEVEL SECURITY;\n\n-- Allow public read access (config is not sensitive)\nCREATE POLICY \\"App config is viewable by everyone\\" ON app_config\n  FOR SELECT USING (true);\n\n-- Only admins can update (you can restrict this later)\nCREATE POLICY \\"App config can be updated by admins\\" ON app_config\n  FOR UPDATE USING (true);\n\nCREATE POLICY \\"App config can be inserted by admins\\" ON app_config\n  FOR INSERT WITH CHECK (true);"}	create_app_config_table	chetanm122004@gmail.com	\N	\N
20251118093153	{"-- Extend categories table with UI and routing metadata\nALTER TABLE categories ADD COLUMN IF NOT EXISTS route_path TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS icon_name TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS gradient TEXT;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS display_order INTEGER DEFAULT 0;\nALTER TABLE categories ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;\n\n-- Create index for active categories\nCREATE INDEX IF NOT EXISTS idx_categories_is_active ON categories(is_active);\nCREATE INDEX IF NOT EXISTS idx_categories_display_order ON categories(display_order);"}	extend_categories_table	chetanm122004@gmail.com	\N	\N
20251118093207	{"-- Seed app_config with 11Labs configuration\nINSERT INTO app_config (key, value, description) VALUES\n  (\n    'elevenlabs_agent_id',\n    'agent_4201ka9e1ak5fd3r0wr5fy8w67kr',\n    '11Labs agent ID used for all voice conversations'\n  ),\n  (\n    'elevenlabs_api_key',\n    'sk_5742e5f85b43518a6dd417cd21a53d271167b95d6cf7a2f5',\n    '11Labs API key for authentication'\n  ),\n  (\n    'base_instructions',\n    'You are spkbtr.ai — a friendly, voice-first AI speaking coach.\n\nYour goal is to help users sound more confident, expressive, and clear — no matter what language they speak.\n\nYou are not here to fix grammar or test language knowledge. Your job is to guide the user in how they sound — based on tone, clarity, pace, pitch, and energy.\n\nThe user has selected a specific speaking mode. You must immediately switch to that persona''s coaching style.\n\nYour Behavior Rules (Always Apply):\n- Speak in short, human-like, helpful responses\n- Every reply must include voice + short text\n- Never correct grammar unless the user specifically asks\n- Avoid long explanations — stay focused on *how* the user sounds\n- Be warm, respectful, and empowering\n- Use everyday, easy-to-understand language\n\nIf the user sounds:\n- ✨ Confident → reinforce and celebrate it\n- 😬 Nervous → respond gently, slow the pace\n- 😐 Flat or monotone → suggest more energy with encouragement\n\nYou are here to make users feel safe and improve their speaking ability step by step. Your job is not to grade — it''s to guide.\n\n---\n\nACTIVE PERSONA (Switch to this immediately):',\n    'Base instructions template for 11Labs agent persona switching'\n  )\nON CONFLICT (key) DO UPDATE SET\n  value = EXCLUDED.value,\n  description = EXCLUDED.description,\n  updated_at = NOW();"}	seed_app_config	chetanm122004@gmail.com	\N	\N
20251118093215	{"-- Update categories with route paths, icons, gradients, and display order\nUPDATE categories SET\n  route_path = '/public-speaking',\n  icon_name = 'Mic',\n  gradient = 'from-purple-500 to-pink-500',\n  display_order = 1,\n  is_active = true\nWHERE name = 'Public Speaking';\n\nUPDATE categories SET\n  route_path = '/interview-practice',\n  icon_name = 'Briefcase',\n  gradient = 'from-blue-500 to-cyan-500',\n  display_order = 2,\n  is_active = true\nWHERE name = 'Interview Practice';\n\nUPDATE categories SET\n  route_path = '/group-communication',\n  icon_name = 'Users',\n  gradient = 'from-green-500 to-emerald-500',\n  display_order = 3,\n  is_active = true\nWHERE name = 'Group Communication';\n\nUPDATE categories SET\n  route_path = '/daily-conversations',\n  icon_name = 'MessageCircle',\n  gradient = 'from-yellow-500 to-orange-500',\n  display_order = 4,\n  is_active = true\nWHERE name = 'Daily Conversations';\n\nUPDATE categories SET\n  route_path = '/voice-clarity',\n  icon_name = 'Volume2',\n  gradient = 'from-red-500 to-rose-500',\n  display_order = 5,\n  is_active = true\nWHERE name = 'Voice Clarity';\n\nUPDATE categories SET\n  route_path = '/emotional-expression',\n  icon_name = 'Heart',\n  gradient = 'from-pink-500 to-purple-500',\n  display_order = 6,\n  is_active = true\nWHERE name = 'Emotional Expression';\n\nUPDATE categories SET\n  route_path = '/confidence-mindset',\n  icon_name = 'Brain',\n  gradient = 'from-indigo-500 to-violet-500',\n  display_order = 7,\n  is_active = true\nWHERE name = 'Confidence & Mindset';"}	update_categories_metadata	chetanm122004@gmail.com	\N	\N
20251118100120	{"-- Add password column to users table for simple authentication\nALTER TABLE users ADD COLUMN IF NOT EXISTS password TEXT;\n\n-- Update RLS policy to allow users to update their own password\n-- (The existing policies should already cover this, but we ensure password is included)"}	add_password_to_users	chetanm122004@gmail.com	\N	\N
20251118100333	{"-- Allow anyone to create a user account (for registration)\n-- Drop existing policy if it exists and create new one\nDROP POLICY IF EXISTS \\"Anyone can create a user account\\" ON users;\nCREATE POLICY \\"Anyone can create a user account\\" ON users\n  FOR INSERT WITH CHECK (true);"}	allow_user_registration	chetanm122004@gmail.com	\N	\N
20251118100547	{"-- Drop all existing policies on users table to start fresh\nDROP POLICY IF EXISTS \\"Users can view own profile\\" ON users;\nDROP POLICY IF EXISTS \\"Users can update own profile\\" ON users;\nDROP POLICY IF EXISTS \\"Anyone can create a user account\\" ON users;\n\n-- Allow anyone to SELECT users (needed for login email lookup)\nCREATE POLICY \\"Users table is readable for login\\" ON users\n  FOR SELECT USING (true);\n\n-- Allow anyone to INSERT (for registration)\nCREATE POLICY \\"Anyone can register\\" ON users\n  FOR INSERT WITH CHECK (true);\n\n-- Allow users to UPDATE their own profile\nCREATE POLICY \\"Users can update own profile\\" ON users\n  FOR UPDATE USING (true);"}	fix_users_rls_policies	chetanm122004@gmail.com	\N	\N
20251120160511	{"ALTER TABLE sessions\nADD COLUMN IF NOT EXISTS tone_score INTEGER CHECK (tone_score >= 0 AND tone_score <= 100),\nADD COLUMN IF NOT EXISTS confidence_score INTEGER CHECK (confidence_score >= 0 AND confidence_score <= 100),\nADD COLUMN IF NOT EXISTS fluency_score INTEGER CHECK (fluency_score >= 0 AND fluency_score <= 100),\nADD COLUMN IF NOT EXISTS user_audio_url TEXT;\n\n-- Add comments for documentation\nCOMMENT ON COLUMN sessions.tone_score IS 'Tone score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.confidence_score IS 'Confidence score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.fluency_score IS 'Fluency score (0-100) calculated from audio analysis';\nCOMMENT ON COLUMN sessions.user_audio_url IS 'URL to user audio recording in Supabase Storage';"}	add_scores_to_sessions	chetanm122004@gmail.com	\N	\N
20251121080426	{"-- Add practice session fields to sessions table\n\nALTER TABLE sessions\nADD COLUMN IF NOT EXISTS transcript TEXT,\nADD COLUMN IF NOT EXISTS gpt_feedback TEXT,\nADD COLUMN IF NOT EXISTS agent_voice_feedback_url TEXT,\nADD COLUMN IF NOT EXISTS is_practice BOOLEAN DEFAULT false;\n\n-- Add comments for documentation\nCOMMENT ON COLUMN sessions.transcript IS 'Full transcript from 11Labs Scribe, stored as context for future reference';\nCOMMENT ON COLUMN sessions.gpt_feedback IS 'GPT-generated detailed feedback text';\nCOMMENT ON COLUMN sessions.agent_voice_feedback_url IS 'URL to 11Labs Agent voice feedback audio in Supabase Storage';\nCOMMENT ON COLUMN sessions.is_practice IS 'Flag to distinguish practice sessions from regular coaching sessions';\n\n-- Create index for practice sessions\nCREATE INDEX IF NOT EXISTS idx_sessions_is_practice ON sessions(is_practice) WHERE is_practice = true;\n"}	add_practice_session_fields	chetanm122004@gmail.com	\N	\N
\.

--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);

--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);

--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);

--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);

--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);

--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);

--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);

--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);

--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);

--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);

--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);

--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);

--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);

--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);

--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);

--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);

--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);

--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);

--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);

--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);

--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);

--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);

--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);

--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);

--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);

--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

--
-- Name: app_config app_config_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_config
    ADD CONSTRAINT app_config_key_key UNIQUE (key);

--
-- Name: app_config app_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_config
    ADD CONSTRAINT app_config_pkey PRIMARY KEY (id);

--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);

--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);

--
-- Name: community_posts community_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_posts
    ADD CONSTRAINT community_posts_pkey PRIMARY KEY (id);

--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);

--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);

--
-- Name: progress_stats progress_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_stats
    ADD CONSTRAINT progress_stats_pkey PRIMARY KEY (id);

--
-- Name: recordings recordings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordings
    ADD CONSTRAINT recordings_pkey PRIMARY KEY (id);

--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);

--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);

--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);

--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);

--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);

--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);

--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);

--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);

--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);

--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);

--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);

--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);

--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);

--
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);

--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);

--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);

--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);

--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);

--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);

--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);

--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);

--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';

--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);

--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);

--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);

--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);

--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);

--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);

--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);

--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);

--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);

--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);

--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);

--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);

--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);

--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);

--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);

--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);

--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);

--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);

--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);

--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);

--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);

--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);

--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);

--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);

--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);

--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);

--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);

--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);

--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));

--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);

--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));

--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);

--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);

--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);

--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);

--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';

--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));

--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);

--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);

--
-- Name: idx_categories_display_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_categories_display_order ON public.categories USING btree (display_order);

--
-- Name: idx_categories_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_categories_is_active ON public.categories USING btree (is_active);

--
-- Name: idx_community_posts_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_community_posts_created_at ON public.community_posts USING btree (created_at DESC);

--
-- Name: idx_community_posts_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_community_posts_user_id ON public.community_posts USING btree (user_id);

--
-- Name: idx_goals_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_goals_user_id ON public.goals USING btree (user_id);

--
-- Name: idx_messages_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_created_at ON public.messages USING btree (created_at DESC);

--
-- Name: idx_messages_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_session_id ON public.messages USING btree (session_id);

--
-- Name: idx_progress_stats_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progress_stats_category_id ON public.progress_stats USING btree (category_id);

--
-- Name: idx_progress_stats_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progress_stats_user_id ON public.progress_stats USING btree (user_id);

--
-- Name: idx_recordings_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recordings_session_id ON public.recordings USING btree (session_id);

--
-- Name: idx_recordings_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recordings_user_id ON public.recordings USING btree (user_id);

--
-- Name: idx_sessions_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_category_id ON public.sessions USING btree (category_id);

--
-- Name: idx_sessions_is_practice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_is_practice ON public.sessions USING btree (is_practice) WHERE (is_practice = true);

--
-- Name: idx_sessions_started_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_started_at ON public.sessions USING btree (started_at DESC);

--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_user_id ON public.sessions USING btree (user_id);

--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);

--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));

--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);

--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);

--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);

--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);

--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);

--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);

--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");

--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);

--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);

--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);

--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");

--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);

--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();

--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();

--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();

--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();

--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();

--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();

--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();

--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();

--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;

--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;

--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;

--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;

--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;

--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;

--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;

--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;

--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;

--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;

--
-- Name: community_posts community_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_posts
    ADD CONSTRAINT community_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- Name: goals goals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- Name: messages messages_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;

--
-- Name: progress_stats progress_stats_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_stats
    ADD CONSTRAINT progress_stats_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;

--
-- Name: progress_stats progress_stats_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_stats
    ADD CONSTRAINT progress_stats_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE SET NULL;

--
-- Name: progress_stats progress_stats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_stats
    ADD CONSTRAINT progress_stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- Name: recordings recordings_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordings
    ADD CONSTRAINT recordings_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE SET NULL;

--
-- Name: recordings recordings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordings
    ADD CONSTRAINT recordings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- Name: sessions sessions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;

--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);

--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);

--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);

--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);

--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;

--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);

--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: users Anyone can register; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can register" ON public.users FOR INSERT WITH CHECK (true);

--
-- Name: app_config App config can be inserted by admins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config can be inserted by admins" ON public.app_config FOR INSERT WITH CHECK (true);

--
-- Name: app_config App config can be updated by admins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config can be updated by admins" ON public.app_config FOR UPDATE USING (true);

--
-- Name: app_config App config is viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "App config is viewable by everyone" ON public.app_config FOR SELECT USING (true);

--
-- Name: categories Categories are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Categories are viewable by everyone" ON public.categories FOR SELECT USING (true);

--
-- Name: community_posts Community posts are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community posts are viewable by everyone" ON public.community_posts FOR SELECT USING (true);

--
-- Name: messages Users can create messages in own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create messages in own sessions" ON public.messages FOR INSERT WITH CHECK (true);

--
-- Name: community_posts Users can create own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own community posts" ON public.community_posts FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: goals Users can create own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own goals" ON public.goals FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: progress_stats Users can create own progress stats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own progress stats" ON public.progress_stats FOR INSERT WITH CHECK ((auth.uid() = user_id));

--
-- Name: recordings Users can create own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own recordings" ON public.recordings FOR INSERT WITH CHECK (true);

--
-- Name: sessions Users can create own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own sessions" ON public.sessions FOR INSERT WITH CHECK (true);

--
-- Name: community_posts Users can delete own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own community posts" ON public.community_posts FOR DELETE USING ((auth.uid() = user_id));

--
-- Name: goals Users can delete own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own goals" ON public.goals FOR DELETE USING ((auth.uid() = user_id));

--
-- Name: recordings Users can delete own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own recordings" ON public.recordings FOR DELETE USING (true);

--
-- Name: community_posts Users can update own community posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own community posts" ON public.community_posts FOR UPDATE USING ((auth.uid() = user_id));

--
-- Name: goals Users can update own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own goals" ON public.goals FOR UPDATE USING ((auth.uid() = user_id));

--
-- Name: users Users can update own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profile" ON public.users FOR UPDATE USING (true);

--
-- Name: sessions Users can update own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own sessions" ON public.sessions FOR UPDATE USING (true);

--
-- Name: messages Users can view messages from own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view messages from own sessions" ON public.messages FOR SELECT USING (true);

--
-- Name: goals Users can view own goals; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own goals" ON public.goals FOR SELECT USING ((auth.uid() = user_id));

--
-- Name: progress_stats Users can view own progress stats; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own progress stats" ON public.progress_stats FOR SELECT USING ((auth.uid() = user_id));

--
-- Name: recordings Users can view own recordings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own recordings" ON public.recordings FOR SELECT USING (true);

--
-- Name: sessions Users can view own sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own sessions" ON public.sessions FOR SELECT USING (true);

--
-- Name: users Users table is readable for login; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users table is readable for login" ON public.users FOR SELECT USING (true);

--
-- Name: app_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.app_config ENABLE ROW LEVEL SECURITY;

--
-- Name: categories; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

--
-- Name: community_posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.community_posts ENABLE ROW LEVEL SECURITY;

--
-- Name: goals; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: messages messages_delete_custom_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY messages_delete_custom_auth ON public.messages FOR DELETE USING (true);

--
-- Name: progress_stats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.progress_stats ENABLE ROW LEVEL SECURITY;

--
-- Name: recordings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.recordings ENABLE ROW LEVEL SECURITY;

--
-- Name: recordings recordings_delete_custom_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY recordings_delete_custom_auth ON public.recordings FOR DELETE USING (true);

--
-- Name: sessions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions sessions_delete_custom_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY sessions_delete_custom_auth ON public.sessions FOR DELETE USING (true);

--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Allow authenticated deletes; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated deletes" ON storage.objects FOR DELETE USING ((bucket_id = 'recordings'::text));

--
-- Name: objects Allow authenticated uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated uploads" ON storage.objects FOR INSERT WITH CHECK ((bucket_id = 'recordings'::text));

--
-- Name: objects Allow public reads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public reads" ON storage.objects FOR SELECT USING ((bucket_id = 'recordings'::text));

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');
