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
def bind_implementation(db,result):
 d=definition()
 if result!=read_catalog(db,d) or result!=json.loads((ROOT/'packages/shared/src/account-mutations.json').read_text()):raise GovernanceReadError('Production-generated mutation catalog required')
 paths=[d['panelFile'],d['clientFile'],'websites/typescript/src/workspace.ts','websites/typescript/src/tenant-accounts-panel.ts','websites/typescript/src/infrastructure/http/base-session-client.ts','packages/shared/src/account-mutations.json','cloudflare/workers/src/auth-invalidation.ts','cloudflare/workers/src/auth.ts','cloudflare/workers/src/account-management.ts','cloudflare/workers/src/account-admin.ts','cloudflare/workers/src/gateway.ts'];hashes={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in paths};out=[]
 for op in d['operations'].values():
  rows=db.execute('SELECT definition_json,definition_sha256,flow_kind,actor_roles_json FROM virtual_workflow_definitions WHERE flow_id=?',(op['flow'],)).fetchall()
  if len(rows)!=1 or rows[0][2]!='business_process' or hashlib.sha256(rows[0][0].encode()).hexdigest()!=rows[0][1]:raise GovernanceReadError('Exact existing mutation process required')
  plan=json.loads(rows[0][0]);actors=json.loads(rows[0][3])
  if sorted(actors)!=sorted(op['actors']) or plan['actor_roles']!=actors:raise GovernanceReadError('Existing mutation actors drift')
  steps=[x for x in plan['steps'] if x.get('api_method')==op['method']];normalized=db.execute('SELECT step_order,api_path FROM virtual_workflow_steps WHERE flow_id=? AND api_method=?',(op['flow'],op['method'])).fetchall()
  def canonical(path):return path.replace('/v1/auth/admin/','/v1/admin/').replace('{id}','{userId}')
  if len(steps)!=1 or len(normalized)!=1 or canonical(steps[0]['api_path'])!=op['path'] or canonical(normalized[0][1])!=op['path']:raise GovernanceReadError('Existing mutation step drift')
  refs=[dict(table='api_endpoints',key=op['apiId'],key_columns=['id'],reference_status='row')]
  for actor in op['actors']:
   a=d['actors'][actor];refs.append(dict(table='screens',key=a['screenId'],key_columns=['id'],reference_status='row'))
   key='createRoot' if op['flow']=='auth.create-tenant-account' else 'manageRoot'
   cid=db.execute('SELECT id FROM screen_components WHERE screen_id=? AND component_code=?',(a['screenId'],'accountMutations.'+key)).fetchone()[0];refs.append(dict(table='screen_components',key=cid,key_columns=['id'],reference_status='row'))
  if op['flow']=='auth.create-tenant-account':
   for actor,target in db.execute("SELECT actor_role_id,target_role_id FROM auth_account_creation_policy WHERE actor_role_id IN (20,27) AND scope='same_tenant' ORDER BY actor_role_id,target_role_id"):
    refs.append(dict(table='auth_account_creation_policy',key={'actor_role_id':actor,'target_role_id':target},key_columns=['actor_role_id','target_role_id'],reference_status='row'))
  else:refs.append(dict(table='auth_account_management_policy',key='ceo',key_columns=['actor_role_code'],reference_status='row'))
  for pid, in db.execute('SELECT id FROM api_permissions WHERE api_id=? AND can_access=1 ORDER BY id',(op['apiId'],)):refs.append(dict(table='api_permissions',key=pid,key_columns=['id'],reference_status='row'))
  steps[0]['api_path']=op['path'];plan.pop('unresolved_governance_refs',None);plan.update(governance_refs=refs,declared_governance_refs=refs,definition_quality='source_mapped',source_paths=paths,source_sha256=hashes,registered_source={'api_id':op['apiId'],'screens':[d['actors'][a]['screenId'] for a in op['actors']],'controls':d['controls'],'actors':{a:d['actors'][a] for a in op['actors']}},gaps=['Existing mutation UI and canonical contract implemented. Current deployed browser/API/native result/audit/reload and owned-inbox evidence, remaining failure alternatives and independent reviews must be proven.'])
  encoded=json.dumps(plan,ensure_ascii=False,sort_keys=True);digest=hashlib.sha256(encoded.encode()).hexdigest()
  if digest==rows[0][1]:continue
  db._update('virtual_workflow_definitions',dict(definition_json=encoded,definition_sha256=digest,definition_status='source_mapped',verification_status='implemented-unverified',test_status='stale',blocker_json=json.dumps(plan['gaps']),updated_at=datetime.datetime.now(datetime.timezone.utc).isoformat()),op['flow'])
  cur=db.db.execute('UPDATE '+db.table('virtual_workflow_steps')+' SET api_path=%s WHERE flow_id=%s AND step_order=%s',(op['path'],op['flow'],normalized[0][0]))
  if cur.rowcount!=1:raise GovernanceReadError('Mutation step update count mismatch')
  db.db.execute('DELETE FROM '+db.table('virtual_workflow_source_links')+' WHERE flow_id=%s',(op['flow'],))
  for ref in refs:
   key=json.dumps(ref['key'],sort_keys=True,separators=(',',':')) if isinstance(ref['key'],dict) else str(ref['key']);v=dict(flow_id=op['flow'],source_table=ref['table'],source_key=key,source_key_columns=json.dumps(ref['key_columns']),reference_status='row');ordinal=db.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+db.table('virtual_workflow_source_links')).fetchone()[0];fields=list(v)
   db.db.execute('INSERT INTO '+db.table('virtual_workflow_source_links')+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('virtual_workflow_source_links',k,v[k]) for k in fields]])
  out.append({'flow':op['flow'],'sourceLinks':len(refs)})
 return out
def open_store():
 import psycopg,time
 for attempt in range(5):
  try:return MutationStore()
  except psycopg.errors.LockNotAvailable:
   if attempt==4:raise
   time.sleep(2)
def main():
 if not any(x in sys.argv for x in ['--apply','--dry-run']):raise SystemExit('Explicit mutation registration mode required')
 with open_store() as db:
  result=register(db,definition());assert result==register(db,definition())
  bindings=bind_implementation(db,result) if '--bind' in sys.argv else []
  if '--dry-run' in sys.argv:db.db.rollback()
 out=ROOT/'test-results/account-mutations-registration';out.mkdir(parents=True,exist_ok=True);(out/'catalog.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
 print('ACCOUNT_MUTATION_CATALOG '+json.dumps(result,ensure_ascii=False));print('ACCOUNT_MUTATIONS_REGISTERED '+json.dumps({'dryRun':'--dry-run' in sys.argv,'newGrants':0,'actors':['ceo','hr_director'],'reviewApprovals':False,'sourceBindings':bindings}))
if __name__=='__main__':main()
