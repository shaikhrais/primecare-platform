"""Billing retirement refuses contract/caller drift and retains dependent identities."""
import importlib.util,json,sqlite3,unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('billing',Path(__file__).with_name('reconcile-client-billing-declarations.py'))
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
class Tests(unittest.TestCase):
 def setUp(self):
  self.db=sqlite3.connect(':memory:');self.db.execute('PRAGMA foreign_keys=ON')
  self.db.execute('CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,'+','.join(k+' '+('INTEGER' if isinstance(v,int) else 'TEXT') for k,v in m.LEGACY_IDENTITY.items())+',implementation_status TEXT,health_status TEXT)')
  for t in ['screen_api_links','screen_api_map','api_permissions']:self.db.execute('CREATE TABLE '+t+'(api_id INTEGER REFERENCES api_endpoints(id))')
  for aid,path,f in m.CANONICAL:
   req,res=m.expected_contract(path,f)
   self.db.execute('INSERT INTO api_endpoints(id,route_path,http_method,service_name,auth_required,permission_key,request_schema,response_schema,implementation_status,app_id,endpoint_code) VALUES(?,?,?,?,?,?,?,?,?,?,?)',(aid,path,'GET','client',1,'authenticated_client_profile_owner',json.dumps(req),json.dumps(res),'implemented',6,'CLIENT_SELF_INVOICES' if aid==16432 else 'CLIENT_SELF_INVOICE_DETAIL'))
  fields=list(m.LEGACY_IDENTITY)+['implementation_status','health_status']
  self.db.execute('INSERT INTO api_endpoints(id,'+','.join(fields)+') VALUES('+','.join('?' for _ in range(len(fields)+1))+')',[248,*m.LEGACY_IDENTITY.values(),'active','healthy']);self.db.commit()
 def tearDown(self):self.db.close()
 def test_retirement_preserves_references_and_is_idempotent(self):
  m.reconcile(self.db);self.assertEqual(self.db.execute('SELECT implementation_status FROM api_endpoints WHERE id=248').fetchone(),('retired',))
  self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
  before='\n'.join(self.db.iterdump());m.reconcile(self.db);self.assertEqual(before,'\n'.join(self.db.iterdump()))
 def test_caller_and_legacy_contract_drift_refused(self):
  for t in ['screen_api_links','screen_api_map']:
   self.db.execute('INSERT INTO '+t+' VALUES(248)')
   with self.assertRaisesRegex(ValueError,'endpoint reference'):m.reconcile(self.db)
   self.db.execute('DELETE FROM '+t)
  for col,val in [('route_path','/changed'),('http_method','GET'),('permission_key','write_feedback'),('request_schema','{}'),('response_schema','{}')]:
   self.db.execute('SAVEPOINT drift');self.db.execute('UPDATE api_endpoints SET '+col+'=? WHERE id=248',(val,))
   with self.assertRaises(ValueError):m.reconcile(self.db)
   self.assertEqual(self.db.execute('SELECT implementation_status FROM api_endpoints WHERE id=248').fetchone(),('active',))
   self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')
 def test_exact_canonical_identity_authority_and_dto_required(self):
  for aid,_,_ in m.CANONICAL:
   for col,val in [('app_id',1),('endpoint_code','wrong'),('implementation_status','active'),('id',90000),('service_name','billing'),('auth_required',0),('permission_key','admin'),('request_schema','{}'),('response_schema','{"type":"object"}'),('response_schema','bad')]:
    self.db.execute('SAVEPOINT drift');self.db.execute('UPDATE api_endpoints SET '+col+'=? WHERE id=?',(val,aid))
    with self.assertRaises(ValueError):m.reconcile(self.db)
    self.assertEqual(self.db.execute('SELECT implementation_status FROM api_endpoints WHERE id=248').fetchone(),('active',))
    self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')
 def test_all_source_pointer_and_state_mutations_refused(self):
  mutations=[(k,777 if v is None or isinstance(v,int) else 'changed') for k,v in m.LEGACY_IDENTITY.items()]+[('implementation_status','implemented'),('health_status','unverified')]
  for col,val in mutations:
   with self.subTest(column=col):
    self.db.execute('SAVEPOINT drift');self.db.execute('UPDATE api_endpoints SET '+col+'=? WHERE id=248',(val,))
    with self.assertRaises(ValueError):m.reconcile(self.db)
    self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')
 def test_future_endpoint_references_refused_but_registry_domain_preserved(self):
  for table,column,ddl in [('future_links','api_id','api_id INTEGER'),('future_fk','endpoint_id','endpoint_id INTEGER REFERENCES api_endpoints(id)')]:
   self.db.execute('CREATE TABLE '+table+'('+ddl+')');self.db.execute('INSERT INTO '+table+' VALUES(248)')
   with self.assertRaisesRegex(ValueError,'endpoint reference'):m.reconcile(self.db)
   self.db.execute('DROP TABLE '+table)
  self.db.execute('CREATE TABLE api_registry(id INTEGER PRIMARY KEY)');self.db.execute('INSERT INTO api_registry VALUES(248)')
  self.db.execute('CREATE TABLE registry_links(api_id INTEGER REFERENCES api_registry(id))');self.db.execute('INSERT INTO registry_links VALUES(248)')
  m.reconcile(self.db);self.assertEqual(self.db.execute('SELECT * FROM registry_links').fetchall(),[(248,)])
  self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
 def test_path_references_and_triggers_refused(self):
  for col in ['route_path','endpoint_path']:
   self.db.execute('CREATE TABLE future_path('+col+' TEXT)');self.db.execute('INSERT INTO future_path VALUES(?)',(m.LEGACY[1],))
   with self.assertRaisesRegex(ValueError,'route reference'):m.reconcile(self.db)
   self.db.execute('DROP TABLE future_path')
  self.db.execute('CREATE TRIGGER unsafe AFTER UPDATE ON api_endpoints BEGIN UPDATE api_endpoints SET auth_required=0; END')
  with self.assertRaisesRegex(ValueError,'trigger'):m.reconcile(self.db)
  self.assertEqual(self.db.execute('SELECT auth_required FROM api_endpoints WHERE id=248').fetchone(),(1,))
 def test_only_exact_closed_generated_diagnostic_preserved(self):
  self.db.execute('CREATE TABLE governance_findings(finding_category TEXT,finding_code TEXT,status TEXT,related_screen_id INTEGER,related_file_id INTEGER,description TEXT,related_api_id INTEGER REFERENCES api_endpoints(id))')
  expected=('drift','missing_test_coverage','closed',None,None,'API Endpoint POST '+m.LEGACY[1]+' is missing verification test proof.',248)
  self.db.execute('INSERT INTO governance_findings VALUES(?,?,?,?,?,?,?)',expected)
  for col,val in [('finding_category','security'),('finding_code','permission'),('status','open'),('related_screen_id',1),('related_file_id',1),('description','different')]:
   self.db.execute('SAVEPOINT drift');self.db.execute('UPDATE governance_findings SET '+col+'=?',(val,))
   with self.assertRaisesRegex(ValueError,'unreviewed diagnostic'):m.reconcile(self.db)
   self.db.execute('ROLLBACK TO drift');self.db.execute('RELEASE drift')
  m.reconcile(self.db);self.assertEqual(self.db.execute('SELECT * FROM governance_findings').fetchall(),[expected])
  self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
if __name__=='__main__':unittest.main()
