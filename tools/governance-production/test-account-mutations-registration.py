import unittest,json
from pathlib import Path
from account_mutations_registration import MutationStore,definition,scope,control_keys,GovernanceReadError
class Tests(unittest.TestCase):
 def test_exact_scope_and_existing_actor_policy(self):
  self.assertEqual(json.loads(Path(__file__).with_name('production-pin.json').read_text())['accountMutationsWriter'],scope());d=definition();source=json.loads((Path(__file__).resolve().parents[2]/'cloudflare/workers/src/account-policy.json').read_text());self.assertEqual({k:v['targets'] for k,v in d['actors'].items()},source);self.assertFalse(scope()['permissionChanges'])
 def test_no_hr_management_controls_or_privileged_creation_targets(self):
  self.assertNotIn('revoke',control_keys('hr_director'));self.assertNotIn('save',control_keys('hr_director'));d=definition()
  for actor in d['actors'].values():self.assertFalse(set(actor['targets'])&{'platform_admin','central_admin','tenant_admin'})
 def test_controls_and_translations_are_unique_and_complete(self):
  d=definition();self.assertEqual(len(d['controls']),len({v['testId'] for v in d['controls'].values()}));self.assertEqual(set(d['locales']),{'en','fr','es'})
  for labels in d['locales'].values():self.assertEqual(set(labels),set(d['locales']['en']));self.assertTrue(all(labels.values()))
 def test_scope_guards_refuse_unrelated_writes_before_sql(self):
  db=MutationStore.__new__(MutationStore)
  for t,v in [('api_permissions',{}),('users',{}),('screen_components',{'screen_id':903}),('screen_components',{'screen_id':705,'file_path':'bad'}),('screen_required_elements',{'screen_id':39,'element_key':'bad'}),('screen_api_links',{'screen_id':39,'api_id':16422}),('language_resources',{'resource_key':'bad'})]:
   with self.subTest(t=t,v=v),self.assertRaises(GovernanceReadError):db.insert_metadata(t,v)
if __name__=='__main__':unittest.main()
