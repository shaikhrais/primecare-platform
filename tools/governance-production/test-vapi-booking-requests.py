"""Native metadata fixtures only; never patient data or production credentials."""
import importlib.util,json,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
import vapi_booking_requests as m
spec=importlib.util.spec_from_file_location('client_reads_fixture',Path(__file__).with_name('test-voice-contact-contracts-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class ReadTests(unittest.TestCase):
 evidence=f.RegistrationTests.evidence;table=f.RegistrationTests.table;open_store=f.RegistrationTests.open_store
 def setUp(self):
  f.RegistrationTests.setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_VAPI_BOOKING_REQUESTS':'1'});env.start();self.addCleanup(env.stop)
  with psycopg.connect(f.URL,autocommit=True) as db:
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   for table,column,kind in [('screens','app_id','integer'),('api_endpoints','rate_limit_key','text')]:
    db.execute('ALTER TABLE '+self.table(table)+' ADD COLUMN '+column+(' bigint' if kind=='integer' else ' text'))
    next(t for t in manifest['tables'] if t['name']==table)['columns'].append(dict(name=column,declared_type='INTEGER' if kind=='integer' else 'TEXT',storage_types=[kind]))
   db.execute('INSERT INTO '+self.table('screens')+"(_primecare_import_row,id,screen_code,active,app_id) VALUES(100,900,'client_profile',1,2)")
   db.execute('INSERT INTO '+self.table('api_endpoints')+"(_primecare_import_row,id,app_id,route_path,http_method,endpoint_code,service_name,auth_required,implementation_status,permission_key,api_version,health_status,uses_pagination) VALUES(100,16431,2,'/v1/client/home/profile','GET','CLIENT_SELF_PROFILE','client',1,'implemented',%s,'v1','unknown',0)",[Jsonb({'t':'text','v':'authenticated_client_profile_owner'})])
   db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',[Jsonb(manifest)])
 def store(self,kind=m.ClientBookingRequestStore):return kind(_test_connection=psycopg.connect(f.URL))
 def test_exact_idempotent_contracts_links_and_independent_read_only_validation(self):
  with self.store() as db:
   grants=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']]
   a=m.register(db);self.assertEqual(a,m.register(db));self.assertEqual(a,m.register(db,False));self.assertEqual(a['registered'],3);self.assertEqual(a['screenLinks'],3);self.assertEqual(a['roleGrants'],0);self.assertFalse(a['authenticationChanges'])
   self.assertEqual(grants,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions']])
 def test_read_only_validation_never_fills_missing_metadata(self):
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):m.register(db,False)
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],0)
 def test_partial_failure_rolls_back_all_three_contracts(self):
  class Failure(m.ClientBookingRequestStore):
   def insert_exact(self,table,entry):
    result=super().insert_exact(table,entry)
    if table=='api_endpoints' and entry['route_path'].endswith('/{requestId}'):raise RuntimeError('Injected failure')
    return result
  with self.assertRaises(RuntimeError):
   with self.store(Failure) as db:m.register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],3)
 def test_edited_existing_contract_and_link_are_never_repaired(self):
  with self.store() as db:r=m.register(db)
  aid=next(iter(r['apiIds'].values()))
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('screen_api_links')+" SET purpose='human edit' WHERE api_id=%s",[aid])
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='edited' WHERE id=%s",[aid])
  with self.assertRaises(m.GovernanceReadError):
   with self.store() as db:m.register(db)
 def test_scope_opt_in_and_unknown_tables_are_refused(self):
  with patch.dict(os.environ,{'GOVERNANCE_VAPI_BOOKING_REQUESTS':'0'}):
   with self.assertRaises(m.GovernanceReadError):self.store()
  with self.store() as db:
   with self.assertRaises(m.GovernanceReadError):db.insert_exact('api_permissions',{})
 def test_concurrent_source_metadata_changes_are_locked(self):
  with self.store() as db:
   for table in ['api_endpoints','screens','screen_api_links']:
    with psycopg.connect(f.URL) as concurrent:
     concurrent.execute("SET LOCAL lock_timeout='100ms'")
     with self.assertRaises(psycopg.errors.LockNotAvailable):concurrent.execute('LOCK TABLE '+self.table(table)+' IN ROW EXCLUSIVE MODE')
     concurrent.rollback()
if __name__=='__main__':unittest.main(verbosity=2)
