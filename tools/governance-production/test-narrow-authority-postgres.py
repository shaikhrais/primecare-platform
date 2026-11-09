"""GitHub-only, disposable PostgreSQL/TLS tests; never invokes production main.

All writes below target the loopback-only synthetic container created by the
matching workflow. No caller-supplied connection, schema, or fixture is accepted.
The production reader remains byte-for-byte unchanged.
"""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys
import unittest

if len(sys.argv) != 1 or os.environ.get('NARROW_READER_ISOLATED_CI') != '1':
    raise SystemExit('Use only the isolated GitHub Actions fixture lane')
if any(k.startswith('PG') or k in ('GOVERNANCE_DATABASE_URL', 'PRODUCTION_DATABASE_URL')
       for k in os.environ):
    raise SystemExit('Fixture tests refuse database environment overrides')

import psycopg
from psycopg.types.json import Jsonb
from psycopg.pq import TransactionStatus

HERE = Path(__file__).resolve().parent
SOURCE_BLOB = 'f41eb82f2fde0faac2654f740b5de81917c83490'
raw = (HERE / 'narrow_authority_reader.py').read_bytes()
if hashlib.sha1(b'blob ' + str(len(raw)).encode() + b'\0' + raw).hexdigest() != SOURCE_BLOB:
    raise SystemExit('Reader source changed: independently review and update fixture provenance')
spec = importlib.util.spec_from_file_location('narrow', HERE / 'narrow_authority_reader.py')
reader = importlib.util.module_from_spec(spec)
spec.loader.exec_module(reader)
CERT = '/tmp/narrow-reader-fixture/server.crt'


def connection(**changes):
    # Exercise the exact explicit libpq configuration with only fixture target,
    # CA and user substitutions. hostaddr fixes transport to loopback even when
    # testing hostname mismatch. This is not a production CLI override.
    config = reader.production_config({'PRODUCTION_DATABASE_URL':
        'postgresql://synthetic:synthetic@pooled.db.prisma.io/postgres'})
    config.update(host='localhost', hostaddr='127.0.0.1', port=55432,
                  user='postgres', sslrootcert=CERT)
    config.update(changes)
    return psycopg.connect(**config)


def fixtures(tagged):
    manifest = {'format': 'primecare-governance-snapshot-v1', 'tables': [
        {'name': table, 'columns': [
            {'name': key, 'storage_types': [] if tagged else [kind]}
            for key, kind in fields.items()]}
        for table, fields in reader.FIELDS.items()]}
    data = {table: [] for table in reader.FIELDS}
    data['screens'] = [dict(id=1, screen_code='synthetic_screen',
        route_path=reader.ROUTES[0], app_id=1, role_id=1, active=1)]
    data['route_registry'] = [dict(id=1, screen_id=1, app_id=1, role_id=1,
        route_path=reader.ROUTES[0], active=1, auth_required=1,
        role_guard_required=1, permission_required='synthetic.view')]
    data['role_screen_permissions'] = [dict(role_id=1, screen_id=1,
        can_view=1, can_create=0, can_edit=0, can_delete=0, can_export=0)]
    data['roles'] = [dict(id=1, role_code='synthetic_role', active=1)]
    data['screen_api_links'] = [dict(screen_id=1, api_id=2)]
    data['screen_api_map'] = [dict(screen_id=1, api_id=999)]
    data['api_endpoints'] = [dict(id=2, app_id=1, endpoint_code='synthetic_api',
        http_method='GET', route_path='/synthetic/only', auth_required=1,
        permission_key='synthetic.view', request_schema='{}', response_schema='{}',
        service_name='synthetic', implementation_status='unverified',
        api_version='v1', rate_limit_key=None)]
    data['api_endpoint_registry'] = [dict(id=3, api_id=2,
        endpoint_code='synthetic_api', method='GET', endpoint_path='/synthetic/only')]
    data['api_permissions'] = [dict(id=4, api_id=2, role_id=1,
        runtime_artifact_id=5, permission_key='synthetic.view', can_access=1)]
    data['runtime_artifacts'] = [dict(id=5)]
    data['runtime_catalog_permissions'] = [dict(role_id=1,
        can_view_inventory=1, can_view_organization=0)]
    return manifest, data


