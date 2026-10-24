"""Transactional metadata revision against disposable loopback PostgreSQL only."""
import json,os,runpy,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import four_digit_voice_revision as m
F=runpy.run_path(str(Path(__file__).with_name('test-communication-access-registration.py')))
A=F['AccessRegistrationTests'];URL=F['URL']
class RevisionTests(unittest.TestCase):
 evidence=A.evidence
 table=A.table
 open_store=A.open_store
 def setUp(self):
  A.setUp(self)
  scope=patch.dict(os.environ,{'GOVERNANCE_TWILIO_CONTRACT_REGISTRATION':'1','GOVERNANCE_FOUR_DIGIT_VOICE_REVISION':'1'});scope.start();self.addCleanup(scope.stop)
  with self.store() as db:
   with patch.object(m.contracts,'FILE',m.OLD_CONTRACTS):m.contracts.register(db)
   p=m.documents()[0]
   db.db.execute('INSERT INTO '+db.table('platform_hierarchy_policy')+' (_primecare_import_row,id,definition,requirement) VALUES(0,%s,%s,%s)',[p['id'],json.dumps(p),p['requirement']])
 def store(self):return m.FourDigitVoiceRevisionStore(_test_connection=psycopg.connect(URL))
 def test_revision_is_idempotent_and_preserves_grants_ids_and_other_fields(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]
   ids=db.execute('SELECT id,route_path,implementation_status FROM api_endpoints ORDER BY id').fetchall()
   first=m.revise(db);self.assertEqual(first,m.revise(db));m.verify_reader(db)
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]);self.assertEqual(ids,db.execute('SELECT id,route_path,implementation_status FROM api_endpoints ORDER BY id').fetchall())
   self.assertFalse(first['activation']);self.assertFalse(first['assignmentsChanged']);self.assertEqual(first['extensionDigits'],4)
  with self.store() as db:m.verify_reader(db)
 def test_explicit_rollback_preserves_all_six_digit_metadata(self):
  with self.store() as db:
   before=db.execute('SELECT * FROM api_endpoints').fetchall();m.revise(db);db.db.rollback()
  with self.store() as db:
   self.assertEqual(before,db.execute('SELECT * FROM api_endpoints').fetchall())
   with self.assertRaises(m.GovernanceReadError):m.verify_reader(db)
 def test_exception_after_updates_rolls_back_everything(self):
  with self.assertRaises(RuntimeError):
   with self.store() as db:m.revise(db);raise RuntimeError('Injected failure')
  with self.store() as db:
   self.assertEqual(json.loads(db.execute('SELECT definition FROM platform_hierarchy_policy').fetchone()[0])['rules']['extensionDigits'],6)
 def test_edited_api_or_policy_is_preserved_and_blocks_all_updates(self):
  for table,sql in [('api_endpoints',"UPDATE {table} SET service_name='human_edit' WHERE route_path='/v1/voice/token'"),('platform_hierarchy_policy',"UPDATE {table} SET definition='{}'")]:
   with self.subTest(table=table):
    with self.store() as db:
     db.db.execute(sql.replace('{table}',db.table(table)))
     with self.assertRaises(m.GovernanceReadError):m.revise(db)
     db.db.rollback()
 def test_missing_or_duplicate_contract_fails_without_policy_update(self):
  with self.store() as db:
   db.db.execute('DELETE FROM '+db.table('api_endpoints')+" WHERE route_path='/v1/voice/token'")
   with self.assertRaises(m.GovernanceReadError):m.revise(db)
   self.assertEqual(json.loads(db.execute('SELECT definition FROM platform_hierarchy_policy').fetchone()[0])['version'],1);db.db.rollback()
 def test_opt_in_pin_and_broader_revision_are_denied(self):
  with patch.dict(os.environ,{'GOVERNANCE_FOUR_DIGIT_VOICE_REVISION':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   db.pin['fourDigitVoiceRevisionWriter']={}
   with self.assertRaises(m.GovernanceReadError):m.revise(db)
  with patch.object(m,'expected_scope',return_value={}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  original=m.FILE.read_text();doc=json.loads(original);doc['policy']['activationApproved']=True
  from tempfile import TemporaryDirectory
  with TemporaryDirectory() as root:
   path=Path(root)/'revision.json';path.write_text(json.dumps(doc))
   with patch.object(m,'FILE',path):
    with self.assertRaises(m.GovernanceReadError):m.documents()
if __name__=='__main__':unittest.main()
