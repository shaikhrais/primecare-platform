"""Batch 21: registered client-owned operational metadata, not clinical writes."""
import json,re,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=[('/consents','consent_forms','consents','consent',['id','form_type','status','signed_at','expires_at','template_version','created_at','updated_at']),('/service-authorizations','service_authorizations','authorizations','authorization',['id','service_id','funding_source','authorized_hours','used_hours','start_date','end_date','status','created_at','updated_at']),('/waitlist','waitlist_entries','entries','entry',['id','service_id','priority','status','requested_start_at','created_at'])]
definitions.extend([('/feedback','feedbacks','feedback','feedback',['id','rating','status','created_at','updated_at']),('/care-feedback','care_feedbacks','feedback','feedback',['id','rating','triage_status','created_at'])])
batches={'feedbacks':36,'care_feedbacks':38}
summary_batches={'feedbacks':37,'care_feedbacks':39}
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
paths={};records=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='client_profile'").fetchone()
 for path,table,collection,item,fields in definitions:
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[a-z_]+',name) for name in [*fields,'client_id','tenant_id','created_at']):raise RuntimeError('Missing registered ownership/projection columns: '+table)
  batch=batches.get(table,21);summary_field='triage_status' if table=='care_feedbacks' else 'status'
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='integer' if kind in ['int4','int8','bigint','integer'] else 'number' if kind in ['float8','numeric','decimal'] else 'string'
   properties[field]={'type':[typ,'null'] if nullable else typ}
   if 'timestamp' in kind:properties[field]['format']='date-time'
  record={'type':'object','additionalProperties':False,'required':fields,'properties':properties}
  records.append({'batch':batch,'summaryBatch':summary_batches.get(table,22),'summaryField':summary_field,'path':path,'table':table,'collection':collection,'item':item,'fields':fields,'types':{k:v['type'] for k,v in properties.items()}})
  for detail in [False,True]:
   route='/v1/client'+path+('/{recordId}' if detail else '')
   response={'type':'object','required':[item] if detail else [collection,'pagination'],'properties':{item:record} if detail else {collection:{'type':'array','items':record},'pagination':pagination}}
   query={} if detail else paging;request={'type':'object','additionalProperties':False,'properties':query}
   code='CLIENT_OWN_'+table.upper()+('_DETAIL' if detail else '_LIST')
   db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(not detail),route))
   aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Owned metadata only; client and tenant SQL scope, no signature/storage/private notes'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read owned '+table.replace('_',' ')+(' record' if detail else ' list'),'description':'Active explicit bearer session, unique owned client profile and matching tenant required. SQL restricts client_id and tenant_id; detail binds the exact record ID. Registered metadata fields only: no notes, authorization codes, signature data, storage keys or witness details. Stored consent status is not a legal validity judgment; authorization hours do not imply available/billable care; waitlist status does not imply an appointment. No new grants or mutations. Feedback is recorded metadata, not proof of authorship or resolved care; comments, resolution notes and visit identifiers are excluded.','security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in query.items()]+([{'in':'path','name':'recordId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}}] if detail else []),'responses':{'200':{'description':'Projected owned metadata','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Profile or record absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}}}
 (ROOT/'cloudflare/workers/src/client-records-registry.json').write_text(json.dumps(records,indent=2)+'\n')
 new_roots=['/v1/client'+r['path'] for r in records if r['batch']>=36]
 new_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/client-feedback-batches-36-38.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Feedback Reads Batches 36 and 38','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths}
 (ROOT/'docs/api/client-records-batch-21.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Client Records','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered client-owned metadata APIs from existing database columns.')
