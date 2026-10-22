"""Native disposable PostgreSQL policy registration; production credentials forbidden."""
import json,os,runpy,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
from communication_access_registration import register,definition,GovernanceReadError
FIXTURE=runpy.run_path(str(Path(__file__).with_name('test-communications-registration.py')))
URL=FIXTURE['URL']
class AccessRegistrationTests(unittest.TestCase):
 evidence=FIXTURE['RegistrationTests'].evidence
 table=FIXTURE['RegistrationTests'].table
 open_store=FIXTURE['RegistrationTests'].open_store
 def setUp(self):
  FIXTURE['RegistrationTests'].setUp(self)
  scope=patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_ACCESS_REGISTRATION':'1'});scope.start();self.addCleanup(scope.stop)
  with psycopg.connect(URL,autocommit=True) as db:
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   cols=[dict(name=k,declared_type='TEXT',storage_types=['text']) for k in ['id','definition','requirement']]
   manifest['tables'].append(dict(name='platform_hierarchy_policy',columns=cols))
   db.execute('CREATE TABLE '+self.table('platform_hierarchy_policy')+' (_primecare_import_row bigint PRIMARY KEY,id text,definition text,requirement text)')
   db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
 def store(self):return FIXTURE['RegistrationTests'].store(self)
 def test_idempotence_without_grants_or_mailbox_provisioning(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']]
   first=register(db);self.assertEqual(first,register(db));self.assertEqual(first['mailboxesProvisioned'],0)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],2)
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']])
 def test_failure_rolls_back_first_insert(self):
  with psycopg.connect(URL,autocommit=True) as admin:
   admin.execute('INSERT INTO '+self.table('platform_hierarchy_policy')+' VALUES(0,%s,%s,%s)',(definition()['directory']['id'],'{}','edited'))
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],1)
 def test_edited_policy_preserved(self):
  with self.store() as db:register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('platform_hierarchy_policy')+" SET definition='{}' WHERE id=%s",(definition()['policy']['id'],))
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
 def test_duplicate_identity_denies_registration(self):
  with self.store() as db:register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('INSERT INTO '+self.table('platform_hierarchy_policy')+' SELECT 99,id,definition,requirement FROM '+self.table('platform_hierarchy_policy')+' WHERE id=%s',(definition()['policy']['id'],))
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
 def test_opt_in_required(self):
  with patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_ACCESS_REGISTRATION':'0'}):
   with self.assertRaises(GovernanceReadError):
    with self.store() as db:register(db)
 def test_wrong_screen_prevents_all_inserts(self):
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('screens')+" SET active=0 WHERE id=234")
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM platform_hierarchy_policy').fetchone()[0],0)
if __name__=='__main__':unittest.main()
