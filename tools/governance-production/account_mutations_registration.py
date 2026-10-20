"""Register existing CEO/HR account mutation controls, with no added authority."""
import datetime,hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from account_sessions_registration import AccountRegistrationStore
T={'screen_components':'id','screen_required_elements':'id','screen_api_links':'id','language_resources':'resource_id','language_resource_values':'translation_id'}
B=['virtual_workflow_definitions','virtual_workflow_steps','virtual_workflow_source_links']
def definition():return json.loads(Path(__file__).with_name('account-mutations-registration.json').read_text())
def scope():return dict(optInVariable='GOVERNANCE_ACCOUNT_MUTATIONS_REGISTRATION',screenIds=[39,705],apiIds=[1,11,16422],flowIds=sorted(o['flow'] for o in definition()['operations'].values()),tables=[*T,*B],definitionSha256=hashlib.sha256(Path(__file__).with_name('account-mutations-registration.json').read_bytes()).hexdigest(),schemaChanges=False,permissionChanges=False,businessDataWrites=False)
class MutationStore(AccountRegistrationStore):
 def __init__(self,**kwargs):
  ProductionWorkflowStore.__init__(self,**kwargs)
  try:
   if self.pin.get('accountMutationsWriter')!=scope() or os.environ.get('GOVERNANCE_ACCOUNT_MUTATIONS_REGISTRATION')!='1':raise GovernanceReadError('Exact account mutation metadata scope required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted([*T,*B]))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in [*T,*B]:
    m=self.tables.get(table)
    if not m or any(len(c['storage_types'])>1 for c in m['columns']):raise GovernanceReadError('Mixed/missing mutation metadata schema')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall());expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in m['columns']}}
    if actual!=expected:raise GovernanceReadError('Mutation metadata physical schema drift')
  except Exception:self.db.rollback();self.db.close();raise
 def insert_metadata(self,table,values):
  if table not in T:raise GovernanceReadError('Mutation table not allowed')
  v=dict(values);d=definition()
  if table in ['screen_components','screen_required_elements','screen_api_links'] and v.get('screen_id') not in [39,705]:raise GovernanceReadError('Only existing CEO/HR dashboard controls allowed')
  if table=='screen_components' and (v.get('file_path')!=d['panelFile'] or not v.get('component_code','').startswith('accountMutations.')):raise GovernanceReadError('Mutation component namespace required')
  if table=='screen_required_elements' and not v.get('element_key','').startswith('accountMutations.'):raise GovernanceReadError('Mutation element namespace required')
  if table=='screen_api_links' and (v.get('api_id') not in [1,11,16422] or v.get('screen_id')==39 and v.get('api_id')!=1):raise GovernanceReadError('Existing actor/API bindings only')
  if table=='language_resources' and not v.get('resource_key','').startswith('accountMutations.'):raise GovernanceReadError('Mutation resource namespace required')
  if table=='language_resource_values' and not self.execute("SELECT resource_id FROM language_resources WHERE resource_id=? AND context='accountMutations'",(v.get('resource_id'),)).fetchone():raise GovernanceReadError('Mutation translation namespace required')
  if not set(v).issubset({c['name'] for c in self.tables[table]['columns']}):raise GovernanceReadError('Unknown mutation field')
  v[T[table]]=self.execute('SELECT COALESCE(MAX('+T[table]+'),0)+1 FROM '+table).fetchone()[0];v['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0];fields=list(v)
  self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*len(fields))+')',[v[k] if k=='_primecare_import_row' else self._value(table,k,v[k]) for k in fields]);return v[T[table]]
def control_keys(actor):return list(definition()['controls']) if actor=='ceo' else ['createRoot','createForm','email','password','createRole','createSubmit','createStatus']
def validate(db,d):
 if d!=definition():raise GovernanceReadError('Exact mutation definition required')
 if db.execute("SELECT scope,permitted_fields,self_modification FROM auth_account_management_policy WHERE actor_role_code='ceo'").fetchall()!=[('same_tenant','roles,status',0)]:raise GovernanceReadError('Existing management authority drift')
 source=json.loads((ROOT/'cloudflare/workers/src/account-policy.json').read_text())
 if {k:v['targets'] for k,v in d['actors'].items()}!=source:raise GovernanceReadError('Existing account role policy drift')
 for actor,a in d['actors'].items():
  if db.execute('SELECT screen_code,role_id,route_path,active FROM screens WHERE id=?',(a['screenId'],)).fetchall()!=[(a['screenCode'],a['id'],a['route'],1)]:raise GovernanceReadError('Registered actor dashboard drift')
  if db.execute('SELECT can_view FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(a['id'],a['screenId'])).fetchall()!=[(1,)]:raise GovernanceReadError('Existing dashboard view required')
  registered=db.execute('SELECT t.role_code,p.scope FROM auth_account_creation_policy p JOIN roles t ON t.id=p.target_role_id WHERE p.actor_role_id=?',(a['id'],)).fetchall()
  if sorted(registered)!=sorted((code,'same_tenant') for code in a['targets']):raise GovernanceReadError('Existing creation target authority drift')
 for op in d['operations'].values():
  if db.execute('SELECT http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=?',(op['apiId'],)).fetchall()!=[(op['method'],op['path'],'auth',1,op['permission'])]:raise GovernanceReadError('Canonical mutation API drift')
  if op['apiId'] in [1,11]:
   grants=db.execute('SELECT role_id FROM api_permissions WHERE api_id=? AND can_access=1 ORDER BY role_id',(op['apiId'],)).fetchall()
   if grants!=sorted((d['actors'][actor]['id'],) for actor in op['actors']):raise GovernanceReadError('Reconciled existing mutation grant required')
 for c in d['controls'].values():
  if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],1)]:raise GovernanceReadError('Approved mutation component drift')
