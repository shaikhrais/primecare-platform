"""Add read controls to existing CEO screen705. No route, API, role or grant changes."""
import datetime,hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from account_sessions_registration import AccountRegistrationStore
TABLES={'screen_components':'id','screen_required_elements':'id','language_resources':'resource_id','language_resource_values':'translation_id'}
BINDINGS=['virtual_workflow_definitions','virtual_workflow_steps','virtual_workflow_source_links']
def definition():return json.loads(Path(__file__).with_name('tenant-accounts-registration.json').read_text())
def expected_scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_TENANT_ACCOUNTS_READ_WRITES',screenId=705,apiIds=sorted(o['apiId'] for o in d['operations'].values()),flowIds=sorted(o['flow'] for o in d['operations'].values()),tables=[*TABLES,*BINDINGS],definitionSha256=hashlib.sha256(Path(__file__).with_name('tenant-accounts-registration.json').read_bytes()).hexdigest(),schemaChanges=False,permissionChanges=False,businessDataWrites=False)
class TenantAccountsStore(AccountRegistrationStore):
 def __init__(self,**kwargs):
  ProductionWorkflowStore.__init__(self,**kwargs)
  try:
   if self.pin.get('tenantAccountsReadWriter')!=expected_scope() or os.environ.get('GOVERNANCE_TENANT_ACCOUNTS_READ_WRITES')!='1':raise GovernanceReadError('Exact pinned account read scope required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted([*TABLES,*BINDINGS]))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in [*TABLES,*BINDINGS]:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Mixed/missing account read metadata')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Account read physical schema differs from manifest')
  except Exception:self.db.rollback();self.db.close();raise
 def insert_metadata(self,table,values):
  if table not in TABLES:raise GovernanceReadError('Account read table not allowed')
  v=dict(values);d=definition()
  if table in ['screen_components','screen_required_elements'] and v.get('screen_id')!=705:raise GovernanceReadError('Existing CEO screen required')
  if table=='screen_components' and (v.get('file_path')!=d['panelFile'] or not v.get('component_code','').startswith('tenantAccounts.')):raise GovernanceReadError('Exact account read panel namespace required')
  if table=='screen_required_elements' and not v.get('element_key','').startswith('tenantAccounts.'):raise GovernanceReadError('Account read element namespace required')
  if table=='language_resources' and not v.get('resource_key','').startswith('tenantAccounts.'):raise GovernanceReadError('Account read resource namespace required')
  if table=='language_resource_values' and not self.execute("SELECT resource_id FROM language_resources WHERE resource_id=? AND context='tenantAccounts'",(v.get('resource_id'),)).fetchone():raise GovernanceReadError('Account read translation namespace required')
  if not set(v).issubset({c['name'] for c in self.tables[table]['columns']}):raise GovernanceReadError('Unknown metadata field')
  v[TABLES[table]]=self.execute('SELECT COALESCE(MAX('+TABLES[table]+'),0)+1 FROM '+table).fetchone()[0]
  v['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  fields=list(v);self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*len(fields))+')',[v[k] if k=='_primecare_import_row' else self._value(table,k,v[k]) for k in fields]);return v[TABLES[table]]
def validate(db,d):
 if d!=definition():raise GovernanceReadError('Exact reviewed definition required')
 if db.execute('SELECT screen_code,role_id,route_path,active FROM screens WHERE id=705').fetchall()!=[('ceo_dashboard',20,d['route'],1)]:raise GovernanceReadError('Existing CEO dashboard changed')
 if db.execute('SELECT can_view FROM role_screen_permissions WHERE role_id=20 AND screen_id=705').fetchall()!=[(1,)]:raise GovernanceReadError('Existing CEO view authority required')
 if db.execute("SELECT scope,permitted_fields,self_modification FROM auth_account_management_policy WHERE actor_role_code='ceo'").fetchall()!=[('same_tenant','roles,status',0)]:raise GovernanceReadError('Existing CEO account authority changed')
 for op in d['operations'].values():
  if db.execute('SELECT http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=?',(op['apiId'],)).fetchall()!=[('GET',op['path'],'auth',1,'auth_account_management_policy')]:raise GovernanceReadError('Existing account read API changed')
  if len(db.execute('SELECT id FROM screen_api_links WHERE screen_id=705 AND api_id=?',(op['apiId'],)).fetchall())!=1:raise GovernanceReadError('Existing CEO API link required')
 for c in d['controls'].values():
  if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],1)]:raise GovernanceReadError('Approved component changed')
def catalog(db,d):
 validate(db,d)
 for key,c in d['controls'].items():
  if db.execute('SELECT component_type,data_cy,file_path FROM screen_components WHERE screen_id=705 AND component_code=?',('tenantAccounts.'+key,)).fetchall()!=[(c['component'],c['testId'],d['panelFile'])]:raise GovernanceReadError('Registered account read control missing')
  if db.execute('SELECT test_id FROM screen_required_elements WHERE screen_id=705 AND element_key=?',('tenantAccounts.'+key,)).fetchall()!=[(c['testId'],)]:raise GovernanceReadError('Registered account read element missing')
 locales={l:{} for l in d['locales']}
 for key,loc,text in db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='tenantAccounts' AND r.active=1"):
  if loc in locales:
   key=key.removeprefix('tenantAccounts.')
   if key in locales[loc]:raise GovernanceReadError('Duplicate account read translation')
   locales[loc][key]=text
 if locales!=d['locales']:raise GovernanceReadError('Account read translation drift')
 return {**d,'authority':{'source':'pinned-production-postgresql','schema':db.pin['schema'],'manifestSha256':db.pin['manifestSha256'],'reviewStatus':'pending','permissionsChanged':False}}
def register(db,d):
 validate(db,d)
 langs=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(langs)!=set(d['locales']):raise GovernanceReadError('Registered languages required')
 for loc,labels in d['locales'].items():
  for key,text in labels.items():
   rid=db.ensure('language_resources',{'resource_key':'tenantAccounts.'+key},{'resource_group':'tenantAccounts','description':'Existing CEO account read controls','context':'tenantAccounts','active':1})
   db.ensure('language_resource_values',{'resource_id':rid,'language_id':langs[loc]},{'translated_text':text,'reviewed':0,'approved':0,'version':'tenant-account-reads-v1'})
 for key,c in d['controls'].items():
  db.ensure('screen_components',{'screen_id':705,'component_code':'tenantAccounts.'+key},{'component_name':'tenantAccounts.'+key,'component_type':c['component'],'data_cy':c['testId'],'file_path':d['panelFile'],'implementation_status':'registered-unimplemented'})
  db.ensure('screen_required_elements',{'screen_id':705,'element_key':'tenantAccounts.'+key},{'element_type':c['component'],'label':'tenantAccounts.'+key,'test_id':c['testId'],'required':1})
 return catalog(db,d)
def main():
 if not any(x in sys.argv for x in ['--apply','--dry-run']):raise SystemExit('Explicit --apply or --dry-run required')
 with TenantAccountsStore() as db:
  result=register(db,definition());assert result==register(db,definition()),'Idempotence failure'
  if '--dry-run' in sys.argv:db.db.rollback()
 out=ROOT/'test-results/tenant-accounts-registration';out.mkdir(parents=True,exist_ok=True);(out/'catalog.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
 print('TENANT_ACCOUNT_READS_REGISTERED '+json.dumps({'screen':705,'controls':len(result['controls']),'apis':len(result['operations']),'dryRun':'--dry-run' in sys.argv,'permissionsChanged':False,'reviewApprovals':False}))
if __name__=='__main__':main()
