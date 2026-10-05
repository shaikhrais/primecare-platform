"""Batches 26–30: direct user/tenant-owned account records; no role grants."""
import json,re,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=[{'path':'/me/notifications','table':'app_notifications','collection':'notifications','item':'notification','fields':['id','title','message','type','is_read','created_at'],'listBatch':26,'summaryBatch':27,'summaryField':'is_read'}, {'path':'/me/activities','table':'daily_activities','collection':'activities','item':'activity','fields':['id','role','title','description','status','due_date','created_at','updated_at'],'listBatch':28,'summaryBatch':29,'summaryField':'status'}, {'path':'/me/rewards','table':'gamification_profiles','item':'profile','fields':['id','care_coins','current_tier','lifetime_points','updated_at'],'listBatch':30,'singleton':True}]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 app=db.execute("SELECT id FROM apps WHERE app_code='at'").fetchone()[0];sid=db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchone()[0]
 for definition in definitions:
  record=dict(definition);table=record['table'];fields=record['fields']
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[a-z_]+',name) for name in [*fields,'user_id','tenant_id']):raise RuntimeError('Missing registered projection/ownership: '+table)
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='boolean' if kind in ['bool','boolean'] else 'integer' if kind in ['int4','int8','bigint','integer'] else 'string'
   properties[field]={'type':[typ,'null'] if nullable else typ}
   if 'timestamp' in kind:properties[field]['format']='date-time'
  record['types']={k:v['type'] for k,v in properties.items()};record['dateFields']=[k for k,v in properties.items() if v.get('format')=='date-time'];registry.append(record)
  projected={'type':'object','additionalProperties':False,'required':fields,'properties':properties}
  for mode in (['singleton'] if record.get('singleton') else ['list','detail','summary']):
   route='/v1/auth'+record['path']+('/{recordId}' if mode=='detail' else '/summary' if mode=='summary' else '')
   batch=record['summaryBatch'] if mode=='summary' else record['listBatch'];paged=mode in ['list','summary'];code='AUTH_OWN_'+table.upper()+'_'+mode.upper()
   if mode=='summary':
    key=record['summaryField'];group={'type':'object','additionalProperties':False,'required':[key,'count'],'properties':{key:properties[key],'count':{'type':'integer','minimum':0}}}
    response={'type':'object','required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
   elif mode=='list':response={'type':'object','required':[record['collection'],'pagination'],'properties':{record['collection']:{'type':'array','items':projected},'pagination':pagination}}
   else:response={'type':'object','required':[record['item']],'properties':{record['item']:projected}}
   request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
   db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','auth',1,'implemented','authenticated_self_record_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(paged),route))
   aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Personal authenticated account records; user/tenant SQL ownership, no grants'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_self_record_owner','implemented','pending')",('GET '+route,sid,batch))
   params=[{'in':'query','name':k,'schema':v} for k,v in (paging if paged else {}).items()]
   if mode=='detail':params.append({'in':'path','name':'recordId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}})
   sample={field:('2026-01-01T12:00:00Z' if field in record['dateFields'] else False if properties[field]['type']=='boolean' else 10 if properties[field]['type']=='integer' else 'record-id' if field=='id' else 'stored') for field in fields}
   page_example={'limit':25,'offset':0,'total':1,'hasMore':False}
   example={'groups':[{record['summaryField']:sample[record['summaryField']],'count':1}],'pagination':page_example} if mode=='summary' else {record['collection']:[sample],'pagination':page_example} if mode=='list' else {record['item']:sample}
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read own '+table.replace('_',' ')+' '+mode,'description':'Active explicit bearer session and matching non-null tenant required. SQL binds user_id from the actor and tenant_id, excluding null-tenant records. No arbitrary user/tenant/role filters or new grants. Notifications expose stored text and read flag, not navigation links; GET does not mark read. Activities expose assignments and stored status, not workflow completion or permissions. Rewards expose recorded points/coins/tier only, not monetary value, redemption eligibility or entitlement. Summary total counts groups, not records.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Projected own records or status groups','content':{'application/json':{'schema':response,'example':example}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch or missing actor tenant'),(404,'Owned record/profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable or ambiguous profile')]}}}}
 (ROOT/'cloudflare/workers/src/self-records-registry.json').write_text(json.dumps(registry,indent=2)+'\n')
 (ROOT/'docs/api/self-records-batches-26-30.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Account Records','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered seven personal record APIs for batches 26–30; no role grants.')
