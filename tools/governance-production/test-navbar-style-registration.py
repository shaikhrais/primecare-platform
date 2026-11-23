"""Exact native navbar metadata boundaries on disposable PostgreSQL."""
import json,os,sys,unittest
from pathlib import Path
from urllib.parse import urlsplit
from unittest.mock import patch
import psycopg
from psycopg.types.json import Jsonb
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
import test_production_store as native
from production_store import quote
import navbar_style_registration as target
URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if URL and (urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/workspace_resources_test'):raise RuntimeError('Disposable loopback fixture required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):raise RuntimeError('Production credentials forbidden in fixtures')

@unittest.skipUnless(URL,'Disposable PostgreSQL service required')
class NavbarRegistrationTests(unittest.TestCase):
    evidence=native.NativeStoreTests.evidence
    table=native.NativeStoreTests.table
    open_store=native.NativeStoreTests.open_store
    def setUp(self):
        native.NativeStoreTests.setUp(self);self.db.__exit__(Exception,None,None)
        env=patch.dict(os.environ,{'GOVERNANCE_NAVBAR_STYLE_WRITES':'1'});env.start();self.addCleanup(env.stop)
        c=json.loads(target.FILE.read_text());h=c['registrationTarget']
        tables=[
            ('languages','language_id:i language_code:s enabled:i',[(1,'en',1),(2,'fr',1),(3,'es',1)]),
            ('screens','id:i screen_code:s route_path:s actual_file_path:s active:i',[(2534,h['screenCode'],h['route'],h['sourceFile'],1)]),
            ('role_screen_permissions','role_id:i screen_id:i can_view:i',[(7,2534,1)]),
            ('primecare_ui_component_registry','component_code:s active:i',[('prime_radio',1)]),
            ('screen_components','id:i screen_id:i component_code:s component_name:s component_type:s data_cy:s file_path:s implementation_status:s',[]),
            ('screen_required_elements','id:i screen_id:i element_key:s element_type:s label:s test_id:s required:i',[]),
            ('language_resources','resource_id:i resource_key:s resource_group:s description:s context:s active:i',[]),
            ('language_resource_values','translation_id:i resource_id:i language_id:i translated_text:s reviewed:i approved:i version:s',[])]
        with psycopg.connect(URL,autocommit=True) as db:
            manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            for name,spec,rows in tables:
                columns=[];physical=[]
                for field in spec.split():
                    key,kind=field.split(':');columns.append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':['integer' if kind=='i' else 'text']});physical.append(quote(key)+' '+('bigint' if kind=='i' else 'text'))
                manifest['tables'].append({'name':name,'columns':columns})
                db.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
                for n,row in enumerate(rows):db.execute('INSERT INTO '+self.table(name)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[n,*row])
            db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
    def store(self,cls=target.NavbarStyleStore):return cls(_test_connection=psycopg.connect(URL))
    def test_exact_optional_control_is_idempotent_and_unapproved(self):
        with self.store() as db:
            grants=list(db.execute('SELECT * FROM role_screen_permissions'))
            first=target.register(db);self.assertEqual(target.register(db),first)
            self.assertEqual(len(first['controls']),1);self.assertEqual(first['translationCount'],12)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values WHERE reviewed=0 AND approved=0').fetchone()[0],12)
            self.assertEqual(list(db.execute('SELECT * FROM role_screen_permissions')),grants)
            self.assertEqual(db.execute('SELECT required FROM screen_required_elements').fetchone(),(0,))
    def test_missing_approved_component_fails_before_writing(self):
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('primecare_ui_component_registry')+' SET active=0')
        with self.assertRaises(target.GovernanceReadError):
            with self.store() as db:target.register(db)
        with self.store() as db:self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
    def test_partial_registration_rolls_back(self):
        class Failure(target.NavbarStyleStore):
            calls=0
            def ensure(self,*args):
                self.calls+=1
                if self.calls==7:raise RuntimeError('Synthetic failure')
                return super().ensure(*args)
        with self.assertRaises(RuntimeError):
            with self.store(Failure) as db:target.register(db)
        with self.store() as db:
            for table in target.TABLES:self.assertEqual(db.execute('SELECT COUNT(*) FROM '+table).fetchone()[0],0)
    def test_edited_translations_are_preserved(self):
        with self.store() as db:target.register(db)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='Human edit',reviewed=1,approved=1 WHERE translation_id=1")
        with self.assertRaises(target.GovernanceReadError):
            with self.store() as db:target.register(db)
        with self.store() as db:self.assertEqual(db.execute('SELECT translated_text,reviewed,approved FROM language_resource_values WHERE translation_id=1').fetchone(),('Human edit',1,1))
    def test_implementation_requires_separate_opt_in_and_never_marks_verified(self):
        with self.store() as db:
            first=target.register(db);tid='theme-navbar-style';cid=first['controls'][tid]
            with self.assertRaises(target.GovernanceReadError):db.record_control_implementation(2534,cid,tid)
            with patch.dict(os.environ,{'GOVERNANCE_NAVBAR_IMPLEMENTATION_WRITES':'1'}):db.record_control_implementation(2534,cid,tid)
            self.assertEqual(target.register(db)['implementationStatuses'][tid],'implemented-unverified')
            with self.assertRaises(target.GovernanceReadError):db.ensure('roles',{'id':99},{})
    def test_lock_timeout_rolls_back_and_a_fresh_transaction_can_register(self):
        blocker=psycopg.connect(URL)
        try:
            blocker.execute('LOCK TABLE '+self.table('screen_components')+' IN SHARE ROW EXCLUSIVE MODE')
            with self.assertRaises(psycopg.errors.LockNotAvailable):self.store()
        finally:
            blocker.rollback();blocker.close()
        with self.store() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
            self.assertEqual(target.register(db)['translationCount'],12)
    def test_exact_contract_and_explicit_opt_in_are_required(self):
        p=self.root/'tampered.json';p.write_text('{}')
        with patch.object(target,'FILE',p):
            with self.assertRaises((target.GovernanceReadError,KeyError)):self.store()
        with patch.dict(os.environ,{'GOVERNANCE_NAVBAR_STYLE_WRITES':''}):
            with self.assertRaises(target.GovernanceReadError):self.store()

if __name__=='__main__':unittest.main(verbosity=2)
