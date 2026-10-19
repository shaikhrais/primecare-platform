import copy,json,sqlite3,tempfile,unittest
from pathlib import Path
from progress import SqliteProgressStore,digest,evaluate,report,capture_browser_evidence
class ProgressTests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup);self.root=Path(self.temp.name);(self.root/'source.ts').write_text('version one')
  self.task=dict(id='synthetic-scope',title='Synthetic test',kind='engineering',implementation='implemented',scope='component test only',evidence='result.json',expected_cases=1,required_sources=['source.ts'],required_flags=['checked'])
  self.receipt=dict(passed=True,wholeTaskVerified=False,scope='component test only',cases=[{'checked':True}],sources={'source.ts':digest(self.root/'source.ts')});self.write()
 def write(self):(self.root/'result.json').write_text(json.dumps(self.receipt))
 def test_current_scope_never_completes_a_workflow(self):
  r=evaluate(self.task,self.root);self.assertEqual(r['status'],'scoped_tested');self.assertFalse(r['whole_workflow_verified']);self.assertEqual(report([self.task],self.root)['summary']['fully_verified_workflows'],0)
 def test_changed_or_missing_evidence_loses_credit(self):
  (self.root/'source.ts').write_text('changed');self.assertEqual(evaluate(self.task,self.root)['status'],'implemented_unverified');(self.root/'result.json').unlink();self.assertEqual(evaluate(self.task,self.root)['status'],'implemented_unverified')
 def test_wrong_scope_case_count_or_missing_acceptance_flag_cannot_pass(self):
  original=copy.deepcopy(self.receipt)
  for patch in [{'scope':'whole duty'},{'cases':[]},{'cases':[{'checked':False}]},{'wholeTaskVerified':True},{'passed':False},{'sources':{}}]:
   self.receipt={**original,**patch};self.write();self.assertNotEqual(evaluate(self.task,self.root)['status'],'scoped_tested')
 def test_planned_work_and_dependencies_are_distinct(self):
  task=dict(id='next',kind='engineering',implementation='pending',depends_on=['missing'])
  self.assertEqual(report([task],self.root)['tasks'][0]['status'],'blocked');task.pop('depends_on');self.assertEqual(report([task],self.root)['tasks'][0]['status'],'pending')
 def test_dependency_can_clear_without_promoting_a_registered_workflow(self):
  task=dict(id='workflow',kind='registered_workflow',implementation='unverified',depends_on=[self.task['id']]);rows=report([task,self.task],self.root)['tasks'];self.assertEqual(rows[0]['status'],'pending');self.assertFalse(rows[0]['whole_workflow_verified'])
 def test_cycles_and_outside_paths_fail_closed(self):
  task={**self.task,'evidence':'../outside.json'};self.assertNotEqual(evaluate(task,self.root)['status'],'scoped_tested');task={**self.task,'depends_on':[self.task['id']]};self.assertEqual(report([task],self.root)['tasks'][0]['status'],'blocked')
 def test_valid_browser_receipt_and_recording_can_be_preserved(self):
  (self.root/'diagnostic.webm').write_bytes(b'synthetic component fixture');task={**self.task,'run_evidence':'result.json','evidence':'preserved/report.json','run_video':'diagnostic.webm','diagnostic_video':'preserved/video.webm'};capture_browser_evidence([task],self.root);self.assertEqual((self.root/'preserved/report.json').read_bytes(),(self.root/'result.json').read_bytes());self.assertEqual(evaluate(task,self.root)['status'],'scoped_tested')
 def test_stale_browser_receipt_cannot_replace_preserved_evidence(self):
  (self.root/'prior.json').write_text('preserved');(self.root/'source.ts').write_text('changed');task={**self.task,'run_evidence':'result.json','evidence':'prior.json'}
  with self.assertRaises(RuntimeError):capture_browser_evidence([task],self.root)
  self.assertEqual((self.root/'prior.json').read_text(),'preserved')
 def test_database_preserves_unrelated_business_data(self):
  db=sqlite3.connect(':memory:');db.execute('CREATE TABLE business_record(value)');db.execute("INSERT INTO business_record VALUES('preserved')");store=SqliteProgressStore(db);store.register([self.task]);result=report(store.tasks(),self.root);store.snapshot(result);self.assertEqual(db.execute('SELECT value FROM business_record').fetchone()[0],'preserved');self.assertEqual(len(store.tasks()),1);db.close()
if __name__=='__main__':unittest.main()
