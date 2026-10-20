import hashlib,json,unittest
from pathlib import Path
from tenant_accounts_registration import TenantAccountsStore,definition,expected_scope,GovernanceReadError
class ScopeTests(unittest.TestCase):
 def test_scope_matches_pin_and_is_read_only_authority(self):
  pin=json.loads(Path(__file__).with_name('production-pin.json').read_text());self.assertEqual(pin['tenantAccountsReadWriter'],expected_scope())
  self.assertEqual(expected_scope()['apiIds'],[16412,16421,16423,16427,16428]);self.assertFalse(expected_scope()['permissionChanges']);self.assertFalse(expected_scope()['businessDataWrites'])
 def test_controls_have_unique_registered_ids_and_locales(self):
  d=definition();ids=[x['testId'] for x in d['controls'].values()];self.assertEqual(len(ids),len(set(ids)));self.assertEqual(set(d['locales']),{'en','fr','es'})
  for values in d['locales'].values():self.assertEqual(set(values),set(d['locales']['en']));self.assertTrue(all(values.values()))
 def test_unrelated_tables_screens_namespaces_refused_before_sql(self):
  db=TenantAccountsStore.__new__(TenantAccountsStore)
  for table,values in [('api_endpoints',{}),('screens',{}),('role_screen_permissions',{}),('screen_components',{'screen_id':903}),('screen_components',{'screen_id':705,'file_path':'bad','component_code':'tenantAccounts.root'}),('screen_required_elements',{'screen_id':705,'element_key':'unrelated'}),('language_resources',{'resource_key':'unrelated'})]:
   with self.subTest(table=table,values=values),self.assertRaises(GovernanceReadError):db.insert_metadata(table,values)
if __name__=='__main__':unittest.main()
