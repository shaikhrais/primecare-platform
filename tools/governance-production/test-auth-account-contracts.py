import unittest,json
from pathlib import Path
from auth_account_contracts import definition,expected_scope,target_permission,GovernanceReadError
class ContractTests(unittest.TestCase):
 def test_exact_pin(self):self.assertEqual(json.loads(Path(__file__).with_name('production-pin.json').read_text())['authAccountContractWriter'],expected_scope())
 def test_targets_are_existing_policy_and_explicit_safe_responses(self):
  d=definition()
  for api in d['apis']:
   self.assertEqual(api['target']['service_name'],'auth');self.assertEqual(json.loads(api['target']['request_schema'])['properties']['role']['enum'],[x['code'] for x in d['actors']['ceo']['targets']]);response=json.loads(api['target']['response_schema']);self.assertFalse(response['additionalProperties']);self.assertFalse(response['properties']['user']['additionalProperties']);self.assertNotIn('password',response['properties']['user']['properties'])
 def test_all_128_legacy_rows_only_narrow_and_keep_identity_history(self):
  d=definition();self.assertEqual(len(d['reviewedPermissions']),128)
  for api in d['apis']:
   rows=[x for x in d['reviewedPermissions'] if x['api_id']==api['id']];out=[target_permission(p,api) for p in rows]
   self.assertEqual([p['role_id'] for p in out if p['can_access']],api['allowedActorIds'])
   for old,new in zip(rows,out):self.assertEqual({k:v for k,v in old.items() if k not in ['permission_key','can_access']},{k:v for k,v in new.items() if k not in ['permission_key','can_access']});self.assertLessEqual(new['can_access'],old['can_access'])
 def test_cannot_enable_disabled_actor(self):
  api=definition()['apis'][0];p=dict(definition()['reviewedPermissions'][19],can_access=0);self.assertEqual(target_permission(p,api)['can_access'],0)
 def test_wrong_api_refused(self):
  with self.assertRaises(GovernanceReadError):target_permission({'api_id':99},definition()['apis'][0])
if __name__=='__main__':unittest.main()
