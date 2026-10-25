"""Disposable PostgreSQL: narrow grants, shared controls and preservation."""
import importlib.util,json,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
import voice_contact_platform_registration as m
spec=importlib.util.spec_from_file_location('ui_fixture',Path(__file__).with_name('test-communication-ui-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
URL=f.URL
@unittest.skipUnless(URL,'Native isolated PostgreSQL required')
class PlatformTests(unittest.TestCase):
 evidence=f.UiTests.evidence
 table=f.UiTests.table
 open_store=f.UiTests.open_store
 def setUp(self):
  f.UiTests.setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_VOICE_CONTACT_PLATFORM':'1','GOVERNANCE_VOICE_CONTACT_REGISTRATION':'1'});env.start();self.addCleanup(env.stop)
  with f.UiTests.store(self) as db:f.register(db)
  with m.contracts.VoiceContactContractRegistrationStore(_test_connection=psycopg.connect(URL)) as db:ids=m.contracts.register(db)['apiIds']
  with psycopg.connect(URL,autocommit=True) as db:
   for key,aid in ids.items():db.execute('UPDATE '+self.table('api_endpoints')+' SET id=%s WHERE id=%s',({'contact.status':16535,'contact.start':16536,'contact.check':16537}[key],aid))
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   db.execute('CREATE TABLE '+self.table('roles')+' (_primecare_import_row bigint PRIMARY KEY,id bigint,role_code text,active bigint)')
   manifest['tables'].append(dict(name='roles',columns=[dict(name=k,declared_type=t,storage_types=[s]) for k,t,s in [('id','INTEGER','integer'),('role_code','TEXT','text'),('active','INTEGER','integer')]]))
   db.execute('INSERT INTO '+self.table('roles')+" VALUES(0,51,'psw',1),(1,64,'code_admin',1)")
   db.execute('INSERT INTO '+self.table('screens')+" VALUES(10,1269,'PLATFORM_ADMINISTRATION',1)")
   db.execute('INSERT INTO '+self.table('role_screen_permissions')+' VALUES(1,2,64,1269,1,0,0)')
   db.execute('ALTER TABLE '+self.table('api_permissions')+' ADD COLUMN permission_key text')
   next(t for t in manifest['tables'] if t['name']=='api_permissions')['columns'].append(dict(name='permission_key',declared_type='TEXT',storage_types=['text']))
   db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
 def store(self,kind=m.PlatformContactStore):return kind(_test_connection=psycopg.connect(URL))
 def test_exact_idempotent_metadata_and_unrelated_preservation(self):
  with self.store() as db:
   unchanged={t:db.execute('SELECT * FROM '+t).fetchall() for t in ['roles','role_screen_permissions','api_endpoints','language_resources','language_resource_values']}
   first=m.reconcile(db);self.assertEqual(first,m.reconcile(db));self.assertEqual(first,m.reconcile(db,False));self.assertEqual(first['apiGrants'],3)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components WHERE screen_id=1269').fetchone()[0],7)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links WHERE screen_id=1269').fetchone()[0],3)
   self.assertEqual(db.execute('SELECT role_id FROM api_permissions WHERE api_id=16535').fetchall(),[(64,)])
   for t,rows in unchanged.items():self.assertEqual(rows,db.execute('SELECT * FROM '+t).fetchall())
 def test_explicit_denial_never_overwritten(self):
  with psycopg.connect(URL,autocommit=True) as db:db.execute('INSERT INTO '+self.table('api_permissions')+" VALUES(1,2,16536,64,0,'role_screen_permissions')")
  with self.store() as db:
   result=m.reconcile(db);self.assertEqual(result['apiGrants'],2);self.assertEqual(result['explicitDenialsPreserved'],1)
 def test_missing_screen_grant_or_inactive_role_cannot_register(self):
  for sql in ["UPDATE role_screen_permissions SET can_view=0 WHERE role_id=64","UPDATE roles SET active=0 WHERE id=64"]:
   with psycopg.connect(URL,autocommit=True) as db:
    name=sql.split()[1];db.execute(sql.replace(name,self.table(name),1))
   with self.assertRaises(m.GovernanceReadError):self.store()
   with psycopg.connect(URL,autocommit=True) as db:
    db.execute('UPDATE '+self.table('role_screen_permissions')+' SET can_view=1 WHERE role_id=64');db.execute('UPDATE '+self.table('roles')+' SET active=1 WHERE id=64')
 def test_unrelated_mutations_and_readback_without_rows_refused(self):
  with self.store() as db:
   for table in ['roles','role_screen_permissions','api_permissions']:
    with self.assertRaises(m.GovernanceReadError):db.insert_planned(table,{}, {})
   with self.assertRaises(m.GovernanceReadError):m.reconcile(db,False)
 def test_partial_write_failure_rolls_back(self):
  class Failure(m.PlatformContactStore):
   def insert_planned(self,*args):
    super().insert_planned(*args)
    if args[0]=='screen_components':raise RuntimeError('Injected failure')
  with self.assertRaises(RuntimeError):
   with self.store(Failure) as db:m.reconcile(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links WHERE screen_id=1269').fetchone()[0],0)
 def test_edited_ui_or_translation_is_preserved(self):
  with self.store() as db:m.reconcile(db)
  with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('screen_components')+" SET data_cy='human-edit' WHERE screen_id=1269")
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.reconcile(db)
  with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='human-edit' WHERE resource_id IN (SELECT resource_id FROM "+self.table('language_resources')+" WHERE resource_key='communicationWorkspace.phoneVerification')")
  with self.assertRaises(m.GovernanceReadError):self.store()
 def test_exact_opt_in_and_source_locks(self):
  with patch.dict(os.environ,{'GOVERNANCE_VOICE_CONTACT_PLATFORM':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   for table in ['roles','role_screen_permissions','api_endpoints','screens','language_resource_values']:
    with psycopg.connect(URL) as other:
     other.execute("SET LOCAL lock_timeout='100ms'")
     with self.assertRaises(psycopg.errors.LockNotAvailable):other.execute('LOCK TABLE '+self.table(table)+' IN ROW EXCLUSIVE MODE')
     other.rollback()
if __name__=='__main__':unittest.main()
