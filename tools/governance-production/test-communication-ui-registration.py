"""Exact UI metadata, native transactions and independently read text; no production data."""
import json,os,runpy,unittest
from pathlib import Path
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
from communication_ui_registration import CommunicationUiStore,register,readback,definition,GovernanceReadError
FIXTURE=runpy.run_path(str(Path(__file__).with_name('test-communications-registration.py')))
URL=FIXTURE['URL']
class UiTests(unittest.TestCase):
 evidence=FIXTURE['RegistrationTests'].evidence
 table=FIXTURE['RegistrationTests'].table
 open_store=FIXTURE['RegistrationTests'].open_store
 def setUp(self):
  FIXTURE['RegistrationTests'].setUp(self)
  env=patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_UI_REGISTRATION':'1'});env.start();self.addCleanup(env.stop)
  with FIXTURE['RegistrationTests'].store(self) as db:ids=FIXTURE['register'](db)['apiIds']
  expected={'message.command':710,'message.inbox':857,'picture.upload':16508,'picture.open':16509,'audio.command':16510,'email.command':16511,'email.inbox':16512}
  with psycopg.connect(URL,autocommit=True) as db:
   for key,old in ids.items():
    if old==expected[key]:continue
    db.execute('UPDATE '+self.table('api_endpoints')+' SET id=%s WHERE id=%s',(expected[key],old));db.execute('UPDATE '+self.table('screen_api_links')+' SET api_id=%s WHERE api_id=%s',(expected[key],old))
   manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
   specs={
    'screen_components':'id:i screen_id:i component_code:s component_name:s component_type:s data_cy:s file_path:s implementation_status:s',
    'screen_required_elements':'id:i screen_id:i element_key:s element_type:s label:s test_id:s required:i',
    'language_resources':'resource_id:i resource_key:s resource_group:s description:s context:s active:i',
    'language_resource_values':'translation_id:i resource_id:i language_id:i translated_text:s reviewed:i approved:i version:s',
    'languages':'language_id:i language_code:s enabled:i',
    'primecare_ui_component_registry':'id:i component_code:s active:i'}
   for name,spec in specs.items():
    cols=[];physical=[]
    for field in spec.split():
     key,kind=field.split(':');cols.append(dict(name=key,declared_type='INTEGER' if kind=='i' else 'TEXT',storage_types=['integer'] if kind=='i' else ['text']));physical.append('"'+key+'" '+('bigint' if kind=='i' else 'text'))
    manifest['tables'].append(dict(name=name,columns=cols));db.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
   for ordinal,(key,code) in enumerate([(1,'prime_button'),(2,'prime_card'),(3,'prime_text_field')]):db.execute('INSERT INTO '+self.table('primecare_ui_component_registry')+' VALUES(%s,%s,%s,1)',(ordinal,key,code))
   for ordinal,code in enumerate(['en','fr','es']):db.execute('INSERT INTO '+self.table('languages')+' VALUES(%s,%s,%s,1)',(ordinal,ordinal+1,code))
   db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
 def store(self,kind=CommunicationUiStore):return kind(_test_connection=psycopg.connect(URL))
 def test_exact_registration_idempotence_readback_and_grants(self):
  with self.store() as db:
   before=[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_endpoints','api_permissions','role_screen_permissions','screen_api_links']]
   result=register(db);self.assertEqual(result,register(db));self.assertTrue(readback(db));self.assertEqual(result['controlsPerScreen'],len(definition()['controls']));self.assertEqual(result['resources'],len(definition()['locales']['en']))
   self.assertEqual(before,[db.execute('SELECT * FROM '+t).fetchall() for t in ['api_endpoints','api_permissions','role_screen_permissions','screen_api_links']])
   self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components').fetchone()[0],4*len(definition()['controls']))
   self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values').fetchone()[0],3*len(definition()['locales']['en']))
 def test_partial_failure_rolls_back_all_controls(self):
  class Failure(CommunicationUiStore):
   count=0
   def ensure_exact(self,*args,**kwargs):
    self.count+=1
    if self.count==12:raise RuntimeError('Synthetic UI failure')
    return super().ensure_exact(*args,**kwargs)
  with self.assertRaises(RuntimeError):
   with self.store(Failure) as db:register(db)
  with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components').fetchone()[0],0)
 def test_edited_text_preserved_and_readback_fails(self):
  with self.store() as db:register(db)
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='human edit' WHERE translation_id=1")
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
  with self.store() as db:
   with self.assertRaises(GovernanceReadError):readback(db)
 def test_missing_or_changed_component_cannot_register(self):
  with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('primecare_ui_component_registry')+' SET active=0 WHERE id=1')
  with self.assertRaises(GovernanceReadError):
   with self.store() as db:register(db)
 def test_exact_opt_in_required(self):
  with patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_UI_REGISTRATION':'0'}):
   with self.assertRaises(GovernanceReadError):self.store()
 def test_unrelated_namespaces_and_grants_refused(self):
  with self.store() as db:
   for table,key,values in [('api_permissions',{},{}),('screen_components',{'screen_id':999,'component_code':'communicationWorkspace.root'},{}),('screen_required_elements',{'screen_id':234,'element_key':'other.root'},{}),('language_resources',{'resource_key':'other.title'},{})]:
    with self.subTest(table=table),self.assertRaises(GovernanceReadError):db.ensure_exact(table,key,values)
if __name__=='__main__':unittest.main()
