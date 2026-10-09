import importlib.util
import sqlite3
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('retirement', Path(__file__).with_name('reconcile-auth-root-declarations.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class RetirementTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.db.execute('CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,endpoint_code TEXT,route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,controller_name TEXT,implementation_status TEXT,health_status TEXT,app_id INTEGER DEFAULT 1,' + ','.join(x + ' TEXT' for x in module.NULL_AUTHORITY) + ')')
        for aid, path, code in module.RETIREMENTS:
            self.db.execute('INSERT INTO api_endpoints(id,endpoint_code,route_path,http_method,service_name,auth_required,controller_name,implementation_status,health_status) VALUES(?,?,?,\'POST\',\'PRISMA\',1,\'\',\'active\',\'healthy\')', (aid, code, path))
        self.db.commit()

    def tearDown(self):
        self.db.close()

    def statuses(self):
        return self.db.execute('SELECT implementation_status FROM api_endpoints ORDER BY id').fetchall()

    def rejects(self):
        with self.assertRaises(ValueError):
            module.reconcile(self.db)
        self.assertEqual(self.statuses(), [('active',), ('active',)])

    def test_atomic_idempotent_tombstones(self):
        module.reconcile(self.db)
        first = self.db.execute('SELECT * FROM api_endpoints ORDER BY id').fetchall()
        module.reconcile(self.db)
        self.assertEqual(first, self.db.execute('SELECT * FROM api_endpoints ORDER BY id').fetchall())
        self.assertEqual(self.statuses(), [('retired',), ('retired',)])

    def test_every_authority_field_refuses(self):
        for field in module.NULL_AUTHORITY:
            with self.subTest(field=field):
                self.db.execute('UPDATE api_endpoints SET ' + field + '=\'new-authority\' WHERE id=1490')
                self.rejects()
                self.db.execute('UPDATE api_endpoints SET ' + field + '=NULL WHERE id=1490')

    def test_actual_inbound_reference_refuses(self):
        for table in ('api_permissions', 'api_request_schemas', 'api_response_schemas', 'screen_api_links', 'unknown_future_consumer'):
            self.db.execute('CREATE TABLE ' + table + '(api_id INTEGER)')
            self.db.execute('INSERT INTO ' + table + ' VALUES(1490)')
            self.rejects()
            self.db.execute('DROP TABLE ' + table)

    def test_future_fk_column_refuses(self):
        self.db.execute('CREATE TABLE future_consumer(target INTEGER REFERENCES api_endpoints(id))')
        self.db.execute('INSERT INTO future_consumer VALUES(822)')
        self.rejects()

    def test_registry_namespace_link_preserved(self):
        self.db.execute('CREATE TABLE screen_endpoint_map(endpoint_id INTEGER,screen_id INTEGER)')
        self.db.execute('INSERT INTO screen_endpoint_map VALUES(822,697)')
        module.reconcile(self.db)
        self.assertEqual(self.db.execute('SELECT * FROM screen_endpoint_map').fetchall(), [(822,697)])

    def test_registered_path_refuses(self):
        self.db.execute('CREATE TABLE button_action_definitions(endpoint_path TEXT)')
        self.db.execute("INSERT INTO button_action_definitions VALUES('/v1/auth')")
        self.rejects()

    def test_only_reviewed_closed_diagnostic_is_preserved(self):
        self.db.execute('CREATE TABLE governance_findings(related_api_id INTEGER REFERENCES api_endpoints(id),finding_category TEXT,finding_code TEXT,status TEXT,related_screen_id INTEGER,related_file_id INTEGER,description TEXT)')
        self.db.execute("INSERT INTO governance_findings VALUES(822,'drift','missing_test_coverage','closed',NULL,NULL,'API Endpoint POST /v1/auth/ is missing verification test proof.')")
        for field, value in [('status', 'open'), ('finding_code', 'newfinding'), ('related_screen_id', 99)]:
            with self.subTest(field=field):
                self.db.execute('SAVEPOINT alter_finding')
                self.db.execute('UPDATE governance_findings SET ' + field + '=?', (value,))
                self.rejects()
                self.db.execute('ROLLBACK TO alter_finding')
                self.db.execute('RELEASE alter_finding')
        module.reconcile(self.db)
        self.assertEqual(self.db.execute('SELECT related_api_id FROM governance_findings').fetchall(), [(822,)])

    def test_different_app_refuses(self):
        self.db.execute('UPDATE api_endpoints SET app_id=2 WHERE id=1490')
        self.rejects()

    def test_exact_identity_refuses(self):
        self.db.execute("UPDATE api_endpoints SET http_method='GET' WHERE id=1490")
        self.rejects()

    def test_missing_second_root_refuses_first_retirement(self):
        self.db.execute('DELETE FROM api_endpoints WHERE id=1490')
        with self.assertRaises(ValueError):
            module.reconcile(self.db)
        self.assertEqual(self.statuses(), [('active',)])

    def test_sql_failure_rolls_back_first_update(self):
        self.db.execute("CREATE TRIGGER block_second BEFORE UPDATE ON api_endpoints WHEN OLD.id=1490 BEGIN SELECT RAISE(ABORT,'fail second'); END")
        with self.assertRaises(sqlite3.IntegrityError):
            module.reconcile(self.db)
        self.assertEqual(self.statuses(), [('active',), ('active',)])

    def test_caller_transaction_preserved(self):
        self.db.execute('CREATE TABLE caller_work(value TEXT)')
        self.db.execute("INSERT INTO caller_work VALUES('keep')")
        self.db.execute("UPDATE api_endpoints SET permission_key='authority' WHERE id=1490")
        self.rejects()
        self.assertEqual(self.db.execute('SELECT * FROM caller_work').fetchall(), [('keep',)])
        self.assertTrue(self.db.in_transaction)


if __name__ == '__main__':
    unittest.main()
