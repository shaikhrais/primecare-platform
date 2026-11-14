/** Bounded Help schema/access readback. Never reads business rows or changes authority. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const quote=s=>'"'+s.replaceAll('"','""')+'"';
const table=name=>quote(pin.schema)+'.'+quote(pin.tablePrefix+name);
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
  return {format:1,sourceCommit:process.env.GITHUB_SHA??null,manifestSha256:pin.manifestSha256,screens,endpoints,roles,apiPermissions,screenPermissions,links,controls,elements,registry,businessColumns,constraints,indexes,governanceColumns,related,bindingColumns,bindingConstraints,bindingIndexes,runtimeRelations,runtimePolicyColumns,policyDefinitionReadback,legacyIdentityReview,runtimePolicyValuesRead:ratePolicies.length+auditDefinitions.length,writes:0,businessRowsRead:0,grantsChanged:0,hostActivated:false,authorityInferred:false};
 }catch(error){const failedPhase=phase;await db.query('ROLLBACK');error.helpPhase=failedPhase;throw error;}
}
async function main(){
 const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error('Missing connection');
 const u=new URL(raw);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 try{await db.connect();const result=await discoverHelp(db);await mkdir('test-results/pc10-help',{recursive:true});await writeFile('test-results/pc10-help/discovery.json',JSON.stringify(result,null,2)+'\n');console.log('PC10_HELP_DISCOVERY '+JSON.stringify(result));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help schema/access discovery failed closed; no mutations attempted. '+JSON.stringify({phase:error.helpPhase??'connection',sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null,bounded:error.message==='Metadata bound exceeded'}));process.exitCode=1;});
