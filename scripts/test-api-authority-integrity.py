import sqlite3
import unittest
from pathlib import Path
from api_authority_integrity import assert_api_authority_integrity, ApiAuthorityIntegrityError


class IntegrityTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.db.executescript('''
            CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,request_schema TEXT,response_schema TEXT,permission_key TEXT);
            CREATE TABLE api_request_schemas(id INTEGER PRIMARY KEY,api_id INTEGER,schema_json TEXT);
            CREATE TABLE api_response_schemas(id INTEGER PRIMARY KEY,api_id INTEGER,schema_json TEXT);
            CREATE TABLE api_permissions(id INTEGER PRIMARY KEY,api_id INTEGER,permission_key TEXT);
            INSERT INTO api_endpoints VALUES(4,'{"type":"object","required":["email"]}','{"type":"object"}','authenticated_self_session');
        ''')

    def tearDown(self):
        self.db.close()

    def rejected(self):
        with self.assertRaises(ApiAuthorityIntegrityError):
            assert_api_authority_integrity(self.db)

    def test_reviewed_contracts_accept_semantic_json(self):
        self.db.execute('INSERT INTO api_request_schemas VALUES(1,4,?)', ('{"required":["email"], "type":"object"}',))
        self.db.execute("INSERT INTO api_permissions VALUES(1,4,'authenticated_self_session')")
        assert_api_authority_integrity(self.db)

    def test_numeric_collision_cannot_supply_contract(self):
        self.db.execute('INSERT INTO api_request_schemas VALUES(1,4,?)', ('{"type":"object","properties":{"id":{"type":"integer"}}}',))
        self.rejected()

    def test_wrong_permission_origin(self):
        self.db.execute("INSERT INTO api_permissions VALUES(1,4,'api_permission_ANOTHER_ENDPOINT')")
        self.rejected()

    def test_synthetic_permission_rejected_even_when_endpoint_copied(self):
        self.db.execute("UPDATE api_endpoints SET permission_key='api_permission_FAKE'")
        self.db.execute("INSERT INTO api_permissions VALUES(1,4,'api_permission_FAKE')")
        self.rejected()

    def test_orphan_schema_and_grant_rejected(self):
        self.db.execute("INSERT INTO api_response_schemas VALUES(1,99,'{}')")
        self.db.execute("INSERT INTO api_permissions VALUES(1,99,'authenticated_self_session')")
        self.rejected()

    def test_missing_reviewed_schema_rejected(self):
        self.db.execute('UPDATE api_endpoints SET response_schema=NULL')
        self.db.execute("INSERT INTO api_response_schemas VALUES(1,4,'{}')")
        self.rejected()

    def test_invalid_json_rejected(self):
        self.db.execute("INSERT INTO api_request_schemas VALUES(1,4,'broken')")
        self.rejected()

    def test_matching_json_primitives_are_not_contracts(self):
        for value in ('null','[]','42','"schema"'):
            with self.subTest(value=value):
                self.db.execute('DELETE FROM api_request_schemas')
                self.db.execute('UPDATE api_endpoints SET request_schema=?',(value,))
                self.db.execute('INSERT INTO api_request_schemas VALUES(1,4,?)',(value,))
                self.rejected()

    def test_migration_does_not_fabricate_contracts_or_grants(self):
        text = Path(__file__).with_name('migrate_architecture_tables.py').read_text()
        section = text[text.index('    # K.'):text.index('    # L.')]
        for table in ('api_permissions', 'api_services', 'api_controllers'):
            self.assertNotIn('INSERT INTO ' + table, section)
        self.assertNotIn('default_schema', section)
        self.assertNotIn('api_perms.append', section)


if __name__ == '__main__':
    unittest.main()
