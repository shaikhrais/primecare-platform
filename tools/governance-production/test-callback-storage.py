"""Native isolated storage registration tests; no production credentials."""
import concurrent.futures,importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import callback_storage as m
spec=importlib.util.spec_from_file_location('callback_metadata_fixture',Path(__file__).with_name('test-communication-storage.py'));fixture=importlib.util.module_from_spec(spec);spec.loader.exec_module(fixture)
URL=fixture.URL
class CallbackStorageTests(unittest.TestCase):
 evidence=fixture.StorageTests.evidence
 table=fixture.StorageTests.table
 open_store=fixture.StorageTests.open_store
 cleanup_target=fixture.StorageTests.cleanup_target
 def setUp(self):
  fixture.StorageTests.setUp(self)
  scope=patch.dict(os.environ,{'GOVERNANCE_CALLBACK_STORAGE_WRITES':'1'});scope.start();self.addCleanup(scope.stop)
 def store(self):return m.CallbackStorageStore(_test_connection=psycopg.connect(URL))
 def test_idempotence_exact_columns_and_independent_readback_preserve_grants(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+n).fetchall() for n in ['api_permissions','role_screen_permissions','screen_api_links']]
   first=m.register(db);self.assertEqual(first,m.register(db));self.assertEqual(first,m.register(m.ReadOnlyCallbackStorageView(db),False));self.assertEqual(first['columns'],9);self.assertEqual(list(first['tableIds']),['communication_callback_requests']);self.assertFalse(first['activation'])
   self.assertEqual(before,[db.execute('SELECT * FROM '+n).fetchall() for n in ['api_permissions','role_screen_permissions','screen_api_links']])
 def test_partial_failure_rolls_back_all_metadata(self):
  class Failure(m.CallbackStorageStore):
   def ensure_exact(self,table,key,values,apply):
    if table=='database_rebuild_baselines':raise RuntimeError('Injected baseline failure')
    return super().ensure_exact(table,key,values,apply)
  with self.assertRaises(RuntimeError):
   with Failure(_test_connection=psycopg.connect(URL)) as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM db_schema_tables').fetchone()[0],0)
 def test_concurrent_registration_creates_one_definition(self):
  def run():
   with self.store() as db:return m.register(db)
  with concurrent.futures.ThreadPoolExecutor(max_workers=2) as threads:a,b=list(threads.map(lambda _:run(),range(2)))
  self.assertEqual(a,b)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM db_schema_columns').fetchone()[0],9)
 def test_edited_metadata_is_preserved(self):
  with self.store() as db:m.register(db)
  with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('db_schema_columns')+" SET data_type='human_edit' WHERE column_name='reason'")
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
 def test_scope_and_opt_in_are_mandatory(self):
  with patch.dict(os.environ,{'GOVERNANCE_CALLBACK_STORAGE_WRITES':'0'}),self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   for table,key in [('api_permissions',{}),('db_schema_tables',{'table_name':'users'})]:
    with self.assertRaises(m.GovernanceReadError):db.ensure_exact(table,key,{},True)
if __name__=='__main__':unittest.main()
