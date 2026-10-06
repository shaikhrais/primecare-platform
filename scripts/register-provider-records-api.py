"""Batches 51–65: provider-owned operational metadata; no grants or writes."""
import json,re,sqlite3
from pathlib import Path
from record_authority_guard import validate_record_authority
ROOT=Path(__file__).resolve().parents[1]
definitions=[
 {'path':'/conversation-threads','table':'messages_threads','collection':'threads','item':'thread','fields':['id','thread_type','created_at'],'listBatch':51,'summaryBatch':52,'summaryField':'thread_type','orderField':'created_at'},
 {'path':'/timesheets','table':'timesheets','collection':'timesheets','item':'timesheet','fields':['id','week_id','status','total_minutes','submitted_at','reviewed_at','created_at','updated_at'],'listBatch':53,'summaryBatch':54,'summaryField':'status','orderField':'created_at'},
 {'path':'/availability-overrides','table':'provider_availability_overrides','collection':'overrides','item':'override','fields':['id','date','start_time','end_time','is_available'],'listBatch':55,'orderField':'date'}
]
definitions.extend([
 {'path':'/mileage-logs','table':'mileage_logs','collection':'logs','item':'log','fields':['id','date','distance_km','travel_minutes','status','created_at'],'listBatch':56,'summaryBatch':57,'summaryField':'status','orderField':'created_at'},
 {'path':'/payouts','table':'payouts','collection':'payouts','item':'payout','fields':['id','currency','status','processed_at','created_at'],'listBatch':58,'summaryBatch':59,'summaryField':'status','orderField':'created_at'},
 {'path':'/performance-reviews','table':'performance_reviews','collection':'reviews','item':'review','fields':['id','period_start','period_end','status','acknowledged_at','created_at','updated_at'],'listBatch':60,'orderField':'created_at'}
])
definitions.extend([
 {'path':'/visit-check-events','table':'visit_check_events','collection':'events','item':'event','fields':['id','event_type','result','device_time_iso','server_time','created_at'],'listBatch':61,'summaryBatch':62,'summaryField':'result','orderField':'created_at'},
 {'path':'/fleet-status','table':'fleet_status','item':'fleet','fields':['id','status','battery_level','last_heartbeat_at'],'listBatch':63,'singleton':True,'tenantThroughProvider':True,'orderField':'last_heartbeat_at'},
 {'path':'/visit-matches','table':'visit_matches','collection':'matches','item':'match','fields':['id','status','created_at'],'listBatch':64,'summaryBatch':65,'summaryField':'status','orderField':'created_at'}
])
definitions.extend([{'path':'/shift-assignment-records','table':'shift_assignments','collection':'assignments','item':'assignment','fields':['id','status','assigned_at'],'listBatch':160,'orderField':'assigned_at'},{'path':'/handover-records','table':'shift_handovers','collection':'handovers','item':'handover','fields':['id','created_at'],'listBatch':161,'orderField':'created_at'},{'path':'/authored-visit-note-records','table':'visit_notes','collection':'notes','item':'note','fields':['id','created_at'],'listBatch':162,'orderField':'created_at','tenantThroughProvider':True},{'path':'/authored-checklist-records','table':'visit_checklists','collection':'checklists','item':'checklist','fields':['id','created_at'],'listBatch':163,'orderField':'created_at','tenantThroughProvider':True}])
definitions.append({'path':'/training-assignment-records','table':'training_assignments','collection':'assignments','item':'assignment','fields':['id','status','assigned_at','due_date','completed_at'],'listBatch':217,'summaryBatch':218,'summaryField':'status','tenantThroughProvider':True,'orderField':'assigned_at'})
for definition in definitions:
 if definition['table']=='performance_reviews':definition.update(summaryBatch=98,summaryField='status')
 if definition['table']=='provider_availability_overrides':definition.update(summaryBatch=99,summaryField='is_available')
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 validate_record_authority(db, definitions, 'provider', 'authenticated_provider_profile_owner')
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='psw_profile'").fetchone()
 for definition in definitions:
  record=dict(definition);table=record['table'];fields=record['fields']
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[a-z_]+',name) for name in [*fields,'provider_id',*([] if record.get('tenantThroughProvider') else ['tenant_id']),record['orderField']]):raise RuntimeError('Missing registered projection/ownership: '+table)
  if record.get('tenantThroughProvider'):
   owner_columns={r[0] for r in db.execute("SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name='provider_profiles'")}
   if not {'id','user_id','tenant_id'}<=owner_columns:raise RuntimeError('Missing registered provider ownership relationship')
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='boolean' if kind in ['bool','boolean'] else 'integer' if kind in ['int4','int8','bigint','integer'] else 'number' if kind in ['float8','double precision'] else 'string'
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
   sample={field:('2026-01-01T12:00:00Z' if field in record['dateFields'] else None if isinstance(properties[field]['type'],list) else False if properties[field]['type']=='boolean' else 12.5 if properties[field]['type']=='number' else 10 if properties[field]['type']=='integer' else 'record-id' if field=='id' else 'stored') for field in fields}
   page_example={'limit':25,'offset':0,'total':1,'hasMore':False}
   example={'groups':[{record['summaryField']:sample[record['summaryField']],'count':1}],'pagination':page_example} if mode=='summary' else {record['collection']:[sample],'pagination':page_example} if mode=='list' else {record['item']:sample}
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read own '+table.replace('_',' ')+' '+mode,'description':'Active explicit bearer and matching non-null tenant required. The actor must own exactly one provider profile; every record query binds provider_id and tenant_id. No caller-selected user/profile/role filters. Thread metadata excludes client IDs and message contents and grants no message access. Timesheets expose stored counters/statuses only, without reviewer IDs, rates, amounts or inferred payroll eligibility; null total_minutes is preserved. Availability overrides are stored observations, not guaranteed bookability or approval. Reads do not change status or availability. Summary totals count groups, not records; no new role grants.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Projected own records or status groups','content':{'application/json':{'schema':response,'example':example}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch or missing actor tenant'),(404,'Owned record/profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable or ambiguous profile')]}}}}
   if 56<=record['listBatch']<=60:
    paths[route]['get']['description']='Active explicit bearer, matching non-null tenant and unique actor-owned provider profile required; every query binds provider_id and tenant_id. Mileage exposes recorded distance/time/status without addresses, visit IDs, reimbursement rates or amounts. Payouts expose metadata only, excluding amounts and notes; stored currency/status does not confirm payment receipt. Performance reviews expose period/status/acknowledgement metadata only, excluding ratings, reviewer IDs, goals and review text. Acknowledgement does not imply agreement. Stored values do not establish eligibility, approval or competence. Read only, no role grants; summary totals count groups, not records.'
   if record['listBatch']>=61:
    paths[route]['get']['description']='Active explicit bearer, matching non-null tenant and exactly one actor-owned provider profile required. Tenant-scoped event/match queries bind provider_id and tenant_id; fleet records lack tenant_id and join the current owning provider profile, binding profile ID, tenant and actor user ID on every query. Events expose stored type/result/timestamps, not proof of attendance. Fleet exposes stored status/battery/heartbeat, not guaranteed current availability or verified location. Matches expose metadata only; status does not grant assignment or patient access. GPS, visit IDs, raw telemetry, overrides/rejection reasons, match scores and client identifiers are excluded. Reads do not change state. Summaries count stored groups. No grants or writes.'
 new_roots=['/v1/provider'+r['path'] for r in registry if 160<=r['listBatch']<=163]
 new_work_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 for operation in new_work_paths.values():operation['get']['description']='Read own ProviderProfile assignment, handover or authored note/checklist metadata only. An active explicit bearer, matching non-null tenant and unique actor-owned ProviderProfile are required. Assignments/handovers bind provider_id and tenant_id in every query. Authored notes/checklists have no tenant column: every query joins the current owning ProviderProfile and binds its provider ID, tenant and actor User. This is current profile authorship scope, not historical visit tenant or present visit assignment authority. Return registered IDs, stored assignment status and timestamps only; exclude visit/client IDs, scores, note/checklist contents, safety concerns and supplies. No clinical access, offers accepted, visit readiness or completed care is inferred. Bounded paging/exact owned detail, no-store, read-only repeatable-read and source limits. No grants or mutations.'
 (ROOT/'docs/api/own-provider-work-batches-160-163.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Provider Work Metadata','version':'1.0.0'},'paths':new_work_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_work_paths}
 (ROOT/'cloudflare/workers/src/provider-records-registry.json').write_text(json.dumps(registry,indent=2)+'\n')
 summary_routes={'/v1/provider'+r['path']+'/summary' for r in registry if 98<=r.get('summaryBatch',0)<=99}
 summary_paths={p:v for p,v in paths.items() if p in summary_routes}
 for operation in summary_paths.values():
  operation['get']['description']='Count stored statuses or availability flags under a unique actor-owned ProviderProfile and matching non-null tenant. Every record query binds provider_id to that profile ID and tenant_id to actor tenant; reviewer User ownership is distinct and does not grant these reads. Return registered stored status or boolean is_available and count only. Pagination total counts groups; boolean false sorts before true. Review contents, reviewer IDs, ratings, goals, availability dates/times and other providers are excluded. Status counts do not establish performance outcomes; availability flags do not establish bookability or override visit schedules. Active explicit bearer, no-store read-only repeatable-read snapshots, bounded paging and source limits apply. No grants or mutations.'
 (ROOT/'docs/api/provider-review-availability-batches-98-99.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Provider Review and Availability Summaries','version':'1.0.0'},'paths':summary_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in summary_paths}
 new_roots=['/v1/provider'+r['path'] for r in registry if 56<=r['listBatch']<=60]
 new_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/provider-metadata-batches-56-60.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Mileage, Payout and Review Metadata','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 training_paths={p:v for p,v in paths.items() if p.startswith('/v1/provider/training-assignment-records')}
 for operation in training_paths.values():operation['get']['description']='Read training assignment metadata linked to the unique active actor-owned ProviderProfile. Every query joins provider_profiles and binds profile ID, current actor tenant and actor User. Staff-only, null-provider and foreign-profile assignments are excluded. Project only ID, stored status and assignment/due/completion timestamps; no module contents, staff IDs or certification inference. Current profile ownership scope is distinct from historical tenant or training completion authority. Bounded read-only paging, no-store and source limits; no mutations or grants.'
 (ROOT/'docs/api/provider-training-batches-217-218.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Provider Training Assignment Metadata','version':'1.0.0'},'paths':training_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in training_paths}
 event_roots=['/v1/provider'+r['path'] for r in registry if r['listBatch']>=61]
 event_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in event_roots)}
 (ROOT/'docs/api/provider-event-fleet-match-batches-61-65.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Visit Events, Fleet Status and Match Metadata','version':'1.0.0'},'paths':event_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths and p not in event_paths}
 (ROOT/'docs/api/provider-metadata-batches-51-55.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Provider-Owned Operational Metadata','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered provider metadata batches 51–65 and 98–99; no role grants.')
