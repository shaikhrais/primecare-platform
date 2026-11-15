/** Exact approved API794 legacy-grant retirement. No grant retargeting or runtime activation. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const root=new URL('../../',import.meta.url);
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const definitionBytes=await readFile(new URL('./pc10-help-legacy-retirement.definition.json',import.meta.url));
export const helpLegacyRetirement=JSON.parse(definitionBytes);
const contractBytes=await readFile(new URL('./pc10-help-reader-contract.json',import.meta.url));
const contract=JSON.parse(contractBytes);
const archiveSql=await readFile(new URL('./pc10-help-legacy-archive.sql',import.meta.url),'utf8');
const sha=value=>createHash('sha256').update(value).digest('hex');
export const legacyRetirementDefinitionHash=sha(definitionBytes),legacyArchiveSqlHash=sha(archiveSql);
export function helpLegacyArchiveStatements(){
 const expectedCreate='CREATE TABLE "'+pin.schema+'"."'+pin.tablePrefix+'help_legacy_grant_archive"';
 const start=archiveSql.indexOf(expectedCreate);
 if(start<=0||archiveSql.indexOf(expectedCreate,start+1)!==-1||!archiveSql.slice(0,start).trimEnd().endsWith('END $$;')||!archiveSql.slice(start).trimEnd().endsWith(');'))throw Error('Reviewed archive SQL markers differ');
 const parts=[{phase:'archive-registration-ddl-guard',sql:archiveSql.slice(0,start)},{phase:'archive-registration-ddl-create',sql:archiveSql.slice(start)}];
 if(parts.map(p=>p.sql).join('')!==archiveSql)throw Error('Reviewed archive SQL bytes differ');return parts;
}
export const legacyRetirementScriptHash=sha(await readFile(new URL(import.meta.url)));
const contractHash=sha(contractBytes),q=name=>'"'+name.replaceAll('"','""')+'"',table=name=>q(pin.schema)+'.'+q(pin.tablePrefix+name);
const source=table('api_permissions'),archive=table('help_legacy_grant_archive');
const fixedKey='api_permission_api_v1_clinical_director_quality_metrics_list_get';
const canonical=value=>Array.isArray(value)?'['+value.map(canonical).join(',')+']':value&&typeof value==='object'?'{'+Object.keys(value).sort().map(k=>JSON.stringify(k)+':'+canonical(value[k])).join(',')+'}':JSON.stringify(value);
export const helpLegacyDigest=value=>sha(canonical(value));
const fixedOrigin={id:794,api_id:5041,endpoint_code:'api_v1_clinical_director_quality_metrics_list_get',method:'GET',endpoint_path:'/v1/clinical-director-quality-metrics'};
const referenceNames=['api_permission_id','api_permission_row_id','permission_id','permission_row_id','grant_id','grant_row_id','source_permission_id','source_grant_id','api_permission_ids','permission_ids','grant_ids','api_permission_import_row','grant_import_row','permission_key'];
const outsideColumns=[{table_schema:'public',table_name:'communication_voice_otp',column_name:'grant_id',data_type:'text',udt_name:'text',sourcePath:'cloudflare/workers/src/business-tasks/voice-otp.ts',sourceSha256:'7e0488c911bbdd603682efbee96404a1adf3d54a690879206cf06bba4080ec3e',migrationPath:'packages/database/migrations/20261023_communication_voice_otp.sql',migrationSha256:'be23c218580c5727064cd971d66e288c2ed5b0500eef523a851b9c71d9e86a6c'}];
const isSha=value=>typeof value==='string'&&/^[a-f0-9]{64}$/.test(value);
const isCommit=value=>typeof value==='string'&&/^[a-f0-9]{40}$/.test(value);
const exactInt=value=>{if(typeof value==='string'&&/^(0|[1-9][0-9]*)$/.test(value))value=Number(value);if(!Number.isSafeInteger(value)||value<0)throw Error('Unsafe projected identity');return value;};
function selectDefinition(fixtureDefinition){
 if(fixtureDefinition!==undefined){
  if(process.env.HELP_LEGACY_RETIREMENT_FIXTURE!=='1'||['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DB_URL'].some(k=>Object.hasOwn(process.env,k)))throw Error('Explicit isolated retirement fixture required');
  const url=process.env.HELP_LEGACY_RETIREMENT_TEST_DATABASE_URL;if(url){const u=new URL(url);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='127.0.0.1'||u.pathname!=='/help_legacy_retirement'||u.search||u.hash)throw Error('Explicit localhost retirement fixture required');}
 }
 const d=fixtureDefinition??helpLegacyRetirement;
 if(d.format!==1||d.operationId!=='pc10.help.api794.legacy-retirement.v1'||d.apiId!==794||d.sourceTable!=='api_permissions'||d.archiveTable!=='help_legacy_grant_archive'||d.permissionKey!==fixedKey||d.expectedCount!==64||canonical(d.origin)!==canonical(fixedOrigin)||canonical(d.missingArtifactIds)!=='["1"]'||canonical(d.logicalReferenceColumns)!==canonical(referenceNames)||canonical(d.reviewedOutsideColumns)!==canonical(outsideColumns)||d.newRoleGrants!==false||d.runtimeActivation!==false||d.contentWrites!==false||d.baselineChanged!==false)throw Error('Retirement scope differs');
 for(const key of ['groupFingerprint','sourceRowsSha256','sourceShapeSha256','referenceInventorySha256','helpContractSha256','manifestDeclaredReferencesSha256'])if(!isSha(d[key]))throw Error('Retirement proof missing');
 if(!Array.isArray(d.manifestDeclaredReferences)||d.manifestDeclaredReferences.length!==2||helpLegacyDigest(d.manifestDeclaredReferences)!==d.manifestDeclaredReferencesSha256)throw Error('Declared reference proof differs');
 if(d.helpContractSha256!==contractHash)throw Error('Help contract source differs');
 if(!fixtureDefinition){
  const r=pin.helpLegacyGrantRetirementWriter;
  if(!r||r.definitionSha256!==legacyRetirementDefinitionHash||r.archiveSqlSha256!==legacyArchiveSqlHash||r.scriptSha256!==legacyRetirementScriptHash||r.sourceTable!=='api_permissions'||r.archiveTable!=='help_legacy_grant_archive'||r.apiId!==794||r.expectedRows!==64||r.groupFingerprint!==d.groupFingerprint||r.archiveOptInVariable!==d.archiveOptInVariable||r.retirementOptInVariable!==d.retirementOptInVariable||r.schemaChanges!==true||r.grantsRetired!==64||r.newRoleGrants!==false||r.runtimeActivation!==false)throw Error('Unregistered retirement writer');
 }
 return {d,definitionHash:fixtureDefinition?helpLegacyDigest(d):legacyRetirementDefinitionHash};
}
async function outsideEvidence(d){for(const r of d.reviewedOutsideColumns){if(sha(await readFile(new URL(r.sourcePath,root)))!==r.sourceSha256||sha(await readFile(new URL(r.migrationPath,root)))!==r.migrationSha256)throw Error('Reviewed outside-column evidence differs');}}
async function begin(db,apply){await db.query(apply?'BEGIN ISOLATION LEVEL SERIALIZABLE':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='20s'");await db.query("SET LOCAL lock_timeout='5s'");}
async function manifest(db,lock=false,d=helpLegacyRetirement){
 const rows=(await db.query('SELECT manifest_sha256,manifest->>\'format\' AS format,jsonb_typeof(manifest->\'sqlite_objects\') AS objects_type FROM '+table('source_manifest')+(lock?' FOR SHARE':''))).rows;
 if(rows.length!==1||rows[0].manifest_sha256!==pin.manifestSha256||rows[0].format!=='primecare-governance-snapshot-v1'||rows[0].objects_type!=='array')throw Error('Authority or declared reference format differs');
 const invalid=(await db.query('SELECT count(*)::text AS n FROM '+table('source_manifest')+" m CROSS JOIN LATERAL jsonb_array_elements(m.manifest->'sqlite_objects') AS objects(object) WHERE jsonb_typeof(object) IS DISTINCT FROM 'array' OR jsonb_array_length(CASE WHEN jsonb_typeof(object)='array' THEN object ELSE '[]'::jsonb END)<>4 OR jsonb_typeof(object->0) IS DISTINCT FROM 'string' OR jsonb_typeof(object->1) IS DISTINCT FROM 'string' OR jsonb_typeof(object->2) IS DISTINCT FROM 'string' OR jsonb_typeof(object->3) NOT IN ('string','null')")).rows;
 if(invalid.length!==1||invalid[0].n!=='0')throw Error('Unsupported declared reference shape');
 const objects=(await db.query('SELECT object->>0 AS object_type,object->>1 AS object_name,object->>2 AS table_name,object->>3 AS sql FROM '+table('source_manifest')+" m CROSS JOIN LATERAL jsonb_array_elements(m.manifest->'sqlite_objects') AS objects(object) WHERE object->>3 ILIKE $1 ORDER BY object->>0,object->>1 LIMIT 3",['%api_permissions%'])).rows;
 if(helpLegacyDigest(objects)!==d.manifestDeclaredReferencesSha256)throw Error('Declared permission references differ');
}
async function relationShape(db,name){
 const full=pin.tablePrefix+name;
 const columns=(await db.query('SELECT column_name,data_type,udt_name,is_nullable,column_default FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[pin.schema,full])).rows;
 const constraints=(await db.query('SELECT c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=$2 ORDER BY c.conname',[pin.schema,full])).rows;
 const indexes=(await db.query('SELECT indexname,indexdef FROM pg_indexes WHERE schemaname=$1 AND tablename=$2 ORDER BY indexname',[pin.schema,full])).rows;
 return {columns,constraints,indexes};
}
async function safeRelation(db,schema,name){
 const rows=(await db.query('SELECT c.relkind,c.relrowsecurity,c.relforcerowsecurity FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relname=$2',[schema,name])).rows;
 if(rows.length!==1||rows[0].relkind!=='r'||rows[0].relrowsecurity||rows[0].relforcerowsecurity)throw Error('Unsafe metadata relation');
 const triggers=(await db.query('SELECT t.tgname FROM pg_trigger t JOIN pg_class c ON c.oid=t.tgrelid JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relname=$2 AND NOT t.tgisinternal',[schema,name])).rows;
 const rules=(await db.query('SELECT rulename FROM pg_rules WHERE schemaname=$1 AND tablename=$2',[schema,name])).rows;
 if(triggers.length||rules.length)throw Error('Unreviewed metadata trigger or rule');
}
const normalized=value=>value.replaceAll(/\s+/g,'').replaceAll('::text','').replaceAll(/[()]/g,'');
async function archiveShape(db){
 const shape=await relationShape(db,'help_legacy_grant_archive');if(!shape.columns.length)return false;
 const expected=[['source_ordinal','bigint','NO',null],['group_fingerprint','text','NO',null],['original_row','jsonb','NO',null],['operation_context','jsonb','NO',null],['retired_at','timestamp with time zone','NO','clock_timestamp()']];
 if(shape.columns.length!==5||shape.columns.some((c,i)=>canonical([c.column_name,c.data_type,c.is_nullable,c.column_default])!==canonical(expected[i])))throw Error('Archive columns differ');
 const checks={pc10_help_legacy_original_row:"CHECK(jsonb_typeof(original_row)='object' AND original_row ? '_primecare_import_row' AND original_row->>'_primecare_import_row'=source_ordinal::text)",pc10_help_legacy_context:"CHECK(jsonb_typeof(operation_context)='object')",pc10_help_legacy_fingerprint:"CHECK(group_fingerprint ~ '^[0-9a-f]{64}$')"};
 if(shape.constraints.length!==4||shape.constraints.some(c=>c.contype==='p'?c.conname!==pin.tablePrefix+'help_legacy_grant_archive_pkey'||c.definition!=='PRIMARY KEY (source_ordinal)':c.contype!=='c'||!Object.hasOwn(checks,c.conname)||normalized(c.definition)!==normalized(checks[c.conname])))throw Error('Archive constraints differ');
 if(shape.indexes.length!==1||shape.indexes[0].indexname!==pin.tablePrefix+'help_legacy_grant_archive_pkey')throw Error('Archive indexes differ');
 await safeRelation(db,pin.schema,pin.tablePrefix+'help_legacy_grant_archive');
 const privileges=(await db.query('SELECT count(*)::text AS n FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace CROSS JOIN LATERAL aclexplode(COALESCE(c.relacl,acldefault(\'r\',c.relowner))) a WHERE n.nspname=$1 AND c.relname=$2 AND a.grantee=0',[pin.schema,pin.tablePrefix+'help_legacy_grant_archive'])).rows;
 if(privileges.length!==1||privileges[0].n!=='0')throw Error('Archive public privileges differ');
 return true;
}
async function references(db){
 const foreignKeys=(await db.query(`SELECT n.nspname AS table_schema,r.relname AS table_name,c.conname,c.confdeltype,c.confupdtype,c.condeferrable,c.condeferred,
 (SELECT jsonb_agg(a.attname ORDER BY k.ord) FROM unnest(c.conkey) WITH ORDINALITY k(num,ord) JOIN pg_attribute a ON a.attrelid=c.conrelid AND a.attnum=k.num) AS columns,
 (SELECT jsonb_agg(a.attname ORDER BY k.ord) FROM unnest(c.confkey) WITH ORDINALITY k(num,ord) JOIN pg_attribute a ON a.attrelid=c.confrelid AND a.attnum=k.num) AS target_columns
 FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE c.contype='f' AND c.confrelid=$1::regclass ORDER BY n.nspname,r.relname,c.conname`,[source])).rows;
 const logicalColumns=(await db.query('SELECT table_schema,table_name,column_name,data_type,udt_name FROM information_schema.columns WHERE table_schema NOT IN (\'pg_catalog\',\'information_schema\') AND column_name=ANY($1::text[]) AND NOT(table_schema=$2 AND table_name=ANY($3::text[])) ORDER BY table_schema,table_name,column_name',[referenceNames,pin.schema,[pin.tablePrefix+'api_permissions',pin.tablePrefix+'help_legacy_grant_archive']])).rows;
 if(foreignKeys.length>300||logicalColumns.length>300)throw Error('Reference inventory exceeded');
 return {foreignKeys,logicalColumns};
}
async function checkReferences(db,inventory,rows,apply){
 const relations=new Map();for(const r of [...inventory.foreignKeys,...inventory.logicalColumns]){
  const outside=outsideColumns.some(c=>['table_schema','table_name','column_name','data_type','udt_name'].every(k=>r[k]===c[k]));
  if((r.table_schema!==pin.schema||!r.table_name.startsWith(pin.tablePrefix))&&!outside)throw Error('Reference outside governed metadata');relations.set(r.table_schema+'.'+r.table_name,r);
 }
 for(const r of [...relations.values()].sort((a,b)=>(a.table_schema+'.'+a.table_name).localeCompare(b.table_schema+'.'+b.table_name))){
  if(apply)await db.query('LOCK TABLE '+q(r.table_schema)+'.'+q(r.table_name)+' IN SHARE MODE');
  const state=(await db.query('SELECT c.relkind,c.relrowsecurity,c.relforcerowsecurity FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relname=$2',[r.table_schema,r.table_name])).rows;
  if(state.length!==1||state[0].relkind!=='r'||state[0].relrowsecurity||state[0].relforcerowsecurity)throw Error('Unreadable metadata reference');
 }
 for(const r of inventory.foreignKeys){
  if(!Array.isArray(r.columns)||!r.columns.length||r.columns.length!==r.target_columns?.length)throw Error('Unreviewed foreign reference');
  const join=r.columns.map((column,i)=>'r.'+q(column)+'=p.'+q(r.target_columns[i])).join(' AND ');
  const count=(await db.query('SELECT count(*)::text AS n FROM '+q(r.table_schema)+'.'+q(r.table_name)+' r JOIN '+source+' p ON '+join+' WHERE p.permission_key=$1',[fixedKey])).rows;
  if(count.length!==1||count[0].n!=='0')throw Error('Incoming foreign reference exists');
 }
 const values=[...new Set(rows.flatMap(r=>[r.source_id,r.source_ordinal]))];
 for(const r of inventory.logicalColumns){
  const targets=r.column_name==='permission_key'?[fixedKey]:values;
  if(r.table_schema!==pin.schema){const count=(await db.query('SELECT count(*)::text AS n FROM '+q(r.table_schema)+'.'+q(r.table_name)+' WHERE '+q(r.column_name)+'=ANY($1::text[])',[targets])).rows;if(count.length!==1||count[0].n!=='0')throw Error('Reviewed outside-column reference exists');continue;}
  const result=(await db.query(`WITH RECURSIVE refs(value,depth) AS (
   SELECT to_jsonb(x)->$1,0 FROM ${q(r.table_schema)}.${q(r.table_name)} x
   UNION ALL SELECT child.value,refs.depth+1 FROM refs CROSS JOIN LATERAL (
    SELECT value FROM jsonb_each(CASE WHEN jsonb_typeof(refs.value)='object' THEN refs.value ELSE '{}'::jsonb END)
    UNION ALL SELECT to_jsonb(key) FROM jsonb_each(CASE WHEN jsonb_typeof(refs.value)='object' THEN refs.value ELSE '{}'::jsonb END)
    UNION ALL SELECT value FROM jsonb_array_elements(CASE WHEN jsonb_typeof(refs.value)='array' THEN refs.value ELSE '[]'::jsonb END)
   ) child WHERE refs.depth<8
  ) SELECT count(*) FILTER(WHERE value #>> '{}' = ANY($2::text[]))::text AS matches,COALESCE(bool_or(depth=8 AND jsonb_typeof(value) IN ('array','object')),false) AS truncated FROM refs`,[r.column_name,targets])).rows;
  if(result.length!==1||result[0].matches!=='0'||result[0].truncated!==false)throw Error('Incoming logical reference exists or is unbounded');
 }
}
async function endpoint(db,lock){
 const endpoints=(await db.query('SELECT to_jsonb(e)::text AS row_text,e.* FROM '+table('api_endpoints')+' e WHERE id=794'+(lock?' FOR SHARE OF e':''))).rows;
 const e=endpoints[0];if(endpoints.length!==1||e.http_method!==contract.method||e.route_path!==contract.path||e.permission_key!==contract.permissionKey||e.rate_limit_key!==contract.rateLimitKey||e.service_name!==contract.service||exactInt(e.auth_required)!==1||e.implementation_status!=='registered-unimplemented'||e.request_schema!==JSON.stringify(contract.requestSchema)||e.response_schema!==JSON.stringify(contract.responseSchema))throw Error('Approved Help endpoint differs');
 return e;
}
async function origins(db,d,lock){
 const rows=(await db.query('SELECT to_jsonb(r)::text AS row_text,r.* FROM '+table('api_endpoint_registry')+' r WHERE to_jsonb(r)->>\'endpoint_code\'=$1'+(lock?' FOR SHARE OF r':''),[d.origin.endpoint_code])).rows;
 const projected=rows.map(r=>({id:exactInt(r.id),api_id:exactInt(r.api_id),endpoint_code:r.endpoint_code,method:r.method,endpoint_path:r.endpoint_path}));
 if(projected.length!==1||canonical(projected[0])!==canonical(d.origin))throw Error('Legacy operation origin differs');
 const candidates=(await db.query('SELECT id FROM '+table('api_endpoints')+' WHERE http_method=$1 AND route_path=$2 LIMIT 2',[d.origin.method,d.origin.endpoint_path])).rows;
 if(candidates.length)throw Error('Unreviewed canonical legacy operation exists');
 const artifacts=(await db.query('SELECT to_jsonb(a)->>\'id\' AS id FROM '+table('runtime_artifacts')+' a WHERE to_jsonb(a)->>\'id\'=ANY($1::text[]) LIMIT 2',[d.missingArtifactIds])).rows;
 if(artifacts.length)throw Error('Legacy artifact disposition differs');
 return {rows,projected};
}
async function rawRows(db,lock=false){return (await db.query('SELECT _primecare_import_row::text AS source_ordinal,id::text AS source_id,to_jsonb(p)::text AS original_row_text,id,api_id,role_id,runtime_artifact_id,permission_key,can_access FROM '+source+' p WHERE permission_key=$1 ORDER BY _primecare_import_row LIMIT 65'+(lock?' FOR UPDATE OF p':''),[fixedKey])).rows;}
const projection=rows=>rows.map(r=>Object.fromEntries(['id','api_id','role_id','runtime_artifact_id','permission_key','can_access'].map(k=>[k,k==='permission_key'?r[k]:r[k]===null?null:exactInt(r[k])]))).sort((a,b)=>a.id-b.id);
const rowDigest=rows=>sha(JSON.stringify(rows.map(r=>r.original_row_text)));
async function unrelated(db){return (await db.query("SELECT count(*)::text AS count,encode(sha256(convert_to(COALESCE(jsonb_agg(to_jsonb(p) ORDER BY _primecare_import_row),'[]'::jsonb)::text,'UTF8')),'hex') AS sha256 FROM "+source+' p WHERE permission_key IS DISTINCT FROM $1',[fixedKey])).rows[0];}
export async function inspectHelpLegacyRetirement(db){
 await manifest(db);const shape=await relationShape(db,'api_permissions'),inventory=await references(db),rows=await rawRows(db),e=await endpoint(db,false),o=await origins(db,helpLegacyRetirement,false);
 return {sourceRows:rows.map(r=>({source_ordinal:r.source_ordinal,source_id:r.source_id,original_row_text:r.original_row_text})),sourceRowsSha256:rowDigest(rows),sourceShape:shape,sourceShapeSha256:helpLegacyDigest(shape),referenceInventory:inventory,referenceInventorySha256:helpLegacyDigest(inventory),groupFingerprint:helpLegacyDigest({members:projection(rows),endpoint:{id:794,http_method:e.http_method,route_path:e.route_path,permission_key:e.permission_key},origins:o.projected}),helpContractSha256:contractHash};
}
export async function registerHelpLegacyArchive(db,{apply=false,fixtureDefinition}={}){
 let phase='archive-registration-definition',begun=false;
 try{
  const {d}=selectDefinition(fixtureDefinition);phase='archive-registration-evidence';if(!fixtureDefinition)await outsideEvidence(d);
  phase='archive-registration-begin';await begin(db,apply);begun=true;
  if(apply){phase='archive-registration-advisory';await db.query('SELECT pg_advisory_xact_lock(794,685)');phase='archive-registration-source-lock';await db.query('LOCK TABLE '+source+' IN SHARE MODE');}
  phase='archive-registration-authority';await manifest(db,apply,d);phase='archive-registration-preflight';let exists=await archiveShape(db);const existed=exists;
  if(!exists&&apply){phase='archive-registration-set-config';await db.query("SELECT set_config('primecare.help_legacy_archive_registration','1',true)");for(const statement of helpLegacyArchiveStatements()){phase=statement.phase;if(typeof db.exec==='function')await db.exec(statement.sql);else await db.query(statement.sql);}phase='archive-registration-readback';exists=await archiveShape(db);if(!exists)throw Error('Archive creation readback missing');}
  phase=apply?'archive-registration-commit':'archive-registration-rollback';await db.query(apply?'COMMIT':'ROLLBACK');begun=false;return {archivePresent:exists,applied:apply&&!existed,grantsRetired:0,newRoleGrants:0,runtimeActivated:false};
 }catch(error){if(error&&typeof error==='object')error.retirementPhase=phase;if(begun)await db.query('ROLLBACK');throw error;}
}
/** Only fixed registration phases and complete PostgreSQL permission sentences.
 * Never serialize DETAIL, HINT, SQL, connection data, or arbitrary error text.
 */
