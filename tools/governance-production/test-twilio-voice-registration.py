"""Native disposable registration checks; no Twilio account or live calls."""
import json,os,runpy,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from twilio_voice_registration import register,definition,retry_transaction,GovernanceReadError
F=runpy.run_path(str(Path(__file__).with_name('test-communication-access-registration.py')))
A=F['AccessRegistrationTests'];URL=F['URL']
class TwilioRequirementTests(unittest.TestCase):
 evidence=A.evidence
 table=A.table
 open_store=A.open_store
 store=A.store
 def setUp(self):
  A.setUp(self);p=patch.dict(os.environ,{'GOVERNANCE_TWILIO_REQUIREMENT_REGISTRATION':'1'});p.start();self.addCleanup(p.stop)
 def test_idempotence_preserves_grants_and_does_not_provision(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']]
   first=register(db);self.assertEqual(first,register(db));self.assertFalse(first['providerWrites']);self.assertEqual(first['numbersPurchased'],0);self.assertEqual(first['extensionsAssigned'],0)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],1);self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']])
 def test_dry_run_rollback_preserves_no_row(self):
  with self.store() as db:register(db);db.db.rollback()
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],0)
 def test_changed_existing_requirement_is_preserved(self):
  with self.store() as db:register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('platform_hierarchy_policy')+" SET definition='{}' WHERE id=%s",(definition()['id'],))
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
 def test_duplicate_requirement_and_wrong_scope_fail_closed(self):
  with self.store() as db:register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('INSERT INTO '+self.table('platform_hierarchy_policy')+' SELECT 99,id,definition,requirement FROM '+self.table('platform_hierarchy_policy'))
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
  with self.store() as db:
   db.pin={**db.pin,'twilioVoiceRequirementWriter':{}}
   with self.assertRaises(GovernanceReadError):register(db)
 def test_opt_in_required(self):
  with patch.dict(os.environ,{'GOVERNANCE_TWILIO_REQUIREMENT_REGISTRATION':'0'}):
   with self.assertRaises(GovernanceReadError):
    with self.store() as db:register(db)
 def test_lock_retry_uses_a_fresh_transaction_after_rollback(self):
  admin=psycopg.connect(URL);self.addCleanup(admin.close)
  admin.execute('LOCK TABLE '+self.table('platform_hierarchy_policy')+' IN SHARE ROW EXCLUSIVE MODE')
  attempts=[]
  def action():
   with self.store() as db:
    attempts.append(db);db.db.execute("SET LOCAL lock_timeout='10ms'");return register(db)
  with patch('twilio_voice_registration.time.sleep',side_effect=lambda delay:admin.rollback()) as pause:
   self.assertTrue(retry_transaction(action)['registered']);pause.assert_called_once_with(2)
  self.assertEqual(len(attempts),2);self.assertIsNot(attempts[0],attempts[1])
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],1)
 def test_non_concurrency_errors_are_not_retried(self):
  with patch('twilio_voice_registration.time.sleep') as pause:
   with self.assertRaises(GovernanceReadError):retry_transaction(lambda:(_ for _ in ()).throw(GovernanceReadError('scope denied')))
   pause.assert_not_called()
if __name__=='__main__':unittest.main()
