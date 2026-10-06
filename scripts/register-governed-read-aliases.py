"""Batches 106–157: repair existing ungoverned read declarations with owned metadata aliases."""
import copy,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=json.loads((ROOT/'scripts/governed-read-alias-definitions.json').read_text())
if len({e['batch'] for e in definitions})!=len(definitions) or len({e['name'] for e in definitions})!=len(definitions):raise RuntimeError('Duplicate alias batch or path')
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for entry in definitions:
  batch,name,service,target,canonical,specname=[entry[k] for k in ['batch','name','service','targetPath','canonical','spec']]
  if canonical!='/v1/'+service+target or service not in ['auth','client','provider']:raise RuntimeError('Invalid canonical service relationship')
  route='/v1/premium/'+name
  canonical_row=db.execute("SELECT id,permission_key,request_schema,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(canonical,)).fetchall()
  if len(canonical_row)!=1 or not canonical_row[0][1]:raise RuntimeError('Unique governed canonical endpoint required: '+canonical)
  aid,permission,request,response=canonical_row[0]
  request_object,response_object=json.loads(request),json.loads(response)
  if not isinstance(request_object,dict) or not isinstance(response_object,dict):raise RuntimeError('Canonical object schemas required')
  operation=copy.deepcopy(json.loads((ROOT/'docs/api'/specname).read_text())['paths'][canonical]['get'])
  if operation['responses']['200']['content']['application/json']['schema']!=response_object:raise RuntimeError('Canonical database/OpenAPI response drift: '+canonical)
  links=db.execute('SELECT screen_id FROM screen_api_links WHERE api_id=? ORDER BY screen_id',(aid,)).fetchall()
  if not links:raise RuntimeError('Canonical screen association required: '+canonical)
  existing=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(existing)!=1:raise RuntimeError('Unique existing alias declaration required: '+route)
  alias_id=existing[0][0]
  db.execute("UPDATE api_endpoints SET service_name=?,auth_required=1,implementation_status='implemented',permission_key=?,request_schema=?,response_schema=?,rate_limit_key='workspace.source',uses_pagination=?,health_status='unverified' WHERE id=?",(service,permission,request,response,int('pagination' in json.loads(response).get('properties',{})),alias_id))
  for (sid,) in links:db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,alias_id,'Compatibility route for canonical owned metadata only: '+canonical))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?,'implemented','pending')",('GET '+route,links[0][0],batch,permission))
  operation['operationId']='governed_compat_'+name
  operation['summary']='Read own metadata through the '+name+' compatibility route'
  operation['description']='Read-only compatibility route to '+canonical+'. This returns the canonical ownership-scoped metadata response, not an unrestricted ORM collection. Only the exact registered collection path and GET are supported. Writes are denied before forwarding; detail/nested or other premium routes remain unhandled. Query, active bearer, non-null tenant, profile uniqueness where applicable, projection, no-store and source limits are enforced by the canonical handler. No role grants, arbitrary owner/tenant filters, business writes or additional record access. Stored metadata does not establish approval, clinical access, document verification or completed care.'
  paths[route]={'get':operation}
  registry.append({'batch':batch,'path':route,'service':service,'targetPath':target,'canonical':canonical})
(ROOT/'cloudflare/workers/src/governed-read-aliases.json').write_text(json.dumps(registry,indent=2)+'\n')
(ROOT/'docs/api/governed-read-aliases.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Governed Compatibility Reads','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered existing owned read aliases 106–157; no new operations or grants.')
