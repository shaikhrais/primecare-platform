"""Synthetic-only tests. No PostgreSQL driver/network/credential files are used.

The in-memory driver evaluates only the fixed query plan's scoped predicates;
it does not claim to validate PostgreSQL syntax, native TLS, or current data.
"""
import copy
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
from unittest.mock import patch

# Fail before imports/fixtures when launched with a production credential.
if any(k in os.environ for k in ('GOVERNANCE_DATABASE_URL', 'PRODUCTION_DATABASE_URL')):
    raise SystemExit('Synthetic tests refuse a production credential environment')


def audit(event, args):
    if event.startswith('socket.') or event in ('subprocess.Popen', 'os.system'):
        raise AssertionError('Synthetic tests prohibit network and subprocess access')
    if event == 'open' and isinstance(args[0], (str, bytes)):
        name = os.fsdecode(args[0])
        if Path(name).name.startswith('.env') or any(x in name for x in ('.pgpass', '.pg_service', '.postgresql/')):
            raise AssertionError('Synthetic tests prohibit credential file reads')


sys.addaudithook(audit)
spec = importlib.util.spec_from_file_location('narrow', Path(__file__).with_name('narrow_authority_reader.py'))
reader = importlib.util.module_from_spec(spec)
spec.loader.exec_module(reader)
SECRET = 'SYNTHETIC_PRIVATE_SENTINEL_NEVER_PRINT'
URL = 'postgresql://fixture:' + SECRET + '@pooled.db.prisma.io/postgres'


def fixture():
    manifest = {'format': 'primecare-governance-snapshot-v1', 'sqlite_objects': [], 'tables': [
        {'name': table, 'columns': [{'name': field, 'declared_type': 'INTEGER' if kind == 'integer' else 'TEXT',
                                    'storage_types': [kind]} for field, kind in fields.items()]}
        for table, fields in reader.FIELDS.items()]}
    data = {table: [] for table in reader.FIELDS}
    for index, path in enumerate(reader.ROUTES[:6], 1):
        code = 'fixture_admin_' + str(index) if index <= 3 else reader.CODE_PAIRS[index - 4][0]
        data['screens'].append(dict(id=index, screen_code=code, route_path=path, app_id=1, role_id=1, active=1))
        data['route_registry'].append(dict(id=index, screen_id=index, app_id=1, role_id=1, route_path=path,
            active=1, auth_required=1, role_guard_required=1, permission_required='fixture.view'))
        data['role_screen_permissions'].append(dict(role_id=1, screen_id=index, can_view=1,
            can_create=0, can_edit=0, can_delete=0, can_export=0))
        data['screen_api_links'].append(dict(screen_id=index, api_id=100))
    for index, pair in enumerate(reader.CODE_PAIRS, 10):
        data['screens'].append(dict(id=index, screen_code=pair[1], route_path='/fixture/generated/' + str(index),
                                   app_id=2, role_id=2, active=1))
    data['roles'] = [dict(id=1, role_code='fixture_role', active=1), dict(id=2, role_code='fixture_other', active=1)]
    data['api_endpoints'] = [dict(id=100, app_id=1, endpoint_code='fixture_endpoint',
        http_method='GET', route_path='/fixture/bounded', auth_required=1, permission_key='fixture.view',
        request_schema=json.dumps({'type': 'object', 'additionalProperties': False}),
        response_schema=json.dumps({'type': 'array', 'maxItems': 20, 'items': {'type': 'object'}}),
        service_name='fixture_service', implementation_status='unverified', api_version='v1', rate_limit_key='fixture.actor')]
    data['api_endpoint_registry'] = [dict(id=101, api_id=100, endpoint_code='fixture_endpoint',
                                        method='GET', endpoint_path='/fixture/bounded')]
    data['api_permissions'] = [dict(id=102, api_id=100, role_id=1, runtime_artifact_id=103,
                                   permission_key='fixture.view', can_access=1)]
    data['runtime_artifacts'] = [dict(id=103)]
    data['runtime_catalog_permissions'] = [dict(role_id=1, can_view_inventory=1, can_view_organization=0)]
    return manifest, data


