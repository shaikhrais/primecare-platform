"""Batches 213–215: items inherit the registered owned-timesheet read boundary."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
identifier={'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}
count={'type':'integer','minimum':0,'maximum':9007199254740991}
item={'type':'object','additionalProperties':False,'required':['id','minutes','created_at'],'properties':{'id':identifier,'minutes':{'type':'integer','minimum':-2147483648,'maximum':2147483647},'created_at':{'type':'string','format':'date-time'}}}
group={'type':'object','additionalProperties':False,'required':['status','count','totalMinutes'],'properties':{'status':{'type':['string','null']},'count':count,'totalMinutes':{'type':'string','pattern':r'^-?\d+$','description':'Exact sum of signed stored item minutes; no payroll or approval inference.'}}}
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{**paging,'total':count,'hasMore':{'type':'boolean'}}}
definitions=[(213,'/v1/provider/timesheet-items','PROVIDER_OWN_TIMESHEET_ITEMS',{'items':{'type':'array','items':item},'pagination':pagination}),(214,'/v1/provider/timesheet-items/{itemId}','PROVIDER_OWN_TIMESHEET_ITEM_DETAIL',{'item':item}),(215,'/v1/provider/timesheet-items/summary','PROVIDER_OWN_TIMESHEET_ITEM_SUMMARY',{'groups':{'type':'array','items':group},'pagination':pagination})]
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 existing=db.execute("SELECT service_name,auth_required,permission_key FROM api_endpoints WHERE route_path='/v1/provider/timesheets' AND http_method='GET'").fetchall()
 if existing!=[('provider',1,'authenticated_provider_profile_owner')]:raise RuntimeError('Owned timesheet authority drift')
 for table,required in [('provider_profiles',{'id','user_id','tenant_id'}),('timesheets',{'id','provider_id','tenant_id','status'}),('timesheet_items',{'id','timesheet_id','minutes','created_at'})]:
  columns={r[0]:r[1] for r in db.execute('SELECT c.column_name,c.data_type FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not required<=columns.keys() or table=='timesheet_items' and columns['minutes']!='int4':raise RuntimeError('Missing registered timesheet relationship: '+table)
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='psw_profile' AND active=1").fetchone()
 for batch,route,code,properties in definitions:
  detail='{itemId}' in route
  request={'type':'object','additionalProperties':False,'properties':{} if detail else paging}
  response={'type':'object','additionalProperties':False,'required':list(properties),'properties':properties}
  rows=db.execute("SELECT service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if rows and rows!=[('provider',1,'authenticated_provider_profile_owner')]:raise RuntimeError('Timesheet item endpoint authority drift')
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','provider',1,'implemented','authenticated_provider_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(not detail),route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Own item metadata through timesheets.provider_id and tenant_id; excludes visit identifiers'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_provider_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  params=[{'in':'path','name':'itemId','required':True,'schema':identifier}] if detail else [{'in':'query','name':k,'schema':v} for k,v in paging.items()]
  paths[route]={'get':{'operationId':code.lower(),'summary':code.replace('_',' ').lower(),'description':'Active explicit bearer session, matching actor tenant and unique owned provider profile required. Every item query joins timesheets and restricts provider_id and tenant_id to that profile and actor. Foreign or missing item returns 404. Only id, signed stored minutes and created_at are projected. Visit identifiers, patient data, reviewer identities and private columns are excluded. No filters overriding owner, tenant, timesheet or status; no writes. Summary groups by stored parent timesheet status, null last, counting items and summing their signed minutes exactly as strings; pagination totals count groups. Does not establish payroll approval, billability or completed visits. Existing authenticated_provider_profile_owner authority only.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Owned item metadata or stored status groups','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query or identifier'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Own provider profile or item absent'),(405,'Read only'),(429,'Source limit'),(503,'Schema dependency or data unavailable')]}}}}
(ROOT/'docs/api/provider-timesheet-items-batches-213-215.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Timesheet Item Metadata','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 213–215 owned timesheet item metadata; no role/write grants.')
