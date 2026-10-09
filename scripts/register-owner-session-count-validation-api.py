"""Batches 201–202: exact counts for owned booking audit and self sessions."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
sources=[
 (201,'client_profile','client','authenticated_client_profile_owner',ROOT/'docs/api/client-booking-lifecycle-batch-19.openapi.json',[('GET','/v1/client/booking-requests/{requestId}/audit')]),
 (202,'login','auth','authenticated_self_session',ROOT/'docs/api/self-sessions-batch-6.openapi.json',[('GET','/v1/user/sessions'),('DELETE','/v1/user/sessions')]),
]
paths={}
for source in [ROOT/'cloudflare/workers/src/client-booking-lifecycle.ts',ROOT/'cloudflare/workers/src/self-sessions.ts']:
 text=source.read_text()
 if 'const exactCount=' not in text or 'Number((await db.query' in text:raise RuntimeError('Exact count runtime guard missing: '+source.name)
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for batch,screen_code,service,permission,source_file,routes in sources:
  document=json.loads(source_file.read_text());sid=db.execute('SELECT id FROM screens WHERE screen_code=?',(screen_code,)).fetchone()[0]
  for method,route in routes:
   rows=db.execute('SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method=?',(route,method)).fetchall()
   if len(rows)!=1 or rows[0][1:]!=(service,1,permission):raise RuntimeError('Owner/session count authority drift: '+method+' '+route)
   operation=document['paths'][route][method.lower()];schema=operation['responses']['200']['content']['application/json']['schema']
   count_schema=schema['properties']['pagination']['properties']['total'] if method=='GET' else schema['properties']['revokedSessions']
   if count_schema!={'type':'integer','minimum':0}:raise RuntimeError('Exact nonnegative count contract required: '+method+' '+route)
   db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?, 'implemented','pending')",(method+' '+route,sid,batch,permission))
   operation['description']='Active explicit bearer session and matching non-null tenant required. Booking audit retains the unique actor-owned ClientProfile and exact owned request scope; self-session operations derive the User solely from the bearer and accept no user override. Database counts must be nonnegative safe integers without coercion; malformed values roll back and return a sanitized 503. Existing bounded paging, no-store, transaction isolation, mutation budget, idempotency and atomic audit behavior remain unchanged. No role grants, clinical access or business-status claims.'
   paths.setdefault(route,{})[method.lower()]=operation
(ROOT/'docs/api/owner-session-count-validation-batches-201-202.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Booking and Self-Session Count Validation','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 201–202 exact owned booking/session counts; existing authority only.')
