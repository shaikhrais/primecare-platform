"""Batches 106–110: replace five ungoverned read declarations with owned metadata aliases."""
import copy,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=[(106,'appnotification','auth','/me/notifications','/v1/auth/me/notifications','self-records-batches-26-30.openapi.json'),(107,'stafftask','auth','/me/assigned-task-records','/v1/auth/me/assigned-task-records','personal-authorship-task-batches-76-80.openapi.json'),(108,'booking','client','/bookings','/v1/client/bookings','client-bookings-batch-9.openapi.json'),(109,'bookingrequest','client','/booking-requests','/v1/client/booking-requests','client-booking-requests-batch-18.openapi.json'),(110,'providerdocument','provider','/documents','/v1/provider/documents','provider-documents-batch-13.openapi.json')]
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for batch,name,service,target,canonical,specname in definitions:
  route='/v1/premium/'+name
  canonical_row=db.execute("SELECT id,permission_key,request_schema,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(canonical,)).fetchall()
  if len(canonical_row)!=1 or not canonical_row[0][1]:raise RuntimeError('Unique governed canonical endpoint required: '+canonical)
  aid,permission,request,response=canonical_row[0]
  links=db.execute('SELECT screen_id FROM screen_api_links WHERE api_id=? ORDER BY screen_id',(aid,)).fetchall()
  if not links:raise RuntimeError('Canonical screen association required: '+canonical)
  existing=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(existing)!=1:raise RuntimeError('Unique existing alias declaration required: '+route)
  alias_id=existing[0][0]
  db.execute("UPDATE api_endpoints SET service_name=?,auth_required=1,implementation_status='implemented',permission_key=?,request_schema=?,response_schema=?,rate_limit_key='workspace.source',uses_pagination=1,health_status='unverified' WHERE id=?",(service,permission,request,response,alias_id))
  for (sid,) in links:db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,alias_id,'Compatibility route for canonical owned metadata only: '+canonical))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?,'implemented','pending')",('GET '+route,links[0][0],batch,permission))
  operation=copy.deepcopy(json.loads((ROOT/'docs/api'/specname).read_text())['paths'][canonical]['get'])
  operation['operationId']='governed_compat_'+name
  operation['summary']='Read own metadata through the '+name+' compatibility route'
  operation['description']='Read-only compatibility route to '+canonical+'. This returns the canonical ownership-scoped metadata response, not an unrestricted ORM collection. Only the exact registered collection path and GET are supported. Writes are denied before forwarding; detail/nested or other premium routes remain unhandled. Query, active bearer, non-null tenant, profile uniqueness where applicable, projection, no-store and source limits are enforced by the canonical handler. No role grants, arbitrary owner/tenant filters, business writes or additional record access. Stored metadata does not establish approval, clinical access, document verification or completed care.'
  paths[route]={'get':operation}
  registry.append({'batch':batch,'path':route,'service':service,'targetPath':target,'canonical':canonical})
(ROOT/'cloudflare/workers/src/governed-read-aliases.json').write_text(json.dumps(registry,indent=2)+'\n')
(ROOT/'docs/api/governed-read-aliases-batches-106-110.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Governed Compatibility Reads','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered existing owned read aliases 106–110; no new operations or grants.')