export function retirementFailureDiagnostic(error){
 const sqlstate=/^[0-9A-Z]{5}$/.test(error?.code??'')?error.code:null;
 const phases=['definition','evidence','begin','advisory','source-lock','authority','preflight','set-config','ddl','ddl-guard','ddl-create','ddl-revoke','readback','commit','rollback'].map(p=>'archive-registration-'+p);
 const result={sqlstate,phase:phases.includes(error?.retirementPhase)?error.retirementPhase:null};
 if(sqlstate==='42501'){
  result.category='insufficient_privilege';const raw=typeof error.message==='string'?error.message:'';
  const message=raw.replace(/\([^\r\n]*\)$/,'(...)');
  if(message.length<=200&&!/[\r\n]|:\/\/|@|password|credential|token/i.test(message)&&[
   /^permission denied for (?:schema|table|relation|sequence|database|language) "?[A-Za-z_][A-Za-z0-9_.-]{0,127}"?$/,
   /^permission denied for function "?[A-Za-z_][A-Za-z0-9_.-]{0,127}"?(?:\(\.\.\.\))?$/,
   /^permission denied to set parameter "[A-Za-z_][A-Za-z0-9_.-]{0,127}"$/,
   /^must be owner of (?:schema|table|relation|sequence|database) "?[A-Za-z_][A-Za-z0-9_.-]{0,127}"?$/
  ].some(pattern=>pattern.test(message)))result.message=message;
 }
 return result;
}
async function archiveRows(db){return (await db.query("SELECT source_ordinal::text,original_row->>'id' AS source_id,group_fingerprint,original_row::text AS original_row_text,operation_context::text AS context_text,operation_context->'endpoint' AS endpoint_context,operation_context->'origins' AS origins_context,retired_at<=clock_timestamp() AS valid_time FROM "+archive+' ORDER BY source_ordinal LIMIT 65')).rows;}
async function checkedState(db,d,definitionHash,lock){
 await manifest(db,lock,d);if(helpLegacyDigest(await relationShape(db,'api_permissions'))!==d.sourceShapeSha256)throw Error('Permission schema differs');await safeRelation(db,pin.schema,pin.tablePrefix+'api_permissions');
 if(!await archiveShape(db))throw Error('Registered archive missing');
 const e=await endpoint(db,lock),o=await origins(db,d,lock),inventory=await references(db);
 if(helpLegacyDigest(inventory)!==d.referenceInventorySha256)throw Error('Reference inventory differs');
 const rows=await rawRows(db,lock),saved=await archiveRows(db);
 if(rows.length===64&&saved.length===0){
  if(rowDigest(rows)!==d.sourceRowsSha256||helpLegacyDigest({members:projection(rows),endpoint:{id:794,http_method:e.http_method,route_path:e.route_path,permission_key:e.permission_key},origins:o.projected})!==d.groupFingerprint)throw Error('Exact approved legacy rows differ');
  await checkReferences(db,inventory,rows,lock);return {rows,saved,e,o,retired:false,unrelated:await unrelated(db)};
 }
 if(rows.length!==0||saved.length!==64||rowDigest(saved)!==d.sourceRowsSha256||saved.some(r=>r.group_fingerprint!==d.groupFingerprint||r.valid_time!==true||r.context_text!==saved[0].context_text))throw Error('Retired archive is incomplete or differs');
 const context=JSON.parse(saved[0].context_text);
 if(context.operationId!==d.operationId||context.manifestSha256!==pin.manifestSha256||context.definitionSha256!==definitionHash||context.sourceRowsSha256!==d.sourceRowsSha256||context.groupFingerprint!==d.groupFingerprint||context.helpContractSha256!==contractHash||!isCommit(context.sourceCommit)||canonical(context.endpoint)!==canonical(JSON.parse(e.row_text))||canonical(context.origins)!==canonical(o.rows.map(r=>JSON.parse(r.row_text))))throw Error('Retired operation context differs');
 const other=await unrelated(db);if(canonical(other)!==canonical(context.unrelatedBefore))throw Error('Unrelated permissions changed since retirement');
 await checkReferences(db,inventory,saved,lock);
 return {rows,saved,e,o,retired:true,unrelated:other,sourceCommit:context.sourceCommit};
}
export async function retireHelpLegacyGrants(db,{apply=false,sourceCommit,fixtureDefinition}={}){
 const {d,definitionHash}=selectDefinition(fixtureDefinition);if(!fixtureDefinition)await outsideEvidence(d);if(apply&&!isCommit(sourceCommit))throw Error('Exact retirement source required');await begin(db,apply);
 try{
  if(apply){await db.query('LOCK TABLE '+source+','+archive+' IN SHARE ROW EXCLUSIVE MODE');await db.query('LOCK TABLE '+['api_endpoint_registry','api_endpoints','runtime_artifacts'].sort().map(table).join(',')+' IN SHARE MODE');}
  const before=await checkedState(db,d,definitionHash,apply);let changed=false;
  if(apply&&!before.retired){
   await db.query('CREATE TEMP TABLE pc10_help_legacy_others ON COMMIT DROP AS SELECT _primecare_import_row,to_jsonb(p) AS original_row FROM '+source+' p WHERE permission_key IS DISTINCT FROM $1',[fixedKey]);
   const context={operationId:d.operationId,manifestSha256:pin.manifestSha256,sourceCommit,definitionSha256:definitionHash,sourceRowsSha256:d.sourceRowsSha256,groupFingerprint:d.groupFingerprint,helpContractSha256:contractHash,unrelatedBefore:before.unrelated};
   await db.query('INSERT INTO '+archive+'(source_ordinal,group_fingerprint,original_row,operation_context) SELECT p._primecare_import_row,$1,to_jsonb(p),$2::jsonb||jsonb_build_object(\'endpoint\',$3::jsonb,\'origins\',$4::jsonb) FROM '+source+' p WHERE p.permission_key=$5',[d.groupFingerprint,JSON.stringify(context),before.e.row_text,'['+before.o.rows.map(r=>r.row_text).join(',')+']',fixedKey]);
   const equality=(await db.query('SELECT count(*)::text AS n FROM '+source+' p JOIN '+archive+' a ON a.source_ordinal=p._primecare_import_row AND a.original_row=to_jsonb(p) AND a.group_fingerprint=$1 WHERE p.permission_key=$2',[d.groupFingerprint,fixedKey])).rows;
   if(equality.length!==1||equality[0].n!=='64'||rowDigest(await archiveRows(db))!==d.sourceRowsSha256)throw Error('Archive equality failed before retirement');
   const deleted=(await db.query('DELETE FROM '+source+' p USING '+archive+' a WHERE p._primecare_import_row=a.source_ordinal AND p.api_id=794 AND p.permission_key=$1 AND a.group_fingerprint=$2 AND a.original_row=to_jsonb(p) RETURNING p._primecare_import_row::text AS source_ordinal',[fixedKey,d.groupFingerprint])).rows;
   if(deleted.length!==64||canonical(deleted.map(r=>r.source_ordinal).sort())!==canonical(before.rows.map(r=>r.source_ordinal).sort()))throw Error('Retirement deletion differs');
   const other=(await db.query('SELECT count(*)::text AS n FROM ((SELECT _primecare_import_row,to_jsonb(p) AS original_row FROM '+source+' p WHERE permission_key IS DISTINCT FROM $1 EXCEPT ALL SELECT * FROM pg_temp.pc10_help_legacy_others) UNION ALL (SELECT * FROM pg_temp.pc10_help_legacy_others EXCEPT ALL SELECT _primecare_import_row,to_jsonb(p) AS original_row FROM '+source+' p WHERE permission_key IS DISTINCT FROM $1)) delta',[fixedKey])).rows;
   if(other.length!==1||other[0].n!=='0')throw Error('Unrelated permissions changed');
   if((await endpoint(db,true)).row_text!==before.e.row_text)throw Error('Help endpoint changed');
   if(!(await checkedState(db,d,definitionHash,true)).retired)throw Error('Retirement readback missing');changed=true;
  }
  await db.query(apply?'COMMIT':'ROLLBACK');return {applied:changed,alreadyRetired:before.retired,activeLegacyRows:changed||before.retired?0:64,archivedRows:changed||before.retired?64:0,sourceRowsSha256:d.sourceRowsSha256,unrelatedBefore:before.unrelated,newRoleGrants:0,runtimeActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
export async function readHelpLegacyRetirement(db,{fixtureDefinition}={}){
 const {d,definitionHash}=selectDefinition(fixtureDefinition);if(!fixtureDefinition)await outsideEvidence(d);await begin(db,false);
 try{const state=await checkedState(db,d,definitionHash,false);if(!state.retired)throw Error('Retirement has not completed');await db.query('ROLLBACK');return {archivedRows:64,activeLegacyRows:0,sourceRowsSha256:d.sourceRowsSha256,sourceCommit:state.sourceCommit,unrelatedBefore:state.unrelated,independentReadback:true,newRoleGrants:0,runtimeActivated:false};}catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 const mode=process.argv[2];if(process.argv.length!==3||!['--plan-archive','--register-archive','--plan','--apply','--readback'].includes(mode)||process.env.HELP_LEGACY_RETIREMENT_FIXTURE!==undefined)throw Error('Explicit production mode required');
 const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned production connection required');
 const apply=['--register-archive','--apply'].includes(mode);if(apply){
  const optIn=mode==='--register-archive'?helpLegacyRetirement.archiveOptInVariable:helpLegacyRetirement.retirementOptInVariable;
  if(process.env[optIn]!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main'||!isCommit(process.env.GITHUB_SHA)||!process.env.GH_TOKEN)throw Error('Exact approved scope required');
  const head=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});if(!head.ok||(await head.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale retirement source');
 }
 const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000,query_timeout:25000});
 const db=connect();let result;try{await db.connect();result=mode.includes('archive')?await registerHelpLegacyArchive(db,{apply}):mode==='--readback'?await readHelpLegacyRetirement(db):await retireHelpLegacyGrants(db,{apply,sourceCommit:process.env.GITHUB_SHA});}finally{await db.end();}
 if(apply){const reader=connect();try{await reader.connect();const readback=mode==='--register-archive'?await registerHelpLegacyArchive(reader):await readHelpLegacyRetirement(reader);if(mode==='--register-archive'&&!readback.archivePresent)throw Error('Independent archive readback missing');result={...result,independentReadback:true,readback};}finally{await reader.end();}}
 await mkdir(new URL('test-results/pc10-help-legacy-retirement/',root),{recursive:true});await writeFile(new URL('test-results/pc10-help-legacy-retirement/'+mode.slice(2)+'.json',root),JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result},null,2)+'\n');console.log('PC10_HELP_LEGACY_RETIREMENT '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help legacy retirement failed closed. '+JSON.stringify(retirementFailureDiagnostic(error)));process.exitCode=1;});
