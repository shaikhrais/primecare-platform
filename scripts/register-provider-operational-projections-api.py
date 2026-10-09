"""Batches 196–198: exact fail-closed provider operational read contracts."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
DB=ROOT/'.agents/governance/governance.db'
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
date={'type':'string','format':'date-time'}
nullable_date={'type':['string','null'],'format':'date-time'}
nullable_string={'type':['string','null']}
profile={'type':'object','additionalProperties':False,'required':['id','full_name','bio','languages','service_areas','provider_type','is_approved','skills'],'properties':{'id':{'type':'string'},'full_name':{'type':'string'},'bio':nullable_string,'languages':{'type':'string'},'service_areas':{'type':'string'},'provider_type':{'type':'string'},'is_approved':{'type':'boolean'},'skills':{'type':'string'}}}
availability={'type':'object','additionalProperties':False,'required':['id','day_of_week','start_time','end_time'],'properties':{'id':{'type':'string'},'day_of_week':{'type':'integer'},'start_time':{'type':'string'},'end_time':{'type':'string'}}}
visit={'type':'object','additionalProperties':False,'required':['id','service_id','requested_start_at','duration_minutes','status','priority','updated_at'],'properties':{'id':{'type':'string'},'service_id':{'type':'string'},'requested_start_at':date,'duration_minutes':{'type':'integer'},'status':nullable_string,'priority':nullable_string,'updated_at':date}}
document={'type':'object','additionalProperties':False,'required':['id','doc_type','status','expiry_date','verified_at','created_at','updated_at'],'properties':{'id':{'type':'string'},'doc_type':{'type':'string'},'status':nullable_string,'expiry_date':nullable_date,'verified_at':nullable_date,'created_at':date,'updated_at':date}}
status_group={'type':'object','additionalProperties':False,'required':['status','count'],'properties':{'status':nullable_string,'count':{'type':'integer','minimum':0}}}
visit_group={'type':'object','additionalProperties':False,'required':['status','count','durationMinutes'],'properties':{'status':nullable_string,'count':{'type':'integer','minimum':0},'durationMinutes':{'type':'string','pattern':'^-?\\d+$','description':'Exact sum of recorded duration_minutes; not billable or completed time.'}}}
availability_group={'type':'object','additionalProperties':False,'required':['day_of_week','count'],'properties':{'day_of_week':{'type':'integer'},'count':{'type':'integer','minimum':0}}}

def detail(name,item):return {'type':'object','additionalProperties':False,'required':[name],'properties':{name:item}}
def listing(name,item):return {'type':'object','additionalProperties':False,'required':[name,'pagination'],'properties':{name:{'type':'array','items':item},'pagination':pagination}}
def summary(group):return {'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}

definitions=[
 (196,'/v1/provider/profile','authenticated_provider_profile_owner',False,detail('profile',profile),'provider-self-batch-8.openapi.json'),
 (196,'/v1/provider/availability','authenticated_provider_profile_owner',True,listing('availability',availability),'provider-self-batch-8.openapi.json'),
 (196,'/v1/provider/availability/{availabilityId}','authenticated_provider_profile_owner',False,detail('availability',availability),'provider-availability-batch-16.openapi.json'),
 (196,'/v1/provider/availability/summary','authenticated_provider_profile_owner',True,summary(availability_group),'provider-availability-batch-16.openapi.json'),
 (197,'/v1/provider/visits','authenticated_assigned_provider_visit',True,listing('visits',visit),'provider-visits-batch-10.openapi.json'),
 (197,'/v1/provider/visits/{visitId}','authenticated_assigned_provider_visit',False,detail('visit',visit),'provider-visits-batch-10.openapi.json'),
 (197,'/v1/provider/visits/summary','authenticated_assigned_provider_visit',True,summary(visit_group),'owner-summaries-batch-14.openapi.json'),
 (198,'/v1/provider/documents','authenticated_provider_profile_owner',True,listing('documents',document),'provider-documents-batch-13.openapi.json'),
 (198,'/v1/provider/documents/{documentId}','authenticated_provider_profile_owner',False,detail('document',document),'provider-documents-batch-13.openapi.json'),
 (198,'/v1/provider/documents/summary','authenticated_provider_profile_owner',True,summary(status_group),'visit-document-summaries-batch-15.openapi.json'),
]

paths={}
with sqlite3.connect(DB) as db:
 sid=db.execute("SELECT id FROM screens WHERE screen_code='psw_profile'").fetchone()[0]
 for batch,route,permission,paged,response,_ in definitions:
  rows=db.execute("SELECT id,endpoint_code,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=1 or rows[0][2:]!=('provider',1,permission):raise RuntimeError('Provider authority drift: '+route)
  aid,code,*_=rows[0]
  request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?,'implemented','pending')",('GET '+route,sid,batch,permission))
  parameters=[{'in':'query','name':name,'schema':schema} for name,schema in (paging.items() if paged else [])]
  for name in ('availabilityId','visitId','documentId'):
   if '{'+name+'}' in route:parameters.append({'in':'path','name':name,'required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}})
  paths[route]={'get':{'operationId':code.lower(),'summary':'Read validated provider operational data','description':'Active explicit bearer session, exactly one actor-owned ProviderProfile and matching non-null tenant are required. Availability and documents retain profile-owner authority; visits retain assigned-provider authority. Runtime projections, timestamps, nullable fields, counts and stored groups are validated without coercion; malformed database values return sanitized 503. Read only, no owner overrides, role grants, client identifiers, document contents, clinical interpretation, approval, completion or readiness claims.','security':[{'bearerAuth':[]}],'parameters':parameters,'responses':{'200':{'description':'Validated scoped provider data','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid identifier, query or body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile or scoped record absent'),(405,'Read only'),(429,'Source limit'),(503,'Provider data unavailable')]}}}}

# Compatibility registrations compare canonical database and OpenAPI schemas.
for filename in sorted({entry[5] for entry in definitions}):
 target=ROOT/'docs/api'/filename
 source=json.loads(target.read_text())
 for _,route,_,_,_,spec in definitions:
  if spec==filename:source['paths'][route]['get']['responses']['200']['content']['application/json']['schema']=paths[route]['get']['responses']['200']['content']['application/json']['schema']
 target.write_text(json.dumps(source,indent=2)+'\n')

(ROOT/'docs/api/provider-operational-projections-batches-196-198.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Validated Provider Operational Reads','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 196–198 validated provider operational reads; existing authority only.')
