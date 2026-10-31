"""Register the scoped additional-charge screen and contracts in production governance."""
import hashlib,json,os,sys,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=ROOT/'packages/shared/src/tenant-dashboard/catalog.json'
TABLES={'screens':'id','screen_requirements':None,'role_screen_permissions':'id','screen_sections':'id','screen_section_elements':'id','element_primecare_component_map':'id','language_resources':'resource_id','language_resource_values':'translation_id','screen_components':'id','screen_required_elements':'id','api_endpoints':'id','api_permissions':'id','screen_api_links':'id','virtual_workflow_definitions':None,'virtual_workflow_steps':None,'virtual_workflow_source_links':None,'virtual_flow_catalog_snapshots':None}
def scope():return {'optInVariable':'GOVERNANCE_TENANT_DASHBOARD_REGISTRATION','tables':list(TABLES),'namespace':'tenant_admin_','catalogSha256':hashlib.sha256(FILE.read_bytes()).hexdigest(),'schemaChanges':False,'businessDataWrites':False,'roles':list(dict.fromkeys(json.loads(FILE.read_text())['teamRoles']+json.loads(FILE.read_text())['globalRoles']))}
class TenantStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('tenantDashboardWriter')!=scope() or os.environ.get('GOVERNANCE_TENANT_DASHBOARD_REGISTRATION')!='1':raise GovernanceReadError('Exact tenant dashboard namespace opt-in required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in TABLES:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing or mixed tenant registry metadata')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Tenant registry physical schema mismatch')
  except Exception:self.db.rollback();self.db.close();raise
 def ensure(self,table,key,values):
  if table not in TABLES:raise GovernanceReadError('Unscoped registry write refused')
  definition=json.loads(FILE.read_text())
  if table=='screens' and key.get('screen_code') not in {definition['screenCode']}:raise GovernanceReadError('Unrelated screen refused')
  if 'flow_id' in key and not key['flow_id'].startswith('tenant.admin.workspace'):raise GovernanceReadError('Unrelated workflow refused')
  if table=='api_endpoints' and key.get('route_path') not in {definition['endpoint']}:raise GovernanceReadError('Unrelated API refused')
  if 'screen_id' in key or 'screen_id' in values:
   sid=key.get('screen_id',values.get('screen_id'))
   rows=self.execute('SELECT screen_code FROM screens WHERE id=?',(sid,)).fetchall()
   if len(rows)!=1 or rows[0][0] not in {definition['screenCode']}:raise GovernanceReadError('Exact tenant screen required')
  if table=='language_resources' and not key.get('resource_key','').startswith('tenant.dashboard.'):raise GovernanceReadError('Unrelated resource refused')
  fields=list(key)+[k for k in values if k not in key];columns={c['name'] for c in self.tables[table]['columns']}
  if not set(fields)<=columns:raise GovernanceReadError('Unregistered personal metadata fields: '+table+' '+str(set(fields)-columns))
  identity=TABLES[table] or ('id' if 'id' in columns else None);selected=([identity] if identity and identity not in fields else [])+fields
  rows=self.execute('SELECT '+','.join(quote(k) for k in selected)+' FROM '+table+' WHERE '+' AND '.join(quote(k)+'=?' for k in key),tuple(key.values())).fetchall()
  if len(rows)>1:raise GovernanceReadError('Ambiguous tenant registry identity')
  if rows:
   old=dict(zip(selected,rows[0]));expected={**key,**values}
   if any(old[k]!=v for k,v in expected.items()):raise GovernanceReadError('Preserve edited tenant registry metadata; explicit reconciliation required: '+table)
   return old.get(identity) if identity else None
  values={**key,**values}
  if identity and identity not in values:values[identity]=self.execute('SELECT COALESCE(MAX('+quote(identity)+'),0)+1 FROM '+table).fetchone()[0]
  for t in ['created_at','updated_at']:
   if t in columns:values.setdefault(t,datetime.datetime.now(datetime.timezone.utc).isoformat())
  ordinal=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0];keys=list(values)
  self.db.execute('INSERT INTO '+self.table(table)+' (_primecare_import_row,'+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*(len(keys)+1))+')',[ordinal,*[self._value(table,k,values[k]) for k in keys]])
  return values.get(identity) if identity else None

