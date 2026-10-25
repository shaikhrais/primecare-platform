import pg from 'pg';
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import {snapshot as nativeSnapshot,privateAcl as nativePrivateAcl} from './migrate-voice-identity-schema.mjs';
const definitionPath='tools/governance-production/messaging-storage-registration.json';
const sourceNames=['20261022_business_communications.sql','20261023_business_sms.sql','20261024_communication_sms_inbox.sql','20261024_communication_ai_turns.sql','20261024_communication_sms_links.sql'];
const output='test-results/messaging-storage-schema';
export async function sources(){
 const definition=JSON.parse(await readFile(definitionPath,'utf8')),parts=[];
 if(definition.version!==1||definition.baseline!=='communication-messaging-storage-v1'||definition.migrationPath!=='packages/database/migrations/20261025_communication_messaging_storage.sql'||Object.keys(definition.tables??{}).length!==13||JSON.stringify(Object.keys(definition.sourceHashes??{}))!==JSON.stringify(sourceNames))throw Error('Exact messaging source scope required');
 for(const name of sourceNames){const sql=await readFile('packages/database/migrations/'+name,'utf8');if(createHash('sha256').update(sql).digest('hex')!==definition.sourceHashes[name])throw Error('Messaging source hash changed');parts.push('-- Reviewed source: '+name+'\n'+sql.replaceAll('CREATE TABLE public.','CREATE TABLE IF NOT EXISTS public.').replaceAll('CREATE UNIQUE INDEX communication_','CREATE UNIQUE INDEX IF NOT EXISTS communication_'));}
 const sql=await readFile(definition.migrationPath,'utf8');
 if(sql!=='-- Generated additive messaging storage bundle. Do not edit; regenerate from reviewed sources.\n\n'+parts.join('\n')||createHash('sha256').update(sql).digest('hex')!==definition.migrationSha256)throw Error('Registered messaging bundle differs');
 return {definition,sql,names:Object.keys(definition.tables)};
}
export async function snapshot(db,names){
 const shapes=await nativeSnapshot(db,names);
 for(const name of names)if(shapes[name]){
  shapes[name].attributes=(await db.query(`SELECT a.attname AS name,a.attidentity AS identity_kind,a.attgenerated AS generated_kind FROM pg_attribute a WHERE a.attrelid=to_regclass($1) AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum`,['public.'+name])).rows;
  shapes[name].relation=(await db.query('SELECT relkind AS kind,relrowsecurity AS row_security,relforcerowsecurity AS force_row_security FROM pg_class WHERE oid=to_regclass($1)',['public.'+name])).rows[0];
 }
 return shapes;
}
export async function privateAcl(db,names){
 await nativePrivateAcl(db,names);
 for(const name of names){
  const rows=(await db.query(`SELECT c.oid FROM pg_class t JOIN pg_attribute a ON a.attrelid=t.oid AND a.attidentity<>'' JOIN pg_class c ON c.oid=pg_get_serial_sequence($1,a.attname)::regclass CROSS JOIN LATERAL aclexplode(COALESCE(c.relacl,acldefault('S',c.relowner))) acl WHERE t.oid=to_regclass($1) AND acl.grantee<>c.relowner LIMIT 1`,['public.'+name])).rows;
  if(rows.length)throw Error('Unexpected sequence access preserved');
 }
}
export async function validateMetadataShape(db,definition){
 for(const [name,expected]of Object.entries(definition.tables)){
  const relation='public.'+name;
  const columns=(await db.query(`SELECT a.attname AS column_name,format_type(a.atttypid,a.atttypmod) AS data_type,NOT a.attnotnull AS nullable,pg_get_expr(d.adbin,d.adrelid) AS default_value,
    EXISTS(SELECT 1 FROM pg_index i WHERE i.indrelid=a.attrelid AND i.indisprimary AND a.attnum=ANY(i.indkey)) AS primary_key
   FROM pg_attribute a LEFT JOIN pg_attrdef d ON d.adrelid=a.attrelid AND d.adnum=a.attnum WHERE a.attrelid=to_regclass($1) AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum`,[relation])).rows;
  const foreign=(await db.query(`SELECT src_attr.attname AS column_name,target.relname AS foreign_table_name,dst_attr.attname AS foreign_column_name FROM pg_constraint c JOIN LATERAL unnest(c.conkey,c.confkey) AS keys(local_id,remote_id) ON true JOIN pg_attribute src_attr ON src_attr.attrelid=c.conrelid AND src_attr.attnum=keys.local_id JOIN pg_class target ON target.oid=c.confrelid JOIN pg_attribute dst_attr ON dst_attr.attrelid=c.confrelid AND dst_attr.attnum=keys.remote_id WHERE c.conrelid=to_regclass($1) AND c.contype='f'`,[relation])).rows;
  const actual=columns.map(c=>{const refs=foreign.filter(f=>f.column_name===c.column_name);if(refs.length>1)throw Error('Ambiguous storage foreign key');return {column_name:c.column_name,data_type:c.data_type,is_nullable:Number(c.nullable),is_primary:Number(c.primary_key),is_foreign:Number(refs.length===1),default_value:c.default_value,foreign_table_name:refs[0]?.foreign_table_name??null,foreign_column_name:refs[0]?.foreign_column_name??null};});
  assert.deepEqual(actual,expected,'Native column design differs from registered metadata: '+name);
 }
}
export async function createPrivateTables(db,input){await db.query(input.sql);}
export async function assertExisting(shapes,reference){
 for(const [name,shape]of Object.entries(shapes))if(shape!==null)assert.deepEqual(shape,reference.shapes[name],'Existing schema differs; preserve and reconcile');
}
function parse(value){return typeof value==='string'?JSON.parse(value):value;}
async function registered(db,pin,input){
 const schema=pin.schema;
 const rows=(await db.query(`SELECT app_id,baseline_sql,schema_metadata,sha256 FROM "${schema}".govt_database_rebuild_baselines WHERE name=$1`,[input.definition.baseline])).rows;
 if(rows.length!==1||rows[0].sha256!==input.definition.migrationSha256||rows[0].baseline_sql!==input.sql)throw Error('Committed storage registration required');
 assert.deepEqual(parse(rows[0].schema_metadata),input.definition,'Committed storage metadata differs');
 const anchor=(await db.query(`SELECT app_id FROM "${schema}".govt_api_endpoints WHERE id=710 AND route_path='/v1/messages' AND service_name='governance' AND permission_key='role_screen_permissions' AND auth_required=1`)).rows;
 if(anchor.length!==1||String(anchor[0].app_id)!==String(rows[0].app_id))throw Error('Registered storage application required');
}
async function main(){
 const mode=process.argv[2],fixture=mode==='--reference';
 if(process.argv.length!==3||!['--reference','--dry-run','--apply','--verify'].includes(mode))throw Error('Explicit messaging schema mode required');
 const report={mode,businessDataWrites:false,roleGrants:0,providerWrites:false,activation:false,committedSchemaChanges:false};let pool;
 try{
  const input=await sources(),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));report.stage='target';
  const scope=pin.messagingStorageSchemaMigration;
  if(scope?.runtimeHost!=='pooled.db.prisma.io'||scope?.directHost!=='db.prisma.io'||scope?.database!=='postgres'||scope?.schema!=='public'||scope?.migrationSha256!==input.definition.migrationSha256||JSON.stringify(scope?.tables)!==JSON.stringify(input.names)||pin.sqliteFallback!==false)throw Error('Pinned messaging migration scope required');
  let options;
  if(fixture){
   const u=new URL(process.env.WORKFLOW_TEST_DATABASE_URL??'');if(!['localhost','127.0.0.1'].includes(u.hostname)||u.username!=='twilio_fixture'||u.pathname!=='/twilio_sms_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Named disposable PostgreSQL required');options={connectionString:u.href};
  }else{
   const u=new URL(process.env.PRODUCTION_DATABASE_URL??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres'||! /^[a-z0-9_]+$/.test(pin.schema))throw Error('Pinned production target required');
   if(mode!=='--verify'&&process.env.MESSAGING_STORAGE_SCHEMA_APPLY!=='1')throw Error('Messaging schema opt-in required');
   options={host:mode==='--verify'?u.hostname:'db.prisma.io',port:Number(u.port||5432),database:'postgres',user:decodeURIComponent(u.username),password:decodeURIComponent(u.password),ssl:{rejectUnauthorized:true}};
  }
  const reference=fixture?null:JSON.parse(await readFile(output+'/reference.json','utf8'));
  if(reference&&(reference.version!==1||reference.migrationSha256!==input.definition.migrationSha256||Object.keys(reference.shapes??{}).sort().join(',')!==[...input.names].sort().join(',')||input.names.some(n=>!reference.shapes[n])))throw Error('Tested messaging reference required');
  pool=new pg.Pool({...options,max:1,connectionTimeoutMillis:10000});const db=await pool.connect();let completed=false;
  try{
   await db.query(mode==='--verify'?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');await db.query("SET LOCAL statement_timeout='60s'");await db.query("SET LOCAL lock_timeout='10s'");await db.query('SET LOCAL search_path=pg_catalog,public');
   report.stage='prerequisites';
   if(fixture){
    const source=await readFile('packages/database/migrations/20261023_communication_voice_otp.sql','utf8');const end=source.indexOf('CREATE TABLE communication_voice_otp (');if(end<0)throw Error('Contact fixture source missing');await db.query(source.slice(0,end).replace('CREATE TABLE communication_voice_verified_contacts','CREATE TABLE public.communication_voice_verified_contacts'));
   }else{
    const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`)).rows;
    if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');
    await registered(db,pin,input);
    for(const name of ['users','tenants','auth_sessions'])if(!(await db.query('SELECT to_regclass($1) IS NOT NULL AS present',['public.'+name])).rows[0]?.present)throw Error('Native identity prerequisite missing');
   }
   const prerequisite=await snapshot(db,['communication_voice_verified_contacts']);
   if(!prerequisite.communication_voice_verified_contacts)throw Error('Verified contact schema missing');
   if(reference)assert.deepEqual(prerequisite,reference.prerequisites,'Verified contact schema differs');
   await privateAcl(db,['communication_voice_verified_contacts']);
   if(mode!=='--verify')await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['primecare-messaging-storage-v1']);
   report.stage='existing-schema';const before=await snapshot(db,input.names),existing=input.names.filter(n=>before[n]!==null);
   if(fixture&&existing.length)throw Error('Fresh isolated schema required');
   if(reference)await assertExisting(before,reference);
   if(existing.length)await privateAcl(db,existing);
   const missing=input.names.filter(n=>before[n]===null);report.tablesExisting=existing.length;report.tablesMissing=missing;
   if(missing.length){
    if(mode==='--verify')throw Error('Messaging schema not deployed');
    if(!(await db.query("SELECT has_schema_privilege(current_user,'public','CREATE') AS allowed")).rows[0]?.allowed)throw Error('Migration role lacks CREATE');
    report.stage='create-empty-storage';await createPrivateTables(db,input);
   }
   report.stage='schema-verification';const actual=await snapshot(db,input.names);
   if(reference)assert.deepEqual(actual,reference.shapes,'Existing schema differs; preserve and reconcile');
   await validateMetadataShape(db,input.definition);await privateAcl(db,input.names);
   report.tablesVerified=input.names.length;report.columnsVerified=Object.values(input.definition.tables).reduce((n,c)=>n+c.length,0);report.ownerOnlyAccessVerified=true;
   if(fixture){await mkdir(output,{recursive:true});await writeFile(output+'/reference.json',JSON.stringify({version:1,migrationSha256:input.definition.migrationSha256,shapes:actual,prerequisites:prerequisite},null,2)+'\n');}
   if(mode==='--dry-run'){await db.query('ROLLBACK');report.rolledBack=true;}else{await db.query('COMMIT');report.committedSchemaChanges=mode==='--apply'&&missing.length>0;}
   completed=true;report.status=fixture?'reference_created':mode==='--verify'?'schema_independently_verified':mode==='--dry-run'?'dry_run_rolled_back':'schema_applied_or_verified';
  }finally{if(!completed)await db.query('ROLLBACK');db.release();}
 }catch(error){report.status='schema_blocked_preserving_existing_data';if(typeof error?.code==='string'&&/^[A-Z0-9]{5}$/.test(error.code))report.databaseErrorCode=error.code;const allowed=['Committed storage registration required','Committed storage metadata differs','Manifest mismatch','Native identity prerequisite missing','Verified contact schema missing','Verified contact schema differs','Messaging schema not deployed','Unexpected table access preserved','Unexpected sequence access preserved','Tested messaging reference required'];if(allowed.includes(error?.message))report.reason=error.message;if(error?.code==='ERR_ASSERTION')report.reason='Existing or generated schema differs from tested reference';process.exitCode=1;
 }finally{await pool?.end();}
 await mkdir(output,{recursive:true});await writeFile(output+'/'+mode.slice(2)+'.json',JSON.stringify(report,null,2)+'\n');console.log('MESSAGING_STORAGE_SCHEMA '+JSON.stringify(report));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)await main();
