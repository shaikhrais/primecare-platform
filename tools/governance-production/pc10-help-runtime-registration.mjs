/** Finite read-only preparation for the approved Help reader. No apply mode. */
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const definitionBytes=await readFile(new URL('./pc10-help-runtime-registration.definition.json',import.meta.url));
export const definition=JSON.parse(definitionBytes);
const names=Object.freeze(['runtime_artifacts','api_endpoints','api_permissions','role_screen_permissions','role_screen_map','screen_components','screen_api_links','roles','screens']);
export const projections=Object.freeze({
 runtime_artifacts:['_primecare_import_row','id','artifact_type','artifact_code','artifact_name','physical_path','status','health_status','deployment_status','version','checksum'],
 api_endpoints:['id','runtime_artifact_id','http_method','route_path','auth_required','permission_key','service_name','rate_limit_key','implementation_status'],
 api_permissions:['_primecare_import_row','id','api_id','role_id','runtime_artifact_id','permission_key','can_access'],
 role_screen_permissions:['_primecare_import_row','id','role_id','screen_id','can_view','can_create','can_edit','can_delete','can_export'],
 role_screen_map:['_primecare_import_row','id','role_id','screen_id','can_view','can_edit'],
 screen_components:['_primecare_import_row','id','screen_id','component_code','component_name','component_type','data_cy','file_path','implementation_status'],
 screen_api_links:['_primecare_import_row','id','screen_id','api_id','purpose'],
 roles:['id','role_code','active'],screens:['id','screen_code','route_path','active'],
});
const integerFields=new Set(['_primecare_import_row','id','api_id','role_id','screen_id','auth_required','can_access','can_view','can_create','can_edit','can_delete','can_export','active']);
export function projectionType(name,field){
 if(name==='runtime_artifacts'&&field!=='_primecare_import_row'||name==='api_endpoints'&&field==='runtime_artifact_id')return 'jsonb';
 if(integerFields.has(field)||name==='api_permissions'&&field==='runtime_artifact_id')return 'bigint';
 return 'text';
}
const q=value=>'"'+value.replaceAll('"','""')+'"';
const table=name=>q(pin.schema)+'.'+q(pin.tablePrefix+name);
function registered(){
 if(definition.format!==1||definition.operation!=='pc10.help.runtime-registration-discovery.v1'||definition.mode!=='read-only'||definition.apiId!==794||definition.roleId!==51||definition.screenId!==685||definition.permissionKey!=='psw_published_help_read'||JSON.stringify(definition.relations)!==JSON.stringify(names)||['businessRowsRead','writes','identityAllocation','runtimeActivation'].some(k=>definition[k]!==false))throw Error('Exact read-only Help scope required');
}
/** Metadata only: never reads FAQ, user, tenant, audit or rate business rows. */
export async function discoverHelpRuntimeRegistration(db){
 registered();const relations=names.map(name=>pin.tablePrefix+name);
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await db.query("SET LOCAL statement_timeout='20s'");await db.query("SET LOCAL lock_timeout='5s'");
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest')+' LIMIT 2')).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Pinned authority differs');
  const read=async(sql,values)=> (await db.query(sql,values)).rows;
  const columns=await read('SELECT table_name,column_name,data_type,udt_name,is_nullable,column_default,is_identity,identity_generation,is_generated,generation_expression FROM information_schema.columns WHERE table_schema=$1 AND table_name=ANY($2::text[]) ORDER BY table_name,ordinal_position',[pin.schema,relations]);
  const present=await read('SELECT c.relname AS table_name,c.relkind,c.relrowsecurity,c.relforcerowsecurity,c.relacl::text AS privileges,c.relowner::regrole::text AS owner FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relname=ANY($2::text[]) ORDER BY c.relname',[pin.schema,relations]);
  if(present.length!==relations.length||present.some(r=>!relations.includes(r.table_name)||r.relkind!=='r')||new Set(present.map(r=>r.table_name)).size!==relations.length)throw Error('Exact ordinary metadata relations required');
  const constraints=await read('SELECT r.relname AS table_name,c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=ANY($2::text[]) ORDER BY r.relname,c.conname',[pin.schema,relations]);
  const incomingForeignKeys=await read('SELECT n.nspname AS table_schema,r.relname AS table_name,c.conname,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace JOIN pg_class target ON target.oid=c.confrelid JOIN pg_namespace target_schema ON target_schema.oid=target.relnamespace WHERE c.contype=\'f\' AND target_schema.nspname=$1 AND target.relname=ANY($2::text[]) ORDER BY n.nspname,r.relname,c.conname',[pin.schema,relations]);
  const indexes=await read('SELECT tablename,indexname,indexdef FROM pg_indexes WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,indexname',[pin.schema,relations]);
  const triggers=await read('SELECT c.relname AS table_name,t.tgname,t.tgenabled,t.tgisinternal,pg_get_triggerdef(t.oid) AS definition FROM pg_trigger t JOIN pg_class c ON c.oid=t.tgrelid JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relname=ANY($2::text[]) ORDER BY c.relname,t.tgname',[pin.schema,relations]);
  const policies=await read('SELECT tablename,policyname,permissive,roles,cmd,qual,with_check FROM pg_policies WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,policyname',[pin.schema,relations]);
  const rules=await read('SELECT tablename,rulename,definition FROM pg_rules WHERE schemaname=$1 AND tablename=ANY($2::text[]) ORDER BY tablename,rulename',[pin.schema,relations]);
  const absentFields=[],unsupportedFields=[];
  for(const [name,fields]of Object.entries(projections))for(const field of new Set([...fields,'_primecare_import_row'])){
   const found=columns.filter(c=>c.table_name===pin.tablePrefix+name&&c.column_name===field);
   if(found.length!==1)absentFields.push({relation:name,field,reason:found.length?'duplicate column metadata':'absent column'});
   else{const expected=projectionType(name,field),udt=expected==='bigint'?'int8':expected;if(found[0].data_type!==expected||found[0].udt_name!==udt)unsupportedFields.push({relation:name,field,expectedType:expected,expectedUdt:udt,actualType:found[0].data_type,actualUdt:found[0].udt_name});}
  }
  const supported=name=>![...absentFields,...unsupportedFields].some(r=>r.relation===name);
  const project=async(name,sql)=>supported(name)?read(sql):[];
  const artifacts=await project('runtime_artifacts','SELECT _primecare_import_row,id,artifact_type,artifact_code,artifact_name,physical_path,status,health_status,deployment_status,version,checksum FROM '+table('runtime_artifacts')+' ORDER BY _primecare_import_row LIMIT 1001');
  if(artifacts.length>1000)throw Error('Artifact metadata exceeds bounded review scope');
  const endpoint=await project('api_endpoints','SELECT id,runtime_artifact_id,http_method,route_path,auth_required,permission_key,service_name,rate_limit_key,implementation_status FROM '+table('api_endpoints')+' WHERE id=794 ORDER BY _primecare_import_row LIMIT 2');
  if(supported('api_endpoints')&&endpoint.length!==1)throw Error('Unique existing Help endpoint required');
  const grants=await project('api_permissions','SELECT _primecare_import_row,id,api_id,role_id,runtime_artifact_id,permission_key,can_access FROM '+table('api_permissions')+' WHERE api_id=794 ORDER BY _primecare_import_row LIMIT 101');
  if(grants.length>100)throw Error('Help permission metadata exceeds bounded review scope');
  const permission=await project('role_screen_permissions','SELECT _primecare_import_row,id,role_id,screen_id,can_view,can_create,can_edit,can_delete,can_export FROM '+table('role_screen_permissions')+' WHERE (role_id=51 AND screen_id=685) OR id=6157 ORDER BY _primecare_import_row LIMIT 101');
  const map=await project('role_screen_map','SELECT _primecare_import_row,id,role_id,screen_id,can_view,can_edit FROM '+table('role_screen_map')+' WHERE (role_id=51 AND screen_id=685) OR id=603 ORDER BY _primecare_import_row LIMIT 101');
  if(permission.length>100||map.length>100)throw Error('Help screen access metadata exceeds bounded review scope');
  const controls=await project('screen_components','SELECT _primecare_import_row,id,screen_id,component_code,component_name,component_type,data_cy,file_path,implementation_status FROM '+table('screen_components')+' WHERE screen_id=685 OR id=779 ORDER BY _primecare_import_row LIMIT 101');
  if(controls.length>100)throw Error('Help control metadata exceeds bounded review scope');
  const links=await project('screen_api_links','SELECT _primecare_import_row,id,screen_id,api_id,purpose FROM '+table('screen_api_links')+' WHERE screen_id=685 AND api_id=794 ORDER BY _primecare_import_row LIMIT 101');
  if(links.length>100)throw Error('Help link metadata exceeds bounded review scope');
  const roles=await project('roles','SELECT id,role_code,active FROM '+table('roles')+' WHERE id IN (13,51) ORDER BY id LIMIT 3');
  const screens=await project('screens','SELECT id,screen_code,route_path,active FROM '+table('screens')+' WHERE id IN (685,2534) ORDER BY id LIMIT 3');
  for(const [name,rows,maximum]of [['permission',permission,100],['map',map,100],['controls',controls,100],['links',links,100],['roles',roles,2],['screens',screens,2]]){
   if(rows.length>maximum||new Set(rows.map(r=>String(r.id))).size!==rows.length)throw Error('Duplicate or overlarge '+name+' metadata');
  }
  await db.query('ROLLBACK');
  return {format:1,operation:definition.operation,definitionSha256:createHash('sha256').update(definitionBytes).digest('hex'),manifestSha256:pin.manifestSha256,applyEligible:false,absentFields,unsupportedFields,schema:{columns,relations:present,constraints,incomingForeignKeys,indexes,triggers,policies,rules},metadata:{artifacts,endpoint,grants,permission,map,controls,links,roles,screens},allocation:{allocated:false,logicalIdentityUniquenessMustBeReviewed:true,requiredBeforeFutureAllocation:'Reviewed schema plus transaction-wide relation locks and duplicate/overflow checks; observed maxima are not reserved IDs.'},remainingInputs:definition.remainingInputs,writes:0,businessRowsRead:0,grantsChanged:0,hostActivated:false,authorityInferred:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 if(process.argv.length!==3||process.argv[2]!=='--plan')throw Error('Only explicit read-only --plan is supported');
 const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');
 if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned production connection required');
 const {default:pg}=await import('pg');const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 try{await db.connect();const result=await discoverHelpRuntimeRegistration(db);console.log('PC10_HELP_RUNTIME_REGISTRATION_PLAN '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('Help runtime registration discovery failed closed.');process.exitCode=1;});
