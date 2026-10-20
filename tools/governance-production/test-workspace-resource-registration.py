"""Prove workspace registration boundaries and rollback in loopback PostgreSQL."""
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
from workspace_resource_registration import WorkspaceResourceStore,register,GovernanceReadError,CATALOG
import workspace_resource_registration as registration

URL=os.environ.get('WORKFLOW_TEST_DATABASE_URL','')
if URL and (urlsplit(URL).hostname not in ['localhost','127.0.0.1'] or urlsplit(URL).path!='/workspace_resources_test'):
    raise RuntimeError('Disposable loopback workspace_resources_test database required')
if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):
    raise RuntimeError('Production credentials forbidden in metadata fixtures')

@unittest.skipUnless(URL,'Disposable native PostgreSQL service required')
class WorkspaceResourcesTests(unittest.TestCase):
    evidence=native.NativeStoreTests.evidence
    table=native.NativeStoreTests.table
    open_store=native.NativeStoreTests.open_store
    def setUp(self):
        native.NativeStoreTests.setUp(self)
        self.db.__exit__(Exception,None,None)
        env=patch.dict(os.environ,{'GOVERNANCE_WORKSPACE_RESOURCE_WRITES':'1'});env.start();self.addCleanup(env.stop)
        with psycopg.connect(URL,autocommit=True) as db:
            manifest=db.execute('SELECT manifest FROM '+self.table('source_manifest')).fetchone()[0]
            for name,spec,rows in [
                ('languages','language_id:i language_code:s enabled:i',[(1,'en',1),(2,'fr',1),(3,'es',1)]),
                ('language_resources','resource_id:i resource_key:s resource_group:s description:s context:s active:i',[]),
                ('language_resource_values','translation_id:i resource_id:i language_id:i translated_text:s reviewed:i approved:i version:s',[])]:
                columns=[];physical=[]
                for field in spec.split():
                    key,kind=field.split(':');columns.append({'name':key,'declared_type':'INTEGER' if kind=='i' else 'TEXT','storage_types':['integer' if kind=='i' else 'text']});physical.append(quote(key)+' '+('bigint' if kind=='i' else 'text'))
                manifest['tables'].append({'name':name,'columns':columns})
                db.execute('CREATE TABLE '+self.table(name)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(physical)+')')
                for n,row in enumerate(rows):db.execute('INSERT INTO '+self.table(name)+' VALUES('+','.join(['%s']*(len(row)+1))+')',[n,*row])
            db.execute('UPDATE '+self.table('source_manifest')+' SET manifest=%s',(Jsonb(manifest),))
    def store(self,cls=WorkspaceResourceStore):return cls(_test_connection=psycopg.connect(URL))
    def test_idempotent_parity_without_approvals_or_business_changes(self):
        with self.store() as db:
            before=list(db.execute('SELECT * FROM virtual_workflow_definitions'))
            first=register(db);second=register(db)
            self.assertEqual(first['values'],105);self.assertEqual(first['created_resources'],35)
            self.assertEqual(second['created_resources'],0);self.assertEqual(second['created_values'],0)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values WHERE reviewed=0 AND approved=0').fetchone()[0],105)
            self.assertEqual(list(db.execute('SELECT * FROM virtual_workflow_definitions')),before)
    def test_unrelated_resources_permissions_and_approval_claims_are_rejected(self):
        with self.store() as db:
            register(db);rid=db.execute('SELECT resource_id FROM language_resources ORDER BY resource_id LIMIT 1').fetchone()[0]
            for table,values in [('roles',{'id':99}),('language_resources',{'resource_key':'other.title'}),('language_resource_values',{'resource_id':rid,'language_id':1,'translated_text':'Invented','reviewed':1,'approved':1})]:
                with self.assertRaises(GovernanceReadError):db.insert_metadata(table,values)
    def test_partial_registration_rolls_back(self):
        class Failure(WorkspaceResourceStore):
            calls=0
            def insert_metadata(self,table,values):
                self.calls+=1
                if self.calls==9:raise RuntimeError('Synthetic mid-registration failure')
                return super().insert_metadata(table,values)
        with self.assertRaises(RuntimeError):
            with self.store(Failure) as db:register(db)
        with self.store() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resources').fetchone()[0],0)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM language_resource_values').fetchone()[0],0)
    def test_preserves_human_edited_values(self):
        with self.store() as db:register(db)
        with psycopg.connect(URL,autocommit=True) as db:db.execute('UPDATE '+self.table('language_resource_values')+" SET translated_text='Human edit',reviewed=1,approved=1 WHERE translation_id=1")
        with self.assertRaises(GovernanceReadError):
            with self.store() as db:register(db)
        with self.store() as db:self.assertEqual(db.execute('SELECT translated_text,reviewed,approved FROM language_resource_values WHERE translation_id=1').fetchone(),('Human edit',1,1))
    def test_exact_catalog_hash_and_opt_in_are_required(self):
        target=self.root/CATALOG;target.parent.mkdir(parents=True,exist_ok=True);target.write_text('{"not":"the pinned catalog"}')
        with patch.object(registration,'ROOT',self.root):
            with self.assertRaises(GovernanceReadError):self.store()
        with patch.dict(os.environ,{'GOVERNANCE_WORKSPACE_RESOURCE_WRITES':''}):
            with self.assertRaises(GovernanceReadError):self.store()

if __name__=='__main__':unittest.main(verbosity=2)
