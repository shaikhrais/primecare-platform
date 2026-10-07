"""Regression cases for catalog collisions, foreign keys and quarantine changes."""
import importlib.util
import sqlite3
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('guard', Path(__file__).with_name('check-api-catalog-identity.py'))
guard = importlib.util.module_from_spec(spec)
spec.loader.exec_module(guard)


class CatalogIdentityTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.db.executescript('''
          CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,http_method TEXT,route_path TEXT,permission_key TEXT);
          CREATE TABLE api_endpoint_registry(id INTEGER PRIMARY KEY,api_id INTEGER,endpoint_code TEXT,method TEXT,endpoint_path TEXT);
          CREATE TABLE api_permissions(id INTEGER PRIMARY KEY,api_id INTEGER,role_id INTEGER,runtime_artifact_id INTEGER,permission_key TEXT,can_access INTEGER);
          CREATE TABLE roles(id INTEGER PRIMARY KEY);
          CREATE TABLE runtime_artifacts(id INTEGER PRIMARY KEY);
          INSERT INTO roles VALUES(1);
          INSERT INTO runtime_artifacts VALUES(1);
          INSERT INTO api_endpoints VALUES(1,'GET','/v1/wrong',NULL),(50,'GET','/v1/correct','self:read');
          INSERT INTO api_endpoint_registry VALUES(1,50,'CORRECT','GET','/v1/correct');
        ''')

    def tearDown(self):
        self.db.close()

    def grant(self, target=50, key='api_permission_CORRECT', role=1, artifact=1, enabled=1, row_id=1):
        self.db.execute('INSERT INTO api_permissions VALUES(?,?,?,?,?,?)', (row_id, target, role, artifact, key, enabled))

    def test_correct_registry_api_id_accepts_identity_without_accepting_authority(self):
        self.grant()
        self.assertEqual(guard.violations(self.db), {})

    def test_collision_uses_key_operation_not_registry_numeric_id(self):
        self.grant(target=1)
        findings = guard.violations(self.db)
        self.assertIn('permission_key_targets_different_operation', next(iter(findings.values()))['reasons'])

    def test_canonical_endpoint_permission_is_valid_identity(self):
        self.grant(key='self:read')
        self.assertEqual(guard.violations(self.db), {})

    def test_foreign_key_failures_and_unknown_key(self):
        self.grant(target=99, key='unknown', role=99, artifact=99)
        reasons = next(iter(guard.violations(self.db).values()))['reasons']
        self.assertEqual(set(reasons), {'missing_endpoint_foreign_key', 'missing_role_foreign_key', 'missing_runtime_artifact_foreign_key'})
        self.db.execute('UPDATE api_permissions SET api_id=50,role_id=1,runtime_artifact_id=1')
        self.assertIn('unknown_permission_identity', next(iter(guard.violations(self.db).values()))['reasons'])

    def test_registry_mapping_method_drift_is_rejected(self):
        self.db.execute("UPDATE api_endpoint_registry SET method='POST'")
        self.assertIn('registry:1', guard.violations(self.db))

    def test_quarantine_does_not_allow_new_grants_or_role_replacement(self):
        self.grant(target=1)
        baseline = guard.violations(self.db)
        self.assertEqual(guard.unexpected(baseline, baseline), {})
        self.grant(target=1, row_id=2)
        self.assertTrue(guard.unexpected(guard.violations(self.db), baseline))
        self.db.execute('DELETE FROM api_permissions WHERE id=2')
        self.db.execute('INSERT INTO roles VALUES(2)')
        self.db.execute('UPDATE api_permissions SET role_id=2')
        self.assertTrue(guard.unexpected(guard.violations(self.db), baseline))

    def test_quarantine_does_not_allow_enabling_disabled_grants(self):
        self.grant(target=1, enabled=0)
        baseline = guard.violations(self.db)
        self.db.execute('UPDATE api_permissions SET can_access=1')
        self.assertTrue(guard.unexpected(guard.violations(self.db), baseline))

    def test_repaired_or_removed_violation_can_leave_quarantine(self):
        self.grant(target=1)
        baseline = guard.violations(self.db)
        self.db.execute('UPDATE api_permissions SET api_id=50')
        self.assertEqual(guard.unexpected(guard.violations(self.db), baseline), {})


if __name__ == '__main__':
    unittest.main()
