"""Native PostgreSQL recovery cutover regression tests; production credentials forbidden."""
import os,json,sys,unittest
from pathlib import Path
from urllib.parse import urlsplit
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from test_production_store import NativeStoreTests
from production_store import quote
from recovery_registration import RecoveryRegistrationStore,register,load_definition,TABLES,GovernanceReadError,read_catalog
URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if URL and (urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/recovery_metadata_test'):raise RuntimeError('Isolated loopback recovery database required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):raise RuntimeError('Production credentials forbidden')

@unittest.skipUnless(URL,'Disposable PostgreSQL required')
class RecoveryTests(unittest.TestCase):
    evidence=NativeStoreTests.evidence
    table=NativeStoreTests.table
    open_store=NativeStoreTests.open_store
    def setUp(self):
        NativeStoreTests.setUp(self)
        self.db.__exit__(Exception,None,None)
        env=patch.dict(os.environ,{'GOVERNANCE_RECOVERY_REGISTRATION_WRITES':'1'});env.start();self.addCleanup(env.stop)
        self.definition=load_definition()
        baseline=json.loads((ROOT/'docs/auth-recovery/native-presentation-baseline.json').read_text())['screens']
        specs={
          'api_endpoints':('id:i route_path:s http_method:s service_name:s auth_required:i request_schema:s response_schema:s rate_limit_key:s',[(395,'/v1/auth/forgot-password','POST','PRISMA',1,None,None,None),(396,'/v1/auth/reset-password','POST','PRISMA',1,None,None,None)]),
          'screen_components':('id:i screen_id:i component_code:s component_name:s component_type:s data_cy:s file_path:s implementation_status:s',[]),
          'screen_api_links':('id:i screen_id:i api_id:i purpose:s',[]),
          'language_resources':('resource_id:i resource_key:s resource_group:s description:s context:s active:i',[]),
          'language_resource_values':('translation_id:i resource_id:i language_id:i translated_text:s reviewed:i approved:i version:s',[]),
          'virtual_workflow_source_links':('flow_id:s source_table:s source_key:s source_key_columns:s reference_status:s',[]),
          'screens':('id:i screen_code:s route_path:s actual_file_path:s active:i',[(sid,r['screen_code'],r['route_path'],r['actual_file_path'],1) for sid,r in zip([947,950],baseline)]),
          'auth_route_registry':('id:i route_code:s route_path:s',[(3,'forgot_password','/forgot-password'),(4,'reset_password','/reset-password')]),
          'primecare_ui_component_registry':('id:i component_code:s',[(1,'prime_button'),(2,'prime_card'),(3,'prime_text_field')]),
          'languages':('language_id:i language_code:s enabled:i',[(1,'en',1),(2,'fr',1),(3,'es',1)]),
          'api_permissions':('id:i api_id:i role_id:i can_access:i',[(1,395,51,1)]),
          'role_screen_permissions':('id:i role_id:i screen_id:i can_view:i',[(1,51,947,1)]),
        }
        with psycopg.connect(URL,autocommit=True) as db:
            manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            for name,(spec,rows) in specs.items():
                columns=[];fields=[]
                for item in spec.split():
                    key,kind=item.split(':');columns.append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':['integer'] if kind=='i' else ['text']});fields.append(quote(key)+' '+('bigint' if kind=='i' else 'text'))
                manifest['tables'].append({'name':name,'columns':columns})
                db.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(fields)+')')
                for n,row in enumerate(rows):db.execute('INSERT INTO '+self.table(name)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[n,*row])
            db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
    def store(self,kind=RecoveryRegistrationStore):return kind(_test_connection=psycopg.connect(URL))
    def test_roundtrip_idempotence_native_and_grant_preservation(self):
        with self.store() as db:
            before={t:list(db.execute('SELECT * FROM '+t)) for t in ['screens','api_permissions','role_screen_permissions']}
            first=register(db,self.definition);second=register(db,self.definition)
            self.assertEqual(first,second);self.assertEqual(first['locales'],self.definition['locales'])
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components').fetchone()[0],18)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values WHERE reviewed<>0 OR approved<>0').fetchone()[0],0)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints WHERE service_name=\'auth\' AND auth_required=0').fetchone()[0],2)
            for t,rows in before.items():self.assertEqual(list(db.execute('SELECT * FROM '+t)),rows)
    def test_mid_cutover_failure_rolls_back_contracts_and_controls(self):
        class Failure(RecoveryRegistrationStore):
            calls=0
            def insert_metadata(self,table,values):
                self.calls+=1
                if self.calls==7:raise RuntimeError('Synthetic cutover interruption')
                return super().insert_metadata(table,values)
        with self.assertRaises(RuntimeError):
            with self.store(Failure) as db:register(db,self.definition)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints WHERE service_name=\'PRISMA\' AND auth_required=1').fetchone()[0],2)
    def test_changed_native_route_blocks_without_partial_writes(self):
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('screens')+" SET route_path='/human-edited' WHERE id=950")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_components').fetchone()[0],0)
    def test_human_translation_is_preserved_and_requires_reconciliation(self):
        with self.store() as db:register(db,self.definition)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='Human edited' WHERE translation_id=1")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT translated_text FROM language_resource_values WHERE translation_id=1').fetchone()[0],'Human edited')
    def test_unreviewed_api_metadata_is_never_overwritten(self):
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='human-reviewed' WHERE id=396")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT service_name FROM api_endpoints WHERE id=395').fetchone()[0],'PRISMA')
            self.assertEqual(db.execute('SELECT service_name FROM api_endpoints WHERE id=396').fetchone()[0],'human-reviewed')
    def test_unrelated_writes_rejected(self):
        with self.store() as db:
            for table,values in [('roles',{}),('api_endpoints',{}),('language_resources',{'resource_key':'other.key'}),('screen_components',{'screen_id':123}),('screen_api_links',{'screen_id':947,'api_id':396})]:
                with self.assertRaises(GovernanceReadError):db.insert_metadata(table,values)
    def test_duplicate_registration_fails_closed(self):
        with self.store() as db:register(db,self.definition)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('INSERT INTO '+self.table('screen_api_links')+' SELECT 99,99,screen_id,api_id,purpose FROM '+self.table('screen_api_links')+' WHERE id=1')
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:read_catalog(db,self.definition)
    def test_missing_optin_and_physical_schema_mismatch_rejected(self):
        with patch.dict(os.environ,{'GOVERNANCE_RECOVERY_REGISTRATION_WRITES':'0'}):
            with self.assertRaises(GovernanceReadError):self.store()
        with psycopg.connect(URL,autocommit=True) as db:db.execute('ALTER TABLE '+self.table('screen_components')+' ADD COLUMN unexpected text')
        with self.assertRaises(GovernanceReadError):self.store()

    def seed_recovery_flows(self,db):
        import hashlib
        table=self.table('virtual_workflow_definitions')
        cursor=db.db.execute('SELECT * FROM '+table)
        names=[c.name for c in cursor.description];base=dict(zip(names,cursor.fetchone()))
        db.db.execute('DELETE FROM '+table)
        for n,(mode,flow) in enumerate([('forgot','auth.forgot-password'),('reset','auth.reset-password')]):
            plan={'id':flow,'kind':'business_process','actor_roles':[],'steps':[{'api_method':'POST','api_path':self.definition['endpoints'][mode]}],'gaps':[]}
            encoded=json.dumps(plan,sort_keys=True)
            values=dict(base)
            for field,value in {'flow_id':flow,'definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest(),'actor_roles_json':'[]'}.items():values[field]=db._value('virtual_workflow_definitions',field,value)
            values['_primecare_import_row']=n
            db.db.execute('INSERT INTO '+table+'('+','.join(map(quote,names))+') VALUES('+','.join(['%s']*len(names))+')',[Jsonb(values[k]) if isinstance(values[k],dict) else values[k] for k in names])
    def test_recovery_process_binding_is_exact_idempotent_and_never_verified(self):
        from recovery_flow_binding import bind
        with self.store() as db:
            catalog=register(db,self.definition);self.seed_recovery_flows(db)
            first=bind(db,catalog);second=bind(db,catalog)
            self.assertTrue(all(r['changed'] for r in first));self.assertTrue(all(not r['changed'] for r in second))
            self.assertEqual(db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE verification_status='verified'").fetchone()[0],0)
            self.assertEqual(db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE test_status='stale'").fetchone()[0],2)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM virtual_workflow_source_links').fetchone()[0],40)
    def test_binding_preserves_changed_public_actor_specification(self):
        from recovery_flow_binding import bind
        with self.store() as db:
            catalog=register(db,self.definition);self.seed_recovery_flows(db)
            db.db.execute('UPDATE '+self.table('virtual_workflow_definitions')+" SET actor_roles_json='[\"ceo\"]' WHERE flow_id='auth.reset-password'")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:bind(db,catalog)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM virtual_workflow_source_links').fetchone()[0],0)


if __name__=='__main__':
    unittest.main(defaultTest='RecoveryTests')
