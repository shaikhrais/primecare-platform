"""Batch 16: owner-bound provider profile and availability reads."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
profile={'type':'object','additionalProperties':False,'required':['id','full_name','bio','languages','service_areas','provider_type','is_approved','skills'],'properties':{'id':{'type':'string'},'full_name':{'type':'string'},'bio':{'type':['string','null']},**{k:{'type':'string'} for k in ['languages','service_areas','provider_type','skills']},'is_approved':{'type':'boolean'}}}
availability={'type':'object','additionalProperties':False,'required':['id','day_of_week','start_time','end_time'],'properties':{'id':{'type':'string'},'day_of_week':{'type':'integer'},'start_time':{'type':'string'},'end_time':{'type':'string'}}}
pagination={'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
group={'type':'object','additionalProperties':False,'required':['day_of_week','count'],'properties':{'day_of_week':{'type':'integer'},'count':{'type':'integer'}}}
ops=[('/v1/provider/availability/{availabilityId}',{}, {'type':'object','required':['availability'],'properties':{'availability':availability}},'Read own availability record'),('/v1/provider/availability/summary',paging,{'type':'object','required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}},'Count own availability by stored weekday')]

paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches(route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 sid=db.execute("SELECT id FROM screens WHERE screen_code='psw_profile'").fetchone()[0]
 app=db.execute('SELECT app_id FROM screens WHERE id=?',(sid,)).fetchone()[0]
 for path,query,response,title in ops:
  code='PROVIDER_SELF_AVAILABILITY_DETAIL' if '{availabilityId}' in path else 'PROVIDER_SELF_AVAILABILITY_SUMMARY'
  req={'type':'object','additionalProperties':False,'properties':query}
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
   SELECT ?,?,?,'GET','provider',1,'implemented','authenticated_provider_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')''',(app,code,path,json.dumps(req),json.dumps(response),int(bool(query)),path))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(path,)).fetchone()[0]
  db.execute("UPDATE api_endpoints SET permission_key='authenticated_provider_profile_owner',request_schema=?,response_schema=? WHERE id=?",(json.dumps(req),json.dumps(response),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Authenticated owner only via provider_profiles.user_id and tenant_id; screen grants never bypass ownership'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,16,'authenticated_provider_profile_owner','implemented','pending')",('GET '+path,sid))
  paths[path]={'get':{'operationId':code.lower(),'summary':title,'description':'Active explicit bearer session. provider_profiles.user_id must match the actor and tenant_id must match the actor tenant. No arbitrary providerId/userId/tenant overrides. Availability query additionally checks provider_id and tenant. Missing profile returns 404; conflicting tenant header returns 403. No client details or provider compliance/retraining fields are returned. Summary groups count stored availability rows by day_of_week; they do not infer free appointment capacity, timezone or weekday numbering. No new role grants.',
   'security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in query.items()]+([{'in':'path','name':'availabilityId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}}] if '{availabilityId}' in path else []),
   'responses':{'200':{'description':'Owner data','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'Invalid session'),(403,'Tenant mismatch'),(404,'Own provider profile absent'),(405,'Unsupported method'),(429,'Source limit'),(503,'Database unavailable or schema dependency missing')]}}}}
 target=ROOT/'docs/api/provider-availability-batch-16.openapi.json';target.write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Provider Availability Batch 16','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered provider owner-bound reads; no new role grants.')
