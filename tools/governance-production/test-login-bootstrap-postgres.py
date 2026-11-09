"""GitHub-only synthetic Login read tests. No production entrypoint or data."""
import contextlib
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import re
import sys
import types
import unittest

if len(sys.argv) != 1 or os.environ.get('NARROW_READER_ISOLATED_CI') != '1':
    raise SystemExit('Use the isolated GitHub fixture lane')
if any(k.startswith('PG') or k in ('PRODUCTION_DATABASE_URL', 'GOVERNANCE_DATABASE_URL')
       for k in os.environ):
    raise SystemExit('Fixture tests refuse credential and database overrides')

import psycopg
from psycopg.types.json import Jsonb
from psycopg.pq import TransactionStatus

spec = importlib.util.spec_from_file_location('login_fixture', Path(__file__).with_name('login_bootstrap_fixture.py'))
reader = importlib.util.module_from_spec(spec)
spec.loader.exec_module(reader)
SENTINEL = 'SYNTHETIC_PRIVATE_VALUE_MUST_NOT_LEAVE_FIXTURE'
EVIDENCE_BLOBS = {
    'scripts/apply-shared-auth-routes.py': 'b690f2550afbe0c82d8828b34eac89fae0d71dcc',
    'scripts/register-auth-login-layout.py': '0e60db7b6b9c104af032af0f19968a66ec799e11',
    'scripts/register-auth-delivery-work-package.py': '4c4bd1367a2abf9af2f66f21ad4fbf505bebe7be',
    'scripts/register-existing-auth-contracts.py': '8891a7595404fed40dd50f53f3abe2e68ac4a12c',
    'tools/governance-production/mfa-login-contract.json': 'dabac4908b51e8deaf28b69ce206305617d87507',
    'tools/governance-production/public_login_grants.py': 'fc3323e0e6c1bc549810683a0278d1a71c132939',
    'packages/primecare_ui/lib/src/features/auth/login_view.dart': '87ebbc56237c2a195996e702793ea644bb2b9d32',
    'packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart': '95ca04b719eaa554c414e826ff689b9c2058c028',
}


def connection(**changes):
    config = dict(host='localhost', hostaddr='127.0.0.1', port=55432,
        dbname='postgres', user='postgres', password='synthetic', autocommit=True,
        sslmode='verify-full', sslrootcert='/tmp/narrow-reader-fixture/server.crt',
        gssencmode='disable', passfile='/dev/null', connect_timeout=5, prepare_threshold=None)
    config.update(changes)
    return psycopg.connect(**config)


def fixture():
    data = {table: [] for table in reader.FIELDS}
    data['auth_route_registry'] = [dict(id=1, route_code='login', route_path='/login', flow_type='shared_credentials')]
    data['screens'] = [dict(id=10, app_id=20, role_id=None, screen_code='login', route_path='/login',
        actual_file_path='packages/primecare_ui/lib/src/features/auth/login_view.dart', active=1),
        dict(id=11, app_id=21, role_id=None, screen_code='auth_login_web', route_path='/login',
        actual_file_path='websites/typescript/src/auth-screen.ts', active=1)]
    data['apps'] = [dict(id=20, app_code='synthetic_native_owner', active=1),
                    dict(id=21, app_code='ui', active=1)]
    data['screen_api_links'] = [dict(screen_id=10, api_id=30), dict(screen_id=11, api_id=30),
                                dict(screen_id=10, api_id=999)]
    for offset, (_, method, path) in enumerate(reader.OPERATIONS):
        api = dict(id=30 + offset, app_id=20, endpoint_code='synthetic_' + str(offset),
            http_method=method, route_path=path, service_name='auth', auth_required=0 if offset in (0, 3) else 1,
            permission_key='public_password_exchange' if offset == 0 else SENTINEL,
            rate_limit_key=SENTINEL, request_schema='{}', response_schema='{"type":"object"}',
            implementation_status='unverified')
        data['api_endpoints'].append(api)
        data['api_endpoint_registry'].append(dict(id=100 + offset, api_id=api['id'],
            endpoint_code=api['endpoint_code'], method=method, endpoint_path=path))
    # Unrelated values and grants must never be fetched/promoted into authority.
    data['api_endpoints'].append(dict(data['api_endpoints'][0], id=999,
        route_path='/synthetic/unrelated', request_schema=SENTINEL))
    return data


