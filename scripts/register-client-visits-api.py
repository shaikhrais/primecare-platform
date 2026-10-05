"""Batch 11: client own visit reads."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
visit={'type':'object','additionalProperties':False,'required':['id','service_id','requested_start_at','duration_minutes','status','priority','updated_at'],'properties':{'id':{'type':'string'},'service_id':{'type':'string'},'requested_start_at':{'type':'string','format':'date-time'},'duration_minutes':{'type':'integer'},'status':{'type':['string','null']},'priority':{'type':['string','null']},'updated_at':{'type':'string','format':'date-time'}}}
ops=[('/v1/client/visits',paging,{'type':'object','required':['visits','pagination'],'properties':{'visits':{'type':'array','items':visit},'pagination':{'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}}},'List own visits'),('/v1/client/visits/{visitId}',{}, {'type':'object','required':['visit'],'properties':{'visit':visit}},'Read own visit')]
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches(route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 sid=db.execute("SELECT id FROM screens WHERE screen_code='client_profile'").fetchone()[0]
 app=db.execute('SELECT app_id FROM screens WHERE id=?',(sid,)).fetchone()[0]
 for path,query,response,title in ops:
  code='CLIENT_OWN_VISIT_DETAIL' if '{visitId}' in path else 'CLIENT_OWN_VISITS'
  req={'type':'object','additionalProperties':False,'properties':query}
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
   SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')''',(app,code,path,json.dumps(req),json.dumps(response),int(bool(query)),path))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(path,)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Authenticated owner only via client_profiles.user_id and tenant_id; screen grants never bypass ownership'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,11,'authenticated_client_profile_owner','implemented','pending')",('GET '+path,sid))
  paths[path]={'get':{'operationId':code.lower(),'summary':title,'description':'Active explicit bearer session. client_profiles.user_id must match the actor and tenant_id must match the actor tenant. No arbitrary clientId/userId/tenant overrides. Visit queries additionally require client_id to match the owned client profile and tenant_id to match the actor tenant. Missing profile returns 404; conflicting tenant header returns 403. Only operational visit summaries are returned. No client identifiers, addresses or clinical/management notes. No new role grants.',
   'security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in query.items()]+([{'in':'path','name':'visitId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}}] if '{visitId}' in path else []),
   'responses':{'200':{'description':'Owner data','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'Invalid session'),(403,'Tenant mismatch'),(404,'Own client profile or visit absent'),(405,'Unsupported method'),(429,'Source limit'),(503,'Database unavailable or schema dependency missing')]}}}}
 target=ROOT/'docs/api/client-visits-batch-11.openapi.json';target.write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client Visits Batch 11','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered client owner-bound reads; no new role grants.')
