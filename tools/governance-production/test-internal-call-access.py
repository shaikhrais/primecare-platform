import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import internal_call_contracts_registration as c
import internal_call_access_registration as a
spec=importlib.util.spec_from_file_location('call_access_fixture',Path(__file__).with_name('test-voice-contact-access-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class AccessTests(f.AccessTests):
 def setUp(self):
  super().setUp();env=patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_CONTRACTS':'1','GOVERNANCE_INTERNAL_CALL_ACCESS':'1'});env.start();self.addCleanup(env.stop)
  with c.InternalCallContractStore(_test_connection=psycopg.connect(f.URL)) as db:c.register(db)
 def test_internal_links_only_eligible_and_exact_denials_preserved(self):
  with a.InternalCallAccessStore(_test_connection=psycopg.connect(f.URL)) as db:
   before=db.execute('SELECT * FROM role_screen_permissions').fetchall();first=a.register(db);self.assertEqual(first,a.register(db));self.assertEqual(first,a.register(a.ReadView(db),False));self.assertEqual(first['screenLinks'],20);self.assertEqual(first['eligibleRoles'],1);self.assertEqual(first['apiGrants'],5);self.assertEqual(before,db.execute('SELECT * FROM role_screen_permissions').fetchall())
 def test_internal_no_role_escalation(self):
  with a.InternalCallAccessStore(_test_connection=psycopg.connect(f.URL)) as db:
   aid=a.definition(db)['apiIds']['call.media']
   for role in [52,53,999]:
    with self.assertRaises(a.GovernanceReadError):db.insert_exact('api_permissions',dict(role_id=role,api_id=aid,permission_key='role_screen_permissions',can_access=1))
if __name__=='__main__':unittest.main(verbosity=2)