class ObservedDB:
    def __init__(self, db, before_fetch=None, on_execute=None, before_execute=None):
        self.db, self.calls, self.before_fetch, self.on_execute = db, [], before_fetch, on_execute
        self.before_execute = before_execute

    def __getattr__(self, name):
        return getattr(self.db, name)

    def cursor(self):
        owner = self
        class Cursor:
            def __enter__(self):
                self.cur = owner.db.cursor().__enter__()
                return self

            def __exit__(self, *args):
                return self.cur.__exit__(*args)

            def __getattr__(self, name):
                if name == 'description' and owner.before_fetch:
                    return owner.before_fetch(self.cur.description, self.sql)
                return getattr(self.cur, name)

            def execute(self, sql, values=()):
                self.sql = sql
                owner.calls.append((sql, tuple(values)))
                if owner.before_execute:
                    owner.before_execute(sql)
                self.cur.execute(sql, values)
                if owner.on_execute:
                    owner.on_execute(sql)

            def fetchmany(self, n):
                if owner.before_fetch and 'govt_source_manifest' in self.sql:
                    raise AssertionError('Invalid metadata should fail before fetch')
                return self.cur.fetchmany(n)
        return Cursor()


class LoginPostgresTests(unittest.TestCase):
    def setUp(self):
        self.db = connection()
        self.addCleanup(self.db.close)

    def table(self, name):
        return '"' + reader.SCHEMA + '"."govt_' + name + '"'

    def install(self, tagged=False, data=None):
        data = fixture() if data is None else data
        self.db.execute(f'DROP SCHEMA IF EXISTS "{reader.SCHEMA}" CASCADE')
        self.db.execute(f'CREATE SCHEMA "{reader.SCHEMA}"')
        self.db.execute(f'CREATE TABLE {self.table("source_manifest")} (manifest_sha256 text, manifest jsonb)')
        manifest = reader.fixture_manifest(tagged)
        self.db.execute(f'INSERT INTO {self.table("source_manifest")} VALUES(%s,%s)',
            (hashlib.sha256(reader.canonical(manifest)).hexdigest(), Jsonb(manifest)))
        for table, fields in reader.FIELDS.items():
            columns = ','.join('"' + key + '" ' + ('jsonb' if tagged else 'bigint' if kind == 'integer' else 'text')
                               for key, kind in fields.items())
            self.db.execute(f'CREATE TABLE {self.table(table)} ({columns})')
            for row in data[table]:
                values = [Jsonb({'t': fields[k] if row[k] is not None else 'null',
                                  'v': str(row[k]) if row[k] is not None else None})
                          if tagged else row[k] for k in fields]
                self.db.execute(f'INSERT INTO {self.table(table)} VALUES({",".join("%s" for _ in fields)})', values)

    def read(self, db=None):
        try:
            return reader.read_fixture(db or self.db)
        finally:
            self.assertEqual(self.db.info.transaction_status, TransactionStatus.IDLE)

    def test_typed_and_tagged_distinct_identity_never_authority(self):
        for tagged in (False, True):
            self.install(tagged)
            receipt = self.read()
            self.assertEqual(receipt['routeMetadata'], 'PRESENT_UNVERIFIED')
            self.assertEqual(receipt['native']['identity'], 'PRESENT_UNVERIFIED')
            self.assertEqual(receipt['web']['identity'], 'PRESENT_UNVERIFIED')
            self.assertEqual(receipt['unresolvedApiLinkCount'], 1)
            for key in ('productionAuthorityEstablished', 'releaseReady', 'contractComplete', 'nativeWebEquivalenceEstablished'):
                self.assertFalse(receipt[key])

    def test_source_evidence_bytes_require_rereview_on_drift(self):
        root = Path(__file__).resolve().parents[2]
        for path, expected in EVIDENCE_BLOBS.items():
            raw = (root / path).read_bytes()
            self.assertEqual(hashlib.sha1(b'blob ' + str(len(raw)).encode() + b'\0' + raw).hexdigest(),
                             expected, path + ': source evidence changed; review scope before updating pin')

    def test_missing_inactive_duplicate_native_not_rescued_by_web(self):
        for state in ('ABSENT', 'INACTIVE', 'AMBIGUOUS', 'ROUTE_CONFLICT'):
            data = fixture()
            if state == 'ABSENT': data['screens'].pop(0)
            if state == 'INACTIVE': data['screens'][0]['active'] = 0
            if state == 'AMBIGUOUS': data['screens'].append(dict(data['screens'][0], id=12))
            if state == 'ROUTE_CONFLICT': data['screens'][0]['route_path'] = '/other'
            self.install(data=data)
            receipt = self.read()
            self.assertEqual(receipt['native']['identity'], state)
            self.assertEqual(receipt['web']['identity'], 'PRESENT_UNVERIFIED')
            self.assertFalse(receipt['contractComplete'])

    def test_source_and_app_binding_remain_unresolved(self):
        data = fixture(); data['screens'][0]['actual_file_path'] = SENTINEL
        data['screens'][0]['app_id'] = 999
        self.install(data=data)
        self.assertEqual(self.read()['native'], dict(identity='PRESENT_UNVERIFIED',
            sourceBinding='UNRESOLVED', appBinding='UNRESOLVED'))
        for duplicate in (False, True):
            data = fixture()
            if duplicate: data['apps'].append(dict(data['apps'][0], app_code=SENTINEL))
            else: data['apps'][0]['active'] = 0
            self.install(data=data)
            self.assertEqual(self.read()['native']['appBinding'], 'UNRESOLVED')

    def test_fixed_method_pairs_duplicates_and_registry_domains(self):
        data = fixture()
        data['api_endpoints'][0]['http_method'] = 'DELETE'
        self.install(data=data)
        self.assertEqual(self.read()['operations']['credentialLogin']['identity'], 'ABSENT')
        data = fixture(); data['api_endpoints'].append(dict(data['api_endpoints'][0], id=88))
        self.install(data=data)
        self.assertEqual(self.read()['operations']['credentialLogin']['identity'], 'AMBIGUOUS')
        data = fixture(); data['api_endpoint_registry'][0]['api_id'] = 999
        data['api_endpoint_registry'][0]['id'] = 30
        self.install(data=data)
        self.assertEqual(self.read()['operations']['credentialLogin']['registry'], 'ABSENT')
        data = fixture(); data['api_endpoints'][1]['id'] = data['api_endpoints'][0]['id']
        self.install(data=data)
        self.assertEqual(self.read()['operations']['credentialLogin']['identity'], 'AMBIGUOUS')

    def test_policy_versions_do_not_establish_authority(self):
        for permission in ('public_password_exchange', 'credential_login', SENTINEL):
            data = fixture(); data['api_endpoints'][0]['permission_key'] = permission
            self.install(data=data)
            result = self.read()
            self.assertTrue(result['operations']['credentialLogin']['policyReviewRequired'])
            self.assertFalse(result['productionAuthorityEstablished'])
        self.install(); before = self.read()
        self.db.execute(f'CREATE TABLE {self.table("api_permissions")} (api_id bigint, can_access bigint)')
        self.db.execute(f'INSERT INTO {self.table("api_permissions")} VALUES(30,0)')
        self.assertEqual(self.read(), before)

    def test_manifest_missing_columns_and_production_format_refused(self):
        for change in ('column', 'relation', 'hash', 'production'):
            self.install()
            manifest = reader.fixture_manifest()
            if change == 'column': manifest['tables'][0]['columns'].pop()
            if change == 'relation': manifest['tables'].pop()
            if change == 'production': manifest['format'] = 'primecare-governance-snapshot-v1'
            digest = '0' * 64 if change == 'hash' else hashlib.sha256(reader.canonical(manifest)).hexdigest()
            self.db.execute(f'UPDATE {self.table("source_manifest")} SET manifest_sha256=%s,manifest=%s', (digest, Jsonb(manifest)))
            observed = ObservedDB(self.db)
            with self.assertRaisesRegex(reader.Fault, '^MANIFEST_UNVERIFIED$'):
                self.read(observed)
            self.assertFalse(any('AS scoped WHERE' in sql for sql, _ in observed.calls))

    def test_empty_metadata_and_fail_before_fetch(self):
        self.install(data={t: [] for t in reader.FIELDS})
        self.assertEqual(self.read()['native']['identity'], 'ABSENT')
        for table, fields in reader.FIELDS.items():
            key = next(iter(fields))
            self.assertEqual(reader._select(reader._Session(self.db), False, table, [[(key, [1])]]), [])
        self.install()
        for mutate in (lambda d: None, lambda d: [], lambda d: list(reversed(d)),
                       lambda d: list(d) + [types.SimpleNamespace(name='extra')]):
            observed = ObservedDB(self.db, before_fetch=lambda d, sql: mutate(d) if 'govt_source_manifest' in sql else d)
            with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$'):
                self.read(observed)
            self.assertEqual(observed.calls[-1][0], 'ROLLBACK')

    def test_bad_tags_oversized_values_and_row_sentinel(self):
        for tag in ({'t': 'text', 'v': '1'}, {'t': 'integer', 'v': True},
                    {'t': 'null', 'v': 'not-null'}, {'t': 'integer', 'v': 'not-an-integer'}):
            self.install(tagged=True)
            self.db.execute(f'UPDATE {self.table("screens")} SET active=%s', (Jsonb(tag),))
            with self.assertRaisesRegex(reader.Fault, '^QUERY_UNAVAILABLE$'): self.read()
        self.install()
        self.db.execute(f'UPDATE {self.table("screens")} SET actual_file_path=%s', ('x' * (reader.MAX_FIELD + 1),))
        with self.assertRaisesRegex(reader.Fault, '^QUERY_UNAVAILABLE$'): self.read()
        data = fixture(); data['screens'] = [dict(data['screens'][0], id=i+1) for i in range(reader.MAX_ROWS+1)]
        self.install(data=data)
        with self.assertRaisesRegex(reader.Fault, '^ROW_LIMIT$'): self.read()

    def test_missing_physical_relation_column_and_null_identity(self):
        self.install()
        self.db.execute(f'DROP TABLE {self.table("apps")}')
        with self.assertRaisesRegex(reader.Fault, '^RELATION_UNAVAILABLE$'): self.read()
        self.install()
        self.db.execute(f'ALTER TABLE {self.table("screens")} DROP COLUMN active')
        with self.assertRaisesRegex(reader.Fault, '^COLUMN_UNAVAILABLE$'): self.read()
        self.install()
        self.db.execute(f'UPDATE {self.table("screens")} SET id=NULL')
        with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$'): self.read()

    def test_transaction_and_cleanup_metadata_cannot_pass(self):
        self.install()
        observed = ObservedDB(self.db, before_fetch=lambda d, sql: [] if sql.startswith('BEGIN ') else d)
        with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$'): self.read(observed)
        def failure(sql):
            if sql == 'ROLLBACK': raise RuntimeError(SENTINEL)
        with self.assertRaisesRegex(reader.Fault, '^ROLLBACK_UNVERIFIED$') as caught:
            self.read(ObservedDB(self.db, on_execute=failure))
        self.assertNotIn(SENTINEL, str(caught.exception))
        try:
            with self.assertRaisesRegex(reader.Fault, '^ROLLBACK_UNVERIFIED$'):
                reader.read_fixture(ObservedDB(self.db, before_execute=failure))
            self.assertEqual(self.db.info.transaction_status, TransactionStatus.INTRANS)
        finally:
            self.db.execute('ROLLBACK')

    def test_real_select_only_role_and_read_denial(self):
        self.install(); role = 'synthetic_login_select_only'
        self.db.execute(f'CREATE ROLE {role} NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOREPLICATION NOBYPASSRLS')
        try:
            self.db.execute(f'GRANT USAGE ON SCHEMA "{reader.SCHEMA}" TO {role}')
            for table in ['source_manifest'] + list(reader.FIELDS):
                self.db.execute(f'GRANT SELECT ON {self.table(table)} TO {role}')
            self.db.execute(f'SET ROLE {role}')
            self.assertEqual(self.read()['native']['identity'], 'PRESENT_UNVERIFIED')
            with self.assertRaises(psycopg.errors.InsufficientPrivilege):
                self.db.execute(f'DELETE FROM {self.table("screens")}')
            self.db.execute('RESET ROLE')
            self.db.execute(f'REVOKE SELECT ON {self.table("screens")} FROM {role}')
            self.db.execute(f'SET ROLE {role}')
            with self.assertRaisesRegex(reader.Fault, '^READ_DENIED$'): self.read()
        finally:
            self.db.execute('RESET ROLE'); self.db.execute(f'DROP OWNED BY {role}'); self.db.execute(f'DROP ROLE {role}')

    def test_actual_reader_transaction_rejects_mutation(self):
        self.install(); checked = []
        def probe(sql):
            if sql.startswith('BEGIN '):
                self.assertEqual(self.db.execute('SHOW transaction_isolation').fetchone(), ('repeatable read',))
                self.db.execute('SAVEPOINT login_probe')
                with self.assertRaises(psycopg.errors.ReadOnlySqlTransaction):
                    self.db.execute(f'DELETE FROM {self.table("screens")}')
                self.db.execute('ROLLBACK TO SAVEPOINT login_probe'); self.db.execute('RELEASE SAVEPOINT login_probe')
                checked.append(True)
        self.read(ObservedDB(self.db, on_execute=probe))
        self.assertEqual(checked, [True])

    def test_tls_and_target_guards(self):
        for changes, message in (({'host': 'wrong.invalid'}, 'does not match host name'),
            ({'sslrootcert': '/tmp/narrow-reader-fixture/untrusted.crt'}, 'certificate verify failed')):
            with self.assertRaises(psycopg.OperationalError) as rejected:
                with connection(**changes): self.fail('TLS accepted an invalid certificate')
            self.assertIn(message, str(rejected.exception))
        fake = types.SimpleNamespace(info=types.SimpleNamespace(hostaddr='192.0.2.1', port=55432, dbname='postgres'))
        with self.assertRaisesRegex(reader.Fault, '^FIXTURE_CONNECTION_REQUIRED$'): reader.read_fixture(fake)
        fake.info.hostaddr = '127.0.0.1'; fake.pgconn = types.SimpleNamespace(ssl_in_use=False)
        with self.assertRaisesRegex(reader.Fault, '^TLS_REQUIRED$'): reader.read_fixture(fake)

    def test_schema_parsing_never_follows_refs_or_leaks_values(self):
        for value in ('{"x":NaN}', '{"x":1e999}', '{"x":1,"x":2}', SENTINEL):
            self.assertEqual(reader._schema(value), 'INVALID_JSON')
        self.assertEqual(reader._schema('{"$ref":"https://unreachable.invalid/private"}'), 'OBJECT_UNVERIFIED')
        for table, fields in reader.FIELDS.items():
            for field, kind in fields.items():
                if kind != 'text': continue
                data = fixture(); data[table][0][field] = SENTINEL
                self.install(data=data)
                out, err = io.StringIO(), io.StringIO()
                with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err): result = self.read()
                self.assertEqual(out.getvalue() + err.getvalue(), '')
                self.assertNotIn(SENTINEL, json.dumps(result))
        self.install()
        def provider_failure(sql):
            if 'AS scoped WHERE' in sql: raise RuntimeError(SENTINEL)
        out, err = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
            with self.assertRaisesRegex(reader.Fault, '^QUERY_UNAVAILABLE$') as caught:
                self.read(ObservedDB(self.db, on_execute=provider_failure))
        self.assertEqual(out.getvalue() + err.getvalue(), '')
        self.assertNotIn(SENTINEL, str(caught.exception))

    def test_route_ambiguity_conflict_and_numeric_domain_separation(self):
        for state in ('AMBIGUOUS', 'IDENTITY_CONFLICT'):
            data = fixture()
            if state == 'AMBIGUOUS': data['auth_route_registry'].append(dict(data['auth_route_registry'][0], id=2))
            else: data['auth_route_registry'][0]['flow_type'] = SENTINEL
            self.install(data=data)
            self.assertEqual(self.read()['routeMetadata'], state)
        data = fixture(); data['screens'][0]['id'] = 30; data['screen_api_links'] = []
        self.install(data=data)
        result = self.read()
        self.assertFalse(result['operations']['credentialLogin']['nativeLinkObserved'])
        data = fixture(); data['screens'][1]['id'] = data['screens'][0]['id']
        self.install(data=data); result = self.read()
        self.assertEqual(result['native']['identity'], 'AMBIGUOUS')
        self.assertEqual(result['web']['identity'], 'AMBIGUOUS')
        self.assertFalse(result['operations']['credentialLogin']['nativeLinkObserved'])
        self.assertFalse(result['operations']['credentialLogin']['webLinkObserved'])

    def test_database_statement_timeout_rolls_back(self):
        self.install()
        def timeout_probe(sql):
            if sql == "SET LOCAL statement_timeout='5s'":
                self.db.execute('SELECT pg_sleep(6)')
        with self.assertRaisesRegex(reader.Fault, '^TIME_LIMIT$'):
            self.read(ObservedDB(self.db, on_execute=timeout_probe))

    def test_query_inventory_scopes_budgets_and_cleanup(self):
        self.install(); observed = ObservedDB(self.db); self.read(observed)
        self.assertEqual((reader.MAX_ROWS, reader.MAX_FIELD, reader.MAX_QUERIES, reader.MAX_BYTES), (64, 8192, 16, 1048576))
        expected_fields = {
            'auth_route_registry': 'id route_code route_path flow_type',
            'screens': 'id app_id role_id screen_code route_path actual_file_path active',
            'apps': 'id app_code active', 'screen_api_links': 'screen_id api_id',
            'api_endpoints': 'id app_id endpoint_code http_method route_path service_name auth_required permission_key rate_limit_key request_schema response_schema implementation_status',
            'api_endpoint_registry': 'id api_id endpoint_code method endpoint_path',
        }
        self.assertEqual({t: list(f) for t, f in reader.FIELDS.items()}, {t: f.split() for t, f in expected_fields.items()})
        expected = [(sql, ()) for sql in [
            'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY', 'SET LOCAL search_path=pg_catalog',
            "SET LOCAL statement_timeout='5s'", "SET LOCAL lock_timeout='1s'",
            "SET LOCAL idle_in_transaction_session_timeout='10s'",
            "SELECT current_setting('transaction_read_only') AS readonly",
            'SELECT CASE WHEN octet_length(manifest_sha256)<=64 THEN manifest_sha256 ELSE NULL END AS manifest_sha256,'
            'CASE WHEN octet_length(manifest::text)<=1048576 THEN manifest ELSE NULL END AS manifest '
            'FROM "synthetic_login_contract_fixture".govt_source_manifest LIMIT 2']]
        def selected(table, predicate, values):
            columns = expected_fields[table].split(); projected = []
            for name in columns:
                col = '"' + name + '"'
                if name not in ('id', 'app_id', 'role_id', 'screen_id', 'api_id', 'active', 'auth_required'):
                    col = f'CASE WHEN octet_length({col})<=8192 THEN {col} ELSE (1/(length({col})-length({col})))::text END'
                projected.append(col + ' AS "' + name + '"')
            expected.append(('SELECT ' + ','.join('"' + name + '"' for name in columns) +
                ' FROM (SELECT ' + ','.join(projected) + ' FROM "synthetic_login_contract_fixture"."govt_' + table +
                '") AS scoped WHERE ' + predicate + ' LIMIT 65', tuple(values)))
        selected('auth_route_registry', '("route_code" IN (%s)) OR ("route_path" IN (%s))', ['login', '/login'])
        selected('screens', '("screen_code" IN (%s,%s)) OR ("route_path" IN (%s))', ['login', 'auth_login_web', '/login'])
        selected('apps', '("id" IN (%s,%s))', [20, 21])
        selected('screen_api_links', '("screen_id" IN (%s,%s))', [10, 11])
        selected('api_endpoints', ' OR '.join(['("http_method" IN (%s) AND "route_path" IN (%s))'] * 4),
            ['POST', '/v1/auth/login', 'GET', '/v1/auth/me', 'POST', '/v1/auth/me', 'POST', '/v1/auth/logout'])
        selected('api_endpoint_registry', '("api_id" IN (%s,%s,%s,%s))', [30, 31, 32, 33])
        expected.append(('ROLLBACK', ()))
        self.assertEqual(observed.calls, expected)
        self.install(tagged=True); tagged_db = ObservedDB(self.db); self.read(tagged_db)
        tagged_expected = []
        for sql, values in expected:
            if 'AS scoped WHERE' in sql:
                table = re.search(r'\."govt_([a-z_]+)"', sql)[1]
                projections = []
                for name in expected_fields[table].split():
                    kind = 'integer' if name in ('id', 'app_id', 'role_id', 'screen_id', 'api_id', 'active', 'auth_required') else 'text'
                    typ = 'bigint' if kind == 'integer' else 'text'; col = '"' + name + '"'
                    col = (f"CASE WHEN {col} IS NULL OR ({col}->>'t'='null' AND {col}->'v'='null'::jsonb) "
                           f"THEN NULL::{typ} WHEN {col}->>'t'='{kind}' AND jsonb_typeof({col}->'v')='string' "
                           f"THEN ({col}->>'v')::{typ} ELSE (1/(length({col}::text)-length({col}::text)))::{typ} END")
                    if kind == 'text': col = f'CASE WHEN octet_length({col})<=8192 THEN {col} ELSE (1/(length({col})-length({col})))::text END'
                    projections.append(col + ' AS "' + name + '"')
                sql = sql.split(' FROM (SELECT ')[0] + ' FROM (SELECT ' + ','.join(projections) + \
                    ' FROM "synthetic_login_contract_fixture"."govt_' + table + '") AS scoped WHERE ' + sql.split('AS scoped WHERE ')[1]
            tagged_expected.append((sql, values))
        self.assertEqual(tagged_db.calls, tagged_expected)
        tables = set()
        for sql, values in observed.calls:
            self.assertNotIn('SELECT *', sql)
            self.assertNotIn('COMMIT', sql)
            if 'AS scoped WHERE' in sql:
                tables.update(re.findall(r'\."govt_([a-z_]+)"', sql))
                self.assertTrue(values); self.assertTrue(sql.endswith('LIMIT 65'))
        self.assertEqual(tables, set(reader.FIELDS))
        self.assertEqual(observed.calls[-1][0], 'ROLLBACK')
        self.assertLessEqual(len(observed.calls), reader.MAX_QUERIES + 1)
        for field, value, reason in [('queries', reader.MAX_QUERIES, 'QUERY_LIMIT'),
                                   ('start', -100, 'TIME_LIMIT'), ('bytes', reader.MAX_BYTES, 'BYTE_LIMIT')]:
            session = reader._Session(self.db); setattr(session, field, value)
            with self.assertRaisesRegex(reader.Fault, '^' + reason + '$'):
                session.query('SELECT 1 AS n', (), ('n',))


if __name__ == '__main__':
    unittest.main(verbosity=2)
