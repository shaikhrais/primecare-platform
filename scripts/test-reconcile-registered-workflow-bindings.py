"""Historical metadata reconciliation units, never current/live authority proof."""
import hashlib
import importlib.util
import json
import os
import sqlite3
import shutil
import tempfile
import unittest
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('workflow_bindings', Path(__file__).with_name('reconcile-registered-workflow-bindings.py'))
m = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(m)
SOURCE_DB = Path(os.environ.get('PRIMECARE_BINDINGS_TEST_DATABASE', m.ROOT / '.agents/governance/governance.db'))


INPUT_FILES = (
    'cloudflare/workers/src/admin-hierarchy.json',
    'cloudflare/workers/src/report-registry.json',
    'cloudflare/workers/src/reporting.ts',
    'cloudflare/workers/src/tenant-operations.ts',
    'docs/api/admin-reports.openapi.json',
    'docs/platform-operations/seed.json',
    'docs/training/admin-course-seed.json',
    'packages/primecare_ui/lib/src/features/auth/auth_experience.dart',
    'packages/primecare_ui/lib/src/features/workspace/governed_workspace_screen.dart',
    'packages/shared/src/tenant-operations.json',
    'scripts/register-admin-training.py',
    'websites/typescript/src/admin-training.ts',
    'websites/typescript/src/reports.ts',
    'websites/typescript/src/tenant-operations/client.ts',
    'websites/typescript/src/tenant-operations/controller.ts',
    'websites/typescript/src/training/admin-course.json',
)

def historical_contract_root(db, target):
    """Pair the historical database with its recorded contracts, never live policy.

    Copy implementation inputs for provenance checks; replace metadata contracts
    only with exact records exported from the read-only historical checkpoint.
    No roles, permissions or authorities are synthesized or updated.
    """
    for name in INPUT_FILES:
        destination = target / name
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(m.ROOT / name, destination)
    contract_path = target / 'cloudflare/workers/src/report-registry.json'
    contract = json.loads(contract_path.read_text())
    contract['definitions'] = []
    for report_id, source, classification, requirement in db.execute('SELECT report_id,source,classification,requirement FROM shared_report_definitions ORDER BY report_id'):
        grants = [dict(zip(('role', 'view', 'export', 'email'), row)) for row in db.execute(
            'SELECT r.role_code,g.can_view,g.can_export,g.can_email FROM shared_report_grants g JOIN roles r ON r.id=g.role_id WHERE g.report_id=? ORDER BY r.role_code', (report_id,))]
        contract['definitions'].append(dict(report_id=report_id, source=source, classification=classification, requirement=requirement, grants=grants))
    contract['surfaces'] = [dict(zip(('screen', 'section_code', 'controls_json'), row)) for row in db.execute(
        'SELECT s.screen_code,g.section_code,g.controls_json FROM shared_report_surfaces g JOIN screens s ON s.id=g.screen_id ORDER BY s.screen_code')]
    contract_path.write_text(json.dumps(contract))
    operations = db.execute("SELECT definition FROM tenant_operations_policy WHERE id='admin-v1'").fetchone()[0]
    for name in ('packages/shared/src/tenant-operations.json', 'docs/platform-operations/seed.json'):
        (target / name).write_text(operations)
    hierarchy = db.execute("SELECT definition FROM platform_hierarchy_policy WHERE id='founder-v1'").fetchone()[0]
    (target / 'cloudflare/workers/src/admin-hierarchy.json').write_text(hierarchy)


def rows(db, table):
    return sorted(repr(tuple(r)) for r in db.execute('SELECT * FROM "' + table.replace('"', '""') + '"'))


def snapshot(db):
    return {name: rows(db, name) for name, in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}


class AdditiveBindingsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if not SOURCE_DB.is_file():
            raise RuntimeError('Restore the current governance checkpoint before isolated metadata tests')
        # The only connection to the real governance database is read-only.
        with sqlite3.connect('file:' + str(SOURCE_DB.resolve()) + '?mode=ro', uri=True) as source:
            copied = sqlite3.connect(':memory:')
            source.backup(copied)
        cls.contract_directory = tempfile.TemporaryDirectory(prefix='historical-workflow-contracts-')
        cls.contract_root = Path(cls.contract_directory.name)
        historical_contract_root(copied, cls.contract_root)
        # Normalize missing metadata only in this disposable copy, so insertion
        # and failure tests still execute after live metadata was reconciled.
        for table in reversed(tuple(m.SCHEMA)):
            copied.execute('DROP TABLE IF EXISTS ' + table)
        route_paths = ['/v1/governance/reports', '/v1/governance/reports/{reportId}',
                       '/v1/governance/reports/{reportId}/pdf', '/v1/governance/reports/{reportId}/email',
                       '/v1/governance/platform/operations']
        for path in route_paths:
            copied.execute('DELETE FROM screen_api_links WHERE api_id IN (SELECT id FROM api_endpoints WHERE route_path=?)', (path,))
            copied.execute('DELETE FROM api_endpoints WHERE route_path=?', (path,))
        copied.commit()
        cls.fixture = copied.serialize()
        copied.close()

    @classmethod
    def tearDownClass(cls):
        cls.contract_directory.cleanup()

    def reconcile(self, db, scopes=m.SCOPES):
        return m.reconcile(db, scopes, root=self.contract_root)

    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.db.deserialize(self.fixture)

    def tearDown(self):
        self.db.close()

    def assert_snapshot_equal(self, expected):
        actual = snapshot(self.db)
        changed = sorted(table for table in set(expected) | set(actual)
                         if expected.get(table) != actual.get(table))
        # Failures identify tables without dumping account/translation rows.
        self.assertEqual(changed, [])

    def test_all_bindings_added_without_mutating_existing_rows_or_other_tables(self):
        before = snapshot(self.db)
        result = self.reconcile(self.db)
        after = snapshot(self.db)
        changed = {table for table in set(before) | set(after) if before.get(table) != after.get(table)}
        self.assertTrue(changed <= set(m.ALLOWED_TABLES) | {'sqlite_sequence'}, changed)
        for table, original in before.items():
            if table != 'sqlite_sequence':
                self.assertTrue(set(original) <= set(after[table]), table + ' lost or modified existing rows')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM shared_report_definitions').fetchone()[0], 3)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM shared_report_surfaces').fetchone()[0], 151)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM admin_training_courses').fetchone()[0], 1)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM admin_training_native_surfaces').fetchone()[0], 2)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM admin_training_learning_grants').fetchone()[0], self.db.execute('SELECT COUNT(*) FROM roles WHERE active=1').fetchone()[0])
        self.assertEqual(result['inserted']['api_endpoints'], 5)
        self.assertEqual(result['inserted']['screen_api_links'], 151 * 4 + 1)
        self.assertEqual(result['workflow_tests_executed'], 0)
        self.assertFalse(result['verification_status_changed'])
        for table in m.SCHEMA:
            self.assertEqual(self.db.execute('PRAGMA foreign_key_check(' + table + ')').fetchall(), [])
        source_hashes = {name: hashlib.sha256((self.contract_root / name).read_bytes()).hexdigest() for name in result['source_bindings']}
        self.assertEqual(result['source_bindings'], source_hashes)

    def test_repeated_reconciliation_is_identical_and_does_not_rewrite_timestamps(self):
        self.db.row_factory = sqlite3.Row
        self.reconcile(self.db)
        first = snapshot(self.db)
        repeated = self.reconcile(self.db)
        self.assertEqual(repeated['inserted'], {})
        self.assert_snapshot_equal(first)

    def test_late_conflict_rolls_back_earlier_scopes_and_preserves_conflicting_row(self):
        self.db.execute('CREATE TABLE tenant_operations_policy(' + m.SCHEMA['tenant_operations_policy'] + ')')
        self.db.execute('INSERT INTO tenant_operations_policy VALUES(?,?,?)', ('admin-v1', '{}', 'Existing reviewed custom policy'))
        self.db.commit()
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Conflicting existing binding: tenant_operations_policy'):
            self.reconcile(self.db)
        self.assert_snapshot_equal(before)
        self.assertIsNone(self.db.execute("SELECT name FROM sqlite_master WHERE name='shared_report_definitions'").fetchone())

    def test_conflicting_report_grant_cannot_be_replaced_or_widened(self):
        self.reconcile(self.db, ('reports',))
        self.db.execute("UPDATE shared_report_grants SET can_email=0 WHERE report_id='organization_summary'")
        self.db.commit()
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Conflicting existing binding: shared_report_grants.can_email'):
            self.reconcile(self.db, ('reports',))
        self.assert_snapshot_equal(before)

    def test_changed_existing_authority_is_rejected_before_new_report_grants(self):
        self.db.execute('UPDATE runtime_catalog_permissions SET can_view_organization=0 WHERE can_view_organization=1')
        self.db.commit()
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Existing report authority differs'):
            self.reconcile(self.db, ('reports',))
        self.assert_snapshot_equal(before)

    def test_current_contracts_fail_closed_against_historical_checkpoint(self):
        # Historical fixture success is not proof of current or production authority.
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Existing report authority differs'):
            m.reconcile(self.db, ('reports',))
        self.assert_snapshot_equal(before)
        with self.assertRaisesRegex(ValueError, 'Missing or ambiguous existing active role code_admin'):
            m.reconcile(self.db, ('operations',))
        self.assert_snapshot_equal(before)

    def test_endpoint_code_collision_fails_atomically(self):
        app = self.db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
        self.db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method) VALUES(?,'SHARED_REPORT_CATALOG','/fixture/conflicting-contract','GET')", (app,))
        self.db.commit()
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Endpoint-code collision'):
            self.reconcile(self.db, ('reports',))
        self.assert_snapshot_equal(before)

    def test_transaction_remains_owned_by_caller_with_and_without_prior_dml(self):
        before = snapshot(self.db)
        self.assertFalse(self.db.in_transaction)
        self.reconcile(self.db, ('training',))
        self.assertTrue(self.db.in_transaction)
        self.db.rollback()
        self.assert_snapshot_equal(before)
        self.db.execute('CREATE TABLE caller_marker(value TEXT)')
        self.db.commit()
        self.db.execute("INSERT INTO caller_marker VALUES('uncommitted caller value')")
        self.reconcile(self.db, ('operations',))
        self.db.rollback()
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM caller_marker').fetchone()[0], 0)
        self.assertIsNone(self.db.execute("SELECT name FROM sqlite_master WHERE name='tenant_operations_policy'").fetchone())

    def test_unknown_scope_and_unreviewed_metadata_triggers_rejected(self):
        with self.assertRaisesRegex(ValueError, 'Choose distinct'):
            self.reconcile(self.db, ('invented',))
        self.db.execute('CREATE TABLE caller_marker(value TEXT)')
        self.db.execute("CREATE TRIGGER unexpected_api_side_effect AFTER INSERT ON api_endpoints BEGIN INSERT INTO caller_marker VALUES('unexpected'); END")
        self.db.commit()
        before = snapshot(self.db)
        with self.assertRaisesRegex(ValueError, 'Unreviewed metadata trigger'):
            self.reconcile(self.db, ('reports',))
        self.assert_snapshot_equal(before)


if __name__ == '__main__':
    unittest.main()
