import importlib.util,sqlite3,tempfile,unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('blockers',Path(__file__).with_name('register-method-capture-blockers.py'));m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class FaultyConnection(sqlite3.Connection):
    fail_id=None
    def execute(self,sql,args=()):
        if sql.startswith('UPDATE api_endpoints SET') and args==(self.fail_id,):raise sqlite3.OperationalError('Injected second update failure')
        return super().execute(sql,args)

class BlockerTests(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:',factory=FaultyConnection)
        self.columns=list(next(iter(m.EXPECTED.values())))
        definition=','.join(k+(' INTEGER PRIMARY KEY' if k=='id' else ' INTEGER' if isinstance(next(iter(m.EXPECTED.values()))[k],int) else ' TEXT') for k in self.columns)
        self.db.execute('CREATE TABLE api_endpoints('+definition+')')
        for row in m.EXPECTED.values():self.insert(row)
        canonical=dict(m.EXPECTED[251],id=3000,http_method='GET',endpoint_code='CANONICAL_OWNER_READ',implementation_status='implemented',permission_key='authenticated_client_profile_owner',request_schema='{"type":"object"}',response_schema='{"type":"object"}',service_name='client',health_status='unverified')
        self.insert(canonical)
        self.db.execute('CREATE TABLE governance_findings(id INTEGER,related_api_id INTEGER,description TEXT)');self.db.execute("INSERT INTO governance_findings VALUES(1,251,'Missing business authorization')")
        self.db.commit()
    def tearDown(self):self.db.close()
    def insert(self,row):self.db.execute('INSERT INTO api_endpoints VALUES('+','.join('?' for _ in self.columns)+')',[row[k] for k in self.columns])
    def rows(self):return self.db.execute('SELECT * FROM api_endpoints ORDER BY id').fetchall()
    def test_atomic_idempotent_preserving_canonical_fields_and_findings(self):
        canonical=self.db.execute('SELECT * FROM api_endpoints WHERE id=3000').fetchone();findings=self.db.execute('SELECT * FROM governance_findings').fetchall()
        self.assertEqual(m.reconcile(self.db)['resolvedOperations'],0);first=self.rows();m.reconcile(self.db);self.assertEqual(first,self.rows())
        self.assertEqual(self.db.execute('SELECT * FROM api_endpoints WHERE id=3000').fetchone(),canonical);self.assertEqual(self.db.execute('SELECT * FROM governance_findings').fetchall(),findings)
        for aid,original in m.EXPECTED.items():
            after=dict(zip(self.columns,self.db.execute('SELECT * FROM api_endpoints WHERE id=?',(aid,)).fetchone()))
            self.assertEqual(after,dict(original,implementation_status='blocked',health_status='unverified'))
    def test_every_identity_authority_pointer_and_query_field_drift_refuses(self):
        for field in self.columns:
            if field in ('id','implementation_status','health_status'):continue
            with self.subTest(field=field):
                self.db.execute('SAVEPOINT drift');self.db.execute('UPDATE api_endpoints SET '+field+'=? WHERE id=253',('unexpected',));before=self.rows()
                with self.assertRaises(ValueError):m.reconcile(self.db)
                self.assertEqual(before,self.rows());self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')
    def test_missing_declaration_refuses_all(self):
        self.db.execute('DELETE FROM api_endpoints WHERE id=253');before=self.rows()
        with self.assertRaisesRegex(ValueError,'Missing'):m.reconcile(self.db)
        self.assertEqual(before,self.rows())
    def test_invalid_health_state_refuses(self):
        self.db.execute("UPDATE api_endpoints SET health_status='unverified' WHERE id=251");before=self.rows()
        with self.assertRaisesRegex(ValueError,'status'):m.reconcile(self.db)
        self.assertEqual(before,self.rows())
    def test_unreviewed_trigger_refuses_before_changes(self):
        self.db.execute("CREATE TRIGGER surprising AFTER UPDATE ON api_endpoints BEGIN UPDATE api_endpoints SET permission_key='invented' WHERE id=3000; END")
        before=self.rows()
        with self.assertRaisesRegex(ValueError,'trigger'):m.reconcile(self.db)
        self.assertEqual(before,self.rows())
    def test_later_sql_failure_rolls_back_all_updates(self):
        before=self.rows();self.db.fail_id=251
        with self.assertRaisesRegex(sqlite3.OperationalError,'Injected'):m.reconcile(self.db)
        self.assertEqual(before,self.rows())
    def test_preserves_callers_outer_transaction_on_rejection(self):
        self.db.execute('CREATE TABLE caller_work(value TEXT)');self.db.execute("INSERT INTO caller_work VALUES('keep')")
        self.db.execute("UPDATE api_endpoints SET permission_key='new-authority' WHERE id=252")
        with self.assertRaises(ValueError):m.reconcile(self.db)
        self.assertTrue(self.db.in_transaction);self.assertEqual(self.db.execute('SELECT value FROM caller_work').fetchone()[0],'keep')
    def test_source_evidence_drift_refuses_before_db_changes(self):
        before=self.rows()
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(ValueError,'evidence changed'):m.reconcile(self.db,Path(directory))
        self.assertEqual(before,self.rows())
    def test_manifest_cannot_promote_blockers_or_change_reasons(self):
        import json,shutil
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory)
            for path in list(m.SOURCE_HASHES)+['docs/api/method-capture-blocker-package.json']:
                target=root/path;target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(m.ROOT/path,target)
            target=root/'docs/api/method-capture-blocker-package.json';package=json.loads(target.read_text());package['resolvedOperations']=4;target.write_text(json.dumps(package))
            before=self.rows()
            with self.assertRaisesRegex(ValueError,'counting provenance'):m.reconcile(self.db,root)
            self.assertEqual(before,self.rows())
    def test_future_schema_field_refuses(self):
        self.db.execute('ALTER TABLE api_endpoints ADD COLUMN future_authority TEXT');before=self.rows()
        with self.assertRaisesRegex(ValueError,'schema'):m.reconcile(self.db)
        self.assertEqual(before,self.rows())

if __name__=='__main__':unittest.main()
