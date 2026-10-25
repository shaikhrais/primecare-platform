"""Disposable native metadata tests; no production credentials or live DDL."""
import concurrent.futures,importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import messaging_storage as m
from communication_storage import CommunicationStorageStore,register as register_old
spec=importlib.util.spec_from_file_location('storage_fixture',Path(__file__).with_name('test-communication-storage.py'))
fixture=importlib.util.module_from_spec(spec);spec.loader.exec_module(fixture)
URL=fixture.URL
class MessagingStorageTests(unittest.TestCase):
 evidence=fixture.StorageTests.evidence
 table=fixture.StorageTests.table
 open_store=fixture.StorageTests.open_store
 cleanup_target=fixture.StorageTests.cleanup_target
 def setUp(self):
  fixture.StorageTests.setUp(self)
  scope=patch.dict(os.environ,{'GOVERNANCE_MESSAGING_STORAGE_WRITES':'1'});scope.start();self.addCleanup(scope.stop)
 def store(self):return m.MessagingStorageStore(_test_connection=psycopg.connect(URL))
 def test_exact_idempotence_and_read_only_recheck_preserve_grants(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+name).fetchall() for name in ['api_permissions','role_screen_permissions','screen_api_links']]
   first=m.register(db);self.assertEqual(first,m.register(db));self.assertEqual(first,m.register(m.ReadOnlyStorageView(db),False));self.assertEqual(len(first['tableIds']),13);self.assertEqual(first['columns'],78)
   self.assertEqual(before,[db.execute('SELECT * FROM '+name).fetchall() for name in ['api_permissions','role_screen_permissions','screen_api_links']]);self.assertFalse(first['activation'])
 def test_existing_shared_storage_registration_is_reused_without_edits(self):
  with CommunicationStorageStore(_test_connection=psycopg.connect(URL)) as db:old=register_old(db)
  with self.store() as db:
   current=m.register(db)
   for name,identity in old['tableIds'].items():self.assertEqual(current['tableIds'][name],identity)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM database_rebuild_baselines').fetchone()[0],2)
 def test_failure_rolls_back_every_new_metadata_row(self):
  class Failure(m.MessagingStorageStore):
   def ensure_exact(self,table,key,values,apply):
    if table=='database_rebuild_baselines':raise RuntimeError('Injected metadata failure')
    return super().ensure_exact(table,key,values,apply)
  with self.assertRaises(RuntimeError):
   with Failure(_test_connection=psycopg.connect(URL)) as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM db_schema_tables').fetchone()[0],0)
 def test_concurrent_connections_produce_one_registration(self):
  def run():
   with self.store() as db:return m.register(db)
  with concurrent.futures.ThreadPoolExecutor(max_workers=2) as threads:left,right=list(threads.map(lambda _:run(),range(2)))
  self.assertEqual(left,right)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM db_schema_tables').fetchone()[0],13)
 def test_edited_metadata_is_preserved(self):
  with self.store() as db:m.register(db)
  with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('db_schema_columns')+" SET data_type='human_edit' WHERE column_name='state'")
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute("SELECT COUNT(*) FROM db_schema_columns WHERE data_type='human_edit'").fetchone()[0],3)
 def test_opt_in_scope_and_unrelated_writes_are_denied(self):
  with patch.dict(os.environ,{'GOVERNANCE_MESSAGING_STORAGE_WRITES':'0'}),self.assertRaises(m.GovernanceReadError):self.store()
  with patch.object(m.MessagingStorageStore,'scope_reader',staticmethod(lambda:{})),self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   for table,key,values in [('api_permissions',{},{}),('db_schema_tables',{'table_name':'users'},{})]:
    with self.assertRaises(m.GovernanceReadError):db.ensure_exact(table,key,values,True)
if __name__=='__main__':unittest.main()
