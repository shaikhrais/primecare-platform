"""Batch 22: counts of stored statuses in already governed owned records."""
import json, sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
group={'type':'object','additionalProperties':False,'required':['status','count'],'properties':{'status':{'type':['string','null']},'count':{'type':'integer','minimum':0}}}
response={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='client_profile'").fetchone()
 for record in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()):
  table=record['table'];field=record.get('summaryField','status');batch=record.get('summaryBatch',22)
  group={'type':'object','additionalProperties':False,'required':[field,'count'],'properties':{field:{'type':['string','null']},'count':{'type':'integer','minimum':0}}}
  response={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
  columns={r[0] for r in db.execute('SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not {field,'client_id','tenant_id'} <= columns:raise RuntimeError('Missing registered status/ownership: '+table)
  route='/v1/client'+record['path']+'/summary';code='CLIENT_OWN_'+table.upper()+'_STATUS_SUMMARY'
  request={'type':'object','additionalProperties':False,'properties':paging}
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',1 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Owned stored status counts; no inferred validity, eligibility or appointment'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  paths[route]={'get':{'operationId':code.lower(),'summary':'Count own '+table.replace('_',' ')+' by stored status','description':'Active explicit bearer session, unique owned client profile and matching tenant required. Counts use only client_id and tenant_id scoped rows and stored statuses, including null. Pagination total counts status groups, not records. No consent validity, authorization eligibility/remaining hours, appointment or feedback-resolution inference. Feedback comments, internal resolution notes and visit identifiers are excluded. Read only; no new role grants.','security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in paging.items()],'responses':{'200':{'description':'Owned status groups','content':{'application/json':{'schema':response,'example':{'groups':[{field:'pending','count':2}],'pagination':{'limit':25,'offset':0,'total':1,'hasMore':False}}}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}}}
 new_roots=['/v1/client'+r['path'] for r in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()) if r.get('summaryBatch',22)>=37]
 new_paths={p:v for p,v in paths.items() if any(p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/client-feedback-summaries-batches-37-39.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Feedback Summaries Batches 37 and 39','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths}
 (ROOT/'docs/api/client-record-summaries-batch-22.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Record Status Summaries','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered owned record status summaries; no new role grants.')
