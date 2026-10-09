import importlib.util,json,sqlite3,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
spec=importlib.util.spec_from_file_location('audit',Path(__file__).with_name('reconcile_governance_screens.py'))
m=importlib.util.module_from_spec(spec);import sys;sys.modules[spec.name]=m;spec.loader.exec_module(m)

class ScreenAuditTest(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.root=Path(self.tmp.name)
        renderer=self.root/m.WORKSPACE_RENDERER;renderer.parent.mkdir(parents=True)
        self.original=(m.ROOT/m.WORKSPACE_RENDERER).read_text();renderer.write_text(self.original)
        self.registry=self.root/'cloudflare/workers/src/workspace-registry.json';self.registry.parent.mkdir(parents=True)
        self.page={'code':'example','route':'/example','sections':[{'code':'example_header','name':'Header Section','testId':'section-example_header'}]}
        self.save_registry()
        self.screen={'id':1,'screen_code':'example','route_path':'/example','actual_file_path':m.WORKSPACE_RENDERER}
    def tearDown(self):self.tmp.cleanup()
    def save_registry(self):self.registry.write_text(json.dumps({'screens':[self.page]}))
    def test_reviewed_returned_section_rendering_is_recognized(self):
        self.assertEqual(m.dynamic_sections(self.root,self.screen,['Header Section'],self.original),['Header Section'])
    def test_dead_or_unrendered_iteration_rejected(self):
        for changed in [self.original.replace('for (final section in list(page[\'sections\'])) _section(page, section, overview, pages),',''),self.original.replace("return _card(section['name'].toString()", "return Text(section['name'].toString()")]:
            self.assertEqual(m.dynamic_sections(self.root,self.screen,['Header Section'],changed),[])
    def test_unknown_section_and_wrong_route_rejected(self):
        self.assertEqual(m.dynamic_sections(self.root,self.screen,['Unknown'],self.original),[])
        self.page['route']='/other';self.save_registry()
        self.assertEqual(m.dynamic_sections(self.root,self.screen,['Header Section'],self.original),[])
    def test_duplicate_or_unidentified_registry_sections_rejected(self):
        self.page['sections'].append(dict(self.page['sections'][0]));self.save_registry()
        self.assertEqual(m.dynamic_sections(self.root,self.screen,['Header Section'],self.original),[])
        self.page['sections']=self.page['sections'][:1];self.page['sections'][0]['testId']='incorrect';self.save_registry()
        self.assertEqual(m.dynamic_sections(self.root,self.screen,['Header Section'],self.original),[])
    def test_archive_preserves_original_and_never_promotes_readiness(self):
        dbpath=self.root/'derived.db';db=sqlite3.connect(dbpath)
        db.executescript('create table screens(id integer primary key,screen_code text,route_path text,actual_file_path text,active integer,component_summary text,section_summary text,completeness_score integer,production_ready integer);create table screen_sections(screen_id integer,section_name text,required integer,section_order integer);')
        db.execute('insert into screens values(1,?,?,?,?,?,?,?,?)',('example','/example',m.WORKSPACE_RENDERER,1,'old','old',0,1));db.execute("insert into screen_sections values(1,'Header Section',1,1)");db.commit();original=db.execute('select * from screens').fetchone();db.close()
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}):
            self.assertEqual(m.reconcile(dbpath,False,None),1)
            self.assertEqual(m.reconcile(dbpath,True,None),0)
            self.assertEqual(m.reconcile(dbpath,False,None),0)
            self.assertEqual(m.reconcile(dbpath,True,None),0)
        db=sqlite3.connect(dbpath);db.row_factory=sqlite3.Row
        self.assertEqual(db.execute('select production_ready from screens').fetchone()[0],0)
        archives=db.execute('select original_row_json from screen_metadata_reconciliation_archive').fetchall();self.assertEqual(len(archives),1)
        archived=json.loads(archives[0][0]);self.assertEqual(archived['component_summary'],'old');self.assertEqual(archived['production_ready'],1)
        self.assertEqual(db.execute('select section_summary from screens').fetchone()[0],'Header Section')
        db.execute('insert or replace into screens values(?,?,?,?,?,?,?,?,?)',original)
        db.execute("update screen_metadata_reconciliation_archive set original_row_json='{}'");db.commit();db.close()
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}):
            with self.assertRaisesRegex(ValueError,'provenance conflict'):m.reconcile(dbpath,True,None)
    def test_correction_failure_rolls_back_archive_and_metadata(self):
        path=self.root/'rollback.db';db=sqlite3.connect(path)
        db.executescript("create table screens(id integer primary key,screen_code text,route_path text,actual_file_path text,active integer,component_summary text,section_summary text,completeness_score integer,production_ready integer);create table screen_sections(screen_id integer,section_name text,required integer,section_order integer);")
        db.execute('insert into screens values(1,?,?,?,?,?,?,?,?)',('example','/example',m.WORKSPACE_RENDERER,1,'old','old',0,0))
        db.execute("insert into screen_sections values(1,'Header Section',1,1)")
        db.execute("create trigger reject_update before update on screens begin select raise(abort,'injected failure'); end")
        db.commit();db.close()
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}):
            with self.assertRaisesRegex(ValueError,'Unreviewed.*trigger'):m.reconcile(path,True,None)
        db=sqlite3.connect(path)
        self.assertEqual(db.execute('select component_summary from screens').fetchone()[0],'old')
        self.assertIsNone(db.execute("select name from sqlite_master where name='screen_metadata_reconciliation_archive'").fetchone())
        db.execute('drop trigger reject_update');db.commit();db.close()
        original_connect=sqlite3.connect
        class FaultyConnection(sqlite3.Connection):
            def execute(self,sql,*args,**kwargs):
                if sql.startswith('UPDATE screens SET'):raise sqlite3.OperationalError('injected update failure')
                return super().execute(sql,*args,**kwargs)
        def faulty_connect(*args,**kwargs):return original_connect(*args,**kwargs,factory=FaultyConnection)
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}),patch.object(m.sqlite3,'connect',side_effect=faulty_connect):
            with self.assertRaisesRegex(sqlite3.OperationalError,'injected update'):m.reconcile(path,True,None)
        db=sqlite3.connect(path);self.assertEqual(db.execute('select component_summary from screens').fetchone()[0],'old')
        self.assertIsNone(db.execute("select name from sqlite_master where name='screen_metadata_reconciliation_archive'").fetchone());db.close()
    def test_concurrent_metadata_change_is_rejected_before_archive(self):
        path=self.root/'concurrent.db';db=sqlite3.connect(path)
        db.executescript("create table screens(id integer primary key,screen_code text,route_path text,actual_file_path text,active integer,component_summary text,section_summary text,completeness_score integer,production_ready integer);create table screen_sections(screen_id integer,section_name text,required integer,section_order integer);")
        db.execute('insert into screens values(1,?,?,?,?,?,?,?,?)',('example','/example',m.WORKSPACE_RENDERER,1,'old','old',0,0));db.commit();db.close()
        inspect=m.inspect_screen
        def concurrent(*args):
            result=inspect(*args)
            other=sqlite3.connect(path);other.execute("update screens set component_summary='concurrent' where id=1");other.commit();other.close();return result
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}),patch.object(m,'inspect_screen',side_effect=concurrent):
            with self.assertRaisesRegex(ValueError,'changed before archive lock'):m.reconcile(path,True,None)
        db=sqlite3.connect(path);self.assertEqual(db.execute('select component_summary from screens').fetchone()[0],'concurrent')
        self.assertIsNone(db.execute("select name from sqlite_master where name='screen_metadata_reconciliation_archive'").fetchone());db.close()
    def test_archive_schema_drift_rejected(self):
        path=self.root/'schema.db';db=sqlite3.connect(path)
        db.executescript("create table screens(id integer primary key,screen_code text,route_path text,actual_file_path text,active integer,component_summary text,section_summary text,completeness_score integer,production_ready integer);create table screen_sections(screen_id integer,section_name text,required integer,section_order integer);create table screen_metadata_reconciliation_archive(screen_id integer);")
        db.execute('insert into screens values(1,?,?,?,?,?,?,?,?)',('example','/example',m.WORKSPACE_RENDERER,1,'old','old',0,0));db.commit();db.close()
        with patch.object(m,'ROOT',self.root),patch.object(m,'pom_routes',return_value={'/example'}):
            with self.assertRaisesRegex(ValueError,'archive schema'):m.reconcile(path,True,None)
    def test_tracked_seed_cannot_be_written(self):
        with self.assertRaisesRegex(ValueError,'immutable'):m.reconcile(m.DEFAULT_DB,True,None)
    def test_generic_missing_section_remains_failure(self):
        screen=dict(self.screen);screen['actual_file_path']='generic.dart'
        (self.root/'generic.dart').write_text('class ExampleScreen extends Widget { Widget build() { return Text("Example"); } }')
        result=m.inspect_screen(self.root,screen,['Header Section'],{'/example'})
        self.assertIn('sections_not_rendered:1',result.issues)

if __name__=='__main__':unittest.main()
