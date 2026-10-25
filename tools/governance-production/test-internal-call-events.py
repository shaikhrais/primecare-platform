import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import internal_call_events_registration as e
import internal_call_events_access_registration as a
import internal_call_access_registration as calls
spec=importlib.util.spec_from_file_location('event_access_fixture',Path(__file__).with_name('test-internal-call-access.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class EventTests(f.AccessTests):
 def setUp(self):
  super().setUp();env=patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_EVENTS':'1','GOVERNANCE_INTERNAL_CALL_EVENTS_ACCESS':'1'});env.start();self.addCleanup(env.stop)
  with calls.InternalCallAccessStore(_test_connection=psycopg.connect(f.f.URL)) as db:calls.register(db)
  with e.InternalCallEventsStore(_test_connection=psycopg.connect(f.f.URL)) as db:
   first=e.register(db);self.assertEqual(first,e.register(db));self.assertEqual(first,e.register(e.ReadView(db)));self.assertEqual(first['registered'],1);self.assertEqual(first['roleGrants'],0)
 def store_events(self):return a.InternalCallEventsAccessStore(_test_connection=psycopg.connect(f.f.URL))
 def test_event_access_inherits_existing_command_and_screen_eligibility(self):
  with self.store_events() as db:
   before=db.execute('SELECT * FROM role_screen_permissions').fetchall();result=a.register(db);self.assertEqual(result,a.register(db));self.assertEqual(result,a.register(a.ReadView(db),False));self.assertEqual(result['eligibleRoles'],1);self.assertEqual(result['screenLinks'],4);self.assertEqual(result['apiGrants'],1);self.assertEqual(before,db.execute('SELECT * FROM role_screen_permissions').fetchall())
 def test_existing_command_deny_cannot_create_new_events_grant(self):
  with self.store_events() as db:
   command=calls.definition(db)['apiIds']['call.command'];event=a.definition(db)['apiIds']['call.events'];roles=a.validate(db);self.assertEqual(len(roles),1)
   db.execute('UPDATE api_permissions SET can_access=0 WHERE role_id=? AND api_id=?',(roles[0],command));self.assertEqual(a.register(db)['eligibleRoles'],0);self.assertEqual(db.execute('SELECT count(*) FROM api_permissions WHERE api_id=?',(event,)).fetchone()[0],0)
 def test_existing_event_deny_is_preserved(self):
  with self.store_events() as db:
   a.register(db);event=a.definition(db)['apiIds']['call.events'];role=a.validate(db)[0];db.execute('UPDATE api_permissions SET can_access=0 WHERE role_id=? AND api_id=?',(role,event));self.assertEqual(a.register(db)['explicitDenialsPreserved'],1);self.assertEqual(db.execute('SELECT can_access FROM api_permissions WHERE role_id=? AND api_id=?',(role,event)).fetchone()[0],0)
if __name__=='__main__':unittest.main(verbosity=2)