class Cursor:
    def __init__(self, db):
        self.db, self.description, self.rows = db, None, []

    def __enter__(self):
        return self

    def __exit__(self, *_):
        return False

    def execute(self, sql, parameters=()):
        self.db.calls.append((sql, tuple(parameters)))
        if self.db.fail and self.db.fail in sql:
            error = RuntimeError(SECRET)
            error.sqlstate = self.db.sqlstate
            raise error
        if not sql.startswith('SELECT'):
            assert sql == 'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY' or sql == 'ROLLBACK' or sql.startswith('SET LOCAL ')
            return
        if sql.startswith("SELECT current_setting"):
            names = ['readonly']
            rows = [{'readonly': self.db.readonly}]
        elif '"govt_source_manifest"' in sql:
            names = ['manifest_sha256', 'manifest']
            rows = self.db.manifest_rows
        else:
            table = re.search(r'FROM "' + reader.SCHEMA + r'"\."govt_([a-z_]+)"', sql)[1]
            assert table in reader.FIELDS
            assert 'SELECT *' not in sql and sql.endswith('LIMIT 257')
            fields = re.findall(r'"([a-z_]+)"', sql.split(' FROM ')[0])
            assert fields == list(reader.FIELDS[table])
            names = fields
            filters = re.findall(r'"([a-z_]+)" IN \(([^)]+)\)', sql.split('AS scoped WHERE ')[1])
            groups, offset = [], 0
            for key, marks in filters:
                count = marks.count('%s')
                groups.append((key, parameters[offset:offset + count]))
                offset += count
            assert offset == len(parameters)
            selected = [r for r in self.db.data[table] if any(r[key] in values for key, values in groups)]
            rows = [{key: r[key] for key in fields} for r in selected][:reader.MAX_ROWS + 1]
        self.description = [types.SimpleNamespace(name=name) for name in names]
        self.rows = [tuple(row[k] for k in names) for row in rows]
        if self.db.short and rows:
            self.rows[0] = self.rows[0][:-1]

    def fetchmany(self, amount):
        return self.rows[:amount]


class Database:
    def __init__(self, manifest=None, data=None):
        default_manifest, default_data = fixture()
        self.manifest = manifest if manifest is not None else default_manifest
        self.data = data if data is not None else default_data
        self.digest = hashlib.sha256(reader.canonical_manifest(self.manifest)).hexdigest()
        self.manifest_rows = [{'manifest_sha256': self.digest, 'manifest': self.manifest}]
        self.calls, self.fail, self.sqlstate, self.short = [], None, None, False
        self.readonly, self.closed = 'on', False
        self.pgconn = types.SimpleNamespace(ssl_in_use=True)

    def cursor(self):
        return Cursor(self)

    def close(self):
        self.closed = True

    def read(self):
        return reader._read_snapshot(self, self.digest)


