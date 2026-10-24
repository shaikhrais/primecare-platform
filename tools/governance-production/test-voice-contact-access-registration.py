"""Native metadata tests, no live users, provider requests or production credentials."""
import importlib.util,json,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
import voice_contact_access_registration as m
import voice_contact_contracts_registration as contracts
spec=importlib.util.spec_from_file_location('contact_fixture',Path(__file__).with_name('test-voice-contact-contracts-registration.py'));fixture=importlib.util.module_from_spec(spec);spec.loader.exec_module(fixture)
URL=fixture.URL
class AccessTests(unittest.TestCase):
 evidence=fixture.NativeStoreTests.evidence
 table=fixture.NativeStoreTests.table
 open_store=fixture.NativeStoreTests.open_store
 def setUp(self):
  fixture.RegistrationTests.setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_VOICE_CONTACT_ACCESS':'1'});env.start();self.addCleanup(env.stop)
  with fixture.RegistrationTests.store(self) as db:ids=contracts.register(db)['apiIds']
  with psycopg.connect(URL,autocommit=True) as db:
   for key,aid in ids.items():db.execute('UPDATE '+self.table('api_endpoints')+' SET id=%s WHERE id=%s',(m.definition()['apiIds'][key],aid))
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   db.execute('CREATE TABLE '+self.table('roles')+' (_primecare_import_row bigint PRIMARY KEY,id bigint,active bigint)')
   manifest['tables'].append(dict(name='roles',columns=[dict(name=k,declared_type='INTEGER',storage_types=['integer']) for k in ['id','active']]))
   db.execute('INSERT INTO '+self.table('roles')+' VALUES(0,51,1),(1,52,1),(2,53,0)')
   db.execute('ALTER TABLE '+self.table('api_permissions')+' ADD COLUMN permission_key text')
   next(t for t in manifest['tables'] if t['name']=='api_permissions')['columns'].append(dict(name='permission_key',declared_type='TEXT',storage_types=['text']))
   db.execute('INSERT INTO '+self.table('role_screen_permissions')+' VALUES(1,2,52,234,0,0,0),(2,3,53,234,1,0,0)')
   db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
 def store(self,kind=m.VoiceContactAccessStore):return kind(_test_connection=psycopg.connect(URL))
 def test_exact_links_grants_readback_and_unrelated_preservation(self):
  with self.store() as db:
   before={t:db.execute('SELECT * FROM '+t).fetchall() for t in ['role_screen_permissions','roles','api_endpoints']}
   first=m.register(db);self.assertEqual(first,m.register(db));self.assertEqual(first,m.register(db,False));self.assertEqual(first['eligibleRoles'],1);self.assertEqual(first['apiGrants'],3);self.assertFalse(first['activation'])
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],12)
   self.assertEqual(db.execute('SELECT role_id FROM api_permissions WHERE api_id=16535').fetchall(),[(51,)])
   for t,rows in before.items():self.assertEqual(rows,db.execute('SELECT * FROM '+t).fetchall())
 def test_existing_explicit_denials_remain_denied(self):
  with psycopg.connect(URL,autocommit=True) as db:db.execute('INSERT INTO '+self.table('api_permissions')+" VALUES(1,2,16536,51,0,'role_screen_permissions')")
  with self.store() as db:
   r=m.register(db);self.assertEqual(r['apiGrants'],2);self.assertEqual(r['explicitDenialsPreserved'],1);self.assertEqual(db.execute('SELECT can_access FROM api_permissions WHERE api_id=16536 AND role_id=51').fetchall(),[(0,)])
 def test_role_without_screen_and_inactive_role_cannot_receive_grant(self):
  with self.store() as db:
   for role in [52,53,999]:
    with self.assertRaises(m.GovernanceReadError):db.insert_exact('api_permissions',dict(role_id=role,api_id=16535,permission_key='role_screen_permissions',can_access=1))
 def test_changed_contract_and_duplicate_screen_grants_fail_closed(self):
  with psycopg.connect(URL,autocommit=True) as db:db.execute('INSERT INTO '+self.table('role_screen_permissions')+' VALUES(3,4,51,234,1,0,0)')
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
  with psycopg.connect(URL,autocommit=True) as db:
   db.execute('DELETE FROM '+self.table('role_screen_permissions')+' WHERE id=4');db.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='edited' WHERE id=16535")
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
 def test_partial_failure_rolls_back_links_and_grants(self):
  class Failure(m.VoiceContactAccessStore):
   def insert_exact(self,table,entry):
    super().insert_exact(table,entry)
    if table=='api_permissions':raise RuntimeError('Injected failure')
  with self.assertRaises(RuntimeError):
   with self.store(Failure) as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],0)
 def test_edited_link_and_grant_are_preserved(self):
  with self.store() as db:m.register(db)
  with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_permissions')+" SET permission_key='edited' WHERE api_id=16535")
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
 def test_opt_in_and_unrelated_tables_refused(self):
  with patch.dict(os.environ,{'GOVERNANCE_VOICE_CONTACT_ACCESS':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):db.insert_exact('roles',{})
 def test_verification_never_fills_missing_rows(self):
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):m.register(db,False)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],0)
if __name__=='__main__':unittest.main()
