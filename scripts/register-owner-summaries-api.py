"""Batch 14: owner/assignment-bound summaries from stored status values."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for service,route,screen,permission in [('client','/v1/client/bookings/summary','client_profile','authenticated_client_profile_owner'),('provider','/v1/provider/visits/summary','psw_profile','authenticated_assigned_provider_visit')]:
  sid,app=db.execute('SELECT id,app_id FROM screens WHERE screen_code=?',(screen,)).fetchone()
  fields={'status':{'type':['string','null']},'count':{'type':'integer'}}
  if service=='provider':fields['durationMinutes']={'type':'string','description':'Exact sum of recorded duration_minutes; not billable or completed time.'}
  group={'type':'object','additionalProperties':False,'required':list(fields),'properties':fields}
  response={'type':'object','required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':{'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}}}
  request={'type':'object','additionalProperties':False,'properties':paging}
  code=service.upper()+'_OWN_STATUS_SUMMARY'
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
    SELECT ?,?,?,'GET',?,1,'implemented',?,?,?,'workspace.source',1 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')''',(app,code,route,service,permission,json.dumps(request),json.dumps(response),route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Stored status summaries with owner/assignment and tenant checks; no inferred permissions or completion'))
  db.execute('INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,14,?,\'implemented\',\'pending\')',('GET '+route,sid,permission))
  paths[route]={'get':{'operationId':code.lower(),'summary':'Own booking status totals' if service=='client' else 'Assigned visit status totals',
   'description':'Active explicit bearer session, owned profile and matching tenant required. Queries restrict client_id or assigned_provider_id to that profile and tenant_id to the actor tenant. Groups use stored statuses, including null. No arbitrary owner or date/status filters. Provider durations are recorded sums, not clinical completion or billable time. No new role grants.',
   'security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in paging.items()],
   'responses':{'200':{'description':'Status groups with bounded pagination','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'Invalid session'),(403,'Tenant mismatch'),(404,'Own profile absent'),(405,'Unsupported method'),(429,'Source limit'),(503,'Database unavailable')]}}}}
 target=ROOT/'docs/api/owner-summaries-batch-14.openapi.json';target.write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owner Status Summaries Batch 14','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered scoped status summaries; no new role grants.')
