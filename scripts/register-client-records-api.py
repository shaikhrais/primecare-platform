"""Batch 21: registered client-owned operational metadata, not clinical writes."""
import json,re,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
definitions=[('/consents','consent_forms','consents','consent',['id','form_type','status','signed_at','expires_at','template_version','created_at','updated_at']),('/service-authorizations','service_authorizations','authorizations','authorization',['id','service_id','funding_source','authorized_hours','used_hours','start_date','end_date','status','created_at','updated_at']),('/waitlist','waitlist_entries','entries','entry',['id','service_id','priority','status','requested_start_at','created_at'])]
definitions.extend([('/feedback','feedbacks','feedback','feedback',['id','rating','status','created_at','updated_at']),('/care-feedback','care_feedbacks','feedback','feedback',['id','rating','triage_status','created_at'])])
definitions.extend([('/conversation-threads','messages_threads','threads','thread',['id','thread_type','created_at']),('/family-links','family_members','links','link',['id','relationship','created_at','updated_at'])])
definitions.extend([('/alert-records','patient_alerts','alerts','alert',['id','type','severity','status','created_at']),('/insurance-claim-records','claims','claims','claim',['id','status','service_date','created_at']),('/prescription-records','prescriptions','prescriptions','prescription',['id','status','created_at'])])
definitions.extend([('/care-plan-records','care_plans','plans','plan',['id','status','review_date','created_at','updated_at']),('/assessment-records','clinical_assessments','assessments','assessment',['id','type','created_at']),('/medication-reconciliation-records','medication_reconciliations','reconciliations','reconciliation',['id','status','created_at'])])
event_definitions=[
 ('/shift-log-records','provider_shift_logs','shifts','shift',['id','shiftStatus','start_time','end_time'],'start_time'),
 ('/adl-records','adl_care_logs','records','record',['id','created_at'],'created_at'),
 ('/vital-observation-records','psw_vital_signs','observations','observation',['id','recorded_at'],'recorded_at'),
 ('/behavior-observation-records','behavior_notes','observations','observation',['id','recorded_at'],'recorded_at'),
 ('/nutrition-observation-records','nutrition_records','observations','observation',['id','recorded_at'],'recorded_at'),
 ('/mobility-observation-records','mobility_logs','observations','observation',['id','recorded_at'],'recorded_at'),
 ('/infection-checklist-records','infection_control_checklists','checklists','checklist',['id','recorded_at'],'recorded_at'),
 ('/progress-note-records','narrative_progress_notes','notes','note',['id','recorded_at'],'recorded_at'),
 ('/care-follow-up-records','care_plan_follow_ups','followUps','followUp',['id','recorded_at'],'recorded_at')]
