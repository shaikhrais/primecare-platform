"""Read-only fixture proves diagnostics cannot turn guessed identities into grants."""
import importlib.util
import sqlite3
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('identity_capture', Path(__file__).with_name('audit_theme_release_identities.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

class IdentityCaptureTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.db.executescript('''
        CREATE TABLE api_endpoints(id,http_method,route_path,permission_key);
        CREATE TABLE api_endpoint_registry(id,api_id,endpoint_code,method,endpoint_path);
        CREATE TABLE api_permissions(id,api_id,role_id,runtime_artifact_id,permission_key,can_access);
        CREATE TABLE roles(id,role_code,active);
        CREATE TABLE runtime_artifacts(id INTEGER,artifact_type TEXT,source_file TEXT,secret TEXT);
        CREATE TABLE screens(id,screen_code,route_path,actual_file_path,active);
        CREATE TABLE screen_api_links(screen_id,api_id);
        CREATE TABLE role_screen_permissions(role_id,screen_id,can_view);
        INSERT INTO api_endpoints VALUES(710,'POST','/v1/messages','role_screen_permissions'),(777,'POST','/v1/user/preferences','authenticated_self_preferences'),(900,'GET','/other','other');
        INSERT INTO api_endpoint_registry VALUES(710,4957,'legacy','GET','/legacy');
        INSERT INTO api_permissions VALUES(1,710,1,1,'api_permission_legacy',0),(2,777,1,1,'authenticated_self_preferences',1),(3,900,1,NULL,'other',1);
        INSERT INTO roles VALUES(1,'staff',1),(65,'tenant_admin',1);
        INSERT INTO runtime_artifacts VALUES(2,'unrelated','some/source.ts','MUST_NOT_EXPORT');
        INSERT INTO screens VALUES(9,'messages','/messages','host.ts',1);
        INSERT INTO screen_api_links VALUES(9,710);
        INSERT INTO role_screen_permissions VALUES(1,9,1),(65,9,0);
        ''')
    def tearDown(self):
        self.db.close()
    def test_exact_rows_preserve_denials_and_exclude_unrelated_grants(self):
        before = self.db.total_changes
        report = module.capture(self.db, scope_details=True)
        self.assertEqual([g['id'] for g in report['grants']], [1,2])
        self.assertEqual(report['grants'][0]['can_access'], 0)
        self.assertEqual(report['missingRuntimeArtifactIds'], [1])
        self.assertEqual(report['rowReconciliation'][0]['blockedBy'], ['permission_operation_authority_required','runtime_artifact_provenance_required'])
        self.assertEqual(report['rowReconciliation'][1]['blockedBy'], ['runtime_artifact_provenance_required'])
        self.assertTrue(all(r['proposedChange'] is None and r['safeToApply'] is False for r in report['rowReconciliation']))
        self.assertEqual(before, self.db.total_changes)
    def test_unrelated_artifact_and_screen_access_never_establish_authority(self):
        report = module.capture(self.db, scope_details=True)
        self.assertEqual(report['runtimeArtifactCandidates'][0]['id'], 2)
        self.assertNotIn('MUST_NOT_EXPORT', str(report))
        self.assertFalse(report['authorityEstablished'])
        self.assertFalse(report['roleAndScreenReadbackEstablishesNewGrants'])
        self.assertEqual(report['screenPermissions'][1]['can_view'], 0)
    def test_unchanged_readback_hash_is_deterministic_and_detects_drift(self):
        original = module.capture(self.db)['snapshotSha256']
        self.assertEqual(original, module.capture(self.db)['snapshotSha256'])
        self.db.execute('UPDATE api_permissions SET can_access=1 WHERE id=1')
        self.assertNotEqual(original, module.capture(self.db)['snapshotSha256'])

if __name__ == '__main__':
    unittest.main()