def read_catalog(db,d):
 validate(db,d)
 for actor,a in d['actors'].items():
  for key in control_keys(actor):
   c=d['controls'][key]
   if db.execute('SELECT component_type,data_cy,file_path FROM screen_components WHERE screen_id=? AND component_code=?',(a['screenId'],'accountMutations.'+key)).fetchall()!=[(c['component'],c['testId'],d['panelFile'])]:raise GovernanceReadError('Registered mutation control missing')
   if db.execute('SELECT test_id FROM screen_required_elements WHERE screen_id=? AND element_key=?',(a['screenId'],'accountMutations.'+key)).fetchall()!=[(c['testId'],)]:raise GovernanceReadError('Registered mutation element missing')
  for op in d['operations'].values():
   if actor in op['actors'] and len(db.execute('SELECT id FROM screen_api_links WHERE screen_id=? AND api_id=?',(a['screenId'],op['apiId'])).fetchall())!=1:raise GovernanceReadError('Mutation API screen link required')
 locales={k:{} for k in d['locales']}
 for key,loc,text in db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='accountMutations' AND r.active=1"):
  if loc in locales:
   key=key.removeprefix('accountMutations.')
   if key in locales[loc]:raise GovernanceReadError('Duplicate mutation translation')
   locales[loc][key]=text
 if locales!=d['locales']:raise GovernanceReadError('Mutation resources drift')
 return {**d,'authority':{'source':'pinned-production-postgresql','schema':db.pin['schema'],'manifestSha256':db.pin['manifestSha256'],'newGrants':0,'reviewStatus':'pending'}}
def register(db,d):
 validate(db,d);langs=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(langs)!=set(d['locales']):raise GovernanceReadError('Enabled mutation languages required')
 for loc,labels in d['locales'].items():
  for key,text in labels.items():
   rid=db.ensure('language_resources',{'resource_key':'accountMutations.'+key},{'resource_group':'accountMutations','description':'Existing account creation, editing and session revocation','context':'accountMutations','active':1});db.ensure('language_resource_values',{'resource_id':rid,'language_id':langs[loc]},{'translated_text':text,'reviewed':0,'approved':0,'version':'account-mutations-v1'})
 for actor,a in d['actors'].items():
  for key in control_keys(actor):
   c=d['controls'][key];db.ensure('screen_components',{'screen_id':a['screenId'],'component_code':'accountMutations.'+key},{'component_name':'accountMutations.'+key,'component_type':c['component'],'data_cy':c['testId'],'file_path':d['panelFile'],'implementation_status':'registered-unimplemented'});db.ensure('screen_required_elements',{'screen_id':a['screenId'],'element_key':'accountMutations.'+key},{'element_type':c['component'],'label':'accountMutations.'+key,'test_id':c['testId'],'required':1})
  for op in d['operations'].values():
   if actor in op['actors']:
    existing=db.execute('SELECT id FROM screen_api_links WHERE screen_id=? AND api_id=?',(a['screenId'],op['apiId'])).fetchall()
    if len(existing)>1:raise GovernanceReadError('Duplicate mutation API link')
    if not existing:db.ensure('screen_api_links',{'screen_id':a['screenId'],'api_id':op['apiId']},{'purpose':'Existing '+op['permission']+' '+op['method']+' operation; no new actor grant'})
 return read_catalog(db,d)
def main():
 if not any(x in sys.argv for x in ['--apply','--dry-run']):raise SystemExit('Explicit mutation registration mode required')
 with MutationStore() as db:
  result=register(db,definition());assert result==register(db,definition())
  if '--dry-run' in sys.argv:db.db.rollback()
 out=ROOT/'test-results/account-mutations-registration';out.mkdir(parents=True,exist_ok=True);(out/'catalog.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
 print('ACCOUNT_MUTATION_CATALOG '+json.dumps(result,ensure_ascii=False));print('ACCOUNT_MUTATIONS_REGISTERED '+json.dumps({'dryRun':'--dry-run' in sys.argv,'newGrants':0,'actors':['ceo','hr_director'],'reviewApprovals':False}))
if __name__=='__main__':main()
