"""Transaction/authority regressions in a disposable loopback PostgreSQL database."""
import json,os,sys,unittest
from pathlib import Path
from urllib.parse import urlsplit
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from test_production_store import NativeStoreTests
from production_store import ProductionWorkflowStore,quote
from maintenance_registration import MaintenanceRegistrationStore,register,TABLES,GovernanceReadError

URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if URL and (urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/maintenance_metadata_test'):
    raise RuntimeError('Disposable loopback maintenance_metadata_test database required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):
    raise RuntimeError('Production credentials forbidden in registration tests')

@unittest.skipUnless(URL,'Disposable PostgreSQL service required')
class RegistrationTests(unittest.TestCase):
    table=NativeStoreTests.table
    open_store=NativeStoreTests.open_store
    def setUp(self):
        NativeStoreTests.setUp(self)
        self.db.__exit__(Exception,None,None)
        self.env2=patch.dict(os.environ,{'GOVERNANCE_MAINTENANCE_REGISTRATION_WRITES':'1'})
        self.env2.start();self.addCleanup(self.env2.stop)
        self.definition=json.loads((ROOT/'tools/governance-production/maintenance-registration.json').read_text())
        with psycopg.connect(URL,autocommit=True) as admin:
            manifest=admin.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            specs={
              'api_endpoints':('id:i app_id:i route_path:s http_method:s endpoint_code:s service_name:s auth_required:i implementation_status:s permission_key:s request_schema:j response_schema:j rate_limit_key:s api_version:s uses_pagination:i health_status:s',[]),
              'api_permissions':('id:i api_id:i role_id:i permission_key:s can_access:i',[]),
              'screen_api_links':('id:i screen_id:i api_id:i purpose:s',[]),
              'screen_components':('id:i screen_id:i component_code:s component_name:s component_type:s data_cy:s file_path:s implementation_status:s',[]),
              'screen_required_elements':('id:i screen_id:i element_key:s element_type:s label:s test_id:s required:i',[]),
              'language_resources':('resource_id:i resource_key:s resource_group:s description:s context:s active:i',[]),
              'language_resource_values':('translation_id:i resource_id:i language_id:i translated_text:s reviewed:i approved:i version:s',[]),
              'roles':('id:i role_code:s active:i',[(20,'ceo',1),(65,'maintenance',1),(51,'psw',1)]),
              'screens':('id:i screen_code:s route_path:s active:i',[(1264,'MAINTENANCE_CONFIGURATION','/maintenance/configuration',1)]),
              'role_screen_permissions':('id:i role_id:i screen_id:i can_view:i can_create:i can_edit:i',[(6587,65,1264,1,1,1),(6588,20,1264,1,1,1)]),
              'apps':('id:i app_code:s',[(26,'at')]),
              'languages':('language_id:i language_code:s enabled:i',[(1,'en',1),(2,'fr',1),(3,'es',1)]),
              'auth_account_creation_policy':('actor_role_id:i target_role_id:i scope:s',[(20,65,'same_tenant')]),
            }
            for name,(spec,rows) in specs.items():
                columns=[];physical=[]
                for field in spec.split():
                    key,kind=field.split(':');columns.append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':[] if kind=='j' else ['integer'] if kind=='i' else ['text']});physical.append(quote(key)+' '+{'i':'bigint','s':'text','j':'jsonb'}[kind])
                manifest['tables'].append({'name':name,'columns':columns})
                admin.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
                for ordinal,row in enumerate(rows):admin.execute('INSERT INTO '+self.table(name)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[ordinal,*row])
            admin.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
    def store(self):return MaintenanceRegistrationStore(_test_connection=psycopg.connect(URL))
    def test_registration_is_idempotent_and_preserves_actor_authority(self):
        with self.store() as db:
            grants=list(db.execute('SELECT * FROM role_screen_permissions'))
            first=register(db,self.definition);second=register(db,self.definition)
            self.assertEqual(first,second);self.assertEqual(first['actorRoles'],['ceo','maintenance'])
            self.assertEqual(first['creationActorRoles'],['ceo'])
            self.assertEqual(list(db.execute('SELECT * FROM role_screen_permissions')),grants)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],3)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values').fetchone()[0],3*len(self.definition['resources']))
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_permissions').fetchone()[0],6)
    def test_rejects_unrelated_namespace_screen_route_and_actor(self):
        with self.store() as db:
            catalog=register(db,self.definition)
            for table,values in [('roles',{'id':999}),('language_resources',{'resource_key':'unrelated.title'}),('screen_components',{'screen_id':1265}),('api_endpoints',{'route_path':'/new-route'}),('api_permissions',{'api_id':catalog['apiIds'][0],'role_id':51})]:
                with self.assertRaises(GovernanceReadError):db.insert_metadata(table,values)
    def test_transaction_rolls_back_partial_registration(self):
        class Failure(MaintenanceRegistrationStore):
            calls=0
            def insert_metadata(self,table,values):
                self.calls+=1
                if self.calls==8:raise RuntimeError('isolated mid-cutover failure')
                return super().insert_metadata(table,values)
        with self.assertRaises(RuntimeError):
            with Failure(_test_connection=psycopg.connect(URL)) as db:register(db,self.definition)
        with self.store() as db:
            for table in TABLES:self.assertEqual(db.execute('SELECT COUNT(*) FROM '+table).fetchone()[0],0)
    def test_changed_live_grant_blocks_all_registration(self):
        with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('role_screen_permissions')+' SET can_view=0 WHERE role_id=65')
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
    def test_existing_translation_is_never_silently_overwritten(self):
        with self.store() as db:register(db,self.definition)
        with psycopg.connect(URL,autocommit=True) as admin:admin.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='Human edited' WHERE translation_id=1")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db,self.definition)
        with self.store() as db:self.assertEqual(db.execute('SELECT translated_text FROM language_resource_values WHERE translation_id=1').fetchone()[0],'Human edited')
    def test_explicit_opt_in_is_required(self):
        with patch.dict(os.environ,{'GOVERNANCE_MAINTENANCE_REGISTRATION_WRITES':''}):
            with self.assertRaises(GovernanceReadError):self.store()

if __name__=='__main__':unittest.main(verbosity=2)
