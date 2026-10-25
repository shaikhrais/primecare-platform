"""Disposable native PostgreSQL only. Tests never use production credentials."""
import concurrent.futures,importlib.util,json,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import messaging_contracts_registration as m
spec=importlib.util.spec_from_file_location('communication_fixture',Path(__file__).with_name('test-communications-registration.py'))
fixture=importlib.util.module_from_spec(spec);spec.loader.exec_module(fixture)
from test_production_store import NativeStoreTests
URL=fixture.URL
class RegistrationTests(unittest.TestCase):
 evidence=NativeStoreTests.evidence
 table=NativeStoreTests.table
 open_store=NativeStoreTests.open_store
 def setUp(self):
  fixture.RegistrationTests.setUp(self)
  scope=patch.dict(os.environ,{'GOVERNANCE_MESSAGING_CONTRACT_REGISTRATION':'1'});scope.start();self.addCleanup(scope.stop)
 def store(self):return m.MessagingContractRegistrationStore(_test_connection=psycopg.connect(URL))
 def test_exact_idempotent_registration_and_grants_are_unchanged(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]
   anchor=db.execute('SELECT * FROM api_endpoints WHERE id=710').fetchall();first=m.register(db);self.assertEqual(first,m.register(db));self.assertEqual(first['registered'],1);self.assertFalse(first['activation']);self.assertEqual(first['messagesSent'],0)
   self.assertEqual(len(set(first['apiIds'].values())),1);self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],3)
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]);self.assertEqual(anchor,db.execute('SELECT * FROM api_endpoints WHERE id=710').fetchall())
  with self.store() as db:self.assertEqual(first,m.register(db))
 def test_concurrent_connections_share_one_exact_registration(self):
  def run():
   with self.store() as db:return m.register(db)
  with concurrent.futures.ThreadPoolExecutor(max_workers=2) as threads:
   left,right=list(threads.map(lambda _:run(),range(2)))
  self.assertEqual(left,right)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],3)
 def test_mid_insert_failure_rolls_back_every_contract(self):
  class Failure(m.MessagingContractRegistrationStore):
   def insert_exact(self,entry):
    result=super().insert_exact(entry)
    raise RuntimeError('Injected failure after insert')
  with self.assertRaises(RuntimeError):
   with Failure(_test_connection=psycopg.connect(URL)) as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],2)
 def test_edited_contract_is_preserved_and_reconciliation_is_required(self):
  with self.store() as db:first=m.register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='human_edit' WHERE id=%s",[first['apiIds']['sms.incoming']])
  with self.assertRaisesRegex(m.GovernanceReadError,'preserved'):
   with self.store() as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT service_name FROM api_endpoints WHERE id=?',(first['apiIds']['sms.incoming'],)).fetchone()[0],'human_edit')
 def test_duplicate_identity_fails_without_mutating_rows(self):
  with self.store() as db:
   op=m.definition()['operations'][0];entry=m.values(m.definition(),op,2);db.insert_exact(entry);db.insert_exact(entry)
  with self.assertRaisesRegex(m.GovernanceReadError,'Duplicate'):
   with self.store() as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],4)
 def test_duplicate_api_id_cannot_inherit_another_contract_identity(self):
  with self.store() as db:first=m.register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('api_endpoints')+' SET id=857 WHERE id=%s',[first['apiIds']['sms.incoming']])
  with self.assertRaisesRegex(m.GovernanceReadError,'identity collision'):
   with self.store() as db:m.register(db)
 def test_opt_in_pin_and_arbitrary_insert_are_denied(self):
  with patch.dict(os.environ,{'GOVERNANCE_MESSAGING_CONTRACT_REGISTRATION':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with patch.object(m,'expected_scope',return_value={}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   for entry in [{},{'route_path':'/unrelated'},{**m.values(m.definition(),m.definition()['operations'][0],2),'implementation_status':'implemented'}]:
    with self.assertRaises(m.GovernanceReadError):db.insert_exact(entry)
 def test_missing_anchor_fails_without_new_contracts(self):
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('DELETE FROM '+self.table('api_endpoints')+' WHERE id=710')
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],1)
if __name__=='__main__':unittest.main()
