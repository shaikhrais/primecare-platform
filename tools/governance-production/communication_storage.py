"""Register exact storage design first, then create and validate native empty tables."""
import hashlib,json,os,re,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
DEFINITION=Path(__file__).with_name('communication-storage-registration.json')
TABLES={'db_schema_tables':'id','db_schema_columns':'id','database_rebuild_baselines':None}
def definition():return json.loads(DEFINITION.read_text())
def migration_sql():
 d=definition();raw=(ROOT/d['migrationPath']).read_bytes()
 if hashlib.sha256(raw).hexdigest()!=d['migrationSha256']:raise GovernanceReadError('Storage migration differs from registered hash')
 return raw.decode()
def expected_scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_COMMUNICATION_STORAGE_WRITES',tables=sorted(TABLES),definitionSha256=hashlib.sha256(DEFINITION.read_bytes()).hexdigest(),migrationSha256=d['migrationSha256'],businessTables=sorted(d['tables']),schemaChanges=False,businessDataWrites=False,roleGrants=False,activation=False)
class CommunicationStorageStore(ProductionWorkflowStore):
 definition_reader=staticmethod(definition)
 migration_reader=staticmethod(migration_sql)
 scope_reader=staticmethod(expected_scope)
 pin_key='communicationStorageWriter'
 opt_in='GOVERNANCE_COMMUNICATION_STORAGE_WRITES'
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get(self.pin_key)!=self.scope_reader() or os.environ.get(self.opt_in)!='1':raise GovernanceReadError('Exact storage registration scope and opt-in required')
   self.migration_reader()
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in TABLES:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing or mixed storage metadata')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Physical storage metadata differs from manifest')
  except Exception:self.db.rollback();self.db.close();raise
 def ensure_exact(self,table,key,values,apply):
  if table not in TABLES:raise GovernanceReadError('Unrelated storage metadata refused')
  d=self.definition_reader()
  if table=='db_schema_tables':
   if set(key)!={'table_name'} or key['table_name'] not in d['tables'] or values!={'app_id':self.app_id(),'table_type':'table','status':'registered-unimplemented'}:raise GovernanceReadError('Exact storage table design required')
  elif table=='db_schema_columns':
   if set(key)!={'table_id','column_name'}:raise GovernanceReadError('Exact storage column key required')
   parent=self.execute('SELECT table_name FROM db_schema_tables WHERE id=?',(key['table_id'],)).fetchall()
   column=next((c for c in d['tables'].get(parent[0][0],[]) if c['column_name']==key['column_name']),None) if len(parent)==1 else None
   if not column or values!={k:v for k,v in column.items() if k!='column_name'}:raise GovernanceReadError('Exact storage column design required')
  elif key!={'name':d['baseline']} or values!=self.baseline_values():raise GovernanceReadError('Exact storage baseline required')
  identity=TABLES[table] or 'name';fields=list(values)
  rows=self.execute('SELECT '+identity+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if len(rows)>1 or rows and tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('Edited or duplicate storage metadata preserved')
  if rows:return rows[0][0]
  if not apply:raise GovernanceReadError('Registered storage metadata is missing')
  data={**key,**values}
  if TABLES[table]:data[identity]=self.execute('SELECT COALESCE(MAX('+identity+'),0)+1 FROM '+table).fetchone()[0]
  data['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  if not set(data)<={'_primecare_import_row',*[c['name'] for c in self.tables[table]['columns']]}:raise GovernanceReadError('Unregistered storage metadata field')
  cols=list(data)
  self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,cols))+') VALUES('+','.join(['%s']*len(cols))+')',[data[k] if k=='_primecare_import_row' else self._value(table,k,data[k]) for k in cols])
  return data[identity]
 def app_id(self):
  rows=self.execute('SELECT app_id,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=710').fetchall()
  if len(rows)!=1 or rows[0][1:]!=('/v1/messages','governance',1,'role_screen_permissions'):raise GovernanceReadError('Registered communication API required')
  return rows[0][0]
 def baseline_values(self):
  d=self.definition_reader()
  return dict(app_id=self.app_id(),baseline_sql=self.migration_reader(),migration_sources=json.dumps([d['migrationPath']]),schema_metadata=json.dumps(d,sort_keys=True),validation_evidence=json.dumps({'status':'registered-unimplemented','runtimeVerified':False,'reviewApproved':False},sort_keys=True),sha256=d['migrationSha256'])
