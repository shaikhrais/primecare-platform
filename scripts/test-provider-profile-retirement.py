"""Retirement must fail closed when caller, identity, contracts or references drift."""
import importlib.util
import json
import sqlite3
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('provider_retirement', Path(__file__).with_name('reconcile-provider-profile-declaration.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class ProviderRetirementTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.root = Path(self.directory.name)
        self.config = self.root / 'packages/flutter_core/lib/src/network/api_client.dart'
        self.config.parent.mkdir(parents=True)
        self.config.write_text("'providerProfile': '/v1/provider/profile',\n'providerDashboard': '/v1/provider/profile',\nreturn route == '/v1/provider/profile' || route == '/v1/provider/dashboard';")
        self.service = self.root / 'packages/flutter_core/lib/provider_service.dart'
        self.service.write_text("ApiConfig.endpoints['providerProfile']")
        self.db = sqlite3.connect(':memory:')
        self.db.execute('CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,endpoint_code TEXT,route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,controller_name TEXT,implementation_status TEXT,health_status TEXT,app_id INTEGER,' + ','.join(f + ' TEXT' for f in module.NULL_AUTHORITY) + ')')
        self.db.execute("INSERT INTO api_endpoints(id,endpoint_code,route_path,http_method,service_name,auth_required,controller_name,implementation_status,health_status,app_id) VALUES(786,'API__V1_PROVIDER_DASHBOARD','/v1/provider/dashboard','POST','PRISMA',1,'','active','healthy',1)")
        self.db.execute("INSERT INTO api_endpoints(id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,health_status,app_id,permission_key,request_schema,response_schema) VALUES(16446,'PROVIDER_SELF_PROFILE','/v1/provider/profile','GET','provider',1,'implemented','healthy',6,'authenticated_provider_profile_owner',?,?)", (json.dumps(module.REQUEST_SCHEMA), json.dumps(module.RESPONSE_SCHEMA)))
        self.db.commit()

    def tearDown(self):
        self.db.close()
        self.directory.cleanup()

    def run_retirement(self):
        module.reconcile(self.db, self.root)

    def rejects(self):
        with self.assertRaises(ValueError):
            self.run_retirement()
        self.assertEqual(self.db.execute('SELECT implementation_status FROM api_endpoints WHERE id=786').fetchone()[0], 'active')

    def test_idempotent_tombstone_preserves_existing_authorized_get(self):
        canonical = self.db.execute('SELECT * FROM api_endpoints WHERE id=16446').fetchone()
        self.run_retirement()
        first = self.db.execute('SELECT * FROM api_endpoints').fetchall()
        self.run_retirement()
        self.assertEqual(first, self.db.execute('SELECT * FROM api_endpoints').fetchall())
        self.assertEqual(canonical, self.db.execute('SELECT * FROM api_endpoints WHERE id=16446').fetchone())
        self.assertEqual(self.db.execute('SELECT implementation_status,health_status FROM api_endpoints WHERE id=786').fetchone(), ('retired', 'unverified'))

    def test_canonical_identity_and_owner_authority_drift(self):
        for field, value in [('http_method', 'POST'), ('service_name', 'auth'), ('permission_key', 'all_roles'), ('auth_required', 0), ('app_id', 99), ('route_path', '/wrong'), ('implementation_status', 'planned')]:
            with self.subTest(field=field):
                self.db.execute('SAVEPOINT changed')
                self.db.execute('UPDATE api_endpoints SET ' + field + '=? WHERE id=16446', (value,))
                self.rejects()
                self.db.execute('ROLLBACK TO changed')
                self.db.execute('RELEASE changed')

    def test_exact_request_and_response_contract_drift(self):
        for column, value in [('request_schema', None), ('request_schema', '{}'), ('response_schema', '{}'), ('response_schema', json.dumps({**module.RESPONSE_SCHEMA, 'additionalProperties': True}))]:
            with self.subTest(column=column, value=value):
                self.db.execute('SAVEPOINT changed')
                self.db.execute('UPDATE api_endpoints SET ' + column + '=? WHERE id=16446', (value,))
                self.rejects()
                self.db.execute('ROLLBACK TO changed')
                self.db.execute('RELEASE changed')

    def test_new_legacy_authority_requires_review(self):
        for field in module.NULL_AUTHORITY:
            self.db.execute('UPDATE api_endpoints SET ' + field + "='new' WHERE id=786")
            self.rejects()
            self.db.execute('UPDATE api_endpoints SET ' + field + '=NULL WHERE id=786')

    def test_canonical_api_and_future_foreign_key_references_refuse(self):
        for ddl, insert in [('CREATE TABLE screen_api_links(api_id INTEGER)', 'INSERT INTO screen_api_links VALUES(786)'), ('CREATE TABLE future_use(target INTEGER REFERENCES api_endpoints(id))', 'INSERT INTO future_use VALUES(786)'), ('CREATE TABLE button_definition(endpoint_path TEXT)', "INSERT INTO button_definition VALUES('/v1/provider/dashboard')")]:
            self.db.execute('SAVEPOINT changed')
            self.db.execute(ddl)
            self.db.execute(insert)
            self.rejects()
            self.db.execute('ROLLBACK TO changed')
            self.db.execute('RELEASE changed')

    def test_registry_numeric_namespace_is_not_canonical_api_reference(self):
        self.db.execute('CREATE TABLE screen_endpoint_map(endpoint_id INTEGER,screen_id INTEGER)')
        self.db.execute('INSERT INTO screen_endpoint_map VALUES(786,999)')
        self.run_retirement()
        self.assertEqual(self.db.execute('SELECT * FROM screen_endpoint_map').fetchall(), [(786,999)])

    def test_new_composed_config_or_archived_caller_refuses(self):
        for location in ['apps/client/lib/caller.dart', 'generated_screen_backup_before_template_reset/archive/caller.dart']:
            path = self.root / location
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("const endpoint = '/v1/provider/dashboard';")
            self.rejects()
            path.unlink()
        self.config.write_text(self.config.read_text().replace("'providerProfile': '/v1/provider/profile'", "'providerProfile': '/wrong'"))
        self.rejects()

    def test_trigger_and_missing_canonical_fail_before_tombstone(self):
        self.db.execute("CREATE TRIGGER unsafe AFTER UPDATE ON api_endpoints BEGIN SELECT 1; END")
        self.rejects()
        self.db.execute('DROP TRIGGER unsafe')
        self.db.execute('DELETE FROM api_endpoints WHERE id=16446')
        self.rejects()


if __name__ == '__main__':
    unittest.main()
