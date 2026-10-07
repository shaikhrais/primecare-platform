"""Reconcile the existing request caller with canonical owner-scoped submission."""
import copy, json, sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
route='/v1/client/bookings/request';canonical='/v1/client/booking-requests'
permission='authenticated_client_profile_owner'
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 rows=db.execute("SELECT id,service_name,auth_required,permission_key,request_schema,response_schema FROM api_endpoints WHERE http_method='POST' AND route_path=?",(canonical,)).fetchall()
 if len(rows)!=1 or rows[0][1:4]!=('client',1,permission):raise RuntimeError('Booking submission canonical authority drift')
 aid,_,_,_,request,response=rows[0]
 op=copy.deepcopy(json.loads((ROOT/'docs/api/client-booking-lifecycle-batch-19.openapi.json').read_text())['paths'][canonical]['post'])
 if op['requestBody']['content']['application/json']['schema']!=json.loads(request) or op['responses']['201']['content']['application/json']['schema']!=json.loads(response):raise RuntimeError('Booking submission canonical contract drift')
 links=db.execute('SELECT screen_id FROM screen_api_links WHERE api_id=? ORDER BY screen_id',(aid,)).fetchall()
 if not links:raise RuntimeError('Booking submission canonical screen missing')
 aliases=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE http_method='POST' AND route_path=?",(route,)).fetchall()
 if len(aliases)!=1 or aliases[0][1:] not in [('PRISMA',1,None),('client',1,permission)]:raise RuntimeError('Booking submission alias authority drift')
 alias_id=aliases[0][0]
 db.execute("UPDATE api_endpoints SET service_name='client',auth_required=1,permission_key=?,implementation_status='implemented',request_schema=?,response_schema=?,rate_limit_key='workspace.source',uses_pagination=0,health_status='unverified' WHERE id=?",(permission,request,response,alias_id))
 for (sid,) in links:db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,alias_id,'Exact submission compatibility route to '+canonical+'; existing owner authority'))
 db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,0,?,'implemented','pending')",('POST '+route,links[0][0],permission))
op['operationId']='clientBookingSubmissionCompatibility'
op['description']='Exact POST compatibility route to '+canonical+'. '+op['description']+' Caller fields are service_type, preferred_date (UTC), optional preferred_time and notes. Legacy serviceTypeId/date/time/duration fields are rejected rather than silently converted. This creates a pending request, not a confirmed appointment. No new role grants.'
(ROOT/'docs/api/booking-submission-delivery.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Booking Submission Reconciliation','version':'1.0.0'},'paths':{route:{'post':op}},'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Reconciled one exact owner-scoped booking submission; no role grants.')
