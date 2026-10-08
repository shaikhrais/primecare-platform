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

    def test_unbound_raw_grant_is_preserved_without_activation(self):
        self.execute('UPDATE api_endpoints SET permission_key=NULL WHERE id=100')
        self.execute("INSERT INTO api_permissions VALUES(100,10,'client.read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['explicitGrants'], [])
        self.assertEqual(row['rawGrantEvidence'][0]['permissionKey'], 'client.read')
        self.assertEqual(row['rawGrantEvidence'][0]['roleCode'], 'client')
        self.assertFalse(row['rawGrantEvidence'][0]['matchesEndpointKey'])
        self.assertEqual(row['disposition'], 'unknown_schema')

    def test_blocked_inclusion_is_explicit_and_preserves_stage(self):
        default = authority.audit(self.database, self.source)
        included = authority.audit(self.database, self.source, include_blocked=True)
        self.assertEqual(default['summary']['pendingUniqueOperations'], 2)
        self.assertEqual(default['summary']['blockedUniqueOperations'], 0)
        self.assertEqual(included['summary']['pendingUniqueOperations'], 2)
        self.assertEqual(included['summary']['blockedUniqueOperations'], 1)
        self.assertEqual(len(included['operations']), 3)
        self.assertEqual(next(r for r in included['operations'] if r['api'].endswith('/blocked'))['stage'], 'blocked')

    def test_exact_function_grants_and_screen_context_do_not_replace_endpoint_authority(self):
        db = sqlite3.connect(self.database)
        db.executescript("""
            CREATE TABLE screen_functions(id INTEGER,api_id INTEGER,screen_id INTEGER,function_code TEXT,permission_key TEXT);
            CREATE TABLE role_function_permissions(role_id INTEGER,function_id INTEGER,can_execute INTEGER);
            CREATE TABLE screen_api_links(screen_id INTEGER,api_id INTEGER,purpose TEXT);
            CREATE TABLE screens(id INTEGER,screen_code TEXT);
            CREATE TABLE role_screen_permissions(role_id INTEGER,screen_id INTEGER,can_view INTEGER);
            INSERT INTO screen_functions VALUES(5,100,7,'self.read','client.read'),(6,101,8,'unrelated','client.read');
            INSERT INTO role_function_permissions VALUES(10,5,1),(11,6,1);
            INSERT INTO screen_api_links VALUES(7,100,'self identity');
            INSERT INTO screens VALUES(7,'identity');
            INSERT INTO role_screen_permissions VALUES(11,7,1);
        """)
        db.commit(); db.close()
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual([f['id'] for f in row['functionEvidence']], [5])
        self.assertEqual(row['functionEvidence'][0]['roleExecuteEvidence'][0]['roleCode'], 'client')
        self.assertTrue(row['screenContext'][0]['contextOnly'])
        self.assertEqual(row['explicitGrants'], [])
        self.assertEqual(row['disposition'], 'no_explicit_grant')

    def test_registry_origin_mismatch_is_preserved_not_attached_as_authority(self):
        self.execute('CREATE TABLE api_endpoint_registry(id INTEGER,api_id INTEGER,endpoint_code TEXT,method TEXT,endpoint_path TEXT)')
        self.execute("INSERT INTO api_endpoint_registry VALUES(100,4253,'api_v1_cns_list_get','GET','/v1/cns')")
        self.execute('UPDATE api_endpoints SET permission_key=NULL WHERE id=100')
        self.execute("INSERT INTO api_permissions VALUES(100,10,'api_permission_api_v1_cns_list_get',1)")
        row = self.audit()['GET /v1/client/pending']
        origin = row['rawGrantEvidence'][0]['registryOriginEvidence']
        self.assertEqual(origin['disposition'], 'method_path_mismatch_observed')
        self.assertEqual(origin['records'][0]['api_id'], 4253)
        self.assertTrue(origin['records'][0]['referencedRegistryIdEqualsEndpointId'])
        self.assertFalse(origin['records'][0]['sameUnderlyingApiId'])
        self.assertEqual(row['explicitGrants'], [])

    def test_registry_exact_match_is_evidence_without_activation_credit(self):
        self.execute('CREATE TABLE api_endpoint_registry(id INTEGER,api_id INTEGER,endpoint_code TEXT,method TEXT,endpoint_path TEXT)')
        self.execute("INSERT INTO api_endpoint_registry VALUES(7,100,'self_read','GET','/v1/client/pending')")
        self.execute("INSERT INTO api_permissions VALUES(100,10,'api_permission_self_read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['rawGrantEvidence'][0]['registryOriginEvidence']['disposition'], 'method_path_match_observed')
        self.assertEqual(row['explicitGrants'], [])

    def test_unknown_registry_preserves_raw_grant(self):
        self.execute("INSERT INTO api_permissions VALUES(100,10,'client.read',1)")
        row = self.audit()['GET /v1/client/pending']
        self.assertEqual(row['rawGrantEvidence'][0]['registryOriginEvidence']['disposition'], 'unknown_registry_schema')
        self.assertEqual(len(row['rawGrantEvidence']), 1)

    def test_missing_database_is_not_created(self):
        missing = self.database.with_name('missing.db')
        with self.assertRaises(ValueError): authority.audit(missing, self.source)
        self.assertFalse(missing.exists())

if __name__ == '__main__': unittest.main()
