"""Native disposable registration tests; never use production credentials."""
import json,os,sys,unittest
from pathlib import Path
from urllib.parse import urlsplit
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from test_production_store import NativeStoreTests
from production_store import quote
from communications_registration import CommunicationRegistrationStore,register,definition,GovernanceReadError
URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if not URL or urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/communication_registration_test':
    raise RuntimeError('Disposable loopback communication_registration_test database required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):
    raise RuntimeError('Production credentials forbidden in isolated registration tests')
class RegistrationTests(unittest.TestCase):
    evidence=NativeStoreTests.evidence
    table=NativeStoreTests.table
    open_store=NativeStoreTests.open_store
    def setUp(self):
        NativeStoreTests.setUp(self)
        self.db.__exit__(Exception,None,None)
        scope=patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_REGISTRATION_WRITES':'1'})
        scope.start();self.addCleanup(scope.stop)
        with psycopg.connect(URL,autocommit=True) as admin:
            manifest=admin.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            specs={
                'api_endpoints':('id:i app_id:i route_path:s http_method:s endpoint_code:s service_name:s auth_required:i implementation_status:s permission_key:j request_schema:j response_schema:j api_version:s health_status:s uses_pagination:i',[
                    (710,2,'/v1/messages','POST','MESSAGE','PRISMA',1,'active',None,None,None,'v1','unknown',0),
                    (857,2,'/v1/messages/inbox','GET','MESSAGE_INBOX','PRISMA',1,'active',None,None,None,'v1','unknown',0)]),
                'screen_api_links':('id:i screen_id:i api_id:i purpose:s',[]),
                'screens':('id:i screen_code:s active:i',[(int(k),v,1) for k,v in definition()['screens'].items()]),
                'api_permissions':('id:i api_id:i role_id:i can_access:i',[(1,999,51,1)]),
                'role_screen_permissions':('id:i role_id:i screen_id:i can_view:i can_create:i can_edit:i',[(1,51,234,1,0,0)]),
            }
            for name,(spec,rows) in specs.items():
                cols=[];physical=[]
                for field in spec.split():
                    key,kind=field.split(':');cols.append(dict(name=key,declared_type='INTEGER' if kind=='i' else 'TEXT',storage_types=[] if kind=='j' else ['integer'] if kind=='i' else ['text']))
                    physical.append(quote(key)+' '+{'i':'bigint','s':'text','j':'jsonb'}[kind])
                manifest['tables'].append(dict(name=name,columns=cols))
                admin.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
                for ordinal,row in enumerate(rows):admin.execute('INSERT INTO '+self.table(name)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[ordinal,*row])
            admin.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
    def store(self):return CommunicationRegistrationStore(_test_connection=psycopg.connect(URL))
    def test_exact_registration_is_idempotent_and_preserves_grants(self):
        with self.store() as db:
            before=[db.execute('SELECT * FROM '+table).fetchall() for table in ['api_permissions','role_screen_permissions']]
            first=register(db);self.assertEqual(first,register(db))
            self.assertEqual(len(first['apiIds']),7);self.assertEqual(first['screenLinks'],28)
            self.assertEqual(first['roleGrants'],0);self.assertFalse(first['activation'])
            self.assertEqual(first['apiIds']['message.command'],710)
            self.assertEqual(first['apiIds']['message.inbox'],857)
            self.assertEqual(db.execute('SELECT http_method,route_path FROM api_endpoints WHERE id=?',(first['apiIds']['email.inbox'],)).fetchall(),[('GET','/v1/messages/email/inbox')])
            self.assertEqual(before,[db.execute('SELECT * FROM '+table).fetchall() for table in ['api_permissions','role_screen_permissions']])
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],7)
    def test_mid_registration_failure_rolls_back_updates_and_inserts(self):
        class Failure(CommunicationRegistrationStore):
            def insert_exact(self,table,values):
                if table=='api_endpoints':raise RuntimeError('Synthetic failure after existing updates')
                return super().insert_exact(table,values)
        with self.assertRaises(RuntimeError):
            with Failure(_test_connection=psycopg.connect(URL)) as db:register(db)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_endpoints').fetchone()[0],2)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],0)
            self.assertEqual(db.execute('SELECT service_name FROM api_endpoints WHERE id=710').fetchone()[0],'PRISMA')
    def test_edited_existing_contract_is_preserved(self):
        with psycopg.connect(URL,autocommit=True) as admin:
            admin.execute('UPDATE '+self.table('api_endpoints')+" SET service_name='human_edit' WHERE id=857")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT service_name FROM api_endpoints WHERE id=710').fetchone()[0],'PRISMA')
            self.assertEqual(db.execute('SELECT COUNT(*) FROM screen_api_links').fetchone()[0],0)
    def test_wrong_screen_or_missing_api_fails_without_partial_registration(self):
        with psycopg.connect(URL,autocommit=True) as admin:
            admin.execute('UPDATE '+self.table('screens')+" SET screen_code='changed' WHERE id=234")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db)
    def test_opt_in_is_mandatory(self):
        with patch.dict(os.environ,{'GOVERNANCE_COMMUNICATION_REGISTRATION_WRITES':'0'}):
            with self.assertRaises(GovernanceReadError):self.store()
    def test_arbitrary_tables_routes_and_grants_are_refused(self):
        with self.store() as db:
            for table,values in [('roles',{}),('api_permissions',{}),('api_endpoints',{'route_path':'/unrelated'}),('screen_api_links',{'screen_id':999,'api_id':710,'purpose':'forged'})]:
                with self.subTest(table=table),self.assertRaises(GovernanceReadError):db.insert_exact(table,values)
if __name__=='__main__':unittest.main()
