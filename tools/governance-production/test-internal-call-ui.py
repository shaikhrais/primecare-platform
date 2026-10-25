import importlib.util,os,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
import internal_call_contracts_registration as c
import internal_call_ui_registration as u
import communication_ui_registration as base
spec=importlib.util.spec_from_file_location('call_ui_fixture',Path(__file__).with_name('test-communication-ui-registration.py'));f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)
class CallUiTests(f.UiTests):
 def setUp(self):
  super().setUp();env=patch.dict(os.environ,{'GOVERNANCE_INTERNAL_CALL_CONTRACTS':'1','GOVERNANCE_INTERNAL_CALL_UI':'1'});env.start();self.addCleanup(env.stop)
  with c.InternalCallContractStore(_test_connection=psycopg.connect(f.URL)) as db:ids=c.register(db)['apiIds']
  with psycopg.connect(f.URL,autocommit=True) as db:
   for aid in ids.values():
    for sid in map(int,u.definition()['screens']):
     high=db.execute('SELECT COALESCE(MAX(id),0),COALESCE(MAX(_primecare_import_row),-1) FROM '+self.table('screen_api_links')).fetchone();db.execute('INSERT INTO '+self.table('screen_api_links')+' VALUES(%s,%s,%s,%s,%s)',[high[1]+1,high[0]+1,sid,aid,'fixture call link'])
 def test_call_ui_uses_inherited_writer_and_exact_readback(self):
  with u.InternalCallUiStore(_test_connection=psycopg.connect(f.URL)) as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['roles'] if t in db.tables]
   result=base.register(db);self.assertEqual(result,base.register(db));self.assertTrue(base.readback(u.ReadView(db)));self.assertEqual(result['controlsPerScreen'],len(u.definition()['controls']));self.assertFalse(result['activation']);self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['roles'] if t in db.tables])
if __name__=='__main__':unittest.main(verbosity=2)
