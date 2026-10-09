"""Retirement preserves foreign-key identities and fails closed on catalog drift."""
import importlib.util,sqlite3,unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('retirements',Path(__file__).with_name('reconcile-client-read-declarations.py'))
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

class RetirementTests(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:');self.db.execute('PRAGMA foreign_keys=ON')
        self.db.execute('CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,permission_key TEXT,request_schema TEXT,response_schema TEXT,implementation_status TEXT,health_status TEXT)')
        for table in ['screen_api_links','screen_api_map','api_permissions']:
            self.db.execute('CREATE TABLE '+table+'(api_id INTEGER REFERENCES api_endpoints(id))')
        for index,(aid,path) in enumerate(module.RETIREMENTS):
            self.db.execute('INSERT INTO api_endpoints VALUES(?,?,?,?,?,?,?,?,?,?)',(index+1,path,'GET','client',1,'authenticated_client_profile_owner','{"type":"object"}','{"type":"object"}','implemented',None))
            self.db.execute('INSERT INTO api_endpoints VALUES(?,?,?,?,?,?,?,?,?,?)',(aid,path,'POST','PRISMA',1,None,None,None,'declared',None))
            self.db.execute('INSERT INTO api_permissions VALUES(?)',(aid,))
        self.db.commit()
    def tearDown(self):self.db.close()
    def test_tombstones_preserve_grant_references_and_are_idempotent(self):
        with self.db:module.reconcile(self.db)
        self.assertEqual(self.db.execute("SELECT COUNT(*) FROM api_endpoints WHERE implementation_status='retired'").fetchone()[0],2)
        self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
        before='\n'.join(self.db.iterdump())
        with self.db:module.reconcile(self.db)
        self.assertEqual('\n'.join(self.db.iterdump()),before)
    def test_linked_caller_denies_retirement_and_rolls_back_package(self):
        self.db.execute('INSERT INTO screen_api_map VALUES(239)');self.db.commit()
        with self.assertRaisesRegex(ValueError,'registered caller'):
            with self.db:module.reconcile(self.db)
        self.assertEqual(self.db.execute("SELECT COUNT(*) FROM api_endpoints WHERE implementation_status='retired'").fetchone()[0],0)
    def test_canonical_authority_or_schema_drift_denies_package(self):
        for column,value in [('service_name','auth'),('auth_required',0),('permission_key','tenant_admin'),('request_schema','{}'),('response_schema','not-json')]:
            with self.subTest(column=column):
                self.db.execute('SAVEPOINT drift')
                self.db.execute('UPDATE api_endpoints SET '+column+'=? WHERE id=1',(value,))
                with self.assertRaises(ValueError):module.reconcile(self.db)
                self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')

if __name__=='__main__':unittest.main()
