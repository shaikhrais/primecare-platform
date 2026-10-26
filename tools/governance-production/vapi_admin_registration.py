import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=ROOT/'packages/shared/src/communications/vapi-admin-contract.json'
TABLES=['api_endpoints','api_permissions','screen_api_links','role_screen_permissions']
def scope():return dict(optInVariable='GOVERNANCE_VAPI_ADMIN_WRITES',tables=TABLES,definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,accountAssignments=False)
def apply(store):
 if store.pin.get('vapiAdminWriter')!=scope() or os.environ.get('GOVERNANCE_VAPI_ADMIN_WRITES')!='1':raise GovernanceReadError('Exact Vapi management writer scope required')
 store.db.execute('LOCK TABLE '+','.join(store.table(t) for t in TABLES)+' IN SHARE ROW EXCLUSIVE MODE')
 def rows(q,v=()):return store.execute(q,v).fetchall()
 def one(q,v=()):
  found=rows(q,v)
  if len(found)!=1:raise GovernanceReadError('Unique Vapi management dependency required')
  return found[0][0]
 def nextid(t):return (rows('SELECT MAX(id) FROM '+t)[0][0] or 0)+1
 def insert(t,v):
  if not set(v).issubset({c['name'] for c in store.tables[t]['columns']}):raise GovernanceReadError('Metadata schema mismatch')
  v={'_primecare_import_row':store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+store.table(t)).fetchone()[0],**v}
  keys=list(v);store.db.execute('INSERT INTO '+store.table(t)+' ('+','.join(quote(k) for k in keys)+') VALUES ('+','.join(['%s']*len(keys))+')',[v[k] if k=='_primecare_import_row' else store._value(t,k,v[k]) for k in keys])
 d=json.loads(FILE.read_text());screen=one('SELECT id FROM screens WHERE id=? AND active=1',(d['screenId'],));role=one("SELECT id FROM roles WHERE role_code='code_admin' AND active=1");app=one("SELECT id FROM apps WHERE app_code='gv'")
 grants=rows('SELECT can_view FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(role,screen))
 if not grants:insert('role_screen_permissions',dict(id=nextid('role_screen_permissions'),role_id=role,screen_id=screen,can_view=1,can_create=1,can_edit=1,can_delete=0,can_export=0))
 elif grants!=[(1,)]:raise GovernanceReadError('Preserve differing screen grant')
 ids=[]
 for op in d['operations']:
  found=rows('SELECT id,endpoint_code,permission_key,service_name FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path']))
  if not found:
   aid=nextid('api_endpoints');insert('api_endpoints',dict(id=aid,app_id=app,endpoint_code=op['code'],route_path=op['path'],http_method=op['method'],service_name='governance',auth_required=1,implementation_status='implemented',permission_key='role_screen_permissions',request_schema=json.dumps({'type':'object'}),response_schema=json.dumps({'type':'object'}),rate_limit_key='platform.actor',uses_pagination=0))
  elif len(found)==1 and found[0][1:]==(op['code'],'role_screen_permissions','governance'):aid=found[0][0]
  else:raise GovernanceReadError('Preserve differing API registration')
  ids.append(aid)
  links=rows('SELECT screen_id FROM screen_api_links WHERE screen_id=? AND api_id=?',(screen,aid))
  if not links:insert('screen_api_links',dict(screen_id=screen,api_id=aid,purpose='Code Admin Vapi configuration management; no calls or business-task execution'))
  elif len(links)!=1:raise GovernanceReadError('Duplicate link')
  access=rows('SELECT can_access,permission_key FROM api_permissions WHERE role_id=? AND api_id=?',(role,aid))
  if not access:insert('api_permissions',dict(id=nextid('api_permissions'),role_id=role,api_id=aid,can_access=1,permission_key='role_screen_permissions'))
  elif access!=[(1,'role_screen_permissions')]:raise GovernanceReadError('Preserve differing API grant')
 return dict(screenId=screen,apiIds=ids,role='code_admin',businessActionsEnabled=False)
with ProductionWorkflowStore() as store:
 receipt=apply(store)
 if apply(store)!=receipt:raise GovernanceReadError('Registration not idempotent')
out=ROOT/'test-results/vapi';out.mkdir(parents=True,exist_ok=True);(out/'ui-registration.json').write_text(json.dumps(receipt,indent=2)+'\n');print('VAPI_UI_REGISTRATION '+json.dumps(receipt))
