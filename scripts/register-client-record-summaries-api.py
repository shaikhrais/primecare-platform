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
  if not batch:continue
  group={'type':'object','additionalProperties':False,'required':[field,'count'],'properties':{field:{'type':['string','null']},'count':{'type':'integer','minimum':0}}}
  response={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
  columns={r[0] for r in db.execute('SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not {field,record.get('ownerField','client_id'),'tenant_id'} <= columns:raise RuntimeError('Missing registered status/ownership: '+table)
  route='/v1/client'+record['path']+'/summary';code='CLIENT_OWN_'+table.upper()+'_STATUS_SUMMARY'
  request={'type':'object','additionalProperties':False,'properties':paging}
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',1 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),route))
  endpoint=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(endpoint)!=1 or endpoint[0][1:]!=('client',1,'authenticated_client_profile_owner'):raise RuntimeError('Conflicting client count contract: '+route)
  aid=endpoint[0][0]
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Owned stored status counts; no inferred validity, eligibility or appointment'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  paths[route]={'get':{'operationId':code.lower(),'summary':'Count own '+table.replace('_',' ')+' by stored status','description':'Active explicit bearer session, unique owned client profile and matching tenant required. Counts use only client_id and tenant_id scoped rows and stored statuses, including null. Pagination total counts status groups, not records. No consent validity, authorization eligibility/remaining hours, appointment or feedback-resolution inference. Feedback comments, internal resolution notes and visit identifiers are excluded. Read only; no new role grants.','security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in paging.items()],'responses':{'200':{'description':'Owned status groups','content':{'application/json':{'schema':response,'example':{'groups':[{field:'pending','count':2}],'pagination':{'limit':25,'offset':0,'total':1,'hasMore':False}}}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}}}
 shift_paths={p:v for p,v in paths.items() if p=='/v1/client/shift-log-records/summary'}
 for operation in shift_paths.values():operation['get']['description']='Count only own client-linked shift logs by stored shiftStatus. Active explicit bearer, matching non-null tenant and unique actor-owned ClientProfile required. Every query binds explicit client_id and tenant_id relationships. Return shiftStatus/count only; pagination total counts groups, not records. No staff IDs, location, signatures or care contents. Labels do not establish delivered care, approved time, payroll or billability. Bounded paging, no-store read-only repeatable-read snapshot and source limits. No delegated access, writes or role grants.'
 (ROOT/'docs/api/own-client-shift-counts-batch-188.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client Stored Shift Status Counts','version':'1.0.0'},'paths':shift_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in shift_paths}
 care_roots=['/v1/client'+r['path'] for r in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()) if 175<=r.get('summaryBatch',0)<=177]
 care_paths={p:v for p,v in paths.items() if any(p.startswith(root+'/') for root in care_roots)}
 for operation in care_paths.values():operation['get']['description']='Count only own care-plan and medication-reconciliation records by stored status, or clinical-assessment records by stored type. Active explicit bearer, matching non-null tenant and unique actor-owned ClientProfile required. Every query binds explicit client_id and tenant_id relationships. Return only the registered label and count; pagination total counts groups, not records. No diagnoses, scores, recommendations, reconciliation contents, author IDs or clinical payloads. Counts do not establish correct care, medication safety, diagnosis or authority to act. Bounded paging, no-store read-only repeatable-read snapshots and source limits. Existing authored User compatibility routes retain their scope. No delegated access, writes or role grants.'
 (ROOT/'docs/api/own-client-care-counts-batches-175-177.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client Care Metadata Counts','version':'1.0.0'},'paths':care_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in care_paths}
 patient_roots=['/v1/client'+r['path'] for r in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()) if 169<=r.get('summaryBatch',0)<=171]
 patient_paths={p:v for p,v in paths.items() if any(p.startswith(root+'/') for root in patient_roots)}
 for operation in patient_paths.values():operation['get']['description']='Count only own patient-linked alert, insurance-claim or prescription records by stored status. Active explicit bearer, matching non-null tenant and unique actor-owned ClientProfile required. Every query binds patient_id to that profile and tenant_id to the actor tenant. Counts return status/count only; pagination total counts groups, not records. Null stored status, where present, is a distinct group. No messages, medication instructions, amounts, denials, IDs of other actors or clinical payloads. Counts do not establish coverage, settlement, diagnosis or correct treatment. Bounded paging, no-store, read-only repeatable-read and source limits. No grants or writes.'
 (ROOT/'docs/api/own-patient-status-summaries-batches-169-171.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Patient Metadata Status Counts','version':'1.0.0'},'paths':patient_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in patient_paths}
 new_roots=['/v1/client'+r['path'] for r in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()) if 37<=r.get('summaryBatch',22)<=39]
 new_paths={p:v for p,v in paths.items() if any(p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/client-feedback-summaries-batches-37-39.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Feedback Summaries Batches 37 and 39','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 owner_roots=['/v1/client'+r['path'] for r in json.loads((ROOT/'cloudflare/workers/src/client-records-registry.json').read_text()) if r.get('summaryBatch',22)>=47]
 owner_paths={p:v for p,v in paths.items() if any(p.startswith(root+'/') for root in owner_roots)}
 for route,operation in owner_paths.items():
  operation['get']['summary']='Count owned records by registered metadata key'
  operation['get']['description']='Active explicit bearer, unique owned client profile and matching tenant required. SQL binds client_id and tenant_id. Counts group stored thread_type or relationship labels only; pagination total counts groups. No message content, family contact details, provider or linked user IDs, access levels or notification flags. Labels do not grant access to messages, consent, proxy or emergency authority. Read only, no role grants.'
 (ROOT/'docs/api/client-thread-family-summaries-batches-47-49.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Thread and Family-Link Summaries','version':'1.0.0'},'paths':owner_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths and p not in owner_paths}
 (ROOT/'docs/api/client-record-summaries-batch-22.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Record Status Summaries','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 # Batch 178 hardens list/group count and plain-string projection validation for
 # the original owned metadata family without changing its permission/schema.
 for root in ['/v1/client/consents','/v1/client/service-authorizations','/v1/client/waitlist']:
  for suffix in ['', '/{recordId}', '/summary']:
   db.execute('UPDATE governance_api_batches SET batch=178 WHERE route=?',('GET '+root+suffix,))
print('Registered owned record status summaries; no new role grants.')
