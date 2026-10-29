"""Register only the implemented PSW personal namespace in pinned PostgreSQL governance."""
import hashlib,json,os,sys,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=ROOT/'packages/shared/src/psw-personal/catalog.json'
TABLES={'screens':'id','screen_requirements':None,'role_screen_permissions':'id','screen_sections':'id','screen_section_elements':'id','element_primecare_component_map':'id','language_resources':'resource_id','language_resource_values':'translation_id','screen_components':'id','screen_required_elements':'id','api_endpoints':'id','api_permissions':'id','screen_api_links':'id','virtual_workflow_definitions':None,'virtual_workflow_steps':None,'virtual_workflow_source_links':None,'virtual_flow_catalog_snapshots':None}
def scope():return {'optInVariable':'GOVERNANCE_PSW_PERSONAL_REGISTRATION','tables':list(TABLES),'namespace':'psw_personal_','catalogSha256':hashlib.sha256(FILE.read_bytes()).hexdigest(),'schemaChanges':False,'businessDataWrites':False,'roles':['psw','hsw','code_admin','platform_admin','central_admin','tenant_admin','scheduler','clinical_director','rn_field_supervisor']}
class PersonalStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('pswPersonalRegistrationWriter')!=scope() or os.environ.get('GOVERNANCE_PSW_PERSONAL_REGISTRATION')!='1':raise GovernanceReadError('Exact PSW personal namespace opt-in required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in TABLES:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing or mixed personal registry metadata')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Personal registry physical schema mismatch')
  except Exception:self.db.rollback();self.db.close();raise
 def ensure(self,table,key,values):
  if table not in TABLES:raise GovernanceReadError('Unscoped registry write refused')
  definition=json.loads(FILE.read_text())
  if table=='screens' and key.get('screen_code') not in {s['code'] for s in definition['screens']}:raise GovernanceReadError('Unrelated screen refused')
  if 'flow_id' in key and not key['flow_id'].startswith('care.psw.personal.'):raise GovernanceReadError('Unrelated workflow refused')
  if table=='api_endpoints' and key.get('route_path') not in {definition['endpoint'],*[a['route'] for a in definition['existingContractsToReuse']]}:raise GovernanceReadError('Unrelated API refused')
  if 'screen_id' in key or 'screen_id' in values:
   sid=key.get('screen_id',values.get('screen_id'))
   rows=self.execute('SELECT screen_code FROM screens WHERE id=?',(sid,)).fetchall()
   if len(rows)!=1 or rows[0][0] not in {s['code'] for s in definition['screens']}:raise GovernanceReadError('Exact personal screen required')
  if table=='language_resources' and not key.get('resource_key','').startswith('psw.personal.'):raise GovernanceReadError('Unrelated resource refused')
  fields=list(key)+[k for k in values if k not in key];columns={c['name'] for c in self.tables[table]['columns']}
  if not set(fields)<=columns:raise GovernanceReadError('Unregistered personal metadata fields: '+table+' '+str(set(fields)-columns))
  identity=TABLES[table] or ('id' if 'id' in columns else None);selected=([identity] if identity and identity not in fields else [])+fields
  rows=self.execute('SELECT '+','.join(quote(k) for k in selected)+' FROM '+table+' WHERE '+' AND '.join(quote(k)+'=?' for k in key),tuple(key.values())).fetchall()
  if len(rows)>1:raise GovernanceReadError('Ambiguous personal registry identity')
  if rows:
   old=dict(zip(selected,rows[0]));expected={**key,**values}
   if any(old[k]!=v for k,v in expected.items()):raise GovernanceReadError('Preserve edited personal registry metadata; explicit reconciliation required: '+table)
   return old.get(identity) if identity else None
  values={**key,**values}
  if identity and identity not in values:values[identity]=self.execute('SELECT COALESCE(MAX('+quote(identity)+'),0)+1 FROM '+table).fetchone()[0]
  for t in ['created_at','updated_at']:
   if t in columns:values.setdefault(t,datetime.datetime.now(datetime.timezone.utc).isoformat())
  ordinal=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0];keys=list(values)
  self.db.execute('INSERT INTO '+self.table(table)+' (_primecare_import_row,'+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*(len(keys)+1))+')',[ordinal,*[self._value(table,k,values[k]) for k in keys]])
  return values.get(identity) if identity else None