def register(db):
 c=json.loads(FILE.read_text());roles=dict(db.execute('SELECT role_code,id FROM roles WHERE active=1'));required=scope()['roles']
 if not set(required)<=set(roles):raise GovernanceReadError('Existing tenant/team roles required: '+str(set(required)-set(roles)))
 app=db.execute("SELECT id FROM apps WHERE app_code='ci'").fetchone()[0];apiapp=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 sid=db.ensure('screens',{'screen_code':c['screenCode']},{'app_id':app,'role_id':roles['tenant_admin'],'screen_name':c['title'],'route_path':c['route'],'actual_file_path':c['sourceFiles'][0],'stage':'created','active':1,'implementation_tag':'partial','content_tag':'governed_content','api_tag':'tenant_dashboard_connected','test_tag':'release_acceptance'})
 db.ensure('screen_requirements',{'screen_id':sid},{'business_purpose':'Tenant dashboard with real aggregates, registered workflow inventory and accountable operational tasks','user_story':'As Tenant Admin I manage task owners, due dates and evidence; staff see only their assigned work; central reviewers use marked database demos.','sidebar_label':c['title'],'acceptance_criteria':'Tenant and owner isolation; current session; registered workflow and active owner; independent review; optimistic version; idempotent save; readback and reload; no invented workflow verification or clinical/payroll approval.'})
 for role in required:db.ensure('role_screen_permissions',{'screen_id':sid,'role_id':roles[role]},{'can_view':1,'can_create':1 if role in c['managerRoles']+c['globalRoles'] else 0,'can_edit':1,'can_delete':0,'can_export':0})
 section=db.ensure('screen_sections',{'screen_id':sid,'section_code':'tenant_admin_command_workspace'},{'section_name':'Tenant operations, work and workflow library','section_type':'dashboard','section_order':1,'purpose':'Real metrics and versioned task/result tracking with independent review','required':1,'file_path':c['sourceFiles'][0],'test_id':'screen-tenant-admin-dashboard','status':'created'})
 language=db.execute("SELECT language_id FROM languages WHERE language_code='en' AND enabled=1").fetchone()[0];components=dict(db.execute('SELECT component_code,id FROM primecare_ui_component_registry WHERE active=1'))
 for order,control in enumerate(c['elements']):
  key=control['key'];label=control['label'];component=control['component']
  if component not in components:raise GovernanceReadError('Existing PrimeCare component required: '+component)
  element='tenant_admin_workspace_'+key;test=control['testId'];kind=control['type']
  db.ensure('screen_components',{'screen_id':sid,'component_code':element},{'component_name':label,'component_type':component,'data_cy':test,'file_path':c['sourceFiles'][0],'implementation_status':'implemented'})
  db.ensure('screen_required_elements',{'screen_id':sid,'element_key':element},{'element_type':kind,'label':label,'test_id':test,'required':0})
  eid=db.ensure('screen_section_elements',{'screen_id':sid,'section_id':section,'element_key':element},{'element_type':kind,'label':label,'test_id':test,'required':0,'action_required':0 if kind in ['table','input','textarea','select'] else 1,'api_usage':c['endpoint'],'element_order':order,'implementation_tag':'partial','content_tag':'governed_content','action_tag':'implemented','api_tag':'tenant_dashboard_connected','test_tag':'release_acceptance'})
  db.ensure('element_primecare_component_map',{'element_id':eid},{'screen_id':sid,'section_id':section,'element_type':kind,'primecare_component_id':components[component],'component_variant':'html-accessible','usage_reason':'Tenant dashboard registered component','required':0})
 for key,label in {**c['labels'],**c['controls']}.items():
  rid=db.ensure('language_resources',{'resource_key':'tenant.dashboard.'+key},{'resource_group':'tenant.dashboard','description':label,'context':'tenant admin dashboard','active':1});db.ensure('language_resource_values',{'resource_id':rid,'language_id':language},{'translated_text':label,'reviewed':0,'approved':0,'version':'tenant-dashboard-v1'})
 for method in ['GET','POST']:
  aid=db.ensure('api_endpoints',{'app_id':apiapp,'route_path':c['endpoint'],'http_method':method},{'endpoint_code':'TENANT_DASHBOARD_'+method,'service_name':'governance','auth_required':1,'permission_key':'tenant_dashboard.current_tenant_or_own_task','implementation_status':'partial','request_schema':json.dumps({'type':'object','description':'Tenant-scoped metrics and registered workflow paging; versioned task commands, evidence, preferences and marked demo reset'},sort_keys=True),'response_schema':json.dumps({'type':'object','description':'Actual authorized tasks, owner directory, workflow source and verification statuses; unavailable metrics remain null'},sort_keys=True)})
  for role in required:db.ensure('api_permissions',{'api_id':aid,'role_id':roles[role]},{'can_access':1,'permission_key':'tenant_dashboard.current_tenant_or_own_task'})
  db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Real tenant dashboard; central access is synthetic demo only; staff live data is own tasks only'})
 flow=c['workflow'];definition={'id':flow,'kind':'screen_journey','title':'Tenant work and accountable task management','actor_roles':required,'source_paths':c['sourceFiles'],'gaps':['Existing business-process verification remains independent. English is registered; independent translation and formal accessibility review are not claimed.']};encoded=json.dumps(definition,sort_keys=True)
 db.ensure('virtual_workflow_definitions',{'flow_id':flow},{'flow_kind':'screen_journey','title':definition['title'],'actor_roles_json':json.dumps(required),'trigger_text':'Open the tenant dashboard and assign work from a registered workflow','preconditions_json':json.dumps(['Active authorized account and tenant','Live tenant admin or own assigned staff task','Explicit marked demo for central administrators']),'outcome_text':'Saved work with owner, due date, result, independent review and immutable audit','definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest(),'definition_status':'source_mapped','verification_status':'implemented-unverified','blocker_json':json.dumps(definition['gaps']),'test_status':'release_acceptance'})
 for n,(action,expected) in enumerate([('Read actual tenant dashboard and workflow inventory','Only tenant-authorized data and original verification status are returned'),('Create a workflow task with active owner and due date','Persist operational responsibility without clinical or payroll authorization'),('Assigned staff record progress or submit evidence','Save version and show the result to Tenant Admin'),('Independent administrator reviews submitted work','Self approval is denied; reviewed task does not mark the business workflow verified'),('Reload dashboard or clear the marked demo','Database changes persist; demo cleanup preserves live records and immutable audit')],1):db.ensure('virtual_workflow_steps',{'flow_id':flow,'step_order':n},{'action_text':action,'expected_text':expected,'api_method':'POST' if n in [2,3,4] else 'GET','api_path':c['endpoint'],'database_effect_json':json.dumps({'tables':['tenant_work_tasks','tenant_dashboard_demos','tenant_dashboard_preferences','tenant_dashboard_events','tenant_dashboard_requests'],'clinicalApproval':False}),'actor_roles_json':json.dumps(required)})
 db.ensure('virtual_workflow_source_links',{'flow_id':flow,'source_table':'screens','source_key':str(sid)},{'source_key_columns':'["id"]','reference_status':'row'})
 return {'screens':1,'workflows':1,'apis':2,'registeredControls':len(c['elements']),'businessProcessesAdded':0,'authority':'pinned-production-postgresql','liveTasksSeeded':0}
if __name__=='__main__':
 if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
 with TenantStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Idempotent registry readback required')
 output=ROOT/'test-results/tenant-dashboard-release';output.mkdir(parents=True,exist_ok=True);(output/'registration.json').write_text(json.dumps({'source':os.environ.get('GITHUB_SHA'),**result},indent=2));print('TENANT_DASHBOARD_REGISTERED '+json.dumps(result))
