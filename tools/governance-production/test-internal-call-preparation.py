import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import internal_call_preparation_registration as e
import internal_call_preparation_access_registration as a
import internal_call_access_registration as calls
import internal_call_contracts_registration as original
spec=importlib.util.spec_from_file_location('event_access_fixture',Path(__file__).with_name('test-internal-call-access.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class PreparationTests(unittest.TestCase):
 evidence=f.AccessTests.evidence;table=f.AccessTests.table;open_store=f.AccessTests.open_store
 def setUp(self):
  f.f.AccessTests.setUp(self);env=patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_CONTRACTS':'1','GOVERNANCE_INTERNAL_CALL_ACCESS':'1','GOVERNANCE_INTERNAL_CALL_PREPARATION':'1','GOVERNANCE_INTERNAL_CALL_PREPARATION_ACCESS':'1'});env.start();self.addCleanup(env.stop)
  with original.InternalCallContractStore(_test_connection=psycopg.connect(f.f.URL)) as db:original.register(db)
  with calls.InternalCallAccessStore(_test_connection=psycopg.connect(f.f.URL)) as db:calls.register(db)
  with e.InternalCallPreparationStore(_test_connection=psycopg.connect(f.f.URL)) as db:
   first=e.register(db);self.assertEqual(first,e.register(db));self.assertEqual(first,e.register(e.ReadView(db)));self.assertEqual(first['registered'],3);self.assertEqual(first['roleGrants'],0)
 def store_events(self):return a.InternalCallPreparationAccessStore(_test_connection=psycopg.connect(f.f.URL))
 def test_event_access_inherits_existing_command_and_screen_eligibility(self):
  with self.store_events() as db:
   before=db.execute('SELECT * FROM role_screen_permissions').fetchall();result=a.register(db);self.assertEqual(result,a.register(db));self.assertEqual(result,a.register(a.ReadView(db),False));self.assertEqual(result['eligibleRoles'],1);self.assertEqual(result['screenLinks'],12);self.assertEqual(result['apiGrants'],3);self.assertEqual(before,db.execute('SELECT * FROM role_screen_permissions').fetchall())
 def test_existing_command_deny_cannot_create_new_events_grant(self):
  with self.store_events() as db:
   command=calls.definition(db)['apiIds']['call.command'];event=a.definition(db)['apiIds']['call.prepare'];roles=a.validate(db);self.assertEqual(len(roles),1)
   db.db.execute('UPDATE '+db.table('api_permissions')+' SET can_access=0 WHERE role_id=%s AND api_id=%s',(roles[0],command));self.assertEqual(a.register(db)['eligibleRoles'],0);self.assertEqual(db.execute('SELECT count(*) FROM api_permissions WHERE api_id=?',(event,)).fetchone()[0],0)
 def test_existing_media_deny_cannot_create_preparation_grant(self):
  with self.store_events() as db:
   media=calls.definition(db)['apiIds']['call.media'];role=a.validate(db)[0];db.db.execute('UPDATE '+db.table('api_permissions')+' SET can_access=0 WHERE role_id=%s AND api_id=%s',(role,media));self.assertEqual(a.register(db)['eligibleRoles'],0)
 def test_existing_event_deny_is_preserved(self):
  with self.store_events() as db:
   a.register(db);event=a.definition(db)['apiIds']['call.prepare'];role=a.validate(db)[0];db.db.execute('UPDATE '+db.table('api_permissions')+' SET can_access=0 WHERE role_id=%s AND api_id=%s',(role,event));self.assertEqual(a.register(db)['explicitDenialsPreserved'],1);self.assertEqual(db.execute('SELECT can_access FROM api_permissions WHERE role_id=? AND api_id=?',(role,event)).fetchone()[0],0)
if __name__=='__main__':unittest.main(verbosity=2)
