"""Disposable PostgreSQL access registration; no production/provider operations."""
import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import callback_approval_access as m
import twilio_contracts_registration as contracts
spec=importlib.util.spec_from_file_location('callback_access_fixture',Path(__file__).with_name('test-voice-contact-access-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class AccessTests(unittest.TestCase):
 evidence=f.AccessTests.evidence;table=f.AccessTests.table;open_store=f.AccessTests.open_store
 def setUp(self):
  f.AccessTests.setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_CALLBACK_APPROVAL_ACCESS':'1','GOVERNANCE_TWILIO_CONTRACT_REGISTRATION':'1'});env.start();self.addCleanup(env.stop)
  with contracts.TwilioContractRegistrationStore(_test_connection=psycopg.connect(f.URL)) as db:contracts.register(db)
  with f.m.VoiceContactAccessStore(_test_connection=psycopg.connect(f.URL)) as db:f.m.register(db)
 def store(self,kind=m.CallbackApprovalAccessStore):return kind(_test_connection=psycopg.connect(f.URL))
 def test_exact_idempotent_readback_and_unrelated_rights_preserved(self):
  with self.store() as db:
   before={t:db.execute('SELECT * FROM '+t).fetchall() for t in ['roles','role_screen_permissions','api_endpoints']}
   first=m.register(db);self.assertEqual(first,m.register(db));self.assertEqual(first,m.register(m.ReadView(db),False));self.assertEqual(first['eligibleRoles'],1);self.assertEqual(first['apiGrants'],2);self.assertEqual(first['screenLinks'],8);self.assertFalse(first['activation'])
   ids=m.definition(db)['apiIds'];self.assertEqual(len(ids),2)
   for aid in ids.values():self.assertEqual(db.execute('SELECT role_id,can_access FROM api_permissions WHERE api_id=?',(aid,)).fetchall(),[(51,1)])
   for t,rows in before.items():self.assertEqual(rows,db.execute('SELECT * FROM '+t).fetchall())
 def test_existing_denial_is_never_overwritten(self):
  with self.store() as db:
   aid=m.definition(db)['apiIds']['task.approve'];db.db.execute('INSERT INTO '+self.table('api_permissions')+" VALUES(50,50,%s,51,0,'role_screen_permissions')",[aid])
   result=m.register(db);self.assertEqual(result['apiGrants'],1);self.assertEqual(result['explicitDenialsPreserved'],1);self.assertEqual(db.execute('SELECT can_access FROM api_permissions WHERE api_id=?',(aid,)).fetchall(),[(0,)])
 def test_missing_or_denied_contact_permission_excludes_role(self):
  with self.store() as db:
   db.db.execute('DELETE FROM '+self.table('api_permissions')+' WHERE api_id=16536');self.assertEqual(m.register(db)['eligibleRoles'],0)
 def test_inactive_and_screen_denied_roles_cannot_gain_approval(self):
  with self.store() as db:
   aid=m.definition(db)['apiIds']['task.approve']
   for role in [52,53,999]:
    with self.assertRaises(m.GovernanceReadError):db.insert_exact('api_permissions',dict(role_id=role,api_id=aid,permission_key='role_screen_permissions',can_access=1))
 def test_partial_failure_rolls_back_every_callback_change(self):
  class Failure(m.CallbackApprovalAccessStore):
   def insert_exact(self,table,entry):
    super().insert_exact(table,entry)
    if table=='api_permissions':raise RuntimeError('Injected failure')
  with self.assertRaises(RuntimeError):
   with self.store(Failure) as db:m.register(db)
  with self.store() as db:
   ids=m.definition(db)['apiIds'];self.assertEqual(sum(db.execute('SELECT COUNT(*) FROM screen_api_links WHERE api_id=?',(aid,)).fetchone()[0] for aid in ids.values()),0)
 def test_verification_never_creates_missing_rows(self):
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):m.register(m.ReadView(db),False)
 def test_edited_contract_or_link_fails_without_repair(self):
  with self.store() as db:m.register(db);aid=m.definition(db)['apiIds']['task.preview']
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('screen_api_links')+" SET purpose='human edit' WHERE api_id=%s",[aid])
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_endpoints')+" SET endpoint_code='edited' WHERE id=%s",[aid])
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
 def test_opt_in_and_unrelated_writes_refused(self):
  with patch.dict(os.environ,{'GOVERNANCE_CALLBACK_APPROVAL_ACCESS':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):db.insert_exact('roles',{})
 def test_eligibility_sources_locked_against_concurrent_changes(self):
  with self.store() as db:
   for table in ['api_endpoints','screens','roles','role_screen_permissions','api_permissions']:
    with psycopg.connect(f.URL) as concurrent:
     concurrent.execute("SET LOCAL lock_timeout='100ms'")
     with self.assertRaises(psycopg.errors.LockNotAvailable):concurrent.execute('LOCK TABLE '+self.table(table)+' IN ROW EXCLUSIVE MODE')
     concurrent.rollback()
if __name__=='__main__':unittest.main(verbosity=2)
