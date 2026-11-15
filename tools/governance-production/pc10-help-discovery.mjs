/** Bounded Help schema/access readback. Never reads business rows or changes authority. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const quote=s=>'"'+s.replaceAll('"','""')+'"';
const table=name=>quote(pin.schema)+'.'+quote(pin.tablePrefix+name);
// Finite source-reviewed count exception, not permission to read OTP records.
// grant_id is a generated call/session UUID, not an API permission foreign key.
const reviewedOutsideColumns=Object.freeze([{schema:'public',table:'communication_voice_otp',column:'grant_id',dataType:'text',requiredApplyLock:'SHARE',evidence:[
 {path:'cloudflare/workers/src/business-tasks/voice-otp.ts',sha256:'7e0488c911bbdd603682efbee96404a1adf3d54a690879206cf06bba4080ec3e'},
 {path:'packages/database/migrations/20261023_communication_voice_otp.sql',sha256:'be23c218580c5727064cd971d66e288c2ed5b0500eef523a851b9c71d9e86a6c'},
]}]);
export async function discoverHelp(db){
 let phase='begin';
 const query=async(sql,args=[])=>{phase=sql.includes('information_schema.columns')?'columns':sql.includes('pg_constraint')?'constraints':sql.includes('pg_indexes')?'indexes':sql.match(/govt_([a-z_]+)/)?.[1]??'transaction';return db.query(sql,args);};
 await query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await query("SET LOCAL statement_timeout='20s'");
  const manifest=(await query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
  const bounded=async(sql,args=[])=>{const rows=(await query(sql,args)).rows;if(rows.length>300)throw Error('Metadata bound exceeded');return rows;};
  const metadata=(name,where,args=[])=>bounded('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+table(name)+' x WHERE '+where+' LIMIT 301',args).then(rows=>rows.map(r=>r.metadata));
  const screens=await metadata('screens','id=685');
  const endpoints=await metadata('api_endpoints','id=794');
  const roles=await bounded('SELECT id,role_code,active FROM '+table('roles')+' WHERE id=51');
  const apiPermissions=await metadata('api_permissions','api_id=794 ORDER BY role_id,id');
  const screenPermissions=await metadata('role_screen_permissions','screen_id=685 ORDER BY role_id');
  const links=await metadata('screen_api_links','screen_id=685 OR api_id=794 ORDER BY screen_id,api_id');
  const controls=await metadata('screen_components','screen_id=685 OR id=779 ORDER BY screen_id,id');
  const elements=await metadata('screen_required_elements','screen_id=685 ORDER BY id');
  // Inspect business schema only: no SELECT is issued against faqs, users or tenants.
  const businessColumns=await bounded(`SELECT table_schema,table_name,column_name,data_type,udt_name,is_nullable,column_default,character_maximum_length FROM information_schema.columns WHERE table_schema='public' AND table_name IN ('faqs','tenants','users') ORDER BY table_name,ordinal_position`);
  const constraints=await bounded(`SELECT c.conrelid::regclass::text AS relation,c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname='public' AND r.relname IN ('faqs','tenants','users') ORDER BY relation,c.conname LIMIT 301`);
  const indexes=await bounded(`SELECT schemaname,tablename,indexname,indexdef FROM pg_indexes WHERE schemaname='public' AND tablename IN ('faqs','tenants','users') ORDER BY tablename,indexname LIMIT 301`);
  const governanceColumns=await bounded(`SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND (table_name LIKE $2 OR table_name LIKE $3 OR table_name=$4) AND column_name IN ('screen_id','role_id','id','permission_key','can_access','can_view') ORDER BY table_name,ordinal_position LIMIT 301`,[pin.schema,pin.tablePrefix+'%permission%',pin.tablePrefix+'%screen%',pin.tablePrefix+'primecare_ui_component_registry']);
  // Describe prospective binding writers, never infer a grant from a role/screen name.
  const bindingTables=['api_permissions','role_screen_permissions','role_screen_map','screen_components','screen_required_elements','screen_api_links','section_permissions','element_permissions'].map(name=>pin.tablePrefix+name);
  const bindingColumns=await bounded(`SELECT table_name,column_name,data_type,udt_name,is_nullable,column_default FROM information_schema.columns WHERE table_schema=$1 AND table_name=ANY($2::text[]) ORDER BY table_name,ordinal_position LIMIT 301`,[pin.schema,bindingTables]);
  const bindingConstraints=await bounded(`SELECT r.relname AS table_name,c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=ANY($2::text[]) ORDER BY r.relname,c.conname LIMIT 301`,[pin.schema,bindingTables]);
  const bindingIndexes=await bounded(`SELECT tablename,indexname,indexdef FROM pg_indexes WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,indexname LIMIT 301`,[pin.schema,bindingTables]);
  // Names/columns only: operational audit, quota and rate rows may contain private data.
  const runtimeRelations=await bounded(`SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema IN ('public',$1) AND table_type='BASE TABLE' AND (table_name ILIKE '%help%' OR table_name ILIKE '%quota%' OR table_name ILIKE '%rate%' OR table_name ILIKE '%audit%') ORDER BY table_schema,table_name LIMIT 301`,[pin.schema]);
  const runtimePolicyColumns=await bounded(`SELECT table_name,column_name,data_type,is_nullable,column_default FROM information_schema.columns WHERE table_schema=$1 AND (table_name ILIKE '%quota%' OR table_name ILIKE '%rate%' OR table_name ILIKE '%audit%') ORDER BY table_name,ordinal_position LIMIT 301`,[pin.schema]);
  // Read only registered policy definitions, never operational counters or audit records.
  const policyShape=(name,shape)=>Object.entries(shape).every(([column,type])=>runtimePolicyColumns.some(c=>c.table_name===pin.tablePrefix+name&&c.column_name===column&&c.data_type===type));
  const rateShape=policyShape('api_rate_limits',{id:'jsonb',api_id:'jsonb',runtime_artifact_id:'jsonb',limit_key:'jsonb',max_requests:'jsonb',time_window:'jsonb'});
  const auditShape=policyShape('audit_event_definitions',{id:'bigint',event_code:'text',event_name:'text',severity:'text',description:'text'});
  const ratePolicies=rateShape?await bounded('SELECT id,api_id,runtime_artifact_id,limit_key,max_requests,time_window FROM '+table('api_rate_limits')+" WHERE api_id #>> '{}'=$1 ORDER BY id::text LIMIT 301",['794']):[];
  const auditDefinitions=auditShape?await bounded('SELECT id,event_code,event_name,severity,description FROM '+table('audit_event_definitions')+" WHERE event_code ILIKE $1 ORDER BY id LIMIT 301",['%help%']):[];
  const policyDefinitionReadback={rateSchemaSupported:rateShape,auditSchemaSupported:auditShape,ratePolicies,auditDefinitions,authorityInferred:false,operationalRowsRead:0};
  // Exact registration and prospective storage shapes only, never operational rows.
  const relationShape=async(schema,names)=>{
   const columns=await bounded(`SELECT table_name,column_name,data_type,udt_name,is_nullable,column_default FROM information_schema.columns WHERE table_schema=$1 AND table_name=ANY($2::text[]) ORDER BY table_name,ordinal_position LIMIT 301`,[schema,names]);
   const constraints=await bounded(`SELECT r.relname AS table_name,c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=ANY($2::text[]) ORDER BY r.relname,c.conname LIMIT 301`,[schema,names]);
   const indexes=await bounded(`SELECT tablename,indexname,indexdef FROM pg_indexes WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,indexname LIMIT 301`,[schema,names]);
   return {schema,requestedTables:names,presentTables:[...new Set(columns.map(c=>c.table_name))],columns,constraints,indexes};
  };
  const operationalRegistrationShape={
   policies:await relationShape(pin.schema,['api_rate_limits','audit_event_definitions'].map(n=>pin.tablePrefix+n)),
   storage:await relationShape('public',['help_reader_rate','help_reader_audit']),
   operationalRowsRead:0,writes:0,authorityInferred:false
  };
  // Exact legacy identity evidence only. Candidate matches never confer authority.
  const legacyKey='api_permission_api_v1_clinical_director_quality_metrics_list_get';
  const identityColumns=await bounded(`SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=ANY($2::text[]) ORDER BY table_name,ordinal_position LIMIT 301`,[pin.schema,['api_endpoint_registry','runtime_artifacts','api_endpoints'].map(n=>pin.tablePrefix+n)]);
  const hasColumns=(name,columns)=>columns.every(column=>identityColumns.some(c=>c.table_name===pin.tablePrefix+name&&c.column_name===column));
  const originFields=['id','api_id','endpoint_code','method','endpoint_path'];
  const endpointFields=['id','http_method','route_path','permission_key'];
  const selectFields=fields=>fields.map(f=>`to_jsonb(x)->'${f}' AS "${f}"`).join(',');
  const originSchemaSupported=hasColumns('api_endpoint_registry',originFields);
  const endpointSchemaSupported=hasColumns('api_endpoints',endpointFields);
  const artifactSchemaSupported=hasColumns('runtime_artifacts',['id']);
  const origins=originSchemaSupported?await bounded('SELECT '+selectFields(originFields)+' FROM '+table('api_endpoint_registry')+" x WHERE 'api_permission_'||(to_jsonb(x)->>'endpoint_code')=$1 ORDER BY to_jsonb(x)->>'id' LIMIT 301",[legacyKey]):[];
  const members=apiPermissions.filter(r=>r.permission_key===legacyKey).map(r=>Object.fromEntries(['id','api_id','role_id','runtime_artifact_id','permission_key','can_access'].map(k=>[k,r[k]??null])));
  const operationPairs=origins.filter(o=>typeof o.method==='string'&&typeof o.endpoint_path==='string').map(o=>({method:o.method,path:o.endpoint_path}));
  const canonicalCandidates=endpointSchemaSupported&&operationPairs.length?await bounded('SELECT '+selectFields(endpointFields)+' FROM '+table('api_endpoints')+" x WHERE EXISTS(SELECT 1 FROM jsonb_to_recordset($1::jsonb) AS o(method text,path text) WHERE o.method=(to_jsonb(x)->>'http_method') AND o.path=(to_jsonb(x)->>'route_path')) ORDER BY to_jsonb(x)->>'id' LIMIT 301",[JSON.stringify(operationPairs)]):[];
  const referencedArtifactIds=[...new Set(members.filter(r=>r.runtime_artifact_id!==null).map(r=>String(r.runtime_artifact_id)))].sort();
  const artifactIds=artifactSchemaSupported&&referencedArtifactIds.length?await bounded('SELECT '+selectFields(['id'])+' FROM '+table('runtime_artifacts')+" x WHERE to_jsonb(x)->>'id'=ANY($1::text[]) ORDER BY to_jsonb(x)->>'id' LIMIT 301",[referencedArtifactIds]):[];
  const presentArtifactIds=artifactIds.map(r=>String(r.id));
  const legacyIdentityReview={permissionKey:legacyKey,identityColumns,originSchemaSupported,endpointSchemaSupported,artifactSchemaSupported,origins,members,canonicalCandidates,referencedArtifactIds,presentArtifactIds,missingArtifactIds:artifactSchemaSupported?referencedArtifactIds.filter(id=>!presentArtifactIds.includes(id)):null,authorityInferred:false,grantsChanged:0};
  // Retirement preparation is metadata only. Preserve PostgreSQL's complete JSONB
  // text rather than parsing bigint values through JavaScript's Number domain.
  const archiveName=pin.tablePrefix+'help_legacy_grant_archive';
  const sourceAndArchiveShape=await relationShape(pin.schema,[pin.tablePrefix+'api_permissions',archiveName]);
  const grantColumns=['_primecare_import_row','id','api_id','role_id','runtime_artifact_id','permission_key','can_access','created_at'];
  const sourceColumns=sourceAndArchiveShape.columns.filter(c=>c.table_name===pin.tablePrefix+'api_permissions');
  const rawRowsSupported=sourceColumns.length===grantColumns.length&&grantColumns.every(name=>sourceColumns.some(c=>c.column_name===name&&c.data_type===(['permission_key','created_at'].includes(name)?'text':'bigint')));
  const sourceRows=rawRowsSupported?await bounded('SELECT _primecare_import_row::text AS source_ordinal,id::text AS source_id,to_jsonb(x)::text AS original_row_text FROM '+table('api_permissions')+' x WHERE api_id=794 AND permission_key=$1 ORDER BY _primecare_import_row,id LIMIT 65',[legacyKey]):[];
  if(sourceRows.length>64)throw Error('Legacy retirement row bound exceeded');
  const sha256=text=>createHash('sha256').update(text,'utf8').digest('hex');
  if(sourceRows.some(r=>typeof r.original_row_text!=='string'||r.original_row_text.length>16384||!/^\d+$/.test(r.source_ordinal??'')||!/^\d+$/.test(r.source_id??'')))throw Error('Unsupported retirement row encoding');
  const sourceIds=sourceRows.map(r=>r.source_id);
  const incomingForeignKeys=await bounded(`SELECT ns.nspname AS source_schema,r.relname AS source_table,c.conname AS constraint_name,ARRAY(SELECT a.attname FROM unnest(c.conkey) WITH ORDINALITY k(attnum,n) JOIN pg_attribute a ON a.attrelid=c.conrelid AND a.attnum=k.attnum ORDER BY k.n) AS source_columns,ARRAY(SELECT a.attname FROM unnest(c.confkey) WITH ORDINALITY k(attnum,n) JOIN pg_attribute a ON a.attrelid=c.confrelid AND a.attnum=k.attnum ORDER BY k.n) AS referenced_columns,c.confupdtype AS update_action,c.confdeltype AS delete_action,c.convalidated AS validated,c.condeferrable AS deferrable,c.condeferred AS initially_deferred,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace ns ON ns.oid=r.relnamespace WHERE c.contype='f' AND c.confrelid=to_regclass($1) ORDER BY ns.nspname,r.relname,c.conname LIMIT 301`,[table('api_permissions')]);
  for(const fk of incomingForeignKeys){
   fk.matchingRows=null;fk.matchCountRead=false;
   if(fk.source_schema!==pin.schema||!/^govt_[a-z0-9_]+$/.test(fk.source_table)){fk.outOfMetadataScope=true;continue;}
   if(!rawRowsSupported||!Array.isArray(fk.source_columns)||!fk.source_columns.length||fk.source_columns.length!==fk.referenced_columns?.length||fk.referenced_columns.some(c=>!grantColumns.includes(c)))continue;
   const join=fk.source_columns.map((column,i)=>'r.'+quote(column)+'=p.'+quote(fk.referenced_columns[i])).join(' AND ');
   const rows=await bounded('SELECT COUNT(*)::text AS matching_rows FROM '+quote(pin.schema)+'.'+quote(fk.source_table)+' r WHERE EXISTS(SELECT 1 FROM '+table('api_permissions')+' p WHERE p.api_id=794 AND p.permission_key=$1 AND '+join+')',[legacyKey]);
   fk.matchingRows=rows[0]?.matching_rows??null;fk.matchCountRead=true;fk.outOfMetadataScope=false;
  }
  const logicalReferenceNames=['api_permission_id','api_permission_row_id','permission_id','permission_row_id','grant_id','grant_row_id','source_permission_id','source_grant_id','api_permission_ids','permission_ids','grant_ids','api_permission_import_row','grant_import_row','permission_key'];
  const sourceOrdinals=sourceRows.map(r=>r.source_ordinal);
  const logicalReferenceColumns=await bounded(`SELECT c.table_schema,c.table_name,c.column_name,c.data_type,c.udt_name,c.is_nullable,c.column_default FROM information_schema.columns c JOIN information_schema.tables t ON t.table_schema=c.table_schema AND t.table_name=c.table_name WHERE c.table_schema<>'information_schema' AND NOT starts_with(c.table_schema,'pg_') AND t.table_type='BASE TABLE' AND NOT(c.table_schema=$1 AND c.table_name=ANY($2::text[])) AND c.column_name=ANY($3::text[]) ORDER BY c.table_schema,c.table_name,c.ordinal_position LIMIT 301`,[pin.schema,[pin.tablePrefix+'api_permissions',archiveName],logicalReferenceNames]);
  const logicalReferences=[];
  for(const column of logicalReferenceColumns){
   if(column.table_schema!==pin.schema||!/^govt_[a-z0-9_]+$/.test(column.table_name)){
    const reviewed=reviewedOutsideColumns.find(v=>v.schema===column.table_schema&&v.table===column.table_name&&v.column===column.column_name);
    if(reviewed){
     if(!rawRowsSupported||column.data_type!==reviewed.dataType)throw Error('Reviewed outside reference shape differs');
     for(const evidence of reviewed.evidence){const content=await readFile(new URL('../../'+evidence.path,import.meta.url));if(createHash('sha256').update(content).digest('hex')!==evidence.sha256)throw Error('Reviewed outside reference source differs');}
     const security=await bounded('SELECT r.relkind,r.relrowsecurity,r.relforcerowsecurity FROM pg_class r JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=$2',[reviewed.schema,reviewed.table]);
     if(security.length!==1||security[0].relkind!=='r'||security[0].relrowsecurity!==false||security[0].relforcerowsecurity!==false)throw Error('Reviewed outside reference visibility differs');
     const rows=await bounded('SELECT COUNT(*)::text AS matching_rows FROM '+quote(reviewed.schema)+'.'+quote(reviewed.table)+' WHERE '+quote(reviewed.column)+'=ANY($1::text[])',[[...new Set([...sourceIds,...sourceOrdinals])]]);
     if(rows.length!==1||typeof rows[0].matching_rows!=='string'||!/^\d+$/.test(rows[0].matching_rows))throw Error('Invalid reviewed outside reference count');
     logicalReferences.push({...column,outOfMetadataScope:true,reviewedCountOnly:true,matchCountRead:true,matching_rows:rows[0].matching_rows,retirementBlocked:rows[0].matching_rows!=='0',businessRowPayloadsRead:0,matches:[],authorityInferred:false});continue;
    }
    logicalReferences.push({...column,outOfMetadataScope:true,matchCountRead:false,matches:[],authorityInferred:false});continue;
   }
   const targets=column.column_name==='permission_key'?[legacyKey]:[...new Set([...sourceIds,...sourceOrdinals])];
   const matches=rawRowsSupported&&sourceIds.length?await bounded('SELECT refs.referenced_grant_id,COUNT(*)::text AS matching_rows FROM '+quote(pin.schema)+'.'+quote(column.table_name)+" x CROSS JOIN LATERAL (SELECT DISTINCT value #>> '{}' AS referenced_grant_id FROM jsonb_path_query(to_jsonb(x)->$1::text,'strict $.**') AS values(value) WHERE jsonb_typeof(value) IN ('number','string')) refs WHERE refs.referenced_grant_id=ANY($2::text[]) GROUP BY 1 ORDER BY 1 LIMIT 301",[column.column_name,targets]):[];
   logicalReferences.push({...column,outOfMetadataScope:false,matchCountRead:rawRowsSupported,matchValueDomain:column.column_name==='permission_key'?'legacy-permission-key':'source-id-or-import-ordinal; target ownership not inferred',matches:matches.map(r=>({...r,matchesSourceId:sourceIds.includes(r.referenced_grant_id),matchesSourceOrdinal:sourceOrdinals.includes(r.referenced_grant_id)})),authorityInferred:false});
  }
  const triggers=await bounded(`SELECT r.relname AS table_name,t.tgname AS trigger_name,pg_get_triggerdef(t.oid) AS definition FROM pg_trigger t JOIN pg_class r ON r.oid=t.tgrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=ANY($2::text[]) AND NOT t.tgisinternal ORDER BY r.relname,t.tgname LIMIT 301`,[pin.schema,[pin.tablePrefix+'api_permissions',archiveName]]);
  const relationSecurity=await bounded(`SELECT r.relname AS table_name,r.relrowsecurity AS row_security,r.relforcerowsecurity AS force_row_security,r.relowner::text AS owner_oid,r.relacl::text AS acl FROM pg_class r JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=ANY($2::text[]) ORDER BY r.relname LIMIT 301`,[pin.schema,[pin.tablePrefix+'api_permissions',archiveName]]);
  const rules=await bounded(`SELECT tablename AS table_name,rulename AS rule_name,definition FROM pg_rules WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,rulename LIMIT 301`,[pin.schema,[pin.tablePrefix+'api_permissions',archiveName]]);
  const rowSecurityPolicies=await bounded(`SELECT tablename AS table_name,policyname AS policy_name,permissive,roles,cmd,qual,with_check FROM pg_policies WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,policyname LIMIT 301`,[pin.schema,[pin.tablePrefix+'api_permissions',archiveName]]);
  const manifestColumns=await bounded(`SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position LIMIT 301`,[pin.schema,pin.tablePrefix+'source_manifest']);
  const manifestDeclaredReferences={supported:false,unsupportedReason:'Missing supported manifest JSONB snapshot format and sqlite_objects array',manifestColumns,objects:[],inspectionRequired:true,sqlExecuted:false,authorityInferred:false};
  if(manifestColumns.some(c=>c.column_name==='manifest'&&c.data_type==='jsonb')){
   const shape=(await query('SELECT manifest->>\'format\' AS format,jsonb_typeof(manifest->\'sqlite_objects\') AS objects_type FROM '+table('source_manifest'))).rows;
   if(shape.length===1&&shape[0].format==='primecare-governance-snapshot-v1'&&shape[0].objects_type==='array'){
    const objects=await bounded('SELECT object->>0 AS object_type,object->>1 AS object_name,object->>2 AS table_name,object->>3 AS sql FROM '+table('source_manifest')+" m CROSS JOIN LATERAL jsonb_array_elements(m.manifest->'sqlite_objects') AS objects(object) WHERE object->>3 ILIKE $1 ORDER BY object->>0,object->>1 LIMIT 301",['%api_permissions%']);
    if(objects.some(o=>!['table','index','view','trigger'].includes(o.object_type)||typeof o.object_name!=='string'||typeof o.table_name!=='string'||typeof o.sql!=='string'||o.sql.length>262144))throw Error('Unsupported declared reference metadata');
    manifestDeclaredReferences.supported=true;manifestDeclaredReferences.unsupportedReason=null;manifestDeclaredReferences.objects=objects;
   }
  }
  const legacyRetirementDiscovery={archiveTable:quote(pin.schema)+'.'+quote(archiveName),sourceAndArchiveShape,triggers,relationSecurity,rules,rowSecurityPolicies,manifestDeclaredReferences,rawRowsSupported,expectedRows:64,sourceRows:sourceRows.map(r=>({...r,sha256:sha256(r.original_row_text)})),sourceRowsSha256:rawRowsSupported?sha256(JSON.stringify(sourceRows.map(r=>r.original_row_text))):null,hashEncoding:'sha256 UTF-8 JSON.stringify(original_row_text strings ordered by numeric source ordinal)',incomingForeignKeys,logicalReferenceNames,logicalReferenceColumns,logicalReferences,reviewedOutsideColumns,archiveContentsRead:false,archiveContentsReason:'Shape only; existing archive contents require the exact reviewed retirement writer',writes:0,businessRowsRead:0,businessRowPayloadsRead:0,outsideReferenceCountQueries:logicalReferences.filter(v=>v.reviewedCountOnly).length,authorityInferred:false};
  // Principal/ACL diagnostics only: never assume that read credentials may create or lock.
  const principals=await bounded('SELECT current_user AS current_user,session_user AS session_user,n.nspname AS schema_name,pg_get_userbyid(n.nspowner) AS schema_owner,has_schema_privilege(current_user,n.oid,\'USAGE\') AS schema_usage,has_schema_privilege(current_user,n.oid,\'CREATE\') AS schema_create FROM pg_namespace n WHERE n.nspname=$1',[pin.schema]);
  const privilegeTargets=[...new Map([
   ...['api_permissions','source_manifest','api_endpoints','api_endpoint_registry','runtime_artifacts','help_legacy_grant_archive'].map(name=>({table_schema:pin.schema,table_name:pin.tablePrefix+name})),
   ...logicalReferenceColumns,...incomingForeignKeys.map(r=>({table_schema:r.source_schema,table_name:r.source_table})),
  ].map(r=>[r.table_schema+'.'+r.table_name,{table_schema:r.table_schema,table_name:r.table_name}])).values()];
  const tablePrivileges=[];
  for(const target of privilegeTargets){
   const rows=await bounded('SELECT pg_get_userbyid(r.relowner) AS owner,has_table_privilege(current_user,r.oid,\'SELECT\') AS can_select,has_table_privilege(current_user,r.oid,\'INSERT\') AS can_insert,has_table_privilege(current_user,r.oid,\'UPDATE\') AS can_update,has_any_column_privilege(current_user,r.oid,\'UPDATE\') AS can_update_any_column,has_table_privilege(current_user,r.oid,\'DELETE\') AS can_delete,has_table_privilege(current_user,r.oid,\'TRUNCATE\') AS can_truncate FROM pg_class r JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=$2',[target.table_schema,target.table_name]);
   tablePrivileges.push({...target,exists:rows.length===1,...(rows[0]??{})});
  }
  const functionPrivileges=await bounded("SELECT has_function_privilege(current_user,'pg_catalog.pg_advisory_xact_lock(integer,integer)','EXECUTE') AS advisory_xact_lock_integer_integer_execute");
  legacyRetirementDiscovery.privilegeDiagnostics={principals,tablePrivileges,functionPrivileges,authorityChanged:false};
  const registryColumns=governanceColumns.filter(c=>c.table_name===pin.tablePrefix+'primecare_ui_component_registry').map(c=>c.column_name);
  const registry=registryColumns.includes('id')?await metadata('primecare_ui_component_registry','id=779'):[];
  // Exact screen-associated access metadata only; a missing table/column is reported, never guessed.
  const related={};
  for(const name of [...new Set(governanceColumns.filter(c=>c.column_name==='screen_id').map(c=>c.table_name))]){
   if(['screens','screen_components','screen_required_elements','screen_api_links','role_screen_permissions'].some(t=>name===pin.tablePrefix+t))continue;
   if(!/^govt_[a-z0-9_]+$/.test(name))throw Error('Invalid relation');
   related[name]=await bounded('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+quote(pin.schema)+'.'+quote(name)+' x WHERE screen_id::text=$1 LIMIT 301',['685']).then(rows=>rows.map(r=>r.metadata));
  }
  await query('ROLLBACK');
  return {format:1,sourceCommit:process.env.GITHUB_SHA??null,manifestSha256:pin.manifestSha256,screens,endpoints,roles,apiPermissions,screenPermissions,links,controls,elements,registry,businessColumns,constraints,indexes,governanceColumns,related,bindingColumns,bindingConstraints,bindingIndexes,runtimeRelations,runtimePolicyColumns,policyDefinitionReadback,operationalRegistrationShape,legacyIdentityReview,legacyRetirementDiscovery,runtimePolicyValuesRead:ratePolicies.length+auditDefinitions.length,writes:0,businessRowsRead:0,grantsChanged:0,hostActivated:false,authorityInferred:false};
 }catch(error){const failedPhase=phase;await db.query('ROLLBACK');error.helpPhase=failedPhase;throw error;}
}
async function main(){
 const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error('Missing connection');
 const u=new URL(raw);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 try{await db.connect();const result=await discoverHelp(db);await mkdir('test-results/pc10-help',{recursive:true});await writeFile('test-results/pc10-help/discovery.json',JSON.stringify(result,null,2)+'\n');console.log('PC10_HELP_DISCOVERY '+JSON.stringify(result));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help schema/access discovery failed closed; no mutations attempted. '+JSON.stringify({phase:error.helpPhase??'connection',sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null,bounded:error.message==='Metadata bound exceeded'}));process.exitCode=1;});

