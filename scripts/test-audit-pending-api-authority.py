"""Evidence audits never turn generic grants or approximate routes into authority."""
import copy
import hashlib
import importlib.util
from pathlib import Path
import sqlite3
import tempfile
import unittest

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('authority', HERE/'audit-pending-api-authority.py')
authority = importlib.util.module_from_spec(spec)
spec.loader.exec_module(authority)


def checklist():
    rows = []
    for index, (method, path, stage) in enumerate([
        ('GET', '/v1/client/pending', 'needs_contract_and_verification'),
        ('POST', '/v1/client/pending', 'needs_contract_and_verification'),
        ('GET', '/v1/client/blocked', 'blocked'),
        ('GET', '/v1/client/done', 'unit_evidence_recorded')]):
        rows.append({'api': f'{method} {path}', 'method': method, 'route': path,
                     'declarationIds': [index + 1], 'stage': stage})
    return {'summary': {'uniqueOperations': 4, 'stages': {
        'needs_contract_and_verification': 2, 'blocked': 1, 'unit_evidence_recorded': 1}},
        'operations': rows}


class AuthorityAuditTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.database = Path(self.directory.name)/'governance.db'
        db = sqlite3.connect(self.database)
        db.executescript('''
          CREATE TABLE api_endpoints (
            id INTEGER PRIMARY KEY, route_path TEXT, http_method TEXT,
            permission_key TEXT, auth_required INTEGER, request_schema TEXT,
            response_schema TEXT, request_schema_id INTEGER, response_schema_id INTEGER,
            rate_limit_key TEXT, controller_name TEXT, service_name TEXT,
            implementation_status TEXT);
          CREATE TABLE roles(id INTEGER PRIMARY KEY, role_code TEXT);
          CREATE TABLE api_permissions(api_id INTEGER, role_id INTEGER,
            permission_key TEXT, can_access INTEGER);
          INSERT INTO roles VALUES(10,'client'),(11,'staff');
          INSERT INTO api_endpoints VALUES
            (100,'/v1/client/pending','GET','client.read',1,'{}','{}',NULL,NULL,'actor','handler','client','implemented'),
            (101,'/v1/client/blocked','GET','client.read',1,'{}','{}',NULL,NULL,'actor','handler','client','implemented');
        ''')
        db.commit(); db.close()
        self.source = checklist()

    def execute(self, sql, values=()):
        db = sqlite3.connect(self.database)
        db.execute(sql, values); db.commit(); db.close()

    def audit(self):
        before = hashlib.sha256(self.database.read_bytes()).hexdigest()
        source = copy.deepcopy(self.source)
        result = authority.audit(self.database, self.source)
        self.assertEqual(hashlib.sha256(self.database.read_bytes()).hexdigest(), before)
        self.assertEqual(self.source, source)
        self.assertTrue(result['noActivation'])
        self.assertEqual(result['implementationCredits'], 0)
        return {row['api']: row for row in result['operations']}

    def test_exact_method_path_and_finite_pending_coverage(self):
        self.execute('INSERT INTO api_permissions VALUES(100,10,?,1)', ('client.read',))
        rows = self.audit()
        self.assertEqual(set(rows), {'GET /v1/client/pending', 'POST /v1/client/pending'})
        self.assertEqual(rows['GET /v1/client/pending']['exactEndpointIds'], [100])
        self.assertEqual(rows['POST /v1/client/pending']['exactEndpointIds'], [])
        self.assertEqual(len(rows['GET /v1/client/pending']['explicitGrants']), 1)
        self.assertEqual(rows['POST /v1/client/pending']['explicitGrants'], [])

    def test_disabled_null_and_noncanonical_grants_do_not_confer_access(self):
        for value in (0, None, 2, -1, 'true'):
            with self.subTest(value=value):
                self.execute('DELETE FROM api_permissions')
                self.execute('INSERT INTO api_permissions VALUES(100,10,?,?)', ('client.read', value))
                row = self.audit()['GET /v1/client/pending']
                self.assertEqual(row['explicitGrants'], [])

    def test_duplicate_endpoint_is_ambiguous_even_with_explicit_grant(self):
        self.execute("INSERT INTO api_endpoints SELECT 102,route_path,http_method,permission_key,auth_required,request_schema,response_schema,request_schema_id,response_schema_id,rate_limit_key,controller_name,service_name,implementation_status FROM api_endpoints WHERE id=100")
        self.execute("INSERT INTO api_permissions VALUES(100,10,'client.read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['disposition'], 'ambiguous_endpoint')
        self.assertEqual(row['exactEndpointIds'], [100,102])

    def test_missing_table_and_columns_are_unknown_not_negative_evidence(self):
        self.execute('DROP TABLE api_permissions')
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['disposition'], 'unknown_schema')
        self.assertTrue(row['unknowns'])
        self.execute('CREATE TABLE api_permissions(api_id INTEGER, role_id INTEGER, can_access INTEGER)')
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['disposition'], 'unknown_schema')

    def test_unknown_role_reference_cannot_be_recorded_as_explicit_role_grant(self):
        self.execute("INSERT INTO api_permissions VALUES(100,999,'client.read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['explicitGrants'], [])
        self.assertTrue(row['unknowns'])

    def test_undefined_matching_permission_keys_do_not_confer_access(self):
        for permission in (None, '', '   '):
            with self.subTest(permission=permission):
                self.execute('UPDATE api_endpoints SET permission_key=? WHERE id=100', (permission,))
                self.execute('DELETE FROM api_permissions')
                self.execute('INSERT INTO api_permissions VALUES(100,10,?,1)', (permission,))
                row = self.audit()['GET /v1/client/pending']
                self.assertEqual(row['explicitGrants'], [])
                self.assertTrue(row['unknowns'])
                self.assertEqual(row['disposition'], 'unknown_schema')

    def test_mismatched_permission_key_is_unknown_without_grant(self):
        self.execute("INSERT INTO api_permissions VALUES(100,10,'different.permission',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['explicitGrants'], [])
        self.assertTrue(row['unknowns'])
        self.assertEqual(row['disposition'], 'unknown_schema')

    def test_duplicate_permission_rows_are_unknown_without_grant(self):
        self.execute("INSERT INTO api_permissions VALUES(100,10,'client.read',1)")
        self.execute("INSERT INTO api_permissions VALUES(100,10,'client.read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['explicitGrants'], [])
        self.assertTrue(row['unknowns'])
        self.assertEqual(row['disposition'], 'unknown_schema')

    def test_generic_role_rules_do_not_replace_exact_api_grants(self):
        self.execute('CREATE TABLE role_permission_rules(role_id INTEGER, action TEXT, can_access INTEGER)')
        self.execute("INSERT INTO role_permission_rules VALUES(10,'read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['explicitGrants'], [])
        self.assertEqual(row['disposition'], 'no_explicit_grant')

    def test_missing_database_is_not_created(self):
        missing = self.database.with_name('missing.db')
        with self.assertRaises(ValueError): authority.audit(missing, self.source)
        self.assertFalse(missing.exists())

if __name__ == '__main__': unittest.main()
