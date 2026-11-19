import hashlib, json, os
from pathlib import Path
import psycopg
from psycopg import sql

data = Path('tests/fixtures/clinical-director-api-candidate/migration-review.sql').read_bytes()
pin = '6b6bf92aa84b37caa01167d408b9cdef14ca5c8b2f25f1534e573f01d2e70a3d'
if hashlib.sha256(data).hexdigest() != pin:
    raise SystemExit('Reviewed migration hash mismatch.')
fixture = os.environ.get('CLINICAL_MIGRATION_FIXTURE') == '1'
if fixture and (os.environ.get('GITHUB_ACTIONS') != 'true' or os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL')):
    raise SystemExit('Disposable runner only.')
dsn = 'postgresql://clinical_fixture:fixture-only@127.0.0.1:5432/clinical_fixture' if fixture else os.environ.get('PRODUCTION_DATABASE_URL')
if not dsn:
    raise SystemExit('Production credential not available to this protected job.')

tables = ['clinical_verified_branches','clinical_branch_grant_admins',
          'clinical_branch_director_grants','clinical_branch_access_audit']
view = 'clinical_branch_director_effective_scope'
seq = 'clinical_branch_access_audit_id_seq'
names = [*tables,view,seq,'clinical_branch_director_single_open_grant']
expected = dict([(name,'r') for name in tables]+[(view,'v'),(seq,'S'),
                ('clinical_branch_director_single_open_grant','i')])
stage = 'connect'
committed = False

def objects(cur):
    cur.execute("""
        SELECT c.relname::text,c.relkind::text
        FROM pg_catalog.pg_class c
        JOIN pg_catalog.pg_namespace n ON n.oid=c.relnamespace
        WHERE n.nspname='public' AND c.relname::text=ANY(%s)
    """,(names,))
    return dict(cur.fetchall())

def verify(cur):
    if objects(cur) != expected:
        raise RuntimeError('new schema object mismatch')
    cur.execute("""
        SELECT count(*) FROM pg_catalog.pg_class c
        JOIN pg_catalog.pg_namespace n ON n.oid=c.relnamespace
        CROSS JOIN LATERAL pg_catalog.aclexplode(c.relacl) a
        WHERE n.nspname='public' AND c.relname::text=ANY(%s)
          AND a.grantee<>c.relowner
    """,([*tables,view,seq],))
    if cur.fetchone() != (0,):
        raise RuntimeError('unexpected default access')
    for name in [*tables,view]:
        cur.execute(sql.SQL('SELECT NOT EXISTS (SELECT 1 FROM {}.{})').format(
            sql.Identifier('public'),sql.Identifier(name)))
        if cur.fetchone() != (True,):
            raise RuntimeError('schema unexpectedly populated')

try:
    with psycopg.connect(dsn,connect_timeout=8) as conn:
        if fixture:
            with conn.cursor() as init:
                init.execute("SELECT current_database()")
                if init.fetchone() != ('clinical_fixture',):
                    raise RuntimeError('not the disposable database')
                init.execute("CREATE TABLE public.tenants(id text PRIMARY KEY,status text NOT NULL)")
                init.execute("CREATE TABLE public.users(id text PRIMARY KEY,tenant_id text NOT NULL REFERENCES public.tenants(id),roles text,status text)")
            conn.commit()
        with conn.cursor() as cur:
            stage = 'preflight'
            cur.execute("SET LOCAL lock_timeout = '3000ms'")
            cur.execute("SET LOCAL statement_timeout = '15000ms'")
            cur.execute("SET LOCAL search_path TO public")
            cur.execute('SELECT current_schema(), pg_catalog.pg_try_advisory_xact_lock(692047823)')
            if cur.fetchone() != ('public',True) or objects(cur):
                raise RuntimeError('schema lock or collision')
            stage = 'reviewed schema SQL'
            # Use the client-side cursor for fixed multi-statement SQL. It
            # sends a simple query instead of preparing the migration batch.
            with psycopg.ClientCursor(conn) as migration:
                migration.execute(data.decode('utf-8'))
            stage = 'pre-commit verification'
            verify(cur)
            stage = 'commit'
            conn.commit()
            committed = True
            stage = 'read-only post-commit verification'
            conn.read_only = True
            cur.execute("SET LOCAL statement_timeout = '10000ms'")
            verify(cur)
            conn.rollback()
    print(json.dumps({'schema_only':True,'new_tables':4,'new_views':1,
                      'all_empty':True,'nonowner_acl_entries':0,'deployed_api':False,
                      'deployed_dashboard':False,'migration_sha256':pin},sort_keys=True))
except Exception as error:
    state = 'DDL committed; inspect production state before any retry' if committed else (
        'commit outcome uncertain; inspect production state before any retry' if stage=='commit'
        else 'no successful transaction commit')
    sqlstate = getattr(error,'sqlstate',None)
    label = sqlstate if isinstance(sqlstate,str) and len(sqlstate)==5 and sqlstate.isalnum() else 'not_available'
    raise SystemExit(f'Schema-only operation failed during {stage} (SQLSTATE {label}); {state}. Connection details suppressed.') from None
