"""GitHub-only candidate tests; synthetic rows, no production connection."""
import contextlib
import hashlib
import importlib.util
import io
import json
import re
from pathlib import Path
import types
import unittest
from unittest.mock import patch

# Import existing guarded harness. It refuses non-CI and credential overrides.
spec = importlib.util.spec_from_file_location('fixture_harness',
    Path(__file__).with_name('test-login-bootstrap-postgres.py'))
harness = importlib.util.module_from_spec(spec)
spec.loader.exec_module(harness)
import login_production_candidate as reader
from psycopg.types.json import Jsonb
from psycopg.errors import ReadOnlySqlTransaction
from psycopg.pq import TransactionStatus


class CandidateTests(unittest.TestCase):
    def setUp(self):
        self.db = harness.connection()
        self.addCleanup(self.db.close)

    def table(self, name):
        return '"' + reader.SCHEMA + '"."govt_' + name + '"'

    def install(self, mode='typed', data=None):
        data = harness.fixture() if data is None else data
        manifest = {'format': 'primecare-governance-snapshot-v1', 'tables': []}
        self.db.execute(f'DROP SCHEMA IF EXISTS "{reader.SCHEMA}" CASCADE')
        self.db.execute(f'CREATE SCHEMA "{reader.SCHEMA}"')
        self.db.execute(f'CREATE TABLE {self.table("source_manifest")} (manifest_sha256 text, manifest jsonb)')
        for table, fields in reader.FIELDS.items():
            columns = []
            tagged = {}
            spec = {'name': table, 'columns': []}
            for index, (key, kind) in enumerate(fields.items()):
                tagged[key] = mode == 'tagged' or (mode == 'mixed' and index % 2 == 0)
                columns.append('"' + key + '" ' + ('jsonb' if tagged[key] else 'bigint' if kind == 'integer' else 'text'))
                spec['columns'].append({'name': key, 'storage_types': [] if tagged[key] else [kind]})
            manifest['tables'].append(spec)
            self.db.execute(f'CREATE TABLE {self.table(table)} ({",".join(columns)})')
            for row in data[table]:
                values = [Jsonb({'t': fields[k] if row[k] is not None else 'null',
                    'v': str(row[k]) if row[k] is not None else None}) if tagged[k] else row[k] for k in fields]
                self.db.execute(f'INSERT INTO {self.table(table)} VALUES({",".join("%s" for _ in fields)})', values)
        self.digest = hashlib.sha256(reader.canonical(manifest)).hexdigest()
        self.manifest = manifest
        self.db.execute(f'INSERT INTO {self.table("source_manifest")} VALUES(%s,%s)', (self.digest, Jsonb(manifest)))

    def read(self, db=None):
        try:
            return reader._read_snapshot(db or self.db, self.digest)
        finally:
            self.assertEqual(self.db.info.transaction_status, TransactionStatus.IDLE)

    def test_typed_tagged_and_mixed_storage(self):
        for mode in ('typed', 'tagged', 'mixed'):
            self.install(mode)
            out = self.read()
            self.assertEqual(out['native']['identity'], 'PRESENT_UNVERIFIED')
            self.assertEqual(out['web']['identity'], 'PRESENT_UNVERIFIED')
            self.assertEqual(out['unresolvedApiLinkCount'], 1)
            for key in ('productionAuthorityEstablished', 'releaseReady', 'contractComplete',
                        'nativeWebEquivalenceEstablished'):
                self.assertFalse(out[key])

    def test_pin_and_manifest_shape_fail_before_scope_reads(self):
        for mutation in ('hash', 'body', 'format', 'duplicate', 'relation', 'duplicate_column', 'column', 'storage'):
            self.install()
            if mutation == 'hash':
                self.digest = '0' * 64
            else:
                if mutation == 'format': self.manifest['format'] = 'synthetic'
                if mutation == 'body': self.manifest['extra'] = 'tampered'
                if mutation == 'relation': self.manifest['tables'].pop()
                if mutation == 'duplicate_column': self.manifest['tables'][0]['columns'].append(self.manifest['tables'][0]['columns'][0])
                if mutation == 'duplicate': self.manifest['tables'].append(self.manifest['tables'][0])
                if mutation == 'column': self.manifest['tables'][0]['columns'].pop()
                if mutation == 'storage': self.manifest['tables'][0]['columns'][0]['storage_types'] = ['blob']
                if mutation != 'body': self.digest = hashlib.sha256(reader.canonical(self.manifest)).hexdigest()
                self.db.execute(f'UPDATE {self.table("source_manifest")} SET manifest_sha256=%s, manifest=%s',
                    (self.digest, Jsonb(self.manifest)))
            observed = harness.ObservedDB(self.db)
            with self.assertRaisesRegex(reader.Fault, '^MANIFEST_UNVERIFIED$'):
                self.read(observed)
            self.assertFalse(any('govt_screens' in sql or 'govt_auth_route_registry' in sql for sql, _ in observed.calls))

    def test_public_entrypoint_rejects_fixture_without_queries(self):
        observed = harness.ObservedDB(self.db)
        with self.assertRaisesRegex(reader.Fault, '^CONNECTION_UNVERIFIED$'):
            reader.read_candidate(observed)
        self.assertEqual(observed.calls, [])

    def test_public_entrypoint_fixed_pin_and_tls_guards(self):
        options = dict(sslmode='verify-full', sslrootcert='/etc/ssl/certs/ca-certificates.crt',
                       gssencmode='disable')
        info = types.SimpleNamespace(host='pooled.db.prisma.io', port=5432, dbname='postgres',
            transaction_status=0, get_parameters=lambda: options)
        db = types.SimpleNamespace(info=info, pgconn=types.SimpleNamespace(ssl_in_use=True), autocommit=True)
        with patch.object(reader, '_read_snapshot', return_value={'synthetic': True}) as run:
            self.assertEqual(reader.read_candidate(db), {'synthetic': True})
            run.assert_called_once_with(db, reader.MANIFEST_SHA)
        for key, value in [('sslmode', 'require'), ('sslrootcert', '/tmp/untrusted'),
                           ('hostaddr', '127.0.0.1'), ('service', 'external'), ('gssencmode', 'prefer')]:
            old = dict(options); options[key] = value
            with patch.object(reader, '_read_snapshot') as run:
                with self.assertRaisesRegex(reader.Fault, '^TLS_REQUIRED$'): reader.read_candidate(db)
                run.assert_not_called()
            options.clear(); options.update(old)

    def test_nonidle_and_unencrypted_connection_rejected(self):
        options = dict(sslmode='verify-full', sslrootcert='/etc/ssl/certs/ca-certificates.crt',
                       gssencmode='disable')
        info = types.SimpleNamespace(host='pooled.db.prisma.io', port=5432, dbname='postgres',
            transaction_status=2, get_parameters=lambda: options)
        db = types.SimpleNamespace(info=info, pgconn=types.SimpleNamespace(ssl_in_use=True), autocommit=True)
        with patch.object(reader, '_read_snapshot') as run:
            with self.assertRaisesRegex(reader.Fault, '^READONLY_UNVERIFIED$'): reader.read_candidate(db)
            info.transaction_status = 0
            db.autocommit = False
            with self.assertRaisesRegex(reader.Fault, '^READONLY_UNVERIFIED$'): reader.read_candidate(db)
            db.autocommit = True
            db.pgconn.ssl_in_use = False
            with self.assertRaisesRegex(reader.Fault, '^TLS_REQUIRED$'): reader.read_candidate(db)
            run.assert_not_called()

    def test_row_limit_and_rollback_failure_are_fixed_faults(self):
        data = harness.fixture()
        data['auth_route_registry'] = [dict(data['auth_route_registry'][0], id=i+1) for i in range(65)]
        self.install(data=data)
        with self.assertRaisesRegex(reader.Fault, '^ROW_LIMIT$'): self.read()
        self.install()
        def fail(sql):
            if sql == 'ROLLBACK': raise RuntimeError(harness.SENTINEL)
        observed = harness.ObservedDB(self.db, before_execute=fail)
        try:
            with self.assertRaisesRegex(reader.Fault, '^ROLLBACK_UNVERIFIED$'):
                reader._read_snapshot(observed, self.digest)
            self.assertEqual(self.db.info.transaction_status, TransactionStatus.INTRANS)
        finally:
            self.db.execute('ROLLBACK')

    def test_exact_scope_and_readonly(self):
        self.install('mixed')
        observed = harness.ObservedDB(self.db)
        self.read(observed)
        tables = [sql for sql, _ in observed.calls if 'FROM (SELECT' in sql]
        self.assertEqual(len(tables), 6)
        for table in reader.FIELDS:
            self.assertEqual(sum('"govt_' + table + '"' in sql for sql in tables), 1)
        self.assertFalse(any('SELECT *' in sql for sql, _ in observed.calls))
        endpoint = next(values for sql, values in observed.calls if '"govt_api_endpoints"' in sql)
        self.assertEqual(endpoint, ('POST', '/v1/auth/login', 'GET', '/v1/auth/me',
                                    'POST', '/v1/auth/me', 'POST', '/v1/auth/logout'))
        self.assertEqual(observed.calls[-1][0], 'ROLLBACK')
        expected = {
            'auth_route_registry': ('login', '/login'),
            'screens': ('login', 'auth_login_web', '/login'),
            'apps': (20, 21),
            'screen_api_links': (10, 11),
            'api_endpoints': ('POST', '/v1/auth/login', 'GET', '/v1/auth/me',
                              'POST', '/v1/auth/me', 'POST', '/v1/auth/logout'),
            'api_endpoint_registry': (30, 31, 32, 33),
        }
        for table, values in expected.items():
            self.assertEqual(next(v for sql, v in observed.calls if '"govt_' + table + '"' in sql), values)
        self.assertEqual(len(observed.calls), 14)
        # Type-preserving probe works for typed/tagged/mixed id columns.
        # Prove it is valid in writable mode before testing read-only rejection.
        mutation = f'UPDATE {self.table("apps")} SET id=id WHERE FALSE'
        self.db.execute(mutation)
        probed = []
        rejected = []
        def write(sql):
            if 'govt_source_manifest' in sql:
                probed.append(True)
                try:
                    self.db.execute(mutation)
                except ReadOnlySqlTransaction:
                    rejected.append(True)
                    raise
                else:
                    self.fail('Write was not rejected by the read-only transaction')
        with self.assertRaises(reader.Fault):
            self.read(harness.ObservedDB(self.db, before_execute=write))
        self.assertEqual(probed, [True])
        self.assertEqual(rejected, [True])

    def test_privacy_and_absent_native_never_rescued(self):
        data = harness.fixture()
        data['screens'] = [r for r in data['screens'] if r['screen_code'] != 'login']
        self.install(data=data)
        stdout, stderr = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            out = self.read()
        self.assertEqual(out['native']['identity'], 'ABSENT')
        self.assertNotIn(harness.SENTINEL, json.dumps(out) + stdout.getvalue() + stderr.getvalue())
        self.db.execute(f'DROP TABLE {self.table("apps")}')
        with self.assertRaisesRegex(reader.Fault, '^RELATION_UNAVAILABLE$'):
            self.read()

    def test_real_select_only_and_denial(self):
        self.install()
        self.db.execute('DROP ROLE IF EXISTS login_candidate_select')
        self.db.execute('CREATE ROLE login_candidate_select')
        self.db.execute(f'GRANT USAGE ON SCHEMA "{reader.SCHEMA}" TO login_candidate_select')
        self.db.execute(f'GRANT SELECT ON ALL TABLES IN SCHEMA "{reader.SCHEMA}" TO login_candidate_select')
        self.db.execute('SET ROLE login_candidate_select')
        try:
            self.read()
        finally:
            self.db.execute('RESET ROLE')
        self.db.execute(f'REVOKE SELECT ON {self.table("screens")} FROM login_candidate_select')
        self.db.execute('SET ROLE login_candidate_select')
        try:
            with self.assertRaisesRegex(reader.Fault, '^READ_DENIED$'): self.read()
        finally:
            self.db.execute('RESET ROLE')
        self.db.execute(f'DROP OWNED BY login_candidate_select')
        self.db.execute('DROP ROLE login_candidate_select')

    def test_query_inventory_scopes_budgets_and_cleanup(self):
        self.install(); observed = harness.ObservedDB(self.db); self.read(observed)
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
            'FROM "governance_68b0b02dd1215f58630d2c1a".govt_source_manifest LIMIT 2']]
        def selected(table, predicate, values):
            columns = expected_fields[table].split(); projected = []
            for name in columns:
                col = '"' + name + '"'
                if name not in ('id', 'app_id', 'role_id', 'screen_id', 'api_id', 'active', 'auth_required'):
                    col = f'CASE WHEN octet_length({col})<=8192 THEN {col} ELSE (1/(length({col})-length({col})))::text END'
                projected.append(col + ' AS "' + name + '"')
            expected.append(('SELECT ' + ','.join('"' + name + '"' for name in columns) +
                ' FROM (SELECT ' + ','.join(projected) + ' FROM "governance_68b0b02dd1215f58630d2c1a"."govt_' + table +
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
        self.install('tagged'); tagged_db = harness.ObservedDB(self.db); self.read(tagged_db)
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
                    ' FROM "governance_68b0b02dd1215f58630d2c1a"."govt_' + table + '") AS scoped WHERE ' + sql.split('AS scoped WHERE ')[1]
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
