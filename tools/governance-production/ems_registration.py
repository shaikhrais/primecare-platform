"""Register only the six user-requested, read-only Code Admin EMS contracts."""
import argparse,hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=ROOT/'packages/shared/src/endpoint-management/contract.json'
TABLES=['screens','role_screen_permissions','api_endpoints','api_permissions','screen_api_links']
def scope():return dict(optInVariable='GOVERNANCE_EMS_REGISTRATION_WRITES',tables=TABLES,definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,accountAssignments=False)
def register(store):
 if store.pin.get('emsRegistrationWriter')!=scope() or os.environ.get('GOVERNANCE_EMS_REGISTRATION_WRITES')!='1':raise GovernanceReadError('Exact EMS registration scope required')
 d=json.loads(FILE.read_text())
 if d['role']!='code_admin' or d['screenCode']!='CODE_ADMIN_EMS_DASHBOARD' or d['route']!='/platform/administration#ems' or len(d['operations'])!=6 or {o['name'] for o in d['operations']}!={'summary','endpoints','services','traffic','capacity','maintenance'} or any(o['method']!='GET' or o['path']!='/v1/governance/platform/ems/'+o['name'] or o['code']!='EMS_'+o['name'].upper()+'_READ' for o in d['operations']):raise GovernanceReadError('EMS read-only definition changed')
 store.db.execute('LOCK TABLE '+','.join(store.table(t) for t in TABLES)+' IN SHARE ROW EXCLUSIVE MODE')
 def rows(sql,args=()):return store.execute(sql,args).fetchall()
 def one(sql,args=()):
  result=rows(sql,args)
  if len(result)!=1:raise GovernanceReadError('Unique EMS registration dependency required')
  return result[0][0]
 def next_id(table):return (rows('SELECT MAX(id) FROM '+table)[0][0] or 0)+1
 def insert(table,values):
  if not set(values).issubset({c['name'] for c in store.tables[table]['columns']}):raise GovernanceReadError('EMS metadata schema differs: '+table)
  values={'_primecare_import_row':store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+store.table(table)).fetchone()[0],**values};keys=list(values)
  store.db.execute('INSERT INTO '+store.table(table)+' ('+','.join(quote(k) for k in keys)+') VALUES ('+','.join(['%s']*len(keys))+')',[values[k] if k=='_primecare_import_row' else store._value(table,k,values[k]) for k in keys])
 role=one("SELECT id FROM roles WHERE role_code='code_admin' AND active=1")
 ui_app=one("SELECT id FROM apps WHERE app_code='go'");api_app=one("SELECT id FROM apps WHERE app_code='gv'")
 screens=rows('SELECT id,app_id,role_id,screen_code,route_path,actual_file_path,active FROM screens WHERE screen_code=? OR route_path=?',(d['screenCode'],d['route']))
 if not screens:
  screen=next_id('screens');insert('screens',dict(id=screen,app_id=ui_app,role_id=role,screen_code=d['screenCode'],screen_name=d['screenName'],route_path=d['route'],actual_file_path=d['file'],stage='created',active=1,implementation_tag='implemented',content_tag='governed_content',api_tag='ems_read_only',test_tag='production_unverified'))
 elif len(screens)==1 and screens[0][1:]==(ui_app,role,d['screenCode'],d['route'],d['file'],1):screen=screens[0][0]
 else:raise GovernanceReadError('Preserve conflicting EMS screen metadata')
 grants=rows('SELECT can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(role,screen))
 if not grants:insert('role_screen_permissions',dict(id=next_id('role_screen_permissions'),role_id=role,screen_id=screen,can_view=1,can_create=0,can_edit=0,can_delete=0,can_export=0))
 elif grants!=[(1,0,0,0,0)]:raise GovernanceReadError('Preserve conflicting EMS screen grant')
 ids={}
 for op in d['operations']:
  request={'type':'object','additionalProperties':False,'properties':{k:{'type':t} for k,t in [('limit','integer'),('offset','integer'),('search','string'),('app','string'),('role','string'),('screen','string')]}} if op['usesPagination'] else {'type':'object','additionalProperties':False}
  required=['data','pagination'] if op['usesPagination'] else ['declarations','readiness'] if op['name']=='summary' else ['status','observedAt']
  response={'type':'object','required':required}
  found=rows('SELECT id,app_id,endpoint_code,service_name,auth_required,permission_key,uses_pagination,request_schema,response_schema FROM api_endpoints WHERE http_method=? AND route_path=?',('GET',op['path']))
  if not found:
   aid=next_id('api_endpoints');insert('api_endpoints',dict(id=aid,app_id=api_app,endpoint_code=op['code'],route_path=op['path'],http_method='GET',service_name='governance',auth_required=1,implementation_status='implemented',permission_key='role_screen_permissions',request_schema=json.dumps(request),response_schema=json.dumps(response),rate_limit_key='ems.source',uses_pagination=int(op['usesPagination'])))
  elif len(found)==1 and found[0][1:7]==(api_app,op['code'],'governance',1,'role_screen_permissions',int(op['usesPagination'])):
   if json.loads(found[0][7])!=request or json.loads(found[0][8])!=response:raise GovernanceReadError('Preserve conflicting EMS endpoint schemas')
   aid=found[0][0]
  else:raise GovernanceReadError('Preserve conflicting EMS endpoint metadata')
  ids[op['name']]=aid
  links=rows('SELECT screen_id FROM screen_api_links WHERE screen_id=? AND api_id=?',(screen,aid))
  if not links:
   values=dict(screen_id=screen,api_id=aid,purpose='Read-only Code Admin EMS; registration is not production readiness evidence')
   if 'id' in {c['name'] for c in store.tables['screen_api_links']['columns']}:values['id']=next_id('screen_api_links')
   insert('screen_api_links',values)
  elif len(links)!=1:raise GovernanceReadError('Duplicate EMS screen API link')
  access=rows('SELECT can_access,permission_key FROM api_permissions WHERE role_id=? AND api_id=?',(role,aid))
  if not access:insert('api_permissions',dict(id=next_id('api_permissions'),role_id=role,api_id=aid,can_access=1,permission_key='role_screen_permissions'))
  elif access!=[(1,'role_screen_permissions')]:raise GovernanceReadError('Preserve conflicting EMS endpoint grant')
 return dict(screenId=screen,apiIds=ids,role='code_admin',readOnly=True,productionVerified=False)
def main():
 parser=argparse.ArgumentParser();group=parser.add_mutually_exclusive_group(required=True);group.add_argument('--dry-run',action='store_true');group.add_argument('--apply',action='store_true');args=parser.parse_args()
 with ProductionWorkflowStore() as store:
  receipt=register(store)
  if register(store)!=receipt:raise GovernanceReadError('EMS registration is not idempotent')
  if args.dry_run:store.db.rollback()
 output=ROOT/'test-results/ems';output.mkdir(parents=True,exist_ok=True)
 (output/('registration-dry-run.json' if args.dry_run else 'registration.json')).write_text(json.dumps({**receipt,'dryRun':args.dry_run},indent=2)+'\n')
 print('EMS_REGISTRATION '+json.dumps({**receipt,'dryRun':args.dry_run}))
if __name__=='__main__':main()
