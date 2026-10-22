"""Disposable native registration/DDL tests. No production credentials allowed."""
import json,os,runpy,unittest,uuid
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
from communication_storage import CommunicationStorageStore,register,migrate,signature,definition,GovernanceReadError,quote
FIXTURE=runpy.run_path(str(Path(__file__).with_name('test-communications-registration.py')))
URL=FIXTURE['URL']
class StorageTests(unittest.TestCase):
 evidence=FIXTURE['RegistrationTests'].evidence
 table=FIXTURE['RegistrationTests'].table
 open_store=FIXTURE['RegistrationTests'].open_store
 def setUp(self):
  FIXTURE['RegistrationTests'].setUp(self)
  self.scope=patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_STORAGE_WRITES':'1','GOVERNANCE_COMMUNICATION_STORAGE_MIGRATION':'1'})
  self.scope.start();self.addCleanup(self.scope.stop)
  with FIXTURE['RegistrationTests'].store(self) as db:FIXTURE['register'](db)
  self.target='communication_fixture_'+uuid.uuid4().hex
  with psycopg.connect(URL,autocommit=True) as admin:
   admin.execute('CREATE SCHEMA '+quote(self.target))
   manifest=admin.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   specs={
    'db_schema_tables':'id:i app_id:i table_name:s table_type:s status:s',
    'db_schema_columns':'id:i table_id:i column_name:s data_type:s is_nullable:i is_primary:i is_foreign:i default_value:j foreign_table_name:j foreign_column_name:j',
    'database_rebuild_baselines':'name:s app_id:i baseline_sql:s migration_sources:s schema_metadata:s validation_evidence:s sha256:s'}
   for name,spec in specs.items():
    cols=[];physical=[]
    for field in spec.split():
     key,kind=field.split(':');cols.append(dict(name=key,declared_type='INTEGER' if kind=='i' else 'TEXT',storage_types=[] if kind=='j' else ['integer'] if kind=='i' else ['text']))
     physical.append(quote(key)+' '+{'i':'bigint','s':'text','j':'jsonb'}[kind])
    manifest['tables'].append(dict(name=name,columns=cols));admin.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
   admin.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
  self.addCleanup(self.cleanup_target)
 def cleanup_target(self):
  with psycopg.connect(URL,autocommit=True) as db:db.execute('DROP SCHEMA '+quote(self.target)+' CASCADE')
 def store(self):return CommunicationStorageStore(_test_connection=psycopg.connect(URL))
 def registered(self):
  with self.store() as db:return register(db)
 def test_registration_idempotence_and_grants_preserved(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']]
   first=register(db);self.assertEqual(first,register(db));self.assertEqual(first['columns'],16)
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']])
   self.assertEqual(db.execute('SELECT COUNT(*) FROM database_rebuild_baselines').fetchone()[0],1)
 def test_partial_metadata_failure_rolls_back_every_record(self):
  class Failure(CommunicationStorageStore):
   def ensure_exact(self,table,key,values,apply):
    if table=='database_rebuild_baselines':raise RuntimeError('Synthetic baseline failure')
    return super().ensure_exact(table,key,values,apply)
  with self.assertRaises(RuntimeError):
   with Failure(_test_connection=psycopg.connect(URL)) as db:register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM db_schema_tables').fetchone()[0],0)
 def test_migration_requires_committed_registered_design(self):
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:migrate(db,self.target)
  with self.store() as db:self.assertIsNone(db.db.execute('SELECT to_regclass(%s)',(self.target+'.business_work_aggregates',)).fetchone()[0])
 def test_native_migration_is_idempotent_without_permission_changes(self):
  self.registered()
  with self.store() as db:
   first=migrate(db,self.target);self.assertEqual(first,migrate(db,self.target));self.assertTrue(first['nativeSchemaVerified'])
   self.assertEqual(first['roleGrants'],0);self.assertFalse(first['activation'])
   self.assertEqual(len(signature(db,self.target,'business_work_events')[1]),7)
 def test_wrong_existing_table_rolls_back_other_new_tables(self):
  self.registered()
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('CREATE TABLE '+quote(self.target)+'.business_work_commands (wrong text)')
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:migrate(db,self.target)
  with self.store() as db:
   self.assertIsNone(db.db.execute('SELECT to_regclass(%s)',(self.target+'.business_work_aggregates',)).fetchone()[0])
   self.assertIsNotNone(db.db.execute('SELECT to_regclass(%s)',(self.target+'.business_work_commands',)).fetchone()[0])
 def test_checks_and_foreign_keys_reject_cross_scope_and_orphan_receipts(self):
  self.registered()
  with self.store() as db:
   migrate(db,self.target)
   target=quote(self.target)
   valid=dict(id='thread',tenantId='tenant-a',kind='conversation',version=1)
   for changes in [{'tenantId':'tenant-b'},{'tenantId':None},{'kind':None},{'version':0},{'version':9007199254740992}]:
    with self.assertRaises(psycopg.Error):
     with db.db.transaction():db.db.execute('INSERT INTO '+target+'.business_work_aggregates VALUES(%s,%s,%s)',('tenant-a','thread',Jsonb({**valid,**changes})))
   db.db.execute('INSERT INTO '+target+'.business_work_aggregates VALUES(%s,%s,%s)',('tenant-a','thread',Jsonb(valid)))
   with self.assertRaises(psycopg.errors.ForeignKeyViolation):
    with db.db.transaction():db.db.execute('INSERT INTO '+target+'.business_work_commands VALUES(%s,%s,%s,%s,%s,%s)',('tenant-b','thread','key','actor','a'*64,Jsonb({'id':'thread'})))
 def test_edited_registration_or_missing_opt_in_blocks_native_ddl(self):
  self.registered()
  with patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_STORAGE_MIGRATION':'0'}):
   with self.assertRaises(GovernanceReadError):
    with self.store() as db:migrate(db,self.target)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('DELETE FROM '+self.table('db_schema_columns')+" WHERE column_name='state'")
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:migrate(db,self.target)
 def test_unrelated_metadata_and_targets_are_refused(self):
  with self.store() as db:
   with self.assertRaises(GovernanceReadError):db.ensure_exact('api_permissions',{}, {},True)
   with self.assertRaises(GovernanceReadError):db.ensure_exact('db_schema_tables',{'table_name':'users'},{},True)
   with self.assertRaises(GovernanceReadError):migrate(db,'another_schema')
if __name__=='__main__':unittest.main()
