"""Disposable native catalogue registration and inherited writer regressions."""
import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import internal_call_contracts_registration as c
import internal_call_access_registration as a
spec=importlib.util.spec_from_file_location('call_fixture',Path(__file__).with_name('test-communications-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
from test_production_store import NativeStoreTests
class ContractTests(unittest.TestCase):
 evidence=NativeStoreTests.evidence;table=NativeStoreTests.table;open_store=NativeStoreTests.open_store
 def setUp(self):
  f.RegistrationTests.setUp(self);e=patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_CONTRACTS':'1'});e.start();self.addCleanup(e.stop)
 def store(self):return c.InternalCallContractStore(_test_connection=psycopg.connect(f.URL))
 def test_exact_five_idempotent_and_read_view(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]
   first=c.register(db);self.assertEqual(first,c.register(db));self.assertEqual(first,c.register(c.ReadView(db)));self.assertEqual(first['registered'],5);self.assertEqual(len(set(first['apiIds'].values())),5);self.assertFalse(first['activation']);self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']])
 def test_edited_contract_is_preserved(self):
  with self.store() as db:ids=c.register(db)['apiIds']
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='human_edit' WHERE id=%s",[ids['call.dial']])
  with self.assertRaises(c.GovernanceReadError):
   with self.store() as db:c.register(db)
 def test_mid_write_failure_rolls_back(self):
  class Failed(c.InternalCallContractStore):
   def insert_exact(self,entry):
    result=super().insert_exact(entry)
    if entry['route_path']=='/v1/calls/dial':raise RuntimeError('injected')
    return result
  with self.assertRaises(RuntimeError):
   with Failed(_test_connection=psycopg.connect(f.URL)) as db:c.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT count(*) FROM api_endpoints').fetchone()[0],2)
 def test_pin_optin_and_arbitrary_insert_fail(self):
  with patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_CONTRACTS':'0'}):
   with self.assertRaises(c.GovernanceReadError):self.store()
  with self.store() as db:
   with self.assertRaises(c.GovernanceReadError):db.insert_exact({'route_path':'/arbitrary'})
if __name__=='__main__':unittest.main(verbosity=2)