def register(db):
 c=json.loads(FILE.read_text());codes=[s['code'] for s in c['screens']]
 if len(codes)!=12 or len(set(codes))!=12 or any(not k.startswith('psw_personal_') for k in codes):raise GovernanceReadError('Exact implemented personal screens required')
 for s in c['screens']:
  if not (ROOT/s['file']).is_file():raise GovernanceReadError('Implemented screen source required')
 roles=dict(db.execute('SELECT role_code,id FROM roles WHERE active=1'));required=set(scope()['roles'])
 if not required<=set(roles):raise GovernanceReadError('Existing PSW and operations roles required')
 app=db.execute("SELECT id FROM apps WHERE app_code='ci'").fetchone()[0];api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0];apis=[]
 for method in ['GET','POST']:
  request={'type':'object','properties':({'dataset':{'enum':['live','demo','queue']},'from':{'type':'string','format':'date'}} if method=='GET' else {'version':{'type':'integer'},'action':{'enum':c['commandActions']},'value':{'type':'object'}})}
  aid=db.ensure('api_endpoints',{'app_id':api_app,'route_path':c['endpoint'],'http_method':method},{'endpoint_code':'PSW_PERSONAL_'+method,'service_name':'governance','auth_required':1,'permission_key':'role_screen_permissions','implementation_status':'partial','request_schema':json.dumps(request,sort_keys=True),'response_schema':json.dumps({'type':'object','description':'Session-scoped personal live/demo records or tenant operations queue'},sort_keys=True)})
  apis.append(aid)
  for role in required:db.ensure('api_permissions',{'api_id':aid,'role_id':roles[role]},{'can_access':1,'permission_key':'role_screen_permissions'})
 component=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code='prime_button' AND active=1").fetchone()[0]
 language=db.execute("SELECT language_id FROM languages WHERE language_code='en' AND enabled=1").fetchone()[0]
 for key,control in c['controls'].items():
  rid=db.ensure('language_resources',{'resource_key':'psw.personal.'+key},{'resource_group':'psw.personal','description':control['label'],'context':'psw.personal','active':1})
  db.ensure('language_resource_values',{'resource_id':rid,'language_id':language},{'translated_text':control['label'],'reviewed':0,'approved':0,'version':'psw-personal-v1'})
 reused=[]
 native_api=json.loads((ROOT/'docs/care/openapi.json').read_text())
 for a in c['existingContractsToReuse']:
  matches=db.execute('SELECT id,service_name,auth_required FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,a['route'],a['method'])).fetchall()
  if len(matches)>1:raise GovernanceReadError('Ambiguous native care API')
  if matches:
   if tuple(matches[0][1:])!=('governance',1):raise GovernanceReadError('Native care API authority differs')
   reused.append(matches[0][0])
  else:
   op=native_api['paths'][a['route']][a['method'].lower()]
   schema=op.get('requestBody',{}).get('content',{}).get('application/json',{}).get('schema',{'type':'object'})
   aid=db.ensure('api_endpoints',{'app_id':api_app,'route_path':a['route'],'http_method':a['method']},{'endpoint_code':'PSW_NATIVE_'+a['method']+'_'+a['route'].rsplit('/',1)[-1].replace('{','').replace('}',''),'service_name':'governance','auth_required':1,'permission_key':'care.current_staff_and_assignment','implementation_status':'partial','request_schema':json.dumps(schema,sort_keys=True),'response_schema':json.dumps({'type':'object'})})
   reused.append(aid)
 screen_ids=[]
 for s in c['screens']:
  grants=['code_admin','platform_admin','central_admin'] if s['previewView']=='plan' else ['tenant_admin','scheduler','clinical_director','rn_field_supervisor'] if s['previewView']=='requests_review' else ['psw','hsw']
  sid=db.ensure('screens',{'screen_code':s['code']},{'app_id':app,'role_id':roles[grants[0]],'screen_name':s['title'],'route_path':s['proposedRoute'],'actual_file_path':s['file'],'stage':'created','active':1,'implementation_tag':'partial','content_tag':'governed_content','api_tag':'care_connected','test_tag':'release_acceptance'})
  screen_ids.append(sid)
  db.ensure('screen_requirements',{'screen_id':sid},{'business_purpose':'PSW personal work, hours and closed-loop requests','user_story':'As an authorized worker I can see my own assigned work and time, record outcomes and track review without coordinator-wide access.','sidebar_label':s['title'],'acceptance_criteria':'Own-account and tenant isolation; API save and DB readback; reload; truthful demo marking; demo-only cleanup; native care approvals remain required.'})
  for role in grants:db.ensure('role_screen_permissions',{'screen_id':sid,'role_id':roles[role]},{'can_view':1,'can_create':0 if s['previewView']=='plan' else 1,'can_edit':0 if s['previewView']=='plan' else 1,'can_delete':0,'can_export':1})
  section=db.ensure('screen_sections',{'screen_id':sid,'section_code':s['code']+'_workspace'},{'section_name':s['title'],'section_type':'dashboard','section_order':1,'purpose':'Own work and explicit status; no invented clinical or payroll approval','required':1,'file_path':s['file'],'test_id':'screen-psw-personal-'+s['previewView'],'status':'created'})
  for n,key in enumerate(s['controls']):
   control=c['controls'][key]
   code=s['code']+'.'+key
   db.ensure('screen_components',{'screen_id':sid,'component_code':code},{'component_name':control['label'],'component_type':'prime_button','data_cy':control['testId'],'file_path':s['file'],'implementation_status':'implemented'})
   db.ensure('screen_required_elements',{'screen_id':sid,'element_key':code},{'element_type':'button','label':control['label'],'test_id':control['testId'],'required':0})
   element=db.ensure('screen_section_elements',{'screen_id':sid,'section_id':section,'element_key':code},{'element_type':'button','label':control['label'],'test_id':control['testId'],'required':0,'action_required':1,'api_usage':c['endpoint'],'element_order':n,'implementation_tag':'partial','content_tag':'governed_content','action_tag':'implemented','api_tag':'care_connected','test_tag':'release_acceptance'})
   db.ensure('element_primecare_component_map',{'element_id':element},{'screen_id':sid,'section_id':section,'element_type':'button','primecare_component_id':component,'component_variant':'html-accessible','usage_reason':'Registered personal workspace control','required':0})
  for aid in apis:db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Personal session and tenant scope; real care commands use existing care endpoints'})
  if s['previewView'] in ['visit','hours','availability']:
   for aid in reused:db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Existing native care contract; current staff and assignment authorization required'})
  flow='care.psw.personal.'+s['previewView'];definition={'id':flow,'kind':'screen_journey','title':s['title'],'actor_roles':grants,'trigger':'Open '+s['proposedRoute'],'preconditions':['Active session and tenant','Own assignment for clinical data','Use explicit marked demo for practice'],'outcome':'Saved authorized records with visible review state','task':s['task'],'question_ids':[q['id'] for q in c['questions'] if q['screen']==s['previewView']],'source_paths':[s['file'],'cloudflare/workers/src/psw-personal/service.ts'],'gaps':['Independent clinical/payroll policy and full multi-language review are not represented as completed']};encoded=json.dumps(definition,sort_keys=True)
  db.ensure('virtual_workflow_definitions',{'flow_id':flow},{'flow_kind':'screen_journey','title':s['title'],'actor_roles_json':json.dumps(grants),'trigger_text':definition['trigger'],'preconditions_json':json.dumps(definition['preconditions']),'outcome_text':definition['outcome'],'definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest(),'definition_status':'source_mapped','verification_status':'implemented-unverified','blocker_json':json.dumps(definition['gaps']),'test_status':'release_acceptance'})
  for n,(action,expected,method) in enumerate([('Read scoped workspace','Authorized live data or clearly marked synthetic dataset','GET'),('Submit allowed action','Versioned PostgreSQL save or explicit denial','POST'),('Reload and inspect status','Saved data and audit event remain visible','GET')],1):db.ensure('virtual_workflow_steps',{'flow_id':flow,'step_order':n},{'action_text':action,'expected_text':expected,'api_method':method,'api_path':c['endpoint'],'database_effect_json':json.dumps({'tables':['psw_personal_workspaces','psw_personal_requests','psw_personal_events'],'noClinicalApprovalSeed':True}),'actor_roles_json':json.dumps(grants)})
  for table,key in [('screens',sid),('api_endpoints',apis[0]),('api_endpoints',apis[1])]:db.ensure('virtual_workflow_source_links',{'flow_id':flow,'source_table':table,'source_key':str(key)},{'source_key_columns':'["id"]','reference_status':'row'})
 db.ensure('virtual_flow_catalog_snapshots',{'name':'psw-personal-questions-v1'},{'summary_json':json.dumps({'questions':c['questions'],'tasks':c['tasks'],'screens':screen_ids,'catalog_sha256':scope()['catalogSha256']},sort_keys=True)})
 return {'screens':len(screen_ids),'workflows':len(screen_ids),'apis':len(apis),'nativeCareContracts':len(reused),'questions':len(c['questions']),'tasks':len(c['tasks']),'businessProcessesAdded':0,'authority':'pinned-production-postgresql','schemaChanges':False}
if __name__=='__main__':
 if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
 with PersonalStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Personal registration must be idempotent')
 output=ROOT/'test-results/psw-personal-release';output.mkdir(parents=True,exist_ok=True)
 (output/'registration.json').write_text(json.dumps({'source':os.environ.get('GITHUB_SHA'),**result},indent=2))
 print('PSW_PERSONAL_REGISTERED '+json.dumps(result))
