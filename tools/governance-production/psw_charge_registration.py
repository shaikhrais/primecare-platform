"""Register the scoped additional-charge screen and contracts in production governance."""
import hashlib,json,os,sys,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=ROOT/'packages/shared/src/coordinator-charge/catalog.json'
TABLES={'screens':'id','screen_requirements':None,'role_screen_permissions':'id','screen_sections':'id','screen_section_elements':'id','element_primecare_component_map':'id','language_resources':'resource_id','language_resource_values':'translation_id','screen_components':'id','screen_required_elements':'id','api_endpoints':'id','api_permissions':'id','screen_api_links':'id','virtual_workflow_definitions':None,'virtual_workflow_steps':None,'virtual_workflow_source_links':None,'virtual_flow_catalog_snapshots':None}
def scope():return {'optInVariable':'GOVERNANCE_PSW_CHARGE_REGISTRATION','tables':list(TABLES),'namespace':'psw_coordinator_','catalogSha256':hashlib.sha256(FILE.read_bytes()).hexdigest(),'schemaChanges':False,'businessDataWrites':False,'roles':['tenant_admin','code_admin','platform_admin','central_admin']}
class ChargeStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('pswCoordinatorChargeWriter')!=scope() or os.environ.get('GOVERNANCE_PSW_CHARGE_REGISTRATION')!='1':raise GovernanceReadError('Exact PSW personal namespace opt-in required')
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
  if table=='screens' and key.get('screen_code') not in {definition['screenCode']}:raise GovernanceReadError('Unrelated screen refused')
  if 'flow_id' in key and not key['flow_id'].startswith('care.psw.additional_charge'):raise GovernanceReadError('Unrelated workflow refused')
  if table=='api_endpoints' and key.get('route_path') not in {definition['endpoint']}:raise GovernanceReadError('Unrelated API refused')
  if 'screen_id' in key or 'screen_id' in values:
   sid=key.get('screen_id',values.get('screen_id'))
   rows=self.execute('SELECT screen_code FROM screens WHERE id=?',(sid,)).fetchall()
   if len(rows)!=1 or rows[0][0] not in {definition['screenCode']}:raise GovernanceReadError('Exact personal screen required')
  if table=='language_resources' and not key.get('resource_key','').startswith('psw.coordinator.charge.'):raise GovernanceReadError('Unrelated resource refused')
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
 c=json.loads(FILE.read_text());roles=dict(db.execute('SELECT role_code,id FROM roles WHERE active=1'));required=scope()['roles']
 if not set(required)<=set(roles):raise GovernanceReadError('Existing administration roles required')
 app=db.execute("SELECT id FROM apps WHERE app_code='ci'").fetchone()[0];apiapp=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 sid=db.ensure('screens',{'screen_code':c['screenCode']},{'app_id':app,'role_id':roles['tenant_admin'],'screen_name':c['title'],'route_path':c['route'],'actual_file_path':c['sourceFiles'][0],'stage':'created','active':1,'implementation_tag':'partial','content_tag':'governed_content','api_tag':'charge_connected','test_tag':'release_acceptance'})
 db.ensure('screen_requirements',{'screen_id':sid},{'business_purpose':'Assign time-bound additional coordinator responsibility while preserving the primary Tenant Admin role','user_story':'As an authorized administrator I assign or end a coordinator additional charge; the employee switches into existing scheduler permissions without changing her primary role.','sidebar_label':c['title'],'acceptance_criteria':'Same tenant; active assignment on every request; expiry/revocation denial; immutable acting-role audit; no clinical authority; no own-hours approval; save and independent database readback.'})
 for role in required:db.ensure('role_screen_permissions',{'screen_id':sid,'role_id':roles[role]},{'can_view':1,'can_create':1,'can_edit':1,'can_delete':0,'can_export':0})
 section=db.ensure('screen_sections',{'screen_id':sid,'section_code':'psw_coordinator_charge_assignments'},{'section_name':'Assignments and responsibility history','section_type':'dashboard','section_order':1,'purpose':'Separate primary role and additional coordinator responsibility','required':1,'file_path':c['sourceFiles'][0],'test_id':'screen-psw-coordinator-additional-charge','status':'created'})
 language=db.execute("SELECT language_id FROM languages WHERE language_code='en' AND enabled=1").fetchone()[0];component=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code='prime_button' AND active=1").fetchone()[0]
 for order,(key,label) in enumerate(c['controls'].items()):
  rid=db.ensure('language_resources',{'resource_key':'psw.coordinator.charge.'+key},{'resource_group':'psw.coordinator.charge','description':label,'context':'coordinator additional charge','active':1})
  db.ensure('language_resource_values',{'resource_id':rid,'language_id':language},{'translated_text':label,'reviewed':0,'approved':0,'version':'psw-charge-v1'})
  element='psw_coordinator_charge_'+key;test='charge-'+key
  db.ensure('screen_components',{'screen_id':sid,'component_code':element},{'component_name':label,'component_type':'prime_button','data_cy':test,'file_path':c['sourceFiles'][0],'implementation_status':'implemented'})
  db.ensure('screen_required_elements',{'screen_id':sid,'element_key':element},{'element_type':'button','label':label,'test_id':test,'required':0})
  eid=db.ensure('screen_section_elements',{'screen_id':sid,'section_id':section,'element_key':element},{'element_type':'button','label':label,'test_id':test,'required':0,'action_required':1,'api_usage':c['endpoint'],'element_order':order,'implementation_tag':'partial','content_tag':'governed_content','action_tag':'implemented','api_tag':'charge_connected','test_tag':'release_acceptance'})
  db.ensure('element_primecare_component_map',{'element_id':eid},{'screen_id':sid,'section_id':section,'element_type':'button','primecare_component_id':component,'component_variant':'html-accessible','usage_reason':'Additional-charge registered control','required':0})
 for method in ['GET','POST']:
  aid=db.ensure('api_endpoints',{'app_id':apiapp,'route_path':c['endpoint'],'http_method':method},{'endpoint_code':'PSW_COORDINATOR_CHARGE_'+method,'service_name':'governance','auth_required':1,'permission_key':'coordinator_charge.current_tenant_admin','implementation_status':'partial','request_schema':json.dumps({'type':'object','description':'Tenant selection for central administrators; assign, revoke or enter an own active charge'},sort_keys=True),'response_schema':json.dumps({'type':'object','description':'Tenant assignments, eligible administrators and responsibility audit'},sort_keys=True)})
  for role in required:db.ensure('api_permissions',{'api_id':aid,'role_id':roles[role]},{'can_access':1,'permission_key':'coordinator_charge.current_tenant_admin'})
  db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Explicit additional-charge management; scheduler context checked on every care request'})
 flow=c['workflow'];definition={'id':flow,'kind':'screen_journey','title':c['title'],'actor_roles':required,'source_paths':c['sourceFiles'],'policy':c['policy'],'effective_existing_role':'scheduler','gaps':['English labels are registered but independent translation/accessibility review is not claimed.']};encoded=json.dumps(definition,sort_keys=True)
 db.ensure('virtual_workflow_definitions',{'flow_id':flow},{'flow_kind':'screen_journey','title':c['title'],'actor_roles_json':json.dumps(required),'trigger_text':'Assign additional responsibility or switch care workspace','preconditions_json':json.dumps(['Active authorized tenant admin','Same tenant employee','Active unexpired unrevoked assignment for coordinator context']),'outcome_text':'Separate roles, attributable coordinator actions, revocable assignment','definition_json':encoded,'definition_sha256':hashlib.sha256(encoded.encode()).hexdigest(),'definition_status':'source_mapped','verification_status':'implemented-unverified','blocker_json':json.dumps(definition['gaps']),'test_status':'release_acceptance'})
 for n,(action,expected) in enumerate([('Assign coordinator additional charge','Persist dates and reason without modifying the primary role'),('Enter coordinator workspace','Validate own current assignment and use existing scheduler permissions'),('Perform scheduling or request review','Audit actor, primary role, effective role and charge ID'),('End or expire additional charge','Deny the old coordinator context; retain primary role and audit')],1):db.ensure('virtual_workflow_steps',{'flow_id':flow,'step_order':n},{'action_text':action,'expected_text':expected,'api_method':'POST','api_path':c['endpoint'],'database_effect_json':json.dumps({'tables':['psw_coordinator_charges','psw_coordinator_charge_events']}),'actor_roles_json':json.dumps(required)})
 db.ensure('virtual_workflow_source_links',{'flow_id':flow,'source_table':'screens','source_key':str(sid)},{'source_key_columns':'["id"]','reference_status':'row'})
 return {'screens':1,'workflows':1,'apis':2,'businessProcessesAdded':0,'authority':'pinned-production-postgresql','assignmentsSeeded':0}
if __name__=='__main__':
 if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
 with ChargeStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Registration idempotency required')
 output=ROOT/'test-results/psw-charge-release';output.mkdir(parents=True,exist_ok=True);(output/'registration.json').write_text(json.dumps({'source':os.environ.get('GITHUB_SHA'),**result},indent=2));print('PSW_CHARGE_REGISTERED '+json.dumps(result))
