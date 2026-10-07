import importlib.util,json,sqlite3,unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('quarantine',Path(__file__).with_name('quarantine-api-grants.py'))
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class QuarantineTest(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:');self.db.row_factory=sqlite3.Row
        self.db.executescript('''
        create table roles(id integer primary key);insert into roles values(1);
        create table runtime_artifacts(id integer primary key);insert into runtime_artifacts values(1);
        create table api_endpoints(id integer primary key,endpoint_code text,http_method text,route_path text,permission_key text);
        insert into api_endpoints values(1,'actual','GET','/actual','explicit');
        insert into api_endpoints values(3,'same','GET','/same','explicit');
        create table api_endpoint_registry(id integer primary key,api_id integer,endpoint_code text,method text,endpoint_path text);
        insert into api_endpoint_registry values(1,100,'other','GET','/other');
        insert into api_endpoint_registry values(2,101,'missing','GET','/missing');
        insert into api_endpoint_registry values(3,102,'same','GET','/same');
        create table api_permissions(id integer primary key autoincrement,api_id integer not null,role_id integer not null,runtime_artifact_id integer,permission_key text not null,can_access integer default 1,created_at text default current_timestamp,
        foreign key(api_id) references api_endpoints(id) on delete cascade,
        foreign key(role_id) references roles(id) on delete cascade,
        foreign key(runtime_artifact_id) references runtime_artifacts(id) on delete set null,unique(api_id,role_id));
        insert into api_permissions values(11,1,1,1,'api_permission_other',1,'exact timestamp');
        insert into api_permissions values(12,2,1,null,'api_permission_missing',1,null);
        insert into api_permissions values(13,3,1,1,'api_permission_same',1,'keep');
        ''')
    def tearDown(self):self.db.close()
    def plan(self):return m.preflight(self.db)[0]
    def test_exact_preservation_and_idempotency(self):
        original=[dict(r) for r in self.db.execute('select * from api_permissions where id in (11,12) order by id')]
        schema=m.validate_schema(self.db);p=self.plan();self.assertEqual(p['candidateRows'],2)
        result=m.apply(self.db,p['planDigest']);self.assertEqual(result['quarantinedRows'],2)
        stored=[json.loads(r[0]) for r in self.db.execute('select source_json from api_permission_quarantine order by source_id')]
        self.assertEqual(stored,original);self.assertEqual(m.validate_schema(self.db),schema)
        self.assertEqual(self.db.execute('select id from api_permissions').fetchone()[0],13)
        self.assertEqual(m.apply(self.db,p['planDigest'])['quarantinedRows'],0)
        self.assertEqual(self.db.execute('pragma foreign_keys').fetchone()[0],1)
        self.assertEqual(list(self.db.execute('pragma foreign_key_check')),[])
    def test_rollback_preserves_every_row_and_no_quarantine_table(self):
        p=self.plan()
        with self.assertRaisesRegex(RuntimeError,'Injected'):m.apply(self.db,p['planDigest'],fail_after=1)
        self.assertEqual(self.db.execute('select count(*) from api_permissions').fetchone()[0],3)
        self.assertIsNone(self.db.execute("select name from sqlite_master where name='api_permission_quarantine'").fetchone())
    def test_stale_plan_rejected(self):
        p=self.plan();self.db.execute("update api_permissions set can_access=0 where id=11");self.db.commit()
        with self.assertRaisesRegex(ValueError,'changed'):m.apply(self.db,p['planDigest'])
        self.assertEqual(self.db.execute('select count(*) from api_permissions').fetchone()[0],3)
    def test_unknown_key_origin_not_deleted(self):
        self.db.execute("update api_permissions set permission_key='unreviewed' where id=11");self.db.commit()
        p=self.plan();self.assertEqual(p['candidateRows'],1);m.apply(self.db,p['planDigest'])
        self.assertEqual(self.db.execute('select permission_key from api_permissions where id=11').fetchone()[0],'unreviewed')
    def test_incoming_fk_denied(self):
        self.db.execute('create table dependent(grant_id references api_permissions(id))')
        with self.assertRaisesRegex(ValueError,'Incoming'):self.plan()
    def test_unreviewed_trigger_denied(self):
        self.db.execute('create trigger keep_grants before delete on api_permissions begin select 1; end')
        with self.assertRaisesRegex(ValueError,'triggers'):self.plan()
    def test_changed_state_after_apply_not_accepted_as_idempotent(self):
        p=self.plan();m.apply(self.db,p['planDigest'])
        self.db.execute('update api_permissions set can_access=0');self.db.commit()
        with self.assertRaisesRegex(ValueError,'state changed'):m.apply(self.db,p['planDigest'])
    def test_runtime_consumer_gate(self):
        import tempfile
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);(root/'services').mkdir();(root/'services'/'runtime.dart').write_text('SELECT * FROM api_permissions')
            with self.assertRaisesRegex(ValueError,'Runtime consumers'):m.consumer_preflight(root)

if __name__=='__main__':unittest.main()