def register(db,apply=True):
 d=db.definition_reader();ids={}
 for name,columns in d['tables'].items():
  tid=db.ensure_exact('db_schema_tables',{'table_name':name},{'app_id':db.app_id(),'table_type':'table','status':'registered-unimplemented'},apply);ids[name]=tid
  for column in columns:db.ensure_exact('db_schema_columns',{'table_id':tid,'column_name':column['column_name']},{k:v for k,v in column.items() if k!='column_name'},apply)
 db.ensure_exact('database_rebuild_baselines',{'name':d['baseline']},db.baseline_values(),apply)
 return dict(tableIds=ids,columns=sum(map(len,d['tables'].values())),baseline=d['baseline'],roleGrants=0,businessDataWrites=False,activation=False)

def signature(db,schema,table):
 target=quote(schema)+'.'+quote(table)
 relation=db.db.execute('SELECT relkind,relrowsecurity,relforcerowsecurity FROM pg_class WHERE oid=to_regclass(%s)',(target,)).fetchone()
 if not relation:raise GovernanceReadError('Native communication table missing')
 columns=db.db.execute("SELECT a.attname,format_type(a.atttypid,a.atttypmod),a.attnotnull,a.attidentity,a.attgenerated,COALESCE(pg_get_expr(d.adbin,d.adrelid),'') FROM pg_attribute a LEFT JOIN pg_attrdef d ON d.adrelid=a.attrelid AND d.adnum=a.attnum WHERE a.attrelid=to_regclass(%s) AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum",(target,)).fetchall()
 constraints=db.db.execute("SELECT c.contype,c.conkey::text,c.confkey::text,COALESCE(r.relname,''),COALESCE(pg_get_expr(c.conbin,c.conrelid),''),c.confupdtype,c.confdeltype,c.confmatchtype,c.condeferrable,c.condeferred,c.convalidated FROM pg_constraint c LEFT JOIN pg_class r ON r.oid=c.confrelid WHERE c.conrelid=to_regclass(%s) ORDER BY 1,2,3,4,5",(target,)).fetchall()
 return relation,columns,constraints

def migrate(db,target='public'):
 d=definition();expected=dict(optInVariable='GOVERNANCE_COMMUNICATION_STORAGE_MIGRATION',migrationPath=d['migrationPath'],migrationSha256=d['migrationSha256'],businessTables=sorted(d['tables']),governanceSchemaChanges=False,businessSchemaChanges=True,businessDataWrites=False,roleGrants=False,activation=False,temporaryValidationTables=True)
 if db.pin.get('communicationStorageMigration')!=expected or os.environ.get('GOVERNANCE_COMMUNICATION_STORAGE_MIGRATION')!='1':raise GovernanceReadError('Exact native storage migration and opt-in required')
 if target!='public' and (not re.fullmatch('communication_fixture_[a-z0-9]+',target) or os.environ.get('GOVERNANCE_ALLOW_TEST_FIXTURE')!='1' or os.environ.get('NODE_ENV')!='test' or os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL')):raise GovernanceReadError('Production communication storage must use public schema')
 registered=register(db,False)
 db.db.execute("SELECT pg_advisory_xact_lock(hashtextextended('primecare-business-communications-storage-v1',0))")
 source=migration_sql()
 for statement in source.split(';'):
  if statement.strip():db.db.execute(statement.replace('public.',quote(target)+'.'))
 # Compare with freshly parsed native temporary tables on this same server.
 # This checks defaults, identity, PK/FK/unique/check constraints, types and nullability.
 temporary=source.replace('CREATE TABLE IF NOT EXISTS','CREATE TEMP TABLE').replace('public.','pg_temp.')
 for statement in temporary.split(';'):
  if statement.strip():db.db.execute(statement+' ON COMMIT DROP')
 temp_schema=db.db.execute('SELECT nspname FROM pg_namespace WHERE oid=pg_my_temp_schema()').fetchone()[0]
 for name in d['tables']:
  if signature(db,target,name)!=signature(db,temp_schema,name):raise GovernanceReadError('Native storage differs from registered design; no changes committed')
 # Permit idempotent validation in the same transaction without leaving temp shadows.
 for name in reversed(list(d['tables'])):db.db.execute('DROP TABLE '+quote(temp_schema)+'.'+quote(name))
 return {**registered,'nativeSchemaVerified':True,'targetSchema':target,'migrationSha256':d['migrationSha256']}

if __name__=='__main__':
 if sys.argv[1:] not in [['--register-dry-run'],['--register'],['--migrate-dry-run'],['--migrate']]:raise SystemExit('Explicit registration or migration mode required')
 with CommunicationStorageStore() as db:
  result=register(db) if sys.argv[1].startswith('--register') else migrate(db)
  if sys.argv[1]=='--register' and result!=register(db):raise GovernanceReadError('Non-idempotent storage registration')
  if sys.argv[1].endswith('dry-run'):db.db.rollback()
 print('COMMUNICATION_STORAGE '+json.dumps(result))
