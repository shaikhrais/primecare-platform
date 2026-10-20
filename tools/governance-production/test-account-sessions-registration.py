"""Own-session registration transactions against a disposable native PostgreSQL service."""
import importlib.util,json,hashlib,os,sys,unittest
from pathlib import Path
from unittest.mock import patch
from urllib.parse import urlsplit
import psycopg
from psycopg.types.json import Jsonb
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from test_production_store import NativeStoreTests
from production_store import quote
from account_sessions_registration import AccountRegistrationStore,register,definition,read_catalog,bind_implementation,GovernanceReadError
spec=importlib.util.spec_from_file_location('recovery_fixture_module',Path(__file__).with_name('test-recovery-registration.py'));fixture=importlib.util.module_from_spec(spec);spec.loader.exec_module(fixture)
URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if URL and (urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/recovery_metadata_test'):raise RuntimeError('Disposable loopback metadata database required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):raise RuntimeError('Production credentials forbidden in account registration fixtures')
@unittest.skipUnless(URL,'Disposable PostgreSQL required')
class AccountTests(unittest.TestCase):
    evidence=NativeStoreTests.evidence
    table=NativeStoreTests.table
    open_store=NativeStoreTests.open_store
    def setUp(self):
        fixture.RecoveryTests.setUp(self)
        self.definition=definition()
        env=patch.dict(os.environ,{'GOVERNANCE_ACCOUNT_REGISTRATION_WRITES':'1'});env.start();self.addCleanup(env.stop)
        with psycopg.connect(URL,autocommit=True) as db:
            manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            byname={t['name']:t for t in manifest['tables']}
            def extend(table,spec):
                for field in spec.split():
                    key,kind=field.split(':')
                    if any(c['name']==key for c in byname[table]['columns']):continue
                    byname[table]['columns'].append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':['integer'] if kind=='i' else ['text']})
                    db.execute('ALTER TABLE '+self.table(table)+' ADD COLUMN '+quote(key)+' '+('bigint' if kind=='i' else 'text'))
            def add(table,spec,rows):
                columns=[];physical=[]
                for field in spec.split():
                    key,kind=field.split(':');columns.append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':['integer'] if kind=='i' else ['text']});physical.append(quote(key)+' '+('bigint' if kind=='i' else 'text'))
                byname[table]={'name':table,'columns':columns};manifest['tables'].append(byname[table])
                db.execute('CREATE TABLE '+self.table(table)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
                for n,row in enumerate(rows):db.execute('INSERT INTO '+self.table(table)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[n,*row])
            extend('screens','app_id:i role_id:i screen_name:s stage:s runtime_verified:i cypress_verified:i production_ready:i completeness_score:i implementation_tag:s content_tag:s api_tag:s test_tag:s review_tag:s component_summary:s section_summary:s screenshot_path:s')
            extend('api_endpoints','permission_key:s')
            extend('auth_route_registry','flow_type:s')
            extend('primecare_ui_component_registry','active:i')
            db.execute('UPDATE '+self.table('primecare_ui_component_registry')+' SET active=1')
            db.execute('INSERT INTO '+self.table('primecare_ui_component_registry')+" VALUES(99,14,'prime_table_web',1)")
            db.execute('INSERT INTO '+self.table('auth_route_registry')+" VALUES(98,1,'login','/login','shared_credentials'),(99,7,'success','/success','authenticated_session_summary')")
            db.execute('INSERT INTO '+self.table('api_endpoints')+" VALUES(98,16425,'/v1/user/sessions','GET','auth',1,'{}','{}','workspace.source','authenticated_self_session'),(99,16426,'/v1/user/sessions','DELETE','auth',1,'{}','{}','manageAccount','authenticated_self_session')")
            add('apps','id:i app_code:s',[(1,'ui')])
            add('screen_required_elements','id:i screen_id:i element_key:s element_type:s label:s test_id:s required:i',[])
            add('virtual_workflow_steps','flow_id:s step_order:i api_method:s api_path:s',[('auth.inspect-own-sessions',2,'GET','/v1/auth/user/sessions'),('auth.revoke-own-sessions',2,'DELETE','/v1/auth/user/sessions')])
            db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
        with self.store() as db:
            table=self.table('virtual_workflow_definitions');cursor=db.db.execute('SELECT * FROM '+table)
            names=[c.name for c in cursor.description];base=dict(zip(names,cursor.fetchone()));db.db.execute('DELETE FROM '+table)
            for n,(flow,method) in enumerate(zip(self.definition['flows'],['GET','DELETE'])):
                actors=['rmt','platform_admin'];plan={'id':flow,'kind':'business_process','actor_roles':actors,'steps':[{'api_method':method,'api_path':'/v1/auth/user/sessions'}],'gaps':[]}
                encoded=json.dumps(plan,sort_keys=True);values=dict(base)
                for field,value in {'flow_id':flow,'definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest(),'actor_roles_json':json.dumps(actors),'verification_status':'missing','test_status':'not_run'}.items():values[field]=db._value('virtual_workflow_definitions',field,value)
                values['_primecare_import_row']=n
                db.db.execute('INSERT INTO '+table+'('+','.join(map(quote,names))+') VALUES('+','.join(['%s']*len(names))+')',[Jsonb(values[k]) if isinstance(values[k],dict) else values[k] for k in names])
    def store(self,kind=AccountRegistrationStore):return kind(_test_connection=psycopg.connect(URL))
    def test_exact_registration_idempotence_and_no_authority_change(self):
        with self.store() as db:
            before={t:list(db.execute('SELECT * FROM '+t)) for t in ['api_permissions','role_screen_permissions','auth_route_registry','api_endpoints']}
            native=list(db.execute('SELECT * FROM screens ORDER BY id'))
            first=register(db,self.definition);second=register(db,self.definition)
            self.assertEqual(first,second);sid=first['screenId'];self.assertNotIn(sid,[947,950])
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components').fetchone()[0],11)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_required_elements').fetchone()[0],11)
            self.assertEqual(list(db.execute('SELECT * FROM screens WHERE id IN (947,950) ORDER BY id')),native)
            for t,rows in before.items():self.assertEqual(list(db.execute('SELECT * FROM '+t)),rows)
            self.assertEqual(db.execute('SELECT role_id,production_ready,runtime_verified,cypress_verified FROM screens WHERE id=?',(sid,)).fetchone(),(None,0,0,0))
            self.assertEqual(db.execute("SELECT COUNT(*) FROM language_resource_values WHERE reviewed<>0 OR approved<>0").fetchone()[0],0)
            self.assertEqual(db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE verification_status='missing'").fetchone()[0],2)
            self.assertEqual(list(db.execute('SELECT api_path FROM virtual_workflow_steps ORDER BY flow_id')),[('/v1/user/sessions',),('/v1/user/sessions',)])
    def test_partial_failure_rolls_back_new_screen_resources_and_steps(self):
        class Failure(AccountRegistrationStore):
            calls=0
            def insert_metadata(self,table,values):
                self.calls+=1
                if self.calls==9:raise RuntimeError('Synthetic mid-registration failure')
                return super().insert_metadata(table,values)
        with self.assertRaises(RuntimeError):
            with self.store(Failure) as db:register(db,self.definition)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screens').fetchone()[0],2)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
            self.assertEqual(db.execute("SELECT COUNT(*) FROM virtual_workflow_steps WHERE api_path='/v1/auth/user/sessions'").fetchone()[0],2)
    def test_existing_route_or_api_policy_change_blocks_without_writes(self):
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('auth_route_registry')+" SET flow_type='operator-edited' WHERE id=7")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM screens').fetchone()[0],2)
    def test_changed_api_permission_is_not_rewritten(self):
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_endpoints')+" SET permission_key='operator-edited' WHERE id=16425")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
    def test_reviewed_translation_is_preserved(self):
        with self.store() as db:register(db,self.definition)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='Human edited' WHERE translation_id=1")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT translated_text FROM language_resource_values WHERE translation_id=1').fetchone()[0],'Human edited')
    def test_unrelated_metadata_writes_are_refused(self):
        with self.store() as db:
            for table,values in [('api_permissions',{}),('language_resources',{'resource_key':'other.title'}),('screens',{'app_id':3,'screen_code':'other'}),('screen_components',{'screen_id':948})]:
                with self.assertRaises(GovernanceReadError):db.insert_metadata(table,values)
    def test_duplicate_control_registration_fails_closed(self):
        with self.store() as db:catalog=register(db,self.definition)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('INSERT INTO '+self.table('screen_components')+' SELECT 999,999,screen_id,component_code,component_name,component_type,data_cy,file_path,implementation_status FROM '+self.table('screen_components')+' WHERE id=1')
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:read_catalog(db,self.definition)
    def test_missing_optin_rejected(self):
        with patch.dict(os.environ,{'GOVERNANCE_ACCOUNT_REGISTRATION_WRITES':'0'}):
            with self.assertRaises(GovernanceReadError):self.store()

    def test_implementation_binding_is_idempotent_and_never_verifies(self):
        with self.store() as db:
            catalog=register(db,self.definition)
            actors=db.execute('SELECT flow_id,actor_roles_json FROM virtual_workflow_definitions ORDER BY flow_id').fetchall()
            first=bind_implementation(db,catalog)
            self.assertTrue(all(r['changed'] and r['verification_status']=='implemented-unverified' for r in first))
            self.assertTrue(all(not r['changed'] for r in bind_implementation(db,catalog)))
            self.assertEqual(register(db,self.definition),catalog)
            self.assertTrue(all(not r['changed'] for r in bind_implementation(db,catalog)))
            self.assertEqual(actors,db.execute('SELECT flow_id,actor_roles_json FROM virtual_workflow_definitions ORDER BY flow_id').fetchall())
            for row in db.execute('SELECT verification_status,test_status,definition_json FROM virtual_workflow_definitions'):
                self.assertEqual(row[:2],('implemented-unverified','stale'))
                self.assertTrue(json.loads(row[2])['source_sha256'])

    def test_implementation_binding_rejects_changed_actor_specification(self):
        with self.store() as db:
            catalog=register(db,self.definition)
            flow=self.definition['flows'][0]
            row=db.execute('SELECT definition_json FROM virtual_workflow_definitions WHERE flow_id=?',(flow,)).fetchone()
            plan=json.loads(row[0]);plan['actor_roles']=['unregistered']
            encoded=json.dumps(plan)
            db._update('virtual_workflow_definitions',{'definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest()},flow)
            with self.assertRaises(GovernanceReadError):bind_implementation(db,catalog)

if __name__=='__main__':unittest.main(defaultTest='AccountTests')