definitions.extend(r[:5] for r in event_definitions)
definitions.append(('/family-notification-records','family_notifications','notifications','notification',['id','type','is_read','created_at']))
order_fields={r[1]:r[5] for r in event_definitions}
event_batches={r[1]:179+i for i,r in enumerate(event_definitions)}
owner_fields={'patient_alerts':'patient_id','claims':'patient_id','prescriptions':'patient_id'}
batches={'care_plans':172,'clinical_assessments':173,'medication_reconciliations':174,'patient_alerts':166,'claims':167,'prescriptions':168,'feedbacks':36,'care_feedbacks':38,'messages_threads':46,'family_members':48}
batches.update(event_batches)
batches.update(family_notifications=222)
summary_batches={'care_plans':175,'clinical_assessments':176,'medication_reconciliations':177,'patient_alerts':169,'claims':170,'prescriptions':171,'feedbacks':37,'care_feedbacks':39,'messages_threads':47,'family_members':49}
summary_batches.update(family_notifications=223)
summary_batches.update({r[1]:188 if r[1]=='provider_shift_logs' else 0 for r in event_definitions})
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}
paths={};records=[]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='client_profile'").fetchone()
 for path,table,collection,item,fields in definitions:
  owner_field=owner_fields.get(table,'client_id');order_field=order_fields.get(table,'created_at')
  columns={name:(kind,nullable) for name,kind,nullable in db.execute('SELECT c.column_name,c.data_type,c.is_nullable FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not all(name in columns and re.fullmatch(r'[A-Za-z_]+',name) for name in [*fields,owner_field,'tenant_id',order_field]):raise RuntimeError('Missing registered ownership/projection columns: '+table)
  # Column names alone cannot establish ownership: validate explicit registered
  # foreign-key targets before generating any owner-bound query or contract.
  relationships={name:(foreign,target,key) for name,foreign,target,key in db.execute('SELECT c.column_name,c.is_foreign,c.foreign_table_name,c.foreign_column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if relationships.get(owner_field)!=(1,'client_profiles','id') or relationships.get('tenant_id')!=(1,'tenants','id'):raise RuntimeError('Unregistered client/tenant relationship: '+table)
  if order_field not in fields or 'timestamp' not in columns[order_field][0] or columns[order_field][1]:raise RuntimeError('Stable non-null timestamp ordering required: '+table)
  batch=batches.get(table,21);summary_field={'provider_shift_logs':'shiftStatus','clinical_assessments':'type','family_notifications':'type','care_feedbacks':'triage_status','messages_threads':'thread_type','family_members':'relationship'}.get(table,'status')
  properties={}
  for field in fields:
   kind,nullable=columns[field];typ='boolean' if kind in ['bool','boolean'] else 'integer' if kind in ['int4','int8','bigint','integer'] else 'number' if kind in ['float8','numeric','decimal'] else 'string'
   properties[field]={'type':[typ,'null'] if nullable else typ}
   if kind in ['int4','integer']:properties[field].update(minimum=-2147483648,maximum=2147483647)
   if 'timestamp' in kind:properties[field]['format']='date-time'
  record={'type':'object','additionalProperties':False,'required':fields,'properties':properties}
  records.append({'orderField':order_field,'ownerField':owner_field,'batch':batch,'summaryBatch':summary_batches.get(table,22),'summaryField':summary_field,'path':path,'table':table,'collection':collection,'item':item,'fields':fields,'dateFields':[k for k,v in properties.items() if v.get('format')=='date-time'],'types':{k:v['type'] for k,v in properties.items()}})
  for detail in [False,True]:
   route='/v1/client'+path+('/{recordId}' if detail else '')
   response={'type':'object','required':[item] if detail else [collection,'pagination'],'properties':{item:record} if detail else {collection:{'type':'array','items':record},'pagination':pagination}}
   query={} if detail else paging;request={'type':'object','additionalProperties':False,'properties':query}
   code='CLIENT_OWN_'+table.upper()+('_DETAIL' if detail else '_LIST')
   db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(not detail),route))
   endpoint=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
   if len(endpoint)!=1 or endpoint[0][1:]!=('client',1,'authenticated_client_profile_owner'):raise RuntimeError('Conflicting client read contract: '+route)
   aid=endpoint[0][0]
   db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Owned metadata only; client and tenant SQL scope, no signature/storage/private notes'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read owned '+table.replace('_',' ')+(' record' if detail else ' list'),'description':'Active explicit bearer session, unique owned client profile and matching tenant required. SQL restricts client_id and tenant_id; detail binds the exact record ID. Registered metadata fields only: no notes, authorization codes, signature data, storage keys or witness details. Stored consent status is not a legal validity judgment; authorization hours do not imply available/billable care; waitlist status does not imply an appointment. No new grants or mutations. Feedback is recorded metadata, not proof of authorship or resolved care; comments, resolution notes and visit identifiers are excluded.','security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in query.items()]+([{'in':'path','name':'recordId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}}] if detail else []),'responses':{'200':{'description':'Projected owned metadata','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Profile or record absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}}}
   if batch>=46:
    paths[route]['get']['description']='Active explicit bearer, unique owned client profile and matching tenant required. Every query binds client_id and tenant_id. Conversation metadata excludes provider IDs and message contents; it does not grant access to messages. Family-link metadata excludes names, contact details, linked user IDs, access levels and notification flags; a relationship label does not grant consent, proxy or emergency authority. Read only, no role grants.'
    sample={f:('2026-01-01T12:00:00Z' if properties[f].get('format')=='date-time' else 'record-id' if f=='id' else 'stored') for f in fields}
    example={item:sample} if detail else {collection:[sample],'pagination':{'limit':25,'offset':0,'total':1,'hasMore':False}}
    paths[route]['get']['responses']['200']['content']['application/json']['example']=example
 event_roots=['/v1/client'+r['path'] for r in records if 179<=r['batch']<=187]
 event_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in event_roots)}
 for route,operation in event_paths.items():
  registered=next(r for r in records if route=='/v1/client'+r['path'] or route=='/v1/client'+r['path']+'/{recordId}')
  operation['get']['description']='Read only own client-linked PSW record metadata. Active explicit bearer, matching non-null tenant and unique actor-owned ClientProfile required. Every query binds explicit client_id and tenant_id relationships. Expose only record ID and timestamps, plus stored shiftStatus for shift logs. Stable descending ordering by '+registered['orderField']+' then id. No location, signatures, staff/provider identifiers, observations, measurements, narratives, checklist answers or care tasks. These records do not establish performed/approved care, diagnosis, medication safety, infection-control compliance or authority to act. Existing authored User compatibility routes retain their original scope. Bounded paging, exact owned detail, no-store read-only repeatable-read snapshot and source limits. No delegated access, writes or role grants.'
 (ROOT/'docs/api/own-client-care-events-batches-179-187.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client PSW Record Metadata','version':'1.0.0'},'paths':event_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in event_paths}
 care_roots=['/v1/client'+r['path'] for r in records if 172<=r['batch']<=174]
 care_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in care_roots)}
 for operation in care_paths.values():operation['get']['description']='Read only own care-plan, clinical-assessment or medication-reconciliation metadata. Active explicit bearer, matching non-null tenant and exactly one actor-owned ClientProfile required. Every data query binds the explicit client_id relationship to that profile and tenant_id to the actor tenant. Return only registered IDs, stored status/type labels and timestamps. Exclude diagnoses, goals, interventions, scores, recommendations, reconciliation data, discrepancies, author/RN identifiers and clinical contents. Stored labels and review dates are not clinical instructions, evidence of safety, access to contents or authority to act. Bounded stable paging, exact owned detail, no-store read-only repeatable-read snapshots and source limits. Existing authored User compatibility routes retain their original scope. No delegated access, writes or role grants.'
 (ROOT/'docs/api/own-client-care-metadata-batches-172-174.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client Care Metadata','version':'1.0.0'},'paths':care_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in care_paths}
 patient_roots=['/v1/client'+r['path'] for r in records if 166<=r['batch']<=168]
 patient_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in patient_roots)}
 for operation in patient_paths.values():operation['get']['description']='Read only own patient-linked alert, insurance-claim or prescription metadata. Active explicit bearer, matching non-null tenant and exactly one actor-owned ClientProfile required. Every data query binds patient_id to that ClientProfile and tenant_id to the actor tenant. Claim provider_id refers to InsuranceProvider and grants no care-provider access. Expose registered IDs, stored statuses, alert type/severity and timestamps only. Exclude alert messages, medications, dosage/frequency/instructions, prescriber/provider identifiers, claim amounts/denials and private clinical contents. Stored statuses are not diagnoses, instructions, coverage approval, payment settlement or permission to act. Bounded lists and exact owned detail, no-store read-only repeatable-read snapshots and source limits. No delegated family access, writes or role grants.'
 (ROOT/'docs/api/own-patient-metadata-batches-166-168.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Patient-Linked Metadata','version':'1.0.0'},'paths':patient_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in patient_paths}
 (ROOT/'cloudflare/workers/src/client-records-registry.json').write_text(json.dumps(records,indent=2)+'\n')
 new_roots=['/v1/client'+r['path'] for r in records if 36<=r['batch']<=38]
 new_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in new_roots)}
 (ROOT/'docs/api/client-feedback-batches-36-38.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Feedback Reads Batches 36 and 38','version':'1.0.0'},'paths':new_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 notification_paths={p:v for p,v in paths.items() if p.startswith('/v1/client/family-notification-records')}
 for operation in notification_paths.values():operation['get']['description']='Read only family-notification metadata directly linked to the active actor-owned ClientProfile and tenant. Every record query binds client_id and tenant_id; exactly one owned profile is required. Project only ID, stored notification type, boolean read flag and creation timestamp. Message text is excluded. These client-owned reads grant no family proxy, linked-family-user or conversation access. Stored read flags do not prove delivery or acknowledgement. Bounded stable paging, exact owned detail, read-only snapshots, no-store and source limits; no mutations or grants.'
 (ROOT/'docs/api/client-family-notifications-batch-222.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Client Family Notification Metadata','version':'1.0.0'},'paths':notification_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in notification_paths}
 owner_roots=['/v1/client'+r['path'] for r in records if r['batch']>=46]
 owner_paths={p:v for p,v in paths.items() if any(p==root or p.startswith(root+'/') for root in owner_roots)}
 (ROOT/'docs/api/client-thread-family-batches-46-48.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Conversation and Family-Link Metadata','version':'1.0.0'},'paths':owner_paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
 paths={p:v for p,v in paths.items() if p not in new_paths and p not in owner_paths}
 (ROOT/'docs/api/client-records-batch-21.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Client Records','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered client-owned metadata APIs from existing database columns.')
