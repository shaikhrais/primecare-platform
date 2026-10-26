"""Exact production-only registration for the user-requested Look Manager."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('look-manager-registration.json')
REGISTRY=ROOT/'packages/shared/src/look/registry.json'
def scope():
 d=json.loads(FILE.read_text())
 return dict(optInVariable='GOVERNANCE_LOOK_MANAGER_WRITES',tables=d['tables'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),registrySha256=hashlib.sha256(REGISTRY.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,accountAssignments=False)
def register(store):
 d=json.loads(FILE.read_text());registry=json.loads(REGISTRY.read_text())
 if store.pin.get('lookManagerWriter')!=scope() or os.environ.get('GOVERNANCE_LOOK_MANAGER_WRITES')!='1':raise GovernanceReadError('Exact Look Manager writer scope required')
 store.db.execute('LOCK TABLE '+','.join(store.table(t) for t in d['tables'])+' IN SHARE ROW EXCLUSIVE MODE')
 def rows(sql,args=()):return store.execute(sql,args).fetchall()
 def one(sql,args=()):
  found=rows(sql,args)
  if len(found)!=1:raise GovernanceReadError('Unique registered Look dependency required')
  return found[0][0]
 def next_id(table,col='id'):return (rows('SELECT MAX('+col+') FROM '+table)[0][0] or 0)+1
 def insert(table,values):
  columns={c['name'] for c in store.tables[table]['columns']}
  if not set(values).issubset(columns):raise GovernanceReadError('Registration schema mismatch: '+table)
  values={'_primecare_import_row':store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+store.table(table)).fetchone()[0],**values};keys=list(values)
  store.db.execute('INSERT INTO '+store.table(table)+' ('+','.join(quote(k) for k in keys)+') VALUES ('+','.join(['%s']*len(keys))+')',[values[k] if k=='_primecare_import_row' else store._value(table,k,values[k]) for k in keys])
 roles={role:one('SELECT id FROM roles WHERE role_code=? AND active=1',(role,)) for role in d['roles']}
 app=one("SELECT id FROM apps WHERE app_code='go'");api_app=one("SELECT id FROM apps WHERE app_code='gv'")
 screens=rows('SELECT id,route_path FROM screens WHERE screen_code=?',(d['screenCode'],))
 if not screens:
  screen=next_id('screens');insert('screens',dict(id=screen,app_id=app,role_id=roles['code_admin'],screen_code=d['screenCode'],screen_name='Look Review Manager',route_path=d['route'],actual_file_path='websites/typescript/src/look-review.ts',stage='created',active=1,implementation_tag='implemented',content_tag='governed_content',api_tag='look_connected',test_tag='test_pending'))
 elif len(screens)==1 and screens[0][1]==d['route']:screen=screens[0][0]
 else:raise GovernanceReadError('Existing Look screen differs')
 api_ids=[]
 for i,c in enumerate(registry['contracts']):
  path=registry['endpoint']+c['suffix'];found=rows('SELECT id,permission_key,service_name FROM api_endpoints WHERE route_path=? AND http_method=?',(path,c['method']))
  if not found:
   aid=next_id('api_endpoints');insert('api_endpoints',dict(id=aid,app_id=api_app,endpoint_code=['LOOK_LIST','LOOK_SUBMIT','LOOK_IMAGE','LOOK_AI','LOOK_HUMAN'][i],route_path=path,http_method=c['method'],service_name='governance',auth_required=1,implementation_status='implemented',permission_key=d['permission'],request_schema=json.dumps(c['request']),response_schema=json.dumps({'type':'object'}),rate_limit_key='look.actor',uses_pagination=0))
  elif len(found)==1 and found[0][1:]==(d['permission'],'governance'):aid=found[0][0]
  else:raise GovernanceReadError('Existing Look API differs; preserve it')
  api_ids.append(aid)
  links=rows('SELECT screen_id FROM screen_api_links WHERE screen_id=? AND api_id=?',(screen,aid))
  if not links:insert('screen_api_links',dict(screen_id=screen,api_id=aid,purpose='Exact screenshot AI assessment followed by independent human review'))
  elif len(links)!=1:raise GovernanceReadError('Duplicate screen API link')
 for role,rid in roles.items():
  grants=rows('SELECT can_view,can_create,can_edit FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(rid,screen))
  if not grants:insert('role_screen_permissions',dict(id=next_id('role_screen_permissions'),role_id=rid,screen_id=screen,can_view=1,can_create=1,can_edit=1,can_delete=0,can_export=0))
  elif grants!=[(1,1,1)]:raise GovernanceReadError('Existing Look screen grant differs')
  for aid in api_ids:
   access=rows('SELECT can_access,permission_key FROM api_permissions WHERE role_id=? AND api_id=?',(rid,aid))
   if not access:insert('api_permissions',dict(id=next_id('api_permissions'),role_id=rid,api_id=aid,can_access=1,permission_key=d['permission']))
   elif access!=[(1,d['permission'])]:raise GovernanceReadError('Existing Look API grant differs')
 resources={}
 for resource,key in rows("SELECT resource_id,resource_key FROM language_resources WHERE resource_key LIKE ?",('look.%',)):
  if key in resources:raise GovernanceReadError('Duplicate Look translation key')
  resources[key]=resource
 translations={}
 for resource,language,text in rows("SELECT r.resource_id,v.language_id,v.translated_text FROM language_resources r JOIN language_resource_values v ON r.resource_id=v.resource_id WHERE r.resource_key LIKE ?",('look.%',)):
  if (resource,language) in translations:raise GovernanceReadError('Duplicate Look translation')
  translations[(resource,language)]=text
 for lang,values in registry['locales'].items():
  lid=one('SELECT language_id FROM languages WHERE language_code=?',(lang,))
  for key,text in values.items():
   code='look.'+key;found=resources.get(code)
   if not found:
    resource=next_id('language_resources','resource_id');insert('language_resources',dict(resource_id=resource,resource_key=code,resource_group='look',description='Look Manager visual review',context='look',active=1));resources[code]=resource
   else:resource=found
   old=translations.get((resource,lid))
   if old is None:insert('language_resource_values',dict(resource_id=resource,language_id=lid,translated_text=text,reviewed=0,approved=0,version='look-v2'));translations[(resource,lid)]=text
   elif old!=text:raise GovernanceReadError('Existing Look translation differs')
 return dict(screenId=screen,apiIds=api_ids,roles=list(roles),productionAuthority=True,accountAssignments=0,humanApprovals=0)
def main():
 if sys.argv[1:] not in [['--apply'],['--dry-run']]:raise SystemExit('Explicit --apply or --dry-run required')
 with ProductionWorkflowStore() as store:
  receipt=register(store)
  if receipt!=register(store):raise GovernanceReadError('Look registration is not idempotent')
  if sys.argv[1]=='--dry-run':store.db.rollback()
 out=ROOT/'test-results/look';out.mkdir(parents=True,exist_ok=True);(out/'registration.json').write_text(json.dumps(receipt,indent=2)+'\n');print('LOOK_REGISTRATION '+json.dumps(receipt))
if __name__=='__main__':main()
