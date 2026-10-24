import pg from 'pg';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
const {Pool}=pg;
export const names=['communication_voice_verified_contacts','communication_voice_otp','communication_voice_otp_limits','communication_voice_tasks','communication_voice_confirmations'];
const files=['20261023_communication_voice_otp.sql','20261023_communication_voice_tasks.sql','20261023_communication_voice_confirmations.sql'];
export async function sources(){const result=[];for(const name of files){const sql=await readFile('packages/database/migrations/'+name,'utf8');result.push({name,sql,sha256:createHash('sha256').update(sql).digest('hex')});}return result;}
export async function snapshot(db){
 const shapes={};
 for(const name of names){
  const relation='public.'+name;
  if(!(await db.query('SELECT to_regclass($1) IS NOT NULL AS present',[relation])).rows[0]?.present){shapes[name]=null;continue;}
  const columns=(await db.query(`SELECT a.attname AS name,format_type(a.atttypid,a.atttypmod) AS type,a.attnotnull AS not_null,pg_get_expr(d.adbin,d.adrelid) AS default_value FROM pg_attribute a LEFT JOIN pg_attrdef d ON d.adrelid=a.attrelid AND d.adnum=a.attnum WHERE a.attrelid=to_regclass($1) AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum`,[relation])).rows;
  const constraints=(await db.query(`SELECT conname AS name,contype AS type,pg_get_constraintdef(oid,false) AS definition,convalidated AS validated,condeferrable AS deferrable,condeferred AS deferred FROM pg_constraint WHERE conrelid=to_regclass($1) AND contype<>'n' ORDER BY conname COLLATE "C"`,[relation])).rows;
  const indexes=(await db.query(`SELECT pg_get_indexdef(indexrelid) AS definition,indisunique AS is_unique,indisvalid AS valid,indisready AS ready FROM pg_index WHERE indrelid=to_regclass($1) ORDER BY pg_get_indexdef(indexrelid) COLLATE "C"`,[relation])).rows;
  shapes[name]={columns,constraints,indexes};
 }
 return shapes;
}
export async function createPrivateTables(db,input){
 for(const source of input){
  // Exact reviewed sources, qualified to public; no model/CLI-selected SQL files.
  const sql=source.sql.replace(/CREATE TABLE (communication_voice_[a-z_]+)/g,'CREATE TABLE public.$1').replace(/REFERENCES communication_voice_tasks/g,'REFERENCES public.communication_voice_tasks');
  await db.query(sql);
 }
 for(const name of names)await db.query('REVOKE ALL ON TABLE public.'+name+' FROM PUBLIC');
}
export async function privateAcl(db){
 for(const name of names){const rows=(await db.query(`SELECT 1 FROM pg_class c CROSS JOIN LATERAL aclexplode(COALESCE(c.relacl,acldefault('r',c.relowner))) a WHERE c.oid=to_regclass($1) AND a.grantee<>c.relowner LIMIT 1`,['public.'+name])).rows;if(rows.length)throw Error('Unexpected table access preserved');}
}
async function main(){
 const mode=process.argv[2],fixture=mode==='--reference';
 if(!['--reference','--dry-run','--apply','--verify'].includes(mode))throw Error('Explicit migration mode required');
 const report={mode,schemaChanges:false,businessDataWrites:false,contactsEnrolled:0,roleGrants:0,providerWrites:false,activation:false};let pool;
 try{
  report.stage='read-sources';
  const input=await sources(),sourceHashes=Object.fromEntries(input.map(row=>[row.name,row.sha256]));
  report.sourceHashes=sourceHashes;report.stage='target-configuration';
  const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
  let options;
  if(fixture){
   const url=new URL(process.env.WORKFLOW_TEST_DATABASE_URL??'');
   if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/voice_identity_schema_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Isolated PostgreSQL required');
   options={connectionString:url.href};
  }else{
   const url=new URL(process.env.PRODUCTION_DATABASE_URL??'');
   if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres'||!/^[a-z0-9_]+$/.test(pin.schema)||pin.sqliteFallback!==false)throw Error('Pinned target required');
   if(mode!=='--verify'&&process.env.VOICE_IDENTITY_SCHEMA_APPLY!=='1')throw Error('Migration opt-in required');
   options={host:url.hostname,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),ssl:{rejectUnauthorized:true}};
  }
  report.stage='reference-validation';
  const reference=fixture?null:JSON.parse(await readFile('test-results/voice-identity-schema/reference.json','utf8'));
  if(reference&&(reference.version!==1||JSON.stringify(reference.sourceHashes)!==JSON.stringify(sourceHashes)||Object.keys(reference.shapes??{}).sort().join(',')!==[...names].sort().join(',')||names.some(name=>!reference.shapes[name])))throw Error('Tested source reference required');
  report.stage='connect';
  pool=new Pool({...options,max:1,connectionTimeoutMillis:10000});const db=await pool.connect();let committed=false;
  try{
   await db.query(mode==='--verify'?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');await db.query("SET LOCAL statement_timeout='30s'");await db.query("SET LOCAL lock_timeout='10s'");await db.query('SET LOCAL search_path=pg_catalog,public');
   report.stage='manifest-check';
   if(!fixture){const manifest=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."govt_source_manifest"`);if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');}
   report.stage='advisory-lock';
   if(mode!=='--verify')await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['primecare-voice-identity-schema-v1']);
   report.stage='schema-inventory';
   const before=await snapshot(db),present=names.filter(name=>before[name]!==null).length;
   if(present!==0&&present!==names.length)throw Error('Partial schema preserved');
   if(fixture&&present!==0)throw Error('Fresh isolated schema required');
   if(present===0){
    if(mode==='--verify')throw Error('Schema not deployed');
    report.stage='schema-create';
    await createPrivateTables(db,input);report.schemaChanges=true;
   }
   report.stage='schema-compare';
   const actual=await snapshot(db);
   if(reference&&JSON.stringify(actual)!==JSON.stringify(reference.shapes))throw Error('Existing schema differs; preserve and reconcile');
   report.stage='private-access-check';
   await privateAcl(db);
   if(fixture){await mkdir('test-results/voice-identity-schema',{recursive:true});await writeFile('test-results/voice-identity-schema/reference.json',JSON.stringify({version:1,sourceHashes,shapes:actual},null,2)+'\n');}
   report.tablesVerified=names.length;report.sourceHashes=sourceHashes;
   if(mode==='--dry-run'){await db.query('ROLLBACK');report.rolledBack=true;}
   else {await db.query('COMMIT');committed=true;}
   report.stage='complete';report.status=fixture?'reference_created':mode==='--apply'?'schema_applied_or_verified':mode==='--dry-run'?'dry_run_rolled_back':'schema_independently_verified';
  }finally{if(!committed)await db.query('ROLLBACK');db.release();}
 }catch(error){if(typeof error?.code==='string'&&/^[A-Z0-9]{5}$/.test(error.code))report.databaseErrorCode=error.code;const reasons=['Tested source reference required','Partial schema preserved','Existing schema differs; preserve and reconcile','Unexpected table access preserved','Manifest mismatch','Schema not deployed'];if(reasons.includes(error?.message))report.reason=error.message;report.status='schema_migration_failed_preserving_existing_data';process.exitCode=1;}
 finally{await pool?.end();}
 await mkdir('test-results/voice-identity-schema',{recursive:true});await writeFile('test-results/voice-identity-schema/'+(fixture?'reference-report':mode.slice(2))+'.json',JSON.stringify(report,null,2)+'\n');console.log('VOICE_IDENTITY_SCHEMA '+JSON.stringify(report));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)await main();