class PostgresTests(unittest.TestCase):
    def setUp(self):
        self.db = connection()
        self.addCleanup(self.db.close)
        self.assertTrue(self.db.pgconn.ssl_in_use)

    def install(self, tagged=False, empty=False):
        manifest, data = fixtures(tagged)
        digest = hashlib.sha256(reader.canonical_manifest(manifest)).hexdigest()
        q = reader.quote
        schema = q(reader.SCHEMA)
        self.db.execute(f'DROP SCHEMA IF EXISTS {schema} CASCADE')
        self.db.execute(f'CREATE SCHEMA {schema}')
        self.db.execute(f'CREATE TABLE {schema}.{q(reader.MANIFEST_TABLE)} '
                        '(manifest_sha256 text, manifest jsonb)')
        self.db.execute(f'INSERT INTO {schema}.{q(reader.MANIFEST_TABLE)} VALUES (%s,%s)',
                        (digest, Jsonb(manifest)))
        for table, fields in reader.FIELDS.items():
            name = schema + '.' + q('govt_' + table)
            columns = ','.join(q(key) + ' ' + ('jsonb' if tagged else
                'bigint' if kind == 'integer' else 'text') for key, kind in fields.items())
            self.db.execute(f'CREATE TABLE {name} ({columns})')
            for row in ([] if empty else data[table]):
                values = [Jsonb({'t': fields[key] if row[key] is not None else 'null',
                                'v': str(row[key]) if row[key] is not None else None})
                          if tagged else row[key] for key in fields]
                self.db.execute(f'INSERT INTO {name} VALUES ({",".join("%s" for _ in fields)})', values)
        return digest

    def read(self, digest):
        try:
            return reader._read_snapshot(self.db, digest)
        finally:
            self.assertEqual(self.db.info.transaction_status, TransactionStatus.IDLE)

    def test_typed_and_tagged_sql_and_rollback(self):
        for tagged in (False, True):
            with self.subTest(tagged=tagged):
                snapshot = self.read(self.install(tagged))
                self.assertEqual(set(snapshot), {'screens', 'routes', 'ownership',
                    'grants', 'links', 'mapping', 'endpoints', 'registry',
                    'api_grants', 'roles', 'inventory', 'artifacts'})
                self.assertTrue(all(snapshot.values()))
                receipt = reader.attestation(snapshot)
                self.assertFalse(receipt['releaseReady'])
                self.assertFalse(receipt['productionAuthorityEstablished'])
                self.assertEqual(receipt['routes'][0]['screenIdentity'], 'EXACT_ACTIVE')
                self.assertNotIn('synthetic.view', json.dumps(receipt))

    def test_empty_results_have_real_column_metadata(self):
        for tagged in (False, True):
            digest = self.install(tagged, empty=True)
            self.assertTrue(all(not rows for rows in self.read(digest).values()))
            # Exercise every fixed projection with real empty cursor metadata,
            # including dependent tables normally skipped when no IDs exist.
            manifest, _ = fixtures(tagged)
            storage = reader.validate_manifest([
                {'manifest_sha256': digest, 'manifest': manifest}], digest)
            for table, fields in reader.FIELDS.items():
                key = next(iter(fields))
                self.assertEqual(reader._select(reader._Session(self.db), storage,
                    table, [(key, [1])]), [])

    def test_manifest_drift_is_not_empty_success(self):
        digest = self.install()
        self.db.execute(f'UPDATE "{reader.SCHEMA}".govt_source_manifest '
                        "SET manifest = manifest || '{\"drift\":true}'::jsonb")
        with self.assertRaisesRegex(reader.Fault, '^MANIFEST_INTEGRITY_MISMATCH$'):
            self.read(digest)

    def test_malformed_tag_and_oversized_text_fail_closed(self):
        digest = self.install(tagged=True)
        self.assertTrue(self.read(digest)['screens'])
        self.db.execute(f'UPDATE "{reader.SCHEMA}".govt_screens SET active=%s',
                        (Jsonb({'t': 'text', 'v': '1'}),))
        with self.assertRaisesRegex(reader.Fault, '^QUERY_UNAVAILABLE$'):
            self.read(digest)
        digest = self.install()
        self.assertTrue(self.read(digest)['screens'])
        self.db.execute(f'UPDATE "{reader.SCHEMA}".govt_screens SET screen_code=%s',
                        ('x' * (reader.MAX_FIELD + 1),))
        with self.assertRaisesRegex(reader.Fault, '^QUERY_UNAVAILABLE$'):
            self.read(digest)

    def test_real_readonly_transaction_rejects_writes(self):
        digest = self.install()
        owner = self
        checked = []

        class ObservedCursor:
            def __enter__(inner):
                inner.cursor = owner.db.cursor().__enter__()
                return inner

            def __exit__(inner, *args):
                return inner.cursor.__exit__(*args)

            def __getattr__(inner, name):
                return getattr(inner.cursor, name)

            def execute(inner, sql, parameters=()):
                inner.cursor.execute(sql, parameters)
                if sql.startswith('BEGIN '):
                    owner.assertEqual(owner.db.execute('SHOW transaction_read_only').fetchone(), ('on',))
                    owner.assertEqual(owner.db.execute('SHOW transaction_isolation').fetchone(), ('repeatable read',))
                    owner.db.execute('SAVEPOINT fixture_write_probe')
                    with owner.assertRaises(psycopg.errors.ReadOnlySqlTransaction):
                        owner.db.execute(f'DELETE FROM "{reader.SCHEMA}".govt_screens')
                    owner.db.execute('ROLLBACK TO SAVEPOINT fixture_write_probe')
                    owner.db.execute('RELEASE SAVEPOINT fixture_write_probe')
                    checked.append(True)

        class ObservedConnection:
            def cursor(inner):
                return ObservedCursor()

        reader._read_snapshot(ObservedConnection(), digest)
        self.assertEqual(checked, [True])
        self.assertEqual(self.db.info.transaction_status, TransactionStatus.IDLE)
        self.assertEqual(self.db.execute(f'SELECT count(*) FROM "{reader.SCHEMA}".govt_screens').fetchone(), (1,))

    def test_tls_hostname_mismatch_and_untrusted_ca_rejected(self):
        for changes, expected in (
                ({'host': 'wrong-host.invalid'}, 'does not match host name'),
                ({'sslrootcert': '/tmp/narrow-reader-fixture/untrusted.crt'},
                 'certificate verify failed')):
            with self.subTest(case=list(changes)[0]):
                # A stopped fixture/connection refusal must not count as a TLS
                # rejection. Only the expected libpq certificate error passes.
                with self.assertRaises(psycopg.OperationalError) as rejected:
                    with connection(**changes):
                        self.fail('Invalid TLS peer was accepted')
                self.assertIn(expected, str(rejected.exception))
                with connection() as verified:
                    self.assertTrue(verified.pgconn.ssl_in_use)

    def test_minimal_select_role_and_denied_read_are_distinct(self):
        digest = self.install()
        role = 'synthetic_narrow_readonly'
        self.db.execute(f'CREATE ROLE {role} NOLOGIN NOSUPERUSER NOCREATEDB '
                        'NOCREATEROLE NOINHERIT NOREPLICATION NOBYPASSRLS')
        try:
            self.db.execute(f'GRANT USAGE ON SCHEMA "{reader.SCHEMA}" TO {role}')
            for name in [reader.MANIFEST_TABLE] + ['govt_' + t for t in reader.FIELDS]:
                self.db.execute(f'GRANT SELECT ON "{reader.SCHEMA}"."{name}" TO {role}')
            self.db.execute(f'SET ROLE {role}')
            self.assertTrue(self.read(digest)['screens'])
            # Privilege restriction is independent of transaction read-only.
            with self.assertRaises(psycopg.errors.InsufficientPrivilege):
                self.db.execute(f'DELETE FROM "{reader.SCHEMA}".govt_screens')
            with self.assertRaises(psycopg.errors.InsufficientPrivilege):
                self.db.execute(f'CREATE TABLE "{reader.SCHEMA}".forbidden(id int)')
            self.db.execute('RESET ROLE')
            self.db.execute(f'REVOKE SELECT ON "{reader.SCHEMA}".govt_screens FROM {role}')
            self.db.execute(f'SET ROLE {role}')
            with self.assertRaisesRegex(reader.Fault, '^READ_DENIED$'):
                self.read(digest)
        finally:
            self.db.execute('RESET ROLE')
            self.db.execute(f'DROP OWNED BY {role}')
            self.db.execute(f'DROP ROLE {role}')


if __name__ == '__main__':
    unittest.main(verbosity=2)
