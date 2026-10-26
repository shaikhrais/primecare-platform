import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
import external_call_registration as c
import external_call_access_registration as a
spec=importlib.util.spec_from_file_location('contact_fixture',Path(__file__).with_name('test-voice-contact-access-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class ExternalTests(unittest.TestCase):
 evidence=f.AccessTests.evidence;table=f.AccessTests.table;open_store=f.AccessTests.open_store
 def setUp(self):
  f.AccessTests.setUp(self);env=patch.dict(os.environ,{'GOVERNANCE_EXTERNAL_CALLS':'1','GOVERNANCE_EXTERNAL_CALL_ACCESS':'1'});env.start();self.addCleanup(env.stop)
  with psycopg.connect(f.URL,autocommit=True) as db:
   db.execute('ALTER TABLE '+self.table('roles')+' ADD COLUMN role_code text');db.execute('UPDATE '+self.table('roles')+" SET role_code=CASE WHEN id=51 THEN 'psw' ELSE 'patient' END")
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0];next(t for t in manifest['tables'] if t['name']=='roles')['columns'].append(dict(name='role_code',declared_type='TEXT',storage_types=['text']));db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
  with c.InternalCallPreparationStore(_test_connection=psycopg.connect(f.URL)) as db:
   result=c.register(db);self.assertEqual(result,c.register(c.ReadView(db)));self.assertEqual(result['registered'],5)
 def test_exact_staff_grants_and_provider_routes_unganked(self):
  with a.InternalCallPreparationAccessStore(_test_connection=psycopg.connect(f.URL)) as db:
   result=a.register(db);self.assertEqual(result,a.register(a.ReadView(db),False));self.assertEqual(result['eligibleRoles'],1);self.assertEqual(result['apiGrants'],3);self.assertEqual(result['screenLinks'],12)
   ids=c.register(c.ReadView(db))['apiIds'];self.assertEqual(db.execute('SELECT count(*) FROM api_permissions WHERE api_id=?',(ids['external.connect'],)).fetchone()[0],0)
 def test_patient_cannot_receive_staff_grant(self):
  with psycopg.connect(f.URL,autocommit=True) as db:db.execute('UPDATE '+self.table('roles')+" SET role_code='patient' WHERE id=51")
  with a.InternalCallPreparationAccessStore(_test_connection=psycopg.connect(f.URL)) as db:self.assertEqual(a.register(db)['eligibleRoles'],0)
 def test_explicit_staff_deny_preserved(self):
  with a.InternalCallPreparationAccessStore(_test_connection=psycopg.connect(f.URL)) as db:
   a.register(db);aid=a.definition(db)['apiIds']['external.prepare'];db.db.execute('UPDATE '+db.table('api_permissions')+' SET can_access=0 WHERE role_id=51 AND api_id=%s',(aid,));self.assertEqual(a.register(db)['explicitDenialsPreserved'],1)
if __name__=='__main__':unittest.main(verbosity=2)
