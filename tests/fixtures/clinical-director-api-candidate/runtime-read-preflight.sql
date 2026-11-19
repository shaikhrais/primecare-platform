-- REVIEW PLAN ONLY. Never auto-run or connect using a CI migrator credential.
-- A separately approved operator must establish provenance to the active
-- governance Worker's existing DB_URL, without reading/exporting that secret.
-- No rows, tokens, connection identities, credentials or patient data emitted.
BEGIN READ ONLY;
SET LOCAL statement_timeout = '3s';
SET LOCAL lock_timeout = '1s';
SELECT has_schema_privilege('public','USAGE') AS public_schema_usage,
       COALESCE((SELECT NOT rolsuper AND NOT rolbypassrls
                 FROM pg_catalog.pg_roles WHERE rolname=CURRENT_USER),false) AS not_superuser_or_bypassrls;
WITH required(relation_name,column_name) AS (VALUES
 ('public.auth_sessions','token_hash'),('public.auth_sessions','user_id'),('public.auth_sessions','expires_at'),
 ('public.users','id'),('public.users','tenant_id'),('public.users','roles'),('public.users','status'),
 ('public.tenants','id'),('public.tenants','status'),
 ('public.clinical_branch_director_effective_scope','tenant_id'),
 ('public.clinical_branch_director_effective_scope','director_user_id'),
 ('public.clinical_branch_director_effective_scope','branch_id')
)
SELECT bool_and(COALESCE(has_column_privilege(to_regclass(relation_name),column_name,'SELECT'),false))
       AS minimum_read_columns_available
FROM required;
WITH clinical(relation_name) AS (VALUES
 ('public.clinical_verified_branches'),('public.clinical_branch_grant_admins'),
 ('public.clinical_branch_director_grants'),('public.clinical_branch_access_audit')
)
SELECT bool_and(to_regclass(relation_name) IS NOT NULL) AS authority_tables_exist,
       bool_and(NOT COALESCE(has_table_privilege(to_regclass(relation_name),'INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER'),false)
         AND NOT COALESCE(has_any_column_privilege(to_regclass(relation_name),'INSERT,UPDATE,REFERENCES'),false)) AS no_clinical_write_privileges
FROM clinical;
SELECT COALESCE((SELECT relkind='v' FROM pg_catalog.pg_class
                 WHERE oid=to_regclass('public.clinical_branch_director_effective_scope')),false) AS scope_is_view,
       COALESCE((SELECT NOT ('security_invoker=true'=ANY(COALESCE(reloptions,ARRAY[]::text[])))
                 FROM pg_catalog.pg_class WHERE oid=to_regclass('public.clinical_branch_director_effective_scope')),false)
       AS reviewed_owner_rights_view_mode;
SELECT COALESCE((SELECT NOT pg_has_role(relowner,'USAGE') FROM pg_catalog.pg_class
                 WHERE oid=to_regclass('public.clinical_branch_director_effective_scope')),false)
       AS runtime_cannot_assume_scope_owner;
-- Resolve exact tables, column types and privileges without examining data.
-- WHERE false prevents identity rows; no real session is submitted.
SELECT u.id,u.tenant_id,u.roles
FROM public.auth_sessions s JOIN public.users u ON u.id=s.user_id
JOIN public.tenants t ON t.id=u.tenant_id
WHERE false AND s.token_hash='' AND s.expires_at>CURRENT_TIMESTAMP
  AND u.status='active' AND t.status='active';
SELECT 1 FROM public.clinical_branch_director_effective_scope
WHERE false AND tenant_id='' AND director_user_id='';
SELECT COUNT(DISTINCT branch_id)=0 AS empty_scope_query_compiles FROM public.clinical_branch_director_effective_scope
WHERE false AND tenant_id='' AND director_user_id='';
ROLLBACK;