class ReaderTests(unittest.TestCase):
    def test_positive_fixture_is_never_production_authority(self):
        db = Database()
        output = reader.attestation(db.read())
        self.assertEqual(output['evidenceMode'], 'synthetic-fixture-only')
        self.assertFalse(output['productionAuthorityEstablished'])
        self.assertFalse(output['releaseReady'])
        self.assertEqual(len(output['routes']), 7)
        for item in output['routes'][:6]:
            self.assertEqual(item['screenIdentity'], 'EXACT_ACTIVE')
            self.assertFalse(item['authorityEstablished'])
            self.assertEqual(item['screenGrantMetadata'], 'VIEW_GRANT_PRESENT')
            self.assertEqual(item['apis']['linkedApiCount'], 1)
            self.assertFalse(item['apis']['contractSemanticsVerified'])
        self.assertEqual(db.calls[-1][0], 'ROLLBACK')
        self.assertEqual(db.calls[1][0], 'SET LOCAL search_path=pg_catalog')
        self.assertLessEqual(len(db.calls), reader.MAX_QUERIES + 1)

    def test_manifest_matches_exporter_encoding_with_unicode(self):
        value = {'z': [1, None, 'é漢😀'], 'a': {'x': '\n'}}
        self.assertEqual(reader.canonical_manifest(value),
                         (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + '\n').encode())

    def test_manifest_nonfinite_values_and_duplicate_metadata_fail(self):
        with self.assertRaisesRegex(reader.Fault, 'MANIFEST_INVALID'):
            reader.canonical_manifest({'bad': float('nan')})
        for change in (lambda m: m['tables'].append(copy.deepcopy(m['tables'][0])),
                       lambda m: m['tables'][0]['columns'].append(copy.deepcopy(m['tables'][0]['columns'][0]))):
            manifest, data = fixture(); change(manifest)
            with self.assertRaises(reader.Fault):
                Database(manifest, data).read()

    def test_tagged_storage_uses_guarded_projection_and_no_schema_execution(self):
        manifest, _ = fixture()
        for table in manifest['tables']:
            for column in table['columns']:
                column['storage_types'] = []
        digest = hashlib.sha256(reader.canonical_manifest(manifest)).hexdigest()
        storage = reader.validate_manifest([{'manifest_sha256': digest, 'manifest': manifest}], digest)
        projection = reader._projection(storage, 'screens')
        self.assertIn("jsonb_typeof(\"id\"->'v')='string'", projection)
        self.assertIn("\"id\"->>'t'='integer'", projection)
        self.assertIn('octet_length', projection)
        self.assertNotIn('sqlite_master', projection)

    def test_manifest_label_alone_does_not_prove_json(self):
        db = Database()
        db.manifest['unexpected'] = 'changed'
        with self.assertRaisesRegex(reader.Fault, 'MANIFEST_INTEGRITY_MISMATCH'):
            db.read()
        self.assertEqual(db.calls[-1][0], 'ROLLBACK')
        self.assertFalse(any('AS scoped WHERE' in sql for sql, _ in db.calls))

    def test_manifest_count_and_hash_fail_closed(self):
        for rows in ([], [{'manifest_sha256': 'wrong', 'manifest': {}}], [dict(), dict()]):
            db = Database()
            db.manifest_rows = rows
            with self.assertRaises(reader.Fault):
                db.read()
            self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_missing_and_mixed_schema_are_not_absence_or_denial(self):
        for mutation, reason in (
            (lambda m: m['tables'].pop(0), 'RELATION_UNVERIFIED'),
            (lambda m: m['tables'][0]['columns'].pop(0), 'COLUMN_UNVERIFIED'),
            (lambda m: m['tables'][0]['columns'][0].update(storage_types=['integer', 'text']), 'STORAGE_UNVERIFIED'),
        ):
            manifest, data = fixture()
            mutation(manifest)
            with self.assertRaisesRegex(reader.Fault, reason):
                Database(manifest, data).read()

    def test_missing_inactive_ambiguous_identity_and_explicit_deny_are_distinct(self):
        for change, expected in (
            (lambda d: d['screens'].pop(0), 'ABSENT'),
            (lambda d: d['screens'][0].update(active=0), 'INACTIVE'),
            (lambda d: d['screens'].append(dict(d['screens'][0], id=50)), 'AMBIGUOUS'),
            (lambda d: d['screens'][0].update(active=None), 'ACTIVE_UNVERIFIED'),
        ):
            db = Database(); change(db.data)
            self.assertEqual(reader.attestation(db.read())['routes'][0]['screenIdentity'], expected)
        db = Database(); db.data['role_screen_permissions'][0]['can_view'] = 0
        self.assertEqual(reader.attestation(db.read())['routes'][0]['screenGrantMetadata'], 'EXPLICIT_VIEW_DENIAL_ONLY')
        db = Database(); db.data['role_screen_permissions'].pop(0)
        self.assertEqual(reader.attestation(db.read())['routes'][0]['screenGrantMetadata'], 'NO_ROWS')

    def test_duplicate_captured_identity_fails_closed(self):
        for table in ('screens', 'roles', 'api_endpoints', 'runtime_artifacts'):
            db = Database(); db.data[table].append(dict(db.data[table][0]))
            with self.assertRaisesRegex(reader.Fault, 'IDENTITY_AMBIGUOUS'):
                db.read()

    def test_duplicate_screen_and_api_grants_preserve_ambiguity(self):
        db = Database()
        db.data['role_screen_permissions'].append(dict(db.data['role_screen_permissions'][0]))
        db.data['api_permissions'].append(dict(db.data['api_permissions'][0], id=104))
        item = reader.attestation(db.read())['routes'][0]
        self.assertEqual(item['screenGrantMetadata'], 'AMBIGUOUS')
        self.assertIn('API_GRANT_AMBIGUOUS', item['apis']['metadataReasons'])

    def test_ownership_and_role_scope_conflicts(self):
        db = Database()
        db.data['route_registry'][0]['role_id'] = 2
        db.data['roles'][1]['active'] = 0
        item = reader.attestation(db.read())['routes'][0]
        self.assertIn('ROUTE_OWNERSHIP_CONFLICT', item['reasons'])
        self.assertIn('OWNER_ROLE_INACTIVE', item['reasons'])

    def test_nonowner_grant_role_states_stay_distinct(self):
        for active, expected in ((0, 'INACTIVE'), (None, 'ACTIVE_UNVERIFIED')):
            db = Database()
            db.data['roles'][1]['active'] = active
            db.data['role_screen_permissions'][0]['role_id'] = 2
            db.data['api_permissions'][0]['role_id'] = 2
            item = reader.attestation(db.read())['routes'][0]
            self.assertEqual(item['screenGrantRoleIdentityStates'], [expected])
            self.assertEqual(item['apis']['grantRoleIdentityStates'], [expected])
        db = Database(); db.data['role_screen_permissions'][0]['role_id'] = 900
        self.assertEqual(reader.attestation(db.read())['routes'][0]['screenGrantRoleIdentityStates'], ['ABSENT'])

    def test_null_identity_is_not_exact_or_authorized(self):
        for change in (lambda d: d['screens'][0].update(id=None),
                       lambda d: d['screens'][0].update(screen_code='')):
            db = Database(); change(db.data)
            item = reader.attestation(db.read())['routes'][0]
            self.assertEqual(item['screenIdentity'], 'IDENTITY_UNVERIFIED')
            self.assertFalse(item['authorityEstablished'])

    def test_extra_owner_rows_do_not_silently_prove_alias(self):
        db = Database()
        db.data['route_registry'].append(dict(db.data['route_registry'][0], id=55, route_path='/fixture/other', app_id=2))
        item = reader.attestation(db.read())['routes'][0]
        self.assertIn('MULTIPLE_OWNERSHIP_RECORDS_REVIEW_REQUIRED', item['reasons'])
        self.assertIn('LINKED_ROUTE_OWNERSHIP_CONFLICT', item['reasons'])

    def test_ceo_generated_mapping_never_aliases(self):
        for item in reader.attestation(Database().read())['routes'][3:6]:
            self.assertIn('CEO_GENERATED_SOURCE_MAPPING_UNRESOLVED', item['reasons'])
            self.assertIn('DISTINCT_CEO_AND_GENERATED_IDENTITIES_PRESENT', item['reasons'])
            self.assertFalse(item['authorityEstablished'])

    def test_candidates_remain_diagnostic_when_native_route_is_absent(self):
        db = Database()
        db.data['screens'][3]['route_path'] = '/fixture/ceo-only'
        item = reader.attestation(db.read())['routes'][3]
        self.assertEqual(item['screenIdentity'], 'ABSENT')
        self.assertEqual(item['sourceCandidateMetadata']['ceo']['screenGrantMetadata'], 'VIEW_GRANT_PRESENT')
        self.assertEqual(item['sourceCandidateMetadata']['importedGenerated']['screenGrantMetadata'], 'NO_ROWS')
        self.assertIn('CEO_GENERATED_SOURCE_MAPPING_UNRESOLVED', item['reasons'])

    def test_unrelated_rows_are_not_returned(self):
        db = Database()
        db.data['screens'].append(dict(db.data['screens'][0], id=990, screen_code=SECRET, route_path='/not-a-target'))
        db.data['api_endpoints'].append(dict(db.data['api_endpoints'][0], id=991, route_path='/not-a-target'))
        snapshot = db.read()
        self.assertNotIn(990, [row['id'] for row in snapshot['screens']])
        self.assertNotIn(991, [row['id'] for row in snapshot['endpoints']])

    def test_placeholder_is_not_a_missing_business_screen(self):
        db = Database()
        item = reader.attestation(db.read())['routes'][-1]
        self.assertEqual(item['classification'], 'NONBUSINESS_FALLBACK')
        self.assertFalse(item['metadataUnexpectedlyPresent'])
        self.assertNotIn('screenIdentity', item)

    def test_legacy_map_id_does_not_select_endpoint(self):
        db = Database()
        db.data['screen_api_links'] = []
        db.data['screen_api_map'] = [dict(screen_id=1, api_id=100)]
        snapshot = db.read()
        self.assertEqual(snapshot['endpoints'], [])
        reasons = reader.attestation(snapshot)['routes'][0]['apis']['metadataReasons']
        self.assertIn('SCREEN_API_MAP_ID_DOMAIN_UNVERIFIED', reasons)
        self.assertIn('NO_LINKED_API', reasons)

    def test_contract_states_and_no_secret_output(self):
        for text, state in ((None, 'ABSENT'), ('no json', 'INVALID_JSON'), ('[]', 'SHAPE_UNVERIFIED'),
                            ('{"type":"object"}', 'GENERIC_SHAPE_UNVERIFIED'),
                            ('{"x":NaN}', 'INVALID_JSON'), ('{"x":Infinity}', 'INVALID_JSON'),
                            ('{"x":1e999}', 'INVALID_JSON'),
                            ('{"x":1,"x":2}', 'INVALID_JSON')):
            self.assertEqual(reader._schema_state(text), state)
        db = Database()
        db.data['api_endpoints'][0]['request_schema'] = json.dumps({'description': SECRET})
        db.data['api_endpoints'][0]['permission_key'] = SECRET
        db.data['roles'][0]['role_code'] = SECRET
        output = json.dumps(reader.attestation(db.read()))
        self.assertNotIn(SECRET, output)
        self.assertNotIn('fixture_endpoint', output)
        self.assertNotIn('/fixture/bounded', output)
        self.assertNotIn('role_id', output)
        self.assertNotIn('runtime_artifact_id', output)

    def test_api_identity_and_artifact_conflicts(self):
        db = Database()
        db.data['api_endpoint_registry'][0]['endpoint_path'] = '/fixture/different'
        db.data['api_permissions'][0]['permission_key'] = 'unknown'
        db.data['runtime_artifacts'] = []
        reasons = reader.attestation(db.read())['routes'][0]['apis']['metadataReasons']
        for reason in ('API_REGISTRY_IDENTITY_CONFLICT', 'API_GRANT_IDENTITY_UNVERIFIED', 'API_ARTIFACT_REFERENCE_UNVERIFIED'):
            self.assertIn(reason, reasons)

    def test_legacy_permission_even_when_copied_to_endpoint_stays_unverified(self):
        db = Database()
        key = 'api_permission_fixture_endpoint'
        db.data['api_permissions'][0]['permission_key'] = key
        db.data['api_endpoints'][0]['permission_key'] = key
        item = reader.attestation(db.read())['routes'][0]
        self.assertIn('LEGACY_API_GRANT_REQUIRES_RECONCILIATION', item['apis']['metadataReasons'])
        self.assertFalse(item['apis']['contractSemanticsVerified'])

    def test_flags_and_row_width_cannot_be_coerced(self):
        db = Database(); db.data['screens'][0]['active'] = '1'
        with self.assertRaisesRegex(reader.Fault, 'INVALID_METADATA'):
            db.read()
        db = Database(); db.short = True
        with self.assertRaisesRegex(reader.Fault, 'INVALID_METADATA'):
            db.read()

    def test_readonly_and_rollback_failures(self):
        db = Database(); db.readonly = 'off'
        with self.assertRaisesRegex(reader.Fault, 'READONLY_UNVERIFIED'):
            db.read()
        db = Database(); db.fail = 'ROLLBACK'
        with self.assertRaisesRegex(reader.Fault, 'ROLLBACK_UNVERIFIED'):
            db.read()

    def test_denied_missing_unknown_errors_are_sanitized_and_distinct(self):
        for state, expected in (('42501', 'READ_DENIED'), ('42P01', 'RELATION_UNVERIFIED'),
                                ('42703', 'COLUMN_UNVERIFIED'), ('57014', 'TOTAL_TIMEOUT'),
                                (SECRET, 'QUERY_UNAVAILABLE')):
            db = Database(); db.fail = 'AS scoped WHERE'; db.sqlstate = state
            with self.assertRaisesRegex(reader.Fault, expected) as caught:
                db.read()
            self.assertNotIn(SECRET, str(caught.exception))
            self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_rows_bytes_query_and_time_budgets(self):
        db = Database()
        db.data['screens'] = [dict(db.data['screens'][0], id=i + 1) for i in range(257)]
        with self.assertRaisesRegex(reader.Fault, 'ROW_LIMIT'):
            db.read()
        session = reader._Session(Database()); session.queries = reader.MAX_QUERIES
        with self.assertRaisesRegex(reader.Fault, 'QUERY_LIMIT'):
            session.query('SELECT irrelevant', expected_columns=('unused',))
        session = reader._Session(Database()); session.started -= reader.TOTAL_SECONDS
        with self.assertRaisesRegex(reader.Fault, 'TOTAL_TIMEOUT'):
            session.query('SELECT irrelevant', expected_columns=('unused',))
        session = reader._Session(Database()); session.bytes = reader.MAX_BYTES
        with self.assertRaisesRegex(reader.Fault, 'BYTE_LIMIT'):
            session.query("SELECT current_setting('transaction_read_only') AS readonly",
                          expected_columns=('readonly',))

    def test_every_select_requires_exact_metadata_before_fetch(self):
        baseline = Database(); baseline.read()
        targets = [i for i, (sql, _) in enumerate(baseline.calls) if sql.startswith('SELECT')]
        mutations = {
            'none': lambda names: None,
            'empty': lambda names: [],
            'missing': lambda names: names[:-1],
            'duplicate': lambda names: names + names[:1],
            'extra': lambda names: names + [types.SimpleNamespace(name=SECRET)],
            'wrong': lambda names: [types.SimpleNamespace(name=SECRET)] + names[1:],
            'non-string': lambda names: [types.SimpleNamespace(name=7)] + names[1:],
            'missing-name': lambda names: [object()] + names[1:],
            'non-iterable': lambda names: 7,
        }
        for target in targets:
            for empty in (False, True):
                for name, mutate in mutations.items():
                    with self.subTest(query=target, empty=empty, mutation=name):
                        class InvalidCursor(Cursor):
                            invalid = False

                            def execute(self, sql, parameters=()):
                                super().execute(sql, parameters)
                                if len(self.db.calls) - 1 == target:
                                    self.invalid = True
                                    self.description = mutate(self.description)
                                    if empty:
                                        self.rows = []

                            def fetchmany(self, amount):
                                if self.invalid:
                                    raise AssertionError('Invalid metadata must fail before fetch')
                                return super().fetchmany(amount)

                        db = Database()
                        with patch.object(db, 'cursor', lambda: InvalidCursor(db)):
                            with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$') as caught:
                                db.read()
                        self.assertEqual(db.calls[-1][0], 'ROLLBACK')
                        self.assertNotIn(SECRET, str(caught.exception))

    def test_reordered_result_names_and_values_are_not_remapped(self):
        class ReorderedCursor(Cursor):
            def execute(self, sql, parameters=()):
                super().execute(sql, parameters)
                if self.description and len(self.description) > 1:
                    self.description.reverse()
                    self.rows = [tuple(reversed(row)) for row in self.rows]

        for empty in (False, True):
            db = Database()
            if empty:
                db.manifest_rows = []
            with patch.object(db, 'cursor', lambda: ReorderedCursor(db)):
                with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$'):
                    db.read()
            self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_empty_data_results_keep_exact_column_metadata(self):
        db = Database(data={table: [] for table in reader.FIELDS})
        storage = reader.validate_manifest(db.manifest_rows, db.digest)
        for table, fields in reader.FIELDS.items():
            with self.subTest(table=table):
                rows = reader._select(reader._Session(db), storage, table,
                                      [(next(iter(fields)), [1])])
                self.assertEqual(rows, [])
        self.assertTrue(all(not rows for rows in db.read().values()))
        db = Database(); db.manifest_rows = []
        with self.assertRaisesRegex(reader.Fault, '^MANIFEST_MISMATCH$'):
            db.read()
        self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_transaction_commands_reject_result_metadata(self):
        for target in range(5):
            class ResultCursor(Cursor):
                def execute(self, sql, parameters=()):
                    super().execute(sql, parameters)
                    if len(self.db.calls) - 1 == target:
                        self.description = []

            with self.subTest(query=target):
                db = Database()
                with patch.object(db, 'cursor', lambda: ResultCursor(db)):
                    with self.assertRaisesRegex(reader.Fault, '^INVALID_METADATA$'):
                        db.read()
                self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_rollback_rejects_unexpected_result_metadata(self):
        class ResultCursor(Cursor):
            def execute(self, sql, parameters=()):
                super().execute(sql, parameters)
                if sql == 'ROLLBACK':
                    self.description = []

        db = Database()
        with patch.object(db, 'cursor', lambda: ResultCursor(db)):
            with self.assertRaisesRegex(reader.Fault, '^ROLLBACK_UNVERIFIED$'):
                db.read()
        self.assertEqual(db.calls[-1][0], 'ROLLBACK')

    def test_transaction_commands_preserve_query_and_time_budgets(self):
        session = reader._Session(Database()); session.queries = reader.MAX_QUERIES
        with self.assertRaisesRegex(reader.Fault, '^QUERY_LIMIT$'):
            session.command('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY')
        self.assertEqual(session.db.calls, [])
        session = reader._Session(Database()); session.started -= reader.TOTAL_SECONDS
        with self.assertRaisesRegex(reader.Fault, '^TOTAL_TIMEOUT$'):
            session.command('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY')
        self.assertEqual(session.db.calls, [])

    def test_fixed_queries_bounded_parameterized_and_no_business_relations(self):
        db = Database(); db.read()
        tables = set()
        for sql, values in db.calls:
            self.assertNotIn(SECRET, sql)
            self.assertNotIn('COMMIT', sql)
            if 'AS scoped WHERE' in sql:
                tables.update(re.findall(r'\."govt_([a-z_]+)"', sql))
                self.assertIn('LIMIT 257', sql)
                self.assertIn('%s', sql)
                self.assertTrue(values)
                self.assertNotIn('SELECT *', sql)
        self.assertEqual(tables, set(reader.FIELDS))
        self.assertTrue(tables.isdisjoint({'users', 'patients', 'clients', 'auth_sessions'}))

    def test_tls_explicit_kwargs_never_uri(self):
        config = reader.production_config({'PRODUCTION_DATABASE_URL': URL})
        self.assertNotIn('conninfo', config)
        self.assertNotIn('connectionString', config)
        self.assertEqual(config['sslmode'], 'verify-full')
        self.assertEqual(config['sslrootcert'], reader.CA_FILE)
        self.assertEqual(config['gssencmode'], 'disable')
        self.assertEqual(config['host'], 'pooled.db.prisma.io')
        self.assertEqual(config['dbname'], 'postgres')

    def test_all_uri_options_and_environment_overrides_rejected(self):
        for suffix in ('?sslmode=disable', '?sslrootcert=evil', '?options=-c%20search_path%3Dpublic', '?', '#frag', '?sslcert=secret'):
            with self.assertRaisesRegex(reader.Fault, 'CONNECTION_OPTIONS_REFUSED'):
                reader.production_config({'PRODUCTION_DATABASE_URL': URL + suffix})
        for name in ('PGHOST', 'PGPASSWORD', 'PGSERVICE', 'PGSSLMODE', 'PGSSLROOTCERT',
                     'PGGSSENCMODE', 'SSL_CERT_FILE', 'OPENSSL_CONF', 'NODE_OPTIONS',
                     'GOVERNANCE_ALLOW_SQLITE_FIXTURES', 'GOVERNANCE_ALLOW_TEST_FIXTURE'):
            with self.assertRaisesRegex(reader.Fault, 'ENVIRONMENT_OPTIONS_REFUSED'):
                reader.production_config({'PRODUCTION_DATABASE_URL': URL, name: ''})

    def test_missing_conflicting_and_wrong_targets(self):
        for env, code in (({}, 'MISSING_DATABASE_URL'),
                          ({'PRODUCTION_DATABASE_URL': URL, 'GOVERNANCE_DATABASE_URL': URL + '?x'}, 'CONFLICTING_DATABASE_URLS'),
                          ({'PRODUCTION_DATABASE_URL': URL.replace('pooled.db.prisma.io', '127.0.0.1')}, 'UNEXPECTED_DATABASE_TARGET'),
                          ({'PRODUCTION_DATABASE_URL': URL.replace('pooled.db.prisma.io', 'pooled.db.prisma.io:0')}, 'UNEXPECTED_DATABASE_TARGET'),
                          ({'PRODUCTION_DATABASE_URL': URL.replace('/postgres', '/other')}, 'UNEXPECTED_DATABASE_TARGET')):
            with self.assertRaisesRegex(reader.Fault, code):
                reader.production_config(env)

    def test_local_home_checks_do_not_read_credentials(self):
        for env in ({}, {'HOME': 'relative'}):
            with self.assertRaisesRegex(reader.Fault, 'CONFIGURATION_UNAVAILABLE'):
                reader.validate_local_configuration(env)
        with patch.object(Path, 'exists', return_value=True):
            with self.assertRaisesRegex(reader.Fault, 'HOME_CREDENTIALS_REFUSED'):
                reader.validate_local_configuration({'HOME': '/fixture/empty-home'})

    def test_no_args_no_fixture_and_no_driver_on_missing_configuration(self):
        output = io.StringIO()
        def never(**kwargs):
            raise AssertionError('A driver must not be called')
        with patch.dict(os.environ, {}, clear=True), patch.object(sys, 'argv', ['reader', '--fixture']), \
             patch.dict(sys.modules, {'psycopg': types.SimpleNamespace(connect=never)}), contextlib.redirect_stdout(output):
            self.assertEqual(reader.main(), 1)
        self.assertEqual(json.loads(output.getvalue())['reason'], 'ARGUMENTS_REFUSED')
        output = io.StringIO()
        with patch.dict(os.environ, {}, clear=True), patch.object(sys, 'argv', ['reader']), \
             patch.dict(sys.modules, {'psycopg': types.SimpleNamespace(connect=never)}), contextlib.redirect_stdout(output):
            self.assertEqual(reader.main(), 1)
        self.assertEqual(json.loads(output.getvalue())['reason'], 'MISSING_DATABASE_URL')

    def test_stub_main_checks_tls_and_sanitizes_connection_errors(self):
        for ssl, fail, code in ((False, False, 'TLS_UNVERIFIED'), (True, True, 'CONNECTION_UNVERIFIED'),
                                (True, '28P01', 'CONNECTION_DENIED'), (True, '28000', 'CONNECTION_DENIED')):
            db = Database(); db.pgconn.ssl_in_use = ssl
            def connect(**config):
                self.assertEqual(config['sslmode'], 'verify-full')
                if fail:
                    error = RuntimeError(SECRET)
                    error.sqlstate = fail if isinstance(fail, str) else None
                    raise error
                return db
            output = io.StringIO()
            with patch.dict(os.environ, {'PRODUCTION_DATABASE_URL': URL, 'HOME': '/fixture/empty-home'}, clear=True), \
                 patch.object(sys, 'argv', ['reader']), patch.object(reader, 'validate_local_configuration'), \
                 patch.dict(sys.modules, {'psycopg': types.SimpleNamespace(connect=connect)}), contextlib.redirect_stdout(output):
                self.assertEqual(reader.main(), 1)
            self.assertNotIn(SECRET, output.getvalue())
            self.assertEqual(json.loads(output.getvalue())['reason'], code)
            self.assertEqual(db.calls, [])


if __name__ == '__main__':
    unittest.main(verbosity=2)
