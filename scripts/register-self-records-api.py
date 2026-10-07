"""Batches 26–30: direct user/tenant-owned account records; no role grants."""
import json,re,sqlite3
from pathlib import Path
from record_authority_guard import validate_record_authority
ROOT=Path(__file__).resolve().parents[1]
definitions=[{'path':'/me/notifications','table':'app_notifications','collection':'notifications','item':'notification','fields':['id','title','message','type','is_read','created_at'],'listBatch':26,'summaryBatch':27,'summaryField':'is_read'}, {'path':'/me/activities','table':'daily_activities','collection':'activities','item':'activity','fields':['id','role','title','description','status','due_date','created_at','updated_at'],'listBatch':28,'summaryBatch':29,'summaryField':'status'}, {'path':'/me/rewards','table':'gamification_profiles','item':'profile','fields':['id','care_coins','current_tier','lifetime_points','updated_at'],'listBatch':30,'singleton':True}]
definitions.extend([
 {'path':'/me/wellness-pulses','table':'wellness_pulses','collection':'pulses','item':'pulse','fields':['id','score','status','created_at'],'listBatch':31,'summaryBatch':32,'summaryField':'status'},
 {'path':'/me/device-events','table':'iot_events','collection':'events','item':'event','fields':['id','device_type','status','created_at'],'listBatch':33,'summaryBatch':34,'summaryField':'status'},
 {'path':'/me/devices','table':'user_devices','collection':'devices','item':'device','fields':['id','device_name','device_type','is_authorized','is_temporary','authorized_at','expires_at','last_active_at','status','created_at','updated_at'],'listBatch':35,'tenantThroughUser':True}
])
definitions.append({'path':'/me/reputation','table':'user_reputations','item':'profile','fields':['id','points','elite_status','crises_resolved','created_at','updated_at'],'listBatch':40,'singleton':True,'tenantThroughUser':True})
definitions.extend([
 {'path':'/me/health-ids','table':'health_ids','collection':'healthIds','item':'healthId','fields':['id','status','created_at','updated_at'],'listBatch':41,'summaryBatch':42,'summaryField':'status','tenantThroughUser':True},
 {'path':'/me/survey-submissions','table':'survey_responses','collection':'submissions','item':'submission','fields':['id','survey_id','created_at'],'listBatch':43,'summaryBatch':44,'summaryField':'survey_id','tenantThroughUser':True},
 {'path':'/me/group-memberships','table':'staff_group_members','collection':'memberships','item':'membership','fields':['id','group_id','role','created_at'],'listBatch':45,'tenantThroughUser':True}
])
definitions.append({'path':'/me/password-history','table':'auth_password_audit','collection':'events','item':'event','fields':['id','action','created_at'],'listBatch':50,'tenantThroughUser':True})
definitions.extend([
 {'path':'/me/shift-logs','table':'provider_shift_logs','collection':'logs','item':'log','fields':['id','date','start_time','end_time','shiftStatus'],'listBatch':66,'summaryBatch':67,'summaryField':'shiftStatus','ownerField':'provider_id','orderField':'date'},
 {'path':'/me/daily-entry-records','table':'daily_entries','collection':'entries','item':'entry','fields':['id','status','created_at','updated_at'],'listBatch':68,'summaryBatch':69,'summaryField':'status','ownerField':'staff_id','orderField':'created_at'},
 {'path':'/me/adl-log-records','table':'adl_care_logs','collection':'logs','item':'log','fields':['id','created_at'],'listBatch':70,'ownerField':'provider_id','orderField':'created_at'}
])
definitions.extend([
 {'path': '/me/vital-sign-records', 'table': 'psw_vital_signs', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 71, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/behavior-note-records', 'table': 'behavior_notes', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 72, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/nutrition-records', 'table': 'nutrition_records', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 73, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/mobility-records', 'table': 'mobility_logs', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 74, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/infection-control-records', 'table': 'infection_control_checklists', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 75, 'ownerField': 'provider_id', 'orderField': 'recorded_at'}
])
definitions.extend([
 {'path': '/me/narrative-note-records', 'table': 'narrative_progress_notes', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 76, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/care-plan-follow-up-records', 'table': 'care_plan_follow_ups', 'collection': 'records', 'item': 'record', 'fields': ['id', 'recorded_at'], 'listBatch': 77, 'ownerField': 'provider_id', 'orderField': 'recorded_at'},
 {'path': '/me/assigned-task-records', 'table': 'staff_tasks', 'collection': 'tasks', 'item': 'task', 'fields': ['id', 'status', 'priority', 'due_date', 'created_at', 'updated_at'], 'listBatch': 78, 'summaryBatch': 79, 'summaryField': 'status', 'ownerField': 'assignee_id', 'orderField': 'created_at'},
 {'path': '/me/audit-signoff-records', 'table': 'daily_audit_signoffs', 'collection': 'signoffs', 'item': 'signoff', 'fields': ['id', 'status', 'signed_at'], 'listBatch': 80, 'ownerField': 'rn_id', 'orderField': 'signed_at'}
])
definitions.extend([
 {'path': '/me/reported-incident-records', 'table': 'incidents', 'collection': 'incidents', 'item': 'incident', 'fields': ['id', 'status', 'created_at', 'updated_at'], 'listBatch': 81, 'ownerField': 'reporter_user_id', 'orderField': 'created_at'},
 {'path': '/me/assessment-records', 'table': 'clinical_assessments', 'collection': 'assessments', 'item': 'assessment', 'fields': ['id', 'created_at', 'updated_at'], 'listBatch': 82, 'ownerField': 'rn_id', 'orderField': 'created_at'},
 {'path': '/me/medication-reconciliation-records', 'table': 'medication_reconciliations', 'collection': 'reconciliations', 'item': 'reconciliation', 'fields': ['id', 'status', 'created_at'], 'listBatch': 83, 'ownerField': 'rn_id', 'orderField': 'created_at'},
 {'path': '/me/supervision-records', 'table': 'supervision_logs', 'collection': 'logs', 'item': 'log', 'fields': ['id', 'created_at'], 'listBatch': 84, 'ownerField': 'rn_id', 'orderField': 'created_at'},
 {'path': '/me/technical-audit-records', 'table': 'technical_audits', 'collection': 'audits', 'item': 'audit', 'fields': ['id', 'status', 'performed_at'], 'listBatch': 85, 'ownerField': 'performed_by_id', 'orderField': 'performed_at'}
])
definitions.extend([
 {'path': '/me/authored-care-plan-records', 'table': 'care_plans', 'collection': 'plans', 'item': 'plan', 'fields': ['id', 'status', 'created_at', 'updated_at'], 'listBatch': 86, 'ownerField': 'author_id', 'orderField': 'created_at'},
 {'path': '/me/authored-review-records', 'table': 'performance_reviews', 'collection': 'reviews', 'item': 'review', 'fields': ['id', 'status', 'period_start', 'period_end', 'created_at', 'updated_at'], 'listBatch': 87, 'ownerField': 'reviewer_id', 'orderField': 'created_at'},
 {'path': '/me/reviewed-timesheet-records', 'table': 'timesheets', 'collection': 'timesheets', 'item': 'timesheet', 'fields': ['id', 'status', 'reviewed_at', 'created_at', 'updated_at'], 'listBatch': 88, 'ownerField': 'reviewed_by', 'orderField': 'created_at'},
 {'path': '/me/telehealth-records', 'table': 'telehealth_sessions', 'collection': 'sessions', 'item': 'session', 'fields': ['id', 'status', 'start_time', 'end_time', 'created_at'], 'listBatch': 89, 'summaryBatch': 90, 'summaryField': 'status', 'ownerField': 'provider_id', 'orderField': 'created_at'}
])
definitions.extend([{'path':'/me/audit-event-records','table':'audit_logs','collection':'events','item':'event','fields':['id','created_at'],'listBatch':158,'ownerField':'actor_user_id','orderField':'created_at'},{'path':'/me/system-event-records','table':'system_events','collection':'events','item':'event','fields':['id','created_at'],'listBatch':159,'ownerField':'actor_user_id','orderField':'created_at'}])
definitions.append({'path':'/me/bootstrap-record','table':'auth_bootstrap_audit','item':'bootstrap','fields':['created_at'],'listBatch':100,'singleton':True})
definitions.append({'path':'/me/authored-message-records','table':'messages','collection':'messages','item':'message','fields':['id','created_at'],'listBatch':220,'ownerField':'sender_user_id','tenantThroughUser':True,'orderField':'created_at'})
# Five owner-scoped summaries reuse the registered list/detail ownership predicates.
summary_batches={'care_plans':91,'performance_reviews':92,'timesheets':93,'incidents':94,'medication_reconciliations':95}
for definition in definitions:
 if definition['table'] in summary_batches:
  definition.update(summaryBatch=summary_batches[definition['table']],summaryField='status')
for definition in definitions:
 if definition['table'] in {'technical_audits':96,'daily_audit_signoffs':97}:
  definition.update(summaryBatch={'technical_audits':96,'daily_audit_signoffs':97}[definition['table']],summaryField='status')
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
paths={};registry=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 validate_record_authority(db, definitions, 'auth', 'authenticated_self_record_owner')
 app=db.execute("SELECT id FROM apps WHERE app_code='at'").fetchone()[0];sid=db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchone()[0]
 for definition in definitions:
  record=dict(definition);table=record['table'];fields=record['fields']
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*',name) for name in [*fields,record.get('ownerField','user_id'),record.get('orderField','created_at') if not record.get('singleton') else fields[0],*([] if record.get('tenantThroughUser') else ['tenant_id'])]):raise RuntimeError('Missing registered projection/ownership: '+table)
  if record.get('tenantThroughUser'):
   owner_columns={r[0] for r in db.execute("SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name='users'")}
   if not {'id','tenant_id'} <= owner_columns:raise RuntimeError('Missing registered user tenant relationship')
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='boolean' if kind in ['bool','boolean'] else 'integer' if kind in ['int4','int8','bigint','integer'] else 'string'
   properties[field]={'type':[typ,'null'] if nullable else typ}
   if kind in ['int4','integer']:properties[field].update(minimum=-2147483648,maximum=2147483647)
   if 'timestamp' in kind or kind=='timestamptz':properties[field]['format']='date-time'
  record['types']={k:v['type'] for k,v in properties.items()};record['dateFields']=[k for k,v in properties.items() if v.get('format')=='date-time'];registry.append(record)
  projected={'type':'object','additionalProperties':False,'required':fields,'properties':properties}
  for mode in (['singleton'] if record.get('singleton') else ['list','detail']+(['summary'] if record.get('summaryField') else [])):
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
   sample={field:('2026-01-01T12:00:00Z' if field in record['dateFields'] else None if isinstance(properties[field]['type'],list) else False if properties[field]['type']=='boolean' else 10 if properties[field]['type']=='integer' else 'record-id' if field=='id' else 'stored') for field in fields}
   page_example={'limit':25,'offset':0,'total':1,'hasMore':False}
   example={'groups':[{record['summaryField']:sample[record['summaryField']],'count':1}],'pagination':page_example} if mode=='summary' else {record['collection']:[sample],'pagination':page_example} if mode=='list' else {record['item']:sample}
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read own '+table.replace('_',' ')+' '+mode,'description':'Active explicit bearer session and matching non-null tenant required. SQL binds user_id from the actor and the matching tenant. Tenant-scoped records exclude null tenants; device records join the owning user to derive tenant scope. Wellness scores/statuses are stored observations, not diagnoses; wellness notes/provider IDs and raw device telemetry/fingerprints/IPs are excluded. Device flags do not authorize sessions or establish trust. Reputation follows the current owning User tenant; points, elite status and crisis counters are stored values, not verified outcomes, entitlement or competence; reward multipliers are excluded. No arbitrary user/tenant/role filters or new grants. Notifications expose stored text and read flag, not navigation links; GET does not mark read. Activities expose assignments and stored status, not workflow completion or permissions. Rewards expose recorded points/coins/tier only, not monetary value, redemption eligibility or entitlement. Health IDs expose stored status only, excluding DID/public keys and identity-verification claims. Survey submissions expose metadata only, excluding answers and survey definitions; grouped survey IDs are opaque references. Group memberships expose stored group ID/role only, without group contents or permission grants. Records without tenant columns follow the current owning User tenant, not a historical tenant. Summary total counts groups, not records.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Projected own records or status groups','content':{'application/json':{'schema':response,'example':example}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch or missing actor tenant'),(404,'Owned record/profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable or ambiguous profile')]}}}}
 new_roots=['/v1/auth'+r['path'] for r in registry if 158<=r['listBatch']<=159]
 new_audit_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 for operation in new_audit_paths.values():operation['get']['description']='Read only your own recorded audit/system event IDs and creation timestamps. Every query binds actor_user_id to the active bearer User and tenant_id to the matching non-null actor tenant. Null/system actors, foreign actors and other tenants are excluded. Actions, resource/model/entity IDs, IP/device identifiers, metadata, payloads, previous data and checksums are excluded. Event timestamps do not prove success, completeness, permission or causality. Bounded list and exact owned detail under read-only repeatable-read snapshots, no-store and source limits. No new grants or mutations.'
 (ROOT/'docs/api/own-audit-events-batches-158-159.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Audit Event Metadata','version':'1.0.0'},'paths':new_audit_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_audit_paths}
 (ROOT/'cloudflare/workers/src/self-records-registry.json').write_text(json.dumps(registry,indent=2)+'\n')
 operational_routes={'/v1/auth'+r['path']+'/summary' for r in registry if 96<=r.get('summaryBatch',0)<=97}
 operational_routes.add('/v1/auth/me/bootstrap-record')
 operational_paths={p:v for p,v in paths.items() if p in operational_routes}
 for route,operation in operational_paths.items():
  operation['get']['description']=('Read only your recorded bootstrap creation timestamp. The existing auth_bootstrap_audit primary key is user_id. Every query binds active bearer actor User ID and the recorded matching non-null tenant. No record returns 404; malformed or duplicate data returns 503. The source, user ID and tenant ID are excluded. A timestamp is historical audit metadata and does not establish current CEO privileges, account creation method or authorization. No query filters, writes or grants.' if route.endswith('/bootstrap-record') else 'Count your own stored technical-audit or daily-audit-signoff statuses. Bind active bearer actor User ID through performed_by_id or rn_id and matching non-null tenant in every query. Exclude null/foreign owners and tenants. Return stored status and count only, with bounded group paging; total counts groups. Clinical comments, visit/patient IDs, summaries, issue counts and details are excluded. Counts do not prove compliance, successful audits or completed care. Read-only repeatable-read snapshots, no-store, source limits and sanitized errors; no role grants or writes.')
 (ROOT/'docs/api/personal-operational-audit-batches-96-97-100.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Operational Audit Summaries and Bootstrap Metadata','version':'1.0.0'},'paths':operational_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in operational_paths}
 summary_routes={'/v1/auth'+r['path']+'/summary' for r in registry if 91<=r.get('summaryBatch',0)<=95}
 summary_paths={p:v for p,v in paths.items() if p in summary_routes}
 for operation in summary_paths.values():
  operation['get']['description']='Count stored statuses for records directly owned by the active bearer actor User, binding the registered author_id, reviewer_id, reviewed_by, reporter_user_id or rn_id and matching non-null tenant in every query. Other users, null owners and other/null tenants are excluded. Nullable stored statuses remain a null group; no normalization or inferred outcome. Pagination total counts status groups, not records. No clinical contents, patient IDs, provider IDs, review/payroll details or incident/medication contents. Counts do not establish review approval, completed care, incident resolution, medication correctness or payroll eligibility. Bounded pagination and no-store repeatable-read responses; no arbitrary ownership/tenant filters, business writes or permission grants.'
 (ROOT/'docs/api/personal-status-summaries-batches-91-95.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Owned Status Summaries','version':'1.0.0'},'paths':summary_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in summary_paths}
 new_roots=['/v1/auth'+r['path'] for r in registry if 31<=r['listBatch']<=35]
 new_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/self-device-wellness-batches-31-35.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Device and Wellness Records','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 reputation_paths={p:v for p,v in paths.items() if p=='/v1/auth/me/reputation'}
 (ROOT/'docs/api/self-reputation-batch-40.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Reputation Profile','version':'1.0.0'},'paths':reputation_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 personal_roots=['/v1/auth'+r['path'] for r in registry if 41<=r['listBatch']<=45]
 personal_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in personal_roots)}
 (ROOT/'docs/api/personal-metadata-batches-41-45.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Identity, Submission and Membership Metadata','version':'1.0.0'},'paths':personal_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 password_paths={p:v for p,v in paths.items() if p.startswith('/v1/auth/me/password-history')}
 for operation in password_paths.values():
  operation['get']['description']='Read recorded password-change audit events for the active bearer actor only. Every query derives the current tenant through the owning User. Events expose id, action and creation time; no password/hash, token, IP or session identifiers. Absence of events does not prove a password was never changed; older operations may lack audit records. Read only, no grants. Lists support bounded pagination; detail accepts no query.'
 (ROOT/'docs/api/self-password-history-batch-50.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Password-Change History','version':'1.0.0'},'paths':password_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 staff_roots=['/v1/auth'+r['path'] for r in registry if 66<=r['listBatch']<=70]
 staff_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in staff_roots)}
 for operation in staff_paths.values():
  operation['get']['description']='Active explicit bearer and matching non-null tenant required. Every query binds the actor User ID and tenant: provider_shift_logs.provider_id and adl_care_logs.provider_id refer to User; daily_entries.staff_id refers to User. Clinical contents, patient/client/visit IDs, GPS and signatures are excluded. Stored shift/status labels do not confirm completed care, attendance, payroll or clinical correctness. Direct authorship grants metadata access only, without patient-record access or clinical writes. Lists use bounded paging and registered timestamp order; summaries count stored groups. No new grants or mutations.'
 (ROOT/'docs/api/personal-work-log-batches-66-70.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Work-Log Metadata','version':'1.0.0'},'paths':staff_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 care_roots=['/v1/auth'+r['path'] for r in registry if 71<=r['listBatch']<=75]
 care_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in care_roots)}
 for operation in care_paths.values():
  operation['get']['description']='Read own authored record metadata only: id and recorded_at. Active explicit bearer and matching non-null tenant required; every query binds provider_id to the actor User ID (not ProviderProfile) and tenant_id to the actor tenant. Clinical readings, patient/client IDs, behavioral notes, nutrition, mobility and infection-control findings are excluded. Metadata access does not grant patient-record access, clinical writes or evidence of completed care. Bounded paging, newest recorded_at then id; missing owned detail returns 404. No arbitrary owner, tenant or role filters; no mutations or new grants.'
 (ROOT/'docs/api/personal-care-metadata-batches-71-75.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Authored Care-Record Metadata','version':'1.0.0'},'paths':care_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 author_roots=['/v1/auth'+r['path'] for r in registry if 76<=r['listBatch']<=80]
 author_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in author_roots)}
 for operation in author_paths.values():
  operation['get']['description']='Read only own authored/assigned metadata under active explicit bearer and matching non-null tenant. Registered provider_id, assignee_id and rn_id relationships refer to actor User ID, not ProviderProfile. Every SQL query binds actor User and tenant. Narrative/follow-up contents, patient/client/visit IDs, task titles/descriptions/group IDs and clinical audit comments are excluded. Assigned tasks require direct assignee ownership; group-only, unassigned and other-user tasks are excluded. Status/priority/signing timestamps are stored values, not completion/compliance or privilege claims. Lists sort by registered timestamp then id; summary total counts status groups. No mutations, new grants, arbitrary user/role/tenant filters or access to clinical records.'
 (ROOT/'docs/api/personal-authorship-task-batches-76-80.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Authorship, Assigned Tasks and Signoff Metadata','version':'1.0.0'},'paths':author_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 audit_roots=['/v1/auth'+r['path'] for r in registry if 81<=r['listBatch']<=85]
 audit_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in audit_roots)}
 for operation in audit_paths.values():
  operation['get']['description']='Read own report/authorship/performance metadata only under active explicit bearer and matching non-null tenant. Registered reporter_user_id, rn_id and performed_by_id refer to actor User ID. Every query binds actor User and tenant, excluding null/other owners and null/other tenants. Projections include only id, stored status where registered, and timestamps. Incident descriptions, patient/client/visit/provider IDs, clinical data, scores, recommendations, reconciliation contents, competencies/feedback and technical audit details are excluded. Supervision ownership uses rn_id (User), not provider_id (ProviderProfile); incident acknowledgement does not grant reporter access. Stored status does not establish resolution, medication correctness, competence or audit success. Bounded lists ordered by registered timestamp then id; owned detail absent returns 404. No arbitrary role/owner/tenant filters, clinical writes, business transitions or new grants.'
 (ROOT/'docs/api/personal-report-audit-batches-81-85.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Report, Clinical Authorship and Audit Metadata','version':'1.0.0'},'paths':audit_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 review_roots=['/v1/auth'+r['path'] for r in registry if 86<=r['listBatch']<=90]
 review_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in review_roots)}
 for operation in review_paths.values():
  operation['get']['description']='Read own authored/reviewed/provider-session metadata under active explicit bearer and matching non-null tenant. Registered author_id, reviewer_id, reviewed_by and telehealth_sessions.provider_id refer to actor User ID. Every query binds actor User and tenant, excluding null/foreign ownership and tenants. Timesheets/performance_reviews.provider_id instead refers to ProviderProfile and is not used for reviewer ownership. Clinical contents, patient IDs, reviewed provider IDs, ratings/goals/notes, payroll totals and meeting links are excluded. Stored statuses/times are not evidence of review approval, completed care, session attendance or payroll eligibility. Lists are bounded and ordered by created_at then id; summary total counts status groups. No clinical writes, role grants, approval/join actions or arbitrary owner/tenant filters.'
 (ROOT/'docs/api/personal-review-telehealth-batches-86-90.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Authorship, Review and Telehealth Metadata','version':'1.0.0'},'paths':review_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths and p not in reputation_paths and p not in personal_paths and p not in password_paths and p not in staff_paths and p not in care_paths and p not in author_paths and p not in audit_paths and p not in review_paths}
 message_paths={p:v for p,v in paths.items() if p.startswith('/v1/auth/me/authored-message-records')}
 for operation in message_paths.values():operation['get']['description']='Read only metadata for messages authored by the active bearer User. Every query joins the sender User and binds sender_user_id and current actor tenant. Only ID and creation time are projected; body text, thread IDs, recipients and clinical contents are excluded. This current sender ownership scope is not historical conversation tenant or thread membership authority. Bounded read-only paging, no-store and source limits; no sending, editing, message contents or grants.'
 (ROOT/'docs/api/authored-message-batch-220.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Authored Message Metadata','version':'1.0.0'},'paths':message_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in message_paths}
 (ROOT/'docs/api/self-records-batches-26-30.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Personal Account Records','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered personal record APIs through batch 159; no role grants.')
