"""Disposable native registration tests; no production accounts or grants."""
import json,os,runpy,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from auth_session_tenant_contracts import TenantContractStore,register,definition,target,validate,GovernanceReadError
F=runpy.run_path(str(Path(__file__).with_name('test-communications-registration.py')))
URL=F['URL']
class TenantContracts(unittest.TestCase):
 evidence=F['RegistrationTests'].evidence
 table=F['RegistrationTests'].table
 open_store=F['RegistrationTests'].open_store
 def setUp(self):
  F['RegistrationTests'].setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_AUTH_SESSION_TENANT_WRITES':'1'});env.start();self.addCleanup(env.stop)
  with self.store() as db:
   for ordinal,entry in enumerate(definition()['contracts'],100):
    row=entry['reviewed'];fields=list(row)
    db.db.execute('INSERT INTO '+self.table('api_endpoints')+'(_primecare_import_row,'+','.join(fields)+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('api_endpoints',key,row[key]) for key in fields]])
 def store(self,kind=TenantContractStore):return kind(_test_connection=psycopg.connect(URL))
 def test_exact_extension_idempotence_and_grant_preservation(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']]
   unrelated=db.execute('SELECT * FROM api_endpoints WHERE id=710').fetchall()
   self.assertEqual(register(db),register(db))
   for e in definition()['contracts']:validate(db,e,False)
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_permissions','role_screen_permissions','screen_api_links']])
   self.assertEqual(unrelated,db.execute('SELECT * FROM api_endpoints WHERE id=710').fetchall())
 def test_rollback_then_independent_readback(self):
  with self.store() as db:register(db);db.db.rollback()
  with self.store() as db:
   with self.assertRaises(GovernanceReadError):validate(db,definition()['contracts'][0],False)
   register(db)
  with self.store() as db:
   for e in definition()['contracts']:validate(db,e,False)
 def test_edited_schema_is_preserved_and_whole_batch_refused(self):
  with self.store() as db:db.db.execute('UPDATE '+self.table('api_endpoints')+' SET response_schema=%s WHERE id=16496',[db._value('api_endpoints','response_schema','{"human":"edit"}')])
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
  with self.store() as db:
   with self.assertRaises(GovernanceReadError):validate(db,definition()['contracts'][0],False)
   self.assertEqual(db.execute('SELECT response_schema FROM api_endpoints WHERE id=16496').fetchone()[0],'{"human":"edit"}')
 def test_route_drift_cannot_update_response(self):
  with self.store() as db:db.db.execute('UPDATE '+self.table('api_endpoints')+" SET route_path='/changed' WHERE id=2")
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
 def test_mid_batch_failure_rolls_back(self):
  class Fail(TenantContractStore):
   count=0
   def write_response(self,*args):
    super().write_response(*args);self.count+=1
    if self.count==3:raise RuntimeError('Synthetic failure')
  with self.assertRaises(RuntimeError):
   with self.store(Fail) as db:register(db)
  with self.store() as db:
   with self.assertRaises(GovernanceReadError):validate(db,definition()['contracts'][0],False)
 def test_only_optional_tenant_property_is_permitted(self):
  for e in definition()['contracts']:
   changed=json.loads(json.dumps(e));branch=changed['response'].get('oneOf',[changed['response']])[0];branch['required'].append('tenantId')
   with self.assertRaises(GovernanceReadError):target(changed)
if __name__=='__main__':unittest.main()
