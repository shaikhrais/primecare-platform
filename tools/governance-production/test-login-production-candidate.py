"""GitHub-only candidate tests; synthetic rows, no production connection."""
import contextlib
import hashlib
import importlib.util
import io
import json
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
        for mutation in ('hash', 'format', 'duplicate', 'column', 'storage'):
            self.install()
            if mutation == 'hash':
                self.digest = '0' * 64
            else:
                if mutation == 'format': self.manifest['format'] = 'synthetic'
                if mutation == 'duplicate': self.manifest['tables'].append(self.manifest['tables'][0])
                if mutation == 'column': self.manifest['tables'][0]['columns'].pop()
                if mutation == 'storage': self.manifest['tables'][0]['columns'][0]['storage_types'] = ['blob']
                self.digest = hashlib.sha256(reader.canonical(self.manifest)).hexdigest()
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
        probed = []
        rejected = []
        def write(sql):
            if 'govt_source_manifest' in sql:
                probed.append(True)
                try:
                    self.db.execute(f'INSERT INTO {self.table("apps")} (id) VALUES (987654)')
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


if __name__ == '__main__':
    unittest.main(verbosity=2)
