import importlib.util, json, pathlib, tempfile, unittest, sqlite3
ROOT=pathlib.Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('production_reader',ROOT/'production_reader.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
pin=json.loads((ROOT/'production-pin.json').read_text());schema=pin['schema']
class ReaderTests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory();self.file=pathlib.Path(self.temp.name)/'fixture.json'
  columns=[{'name':'id','declared_type':'INTEGER','storage_types':['integer']},{'name':'role_code','declared_type':'TEXT','storage_types':['text']},{'name':'note','declared_type':'TEXT','storage_types':[]}]
  m={'tables':[{'name':'roles','columns':columns}],'sqlite_objects':[['table','roles','roles','CREATE TABLE roles(id INTEGER,role_code TEXT,note TEXT)']]}
  q=lambda s:"'"+s.replace("'","''")+"'"
  setup=['CREATE SCHEMA '+schema,'CREATE TABLE '+schema+'.govt_source_manifest(manifest_sha256 text,manifest jsonb)','INSERT INTO '+schema+'.govt_source_manifest VALUES('+q(pin['manifestSha256'])+','+q(json.dumps(m))+')','CREATE TABLE '+schema+'.govt_roles(id bigint,role_code text,note jsonb)',"INSERT INTO "+schema+".govt_roles VALUES(1,'ceo','{\"t\":\"null\",\"v\":null}'),(2,'rn','{\"t\":\"null\",\"v\":null}')"]
  self.file.write_text(json.dumps({'setup':setup}));self.db=module.connect(_test_fixture=self.file)
 def tearDown(self):self.db.close();self.temp.cleanup()
 def test_live_queries_and_parameter_order(self):
  self.db.row_factory=sqlite3.Row
  r=self.db.execute("SELECT id,role_code roleCode,COALESCE(note,'empty') note FROM roles WHERE id=?",(1,)).fetchone()
  self.assertEqual(dict(r),{'id':1,'roleCode':'ceo','note':'empty'});self.assertEqual(r[0],1)
  sql,args=self.db.compile('SELECT a.id FROM roles a JOIN roles b ON a.id=b.id WHERE a.id=? AND b.role_code=?',(2,'rn'))
  self.assertIn('govt_roles',sql);self.assertEqual(args,[2,'rn']);self.assertEqual(self.db.execute('SELECT id FROM govt_roles WHERE id=?',(2,)).fetchone()[0],2)
 def test_catalog_and_readonly(self):
  self.assertEqual(self.db.execute('PRAGMA table_info(roles)').fetchone()[1],'id')
  self.assertEqual(self.db.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchone()[0],'roles')
  for q in ["UPDATE roles SET role_code='bad'",'SELECT * FROM public.users','SELECT * FROM unregistered', 'SELECT * FROM unregistered WHERE EXISTS (WITH unregistered AS (SELECT id FROM roles) SELECT id FROM unregistered)']:
   with self.assertRaises(module.GovernanceReadError):self.db.execute(q)
  self.assertEqual(self.db.execute('SELECT count(*) FROM roles').fetchone()[0],2)
 def test_scoped_ctes(self):
  self.assertEqual(self.db.execute('WITH allowed AS (SELECT id FROM roles) SELECT COUNT(*) FROM allowed').fetchone()[0],2)
 def test_no_sqlite_substring_routing(self):
  self.assertEqual(self.db.execute("SELECT count(*) FROM roles WHERE 'sqlite_master'='sqlite_master'").fetchone()[0],2)
if __name__=='__main__':unittest.main()
