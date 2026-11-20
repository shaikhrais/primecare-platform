"""Offline metadata contract tests; this fixture cannot connect to production."""
import importlib.util,json,os,sqlite3,sys,unittest
from pathlib import Path
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(Path(__file__).parent))
import ems_registration as ems
SPECS={
 'roles':'id INTEGER,role_code TEXT,active INTEGER',
 'apps':'id INTEGER,app_code TEXT',
 'screens':'id INTEGER,app_id INTEGER,role_id INTEGER,screen_code TEXT,screen_name TEXT,route_path TEXT,actual_file_path TEXT,stage TEXT,active INTEGER,implementation_tag TEXT,content_tag TEXT,api_tag TEXT,test_tag TEXT',
 'role_screen_permissions':'id INTEGER,role_id INTEGER,screen_id INTEGER,can_view INTEGER,can_create INTEGER,can_edit INTEGER,can_delete INTEGER,can_export INTEGER',
 'api_endpoints':'id INTEGER,app_id INTEGER,endpoint_code TEXT,route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,implementation_status TEXT,permission_key TEXT,request_schema TEXT,response_schema TEXT,rate_limit_key TEXT,uses_pagination INTEGER',
 'api_permissions':'id INTEGER,role_id INTEGER,api_id INTEGER,can_access INTEGER,permission_key TEXT',
 'screen_api_links':'id INTEGER,screen_id INTEGER,api_id INTEGER,purpose TEXT',
}
class Fixture:
 def __init__(self):
  self.conn=sqlite3.connect(':memory:');self.db=self;self.pin={'emsRegistrationWriter':ems.scope()};self.tables={}
  for table,spec in SPECS.items():
   self.conn.execute('CREATE TABLE '+table+' (_primecare_import_row INTEGER PRIMARY KEY,'+spec+')')
   self.tables[table]={'columns':[{'name':field.split()[0]} for field in spec.split(',')]}
  self.conn.execute("INSERT INTO roles VALUES(0,72,'code_admin',1)");self.conn.execute("INSERT INTO apps VALUES(0,20,'go'),(1,21,'gv')");self.conn.commit()
 def table(self,name):return name
 def _value(self,table,column,value):return value
 def execute(self,sql,args=()):
  if sql.startswith('LOCK TABLE '):return self.conn.execute('SELECT 1')
  return self.conn.execute(sql.replace('%s','?'),args)
 def counts(self):return [self.conn.execute('SELECT COUNT(*) FROM '+table).fetchone()[0] for table in SPECS]
class RegistrationTest(unittest.TestCase):
 def setUp(self):self.store=Fixture();self.env=patch.dict(os.environ,{'GOVERNANCE_EMS_REGISTRATION_WRITES':'1'});self.env.start();self.addCleanup(self.env.stop);self.addCleanup(self.store.conn.close)
 def test_exact_read_only_registration_is_idempotent_and_does_not_assign_accounts(self):
  first=ems.register(self.store);counts=self.store.counts();self.assertEqual(ems.register(self.store),first);self.assertEqual(self.store.counts(),counts)
  self.assertEqual(len(first['apiIds']),6);self.assertFalse(first['productionVerified'])
  self.assertEqual(self.store.execute('SELECT can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions').fetchall(),[(1,0,0,0,0)])
  self.assertEqual(self.store.execute('SELECT DISTINCT role_id FROM api_permissions').fetchall(),[(72,)])
  self.assertEqual(self.store.execute('SELECT DISTINCT http_method,auth_required,service_name,permission_key FROM api_endpoints').fetchall(),[('GET',1,'governance','role_screen_permissions')])
  for request,response in self.store.execute('SELECT request_schema,response_schema FROM api_endpoints').fetchall():self.assertEqual(json.loads(request)['type'],'object');self.assertEqual(json.loads(response)['type'],'object')
 def test_wrong_scope_or_missing_opt_in_cannot_insert(self):
  before=self.store.counts()
  with patch.dict(os.environ,{'GOVERNANCE_EMS_REGISTRATION_WRITES':'0'}):
   with self.assertRaises(ems.GovernanceReadError):ems.register(self.store)
  self.store.pin['emsRegistrationWriter']['definitionSha256']='0'*64
  with self.assertRaises(ems.GovernanceReadError):ems.register(self.store)
  self.assertEqual(self.store.counts(),before)
 def test_conflicts_are_preserved_instead_of_overwriting_authority(self):
  ems.register(self.store);self.store.execute('UPDATE role_screen_permissions SET can_edit=1')
  with self.assertRaises(ems.GovernanceReadError):ems.register(self.store)
  self.assertEqual(self.store.execute('SELECT can_edit FROM role_screen_permissions').fetchone()[0],1)
 def test_failed_registration_can_rollback_every_insert(self):
  before=self.store.counts();self.store.conn.execute('BEGIN')
  original=self.store.execute
  def fail(sql,args=()):
   if sql.startswith('SELECT id,app_id,endpoint_code'):raise ems.GovernanceReadError('Fixture injected failure')
   return original(sql,args)
  self.store.execute=fail
  with self.assertRaises(ems.GovernanceReadError):ems.register(self.store)
  self.store.conn.rollback();self.assertEqual(self.store.counts(),before)
if __name__=='__main__':unittest.main()
