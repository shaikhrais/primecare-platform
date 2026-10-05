"""Batches 51–55: provider-owned operational metadata; no grants or writes."""
import json,re,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=[
 {'path':'/conversation-threads','table':'messages_threads','collection':'threads','item':'thread','fields':['id','thread_type','created_at'],'listBatch':51,'summaryBatch':52,'summaryField':'thread_type','orderField':'created_at'},
 {'path':'/timesheets','table':'timesheets','collection':'timesheets','item':'timesheet','fields':['id','week_id','status','total_minutes','submitted_at','reviewed_at','created_at','updated_at'],'listBatch':53,'summaryBatch':54,'summaryField':'status','orderField':'created_at'},
 {'path':'/availability-overrides','table':'provider_availability_overrides','collection':'overrides','item':'override','fields':['id','date','start_time','end_time','is_available'],'listBatch':55,'orderField':'date'}
]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='psw_profile'").fetchone()
 for definition in definitions:
  record=dict(definition);table=record['table'];fields=record['fields']
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[a-z_]+',name) for name in [*fields,'provider_id','tenant_id',record['orderField']]):raise RuntimeError('Missing registered projection/ownership: '+table)
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='boolean' if kind in ['bool','boolean'] else 'integer' if kind in ['int4','int8','bigint','integer'] else 'string'
   properties[field]={'type':[typ,'null'] if nullable else typ}
   if 'timestamp' in kind or kind=='timestamptz':properties[field]['format']='date-time'
  record['types']={k:v['type'] for k,v in properties.items()};record['dateFields']=[k for k,v in properties.items() if v.get('format')=='date-time'];registry.append(record)
  projected={'type':'object','additionalProperties':False,'required':fields,'properties':properties}
  for mode in (['singleton'] if record.get('singleton') else ['list','detail']+(['summary'] if record.get('summaryField') else [])):
   route='/v1/provider'+record['path']+('/{recordId}' if mode=='detail' else '/summary' if mode=='summary' else '')
   batch=record['summaryBatch'] if mode=='summary' else record['listBatch'];paged=mode in ['list','summary'];code='PROVIDER_OWN_'+table.upper()+'_'+mode.upper()
   if mode=='summary':
    key=record['summaryField'];group={'type':'object','additionalProperties':False,'required':[key,'count'],'properties':{key:properties[key],'count':{'type':'integer','minimum':0}}}
    response={'type':'object','required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
   elif mode=='list':response={'type':'object','required':[record['collection'],'pagination'],'properties':{record['collection']:{'type':'array','items':projected},'pagination':pagination}}
   else:response={'type':'object','required':[record['item']],'properties':{record['item']:projected}}
   request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
   db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','provider',1,'implemented','authenticated_provider_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(paged),route))
   aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Own provider operational metadata; profile/user and tenant SQL ownership, no grants'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_provider_profile_owner','implemented','pending')",('GET '+route,sid,batch))
   params=[{'in':'query','name':k,'schema':v} for k,v in (paging if paged else {}).items()]
   if mode=='detail':params.append({'in':'path','name':'recordId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}})
   sample={field:('2026-01-01T12:00:00Z' if field in record['dateFields'] else None if isinstance(properties[field]['type'],list) else False if properties[field]['type']=='boolean' else 10 if properties[field]['type']=='integer' else 'record-id' if field=='id' else 'stored') for field in fields}
   page_example={'limit':25,'offset':0,'total':1,'hasMore':False}
   example={'groups':[{record['summaryField']:sample[record['summaryField']],'count':1}],'pagination':page_example} if mode=='summary' else {record['collection']:[sample],'pagination':page_example} if mode=='list' else {record['item']:sample}
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read own '+table.replace('_',' ')+' '+mode,'description':'Active explicit bearer and matching non-null tenant required. The actor must own exactly one provider profile; every record query binds provider_id and tenant_id. No caller-selected user/profile/role filters. Thread metadata excludes client IDs and message contents and grants no message access. Timesheets expose stored counters/statuses only, without reviewer IDs, rates, amounts or inferred payroll eligibility; null total_minutes is preserved. Availability overrides are stored observations, not guaranteed bookability or approval. Reads do not change status or availability. Summary totals count groups, not records; no new role grants.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Projected own records or status groups','content':{'application/json':{'schema':response,'example':example}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch or missing actor tenant'),(404,'Owned record/profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable or ambiguous profile')]}}}}
 (ROOT/'cloudflare/workers/src/provider-records-registry.json').write_text(json.dumps(registry,indent=2)+'\n')
 (ROOT/'docs/api/provider-metadata-batches-51-55.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Provider-Owned Operational Metadata','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered provider metadata batches 51–55; no role grants.')
