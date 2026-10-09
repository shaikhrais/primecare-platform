"""Batches 191–194: exact fail-closed client operational read contracts."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
DB=ROOT/'.agents/governance/governance.db'
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
date={'type':'string','format':'date-time'}
nullable_string={'type':['string','null']}
profile={'type':'object','additionalProperties':False,'required':['id','full_name','city','province','postal_code','updated_at'],'properties':{'id':{'type':'string'},'full_name':{'type':'string'},'city':nullable_string,'province':nullable_string,'postal_code':nullable_string,'updated_at':date}}
booking={'type':'object','additionalProperties':False,'required':['id','start_at','end_at','service_type','priority','status','recurrence_rule'],'properties':{'id':{'type':'string'},'start_at':date,'end_at':date,'service_type':{'type':'string'},'priority':{'type':'string'},'status':{'type':'string'},'recurrence_rule':nullable_string}}
visit={'type':'object','additionalProperties':False,'required':['id','service_id','requested_start_at','duration_minutes','status','priority','updated_at'],'properties':{'id':{'type':'string'},'service_id':{'type':'string'},'requested_start_at':date,'duration_minutes':{'type':'integer'},'status':nullable_string,'priority':nullable_string,'updated_at':date}}
booking_request={'type':'object','additionalProperties':False,'required':['id','service_type','preferred_date','preferred_time','status','created_at','updated_at'],'properties':{'id':{'type':'string'},'service_type':{'type':'string'},'preferred_date':date,'preferred_time':nullable_string,'status':{'type':'string'},'created_at':date,'updated_at':date}}
group={'type':'object','additionalProperties':False,'required':['status','count'],'properties':{'status':nullable_string,'count':{'type':'integer','minimum':0}}}

def list_response(collection,item):
 return {'type':'object','additionalProperties':False,'required':[collection,'pagination'],'properties':{collection:{'type':'array','items':item},'pagination':pagination}}
def detail_response(name,item):
 return {'type':'object','additionalProperties':False,'required':[name],'properties':{name:item}}
summary={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
definitions=[
 (191,'/v1/client/home/profile',False,{'type':'object','additionalProperties':False,'required':['profile'],'properties':{'profile':profile}}),
 (192,'/v1/client/bookings',True,list_response('bookings',booking)),
 (192,'/v1/client/bookings/{bookingId}',False,detail_response('booking',booking)),
 (192,'/v1/client/bookings/summary',True,summary),
 (193,'/v1/client/visits',True,list_response('visits',visit)),
 (193,'/v1/client/visits/{visitId}',False,detail_response('visit',visit)),
 (193,'/v1/client/visits/summary',True,summary),
 (194,'/v1/client/booking-requests',True,list_response('requests',booking_request)),
 (194,'/v1/client/booking-requests/{requestId}',False,detail_response('request',booking_request)),
 (194,'/v1/client/booking-requests/summary',True,summary),
]

paths={}
with sqlite3.connect(DB) as db:
 sid=db.execute("SELECT id FROM screens WHERE screen_code='client_profile'").fetchone()[0]
 for batch,route,paged,response in definitions:
  row=db.execute("SELECT id,endpoint_code,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(row)!=1 or row[0][2:]!=('client',1,'authenticated_client_profile_owner'):
   raise RuntimeError('Client owner authority drift: '+route)
  aid,code,*_=row[0]
  request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  parameters=[{'in':'query','name':name,'schema':schema} for name,schema in (paging.items() if paged else [])]
  for name in ('bookingId','visitId','requestId'):
   if '{'+name+'}' in route:parameters.append({'in':'path','name':name,'required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}})
  paths[route]={'get':{'operationId':code.lower(),'summary':'Read validated own client operational data','description':'Active explicit bearer session, one client profile owned through client_profiles.user_id, and matching non-null tenant are required. Every domain query binds the owned profile and tenant. Runtime projections, counts, timestamps, nullable fields and stored status groups are validated without coercion; malformed database values return a sanitized 503. Read only; no role grants, owner overrides, clinical interpretation, approval, completion or production-readiness claims.','security':[{'bearerAuth':[]}],'parameters':parameters,'responses':{'200':{'description':'Validated owner-scoped data','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid identifier, query or body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile or record absent'),(405,'Read only'),(429,'Source limit'),(503,'Client data unavailable')]}}}}

# Compatibility registrations consume the original canonical OpenAPI files.
# Keep those exact schemas synchronized before their drift checks execute.
specs={
 '/v1/client/home/profile':'client-self-batch-7.openapi.json',
 '/v1/client/bookings':'client-bookings-batch-9.openapi.json',
 '/v1/client/bookings/{bookingId}':'client-bookings-batch-9.openapi.json',
 '/v1/client/bookings/summary':'owner-summaries-batch-14.openapi.json',
 '/v1/client/visits':'client-visits-batch-11.openapi.json',
 '/v1/client/visits/{visitId}':'client-visits-batch-11.openapi.json',
 '/v1/client/visits/summary':'visit-document-summaries-batch-15.openapi.json',
 '/v1/client/booking-requests':'client-booking-requests-batch-18.openapi.json',
 '/v1/client/booking-requests/{requestId}':'client-booking-requests-batch-18.openapi.json',
 '/v1/client/booking-requests/summary':'booking-payment-batches-23-25.openapi.json',
}
for filename in sorted(set(specs.values())):
 target=ROOT/'docs/api'/filename
 document=json.loads(target.read_text())
 for route,spec in specs.items():
  if spec==filename:document['paths'][route]['get']['responses']['200']['content']['application/json']['schema']=paths[route]['get']['responses']['200']['content']['application/json']['schema']
 target.write_text(json.dumps(document,indent=2)+'\n')

target=ROOT/'docs/api/client-operational-projections-batches-191-194.openapi.json'
target.write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Validated Client Operational Reads','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 191–194 validated client operational reads; existing owner authority only.')
