"""Metadata-only fixtures: no database, transport or production authority."""
import importlib.util
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('dashboard_metadata.py'))
audit = importlib.util.module_from_spec(spec)
spec.loader.exec_module(audit)


class Cursor:
    def __init__(self, names, values):
        self.description = [(name,) for name in names]
        self.values = values
    def fetchall(self):
        return self.values


class Metadata:
    def __init__(self, permission='authenticated_self_preferences'):
        self.permission = permission
        self.statements = []
    def execute(self, sql, parameters=()):
        self.statements.append(sql)
        if not sql.startswith('SELECT '):
            raise AssertionError('Only SELECT metadata reads are expected')
        if 'FROM api_endpoints' in sql:
            return Cursor(['id','path','method','service_name','auth_required','permission_key'], [(777,'/v1/user/preferences','POST','auth',1,self.permission)])
        if 'FROM role_screen_permissions' in sql:
            return Cursor(['role_id'], [(7,)])
        if 'FROM screen_components' in sql:
            return Cursor(['component_code','implementation_status'], [('prime_card','implemented_unverified')])
        if 'WHERE route_path' in sql:
            return Cursor(['id','screen_code','route_path','actual_file_path','active'], [(91,'tenant_admin_command_center','/tenant-dashboard','websites/typescript/src/tenant-dashboard/index.ts',1)])
        if 'FROM screens' in sql:
            return Cursor(['id','screen_code','route_path','actual_file_path','active'], [])
        raise AssertionError('Unexpected metadata read')


class ReadinessTests(unittest.TestCase):
    def test_matching_metadata_is_not_reported_as_business_acceptance(self):
        db = Metadata()
        result = audit.inspect(db)
        self.assertTrue(result['preferenceApi']['matchesSourceContract'])
        self.assertTrue(result['contracts']['dashboard-pages']['registeredHosts'][0]['matchesContract'])
        self.assertNotIn('productionReady', result)
        self.assertIn('theme', result['sourcePreferenceKinds'])
        self.assertNotIn('dashboard', result['sourcePreferenceKinds'])
        self.assertTrue(all(sql.startswith('SELECT ') for sql in db.statements))
    def test_permission_mismatch_does_not_match_source_contract(self):
        result = audit.inspect(Metadata(permission='different_permission'))
        self.assertFalse(result['preferenceApi']['matchesSourceContract'])


if __name__ == '__main__':
    unittest.main()
