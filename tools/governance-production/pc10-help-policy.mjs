/** Register definitions only. No reader grant, runtime artifact or business action. */
import {readFile} from 'node:fs/promises';import {createHash} from 'node:crypto';import {pathToFileURL} from 'node:url';import pg from 'pg';
import {migrateHelpStorage,inspectHelpStorage} from './pc10-help-storage.mjs';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const raw=await readFile(new URL('./pc10-help-policy.definition.json',import.meta.url),'utf8');
const storageDefinition=JSON.parse(await readFile(new URL('./pc10-help-storage.definition.json',import.meta.url)));
const parsed=JSON.parse(raw);
export const helpPolicy=Object.freeze({...parsed,auditFields:Object.freeze([...parsed.auditFields])}),policyHash=createHash('sha256').update(raw).digest('hex');
const quote=s=>'"'+s.replaceAll('"','""')+'"',table=n=>quote(pin.schema)+'.'+quote(pin.tablePrefix+n);
const description=JSON.stringify({apiId:helpPolicy.apiId,key:helpPolicy.key,maxReads:helpPolicy.maxReads,windowSeconds:helpPolicy.windowSeconds,auditRetentionSeconds:helpPolicy.auditRetentionSeconds,auditFields:helpPolicy.auditFields,runtimeActivation:false});
const rateColumns=['_primecare_import_row','id','api_id','runtime_artifact_id','limit_key','max_requests','time_window','created_at'];
const auditColumns=['_primecare_import_row','id','event_code','event_name','severity','description'];
function registered(){const p=pin.helpOperationalPolicyWriter;if(p?.definitionSha256!==policyHash||p.apiId!==794||p.schemaChanges!==false||p.roleGrants!==false||p.contentWrites!==false||p.runtimeActivation!==false||JSON.stringify(p.tables)!==JSON.stringify(['api_rate_limits','audit_event_definitions'])||helpPolicy.apiId!==794||helpPolicy.key!=='psw_published_help_read'||helpPolicy.maxReads!==30||helpPolicy.windowSeconds!==60||helpPolicy.auditRetentionSeconds!==2592000||helpPolicy.runtimeActivation!==false||helpPolicy.grantsChanged!==false)throw Error('Unregistered Help policy');}
export async function registerHelpPolicy(db,{apply=false}={}){
 if(typeof apply!=='boolean')throw Error('Explicit boolean registration mode required');
 registered();if(!(await migrateHelpStorage(db)).alreadyApplied)throw Error('Verified Help storage required');
 await db.query(apply?'BEGIN ISOLATION LEVEL SERIALIZABLE':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await db.query("SET LOCAL statement_timeout='20s'");await db.query("SET LOCAL lock_timeout='5s'");
  if(apply){await db.query('LOCK TABLE '+table('api_rate_limits')+','+table('audit_event_definitions')+' IN SHARE ROW EXCLUSIVE MODE');await db.query('LOCK TABLE public.help_reader_rate,public.help_reader_audit IN ACCESS SHARE MODE');}
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256||JSON.stringify(await inspectHelpStorage(db))!==JSON.stringify(storageDefinition.shape))throw Error('Storage or authority changed');
  for(const [name,expected] of [['api_rate_limits',rateColumns],['audit_event_definitions',auditColumns]]){
   const columns=(await db.query('SELECT column_name,data_type,is_nullable FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[pin.schema,pin.tablePrefix+name])).rows;
   if(columns.length!==expected.length||columns.some((c,i)=>c.column_name!==expected[i]||c.data_type!==(i===0?'bigint':name==='api_rate_limits'?'jsonb':i===1?'bigint':'text')||c.is_nullable!==(i===0?'NO':'YES')))throw Error('Policy registration schema differs');
   const constraints=(await db.query('SELECT c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname=$1 AND r.relname=$2',[pin.schema,pin.tablePrefix+name])).rows;
   if(constraints.length!==1||constraints[0].contype!=='p'||constraints[0].definition!=='PRIMARY KEY (_primecare_import_row)')throw Error('Policy constraints differ');
  }
  const e=(await db.query('SELECT id,http_method,route_path,permission_key,rate_limit_key,service_name FROM '+table('api_endpoints')+' WHERE id=794'+(apply?' FOR SHARE':''))).rows;
  if(e.length!==1||e[0].http_method!=='POST'||e[0].route_path!=='/v1/psw/help-support'||e[0].permission_key!==helpPolicy.key||e[0].rate_limit_key!==helpPolicy.key||e[0].service_name!=='governance')throw Error('Accepted reader definition differs');
  const rateQuery='SELECT id,api_id,runtime_artifact_id,limit_key,max_requests,time_window FROM '+table('api_rate_limits')+" WHERE api_id #>> '{}'='794' OR api_id->>'v'='794' OR limit_key #>> '{}'=$1 OR limit_key->>'v'=$1";
  const auditQuery='SELECT id,event_code,event_name,severity,description FROM '+table('audit_event_definitions')+' WHERE event_code=$1';
  const beforeRate=(await db.query(rateQuery,[helpPolicy.key])).rows,beforeAudit=(await db.query(auditQuery,[helpPolicy.eventCode])).rows;
  const validRate=r=>r.length===1&&r[0].api_id===794&&r[0].runtime_artifact_id===null&&r[0].limit_key===helpPolicy.key&&r[0].max_requests===30&&r[0].time_window===60;
  const validAudit=r=>r.length===1&&r[0].event_code===helpPolicy.eventCode&&r[0].event_name===helpPolicy.eventName&&r[0].severity===helpPolicy.severity&&r[0].description===description;
  if(beforeRate.length&&!validRate(beforeRate)||beforeAudit.length&&!validAudit(beforeAudit))throw Error('Conflicting Help policy');
  if(apply){
   if(!beforeRate.length){
    const next=(await db.query('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 AS row_id,GREATEST(0,COALESCE(MAX(_primecare_import_row),-1),COALESCE(MAX(CASE WHEN COALESCE(id #>> \'{}\',\'\') ~ \'^[0-9]{1,18}$\' THEN (id #>> \'{}\')::bigint WHEN COALESCE(id->>\'v\',\'\') ~ \'^[0-9]{1,18}$\' THEN (id->>\'v\')::bigint ELSE NULL END),-1))+1 AS id FROM '+table('api_rate_limits'))).rows[0];
    if(!Number.isSafeInteger(Number(next.id))||!Number.isSafeInteger(Number(next.row_id)))throw Error('Policy identifier allocation differs');
    await db.query('INSERT INTO '+table('api_rate_limits')+' (_primecare_import_row,id,api_id,runtime_artifact_id,limit_key,max_requests,time_window,created_at) VALUES($1,$2::jsonb,$3::jsonb,NULL,$4::jsonb,$5::jsonb,$6::jsonb,to_jsonb(statement_timestamp()::text))',[next.row_id,JSON.stringify(Number(next.id)),'794',JSON.stringify(helpPolicy.key),'30','60']);
   }
   if(!beforeAudit.length){
    const next=(await db.query('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 AS row_id,GREATEST(0,COALESCE(MAX(id),-1),COALESCE(MAX(_primecare_import_row),-1))+1 AS id FROM '+table('audit_event_definitions'))).rows[0];
    if(!Number.isSafeInteger(Number(next.id))||!Number.isSafeInteger(Number(next.row_id)))throw Error('Audit identifier allocation differs');
    await db.query('INSERT INTO '+table('audit_event_definitions')+' (_primecare_import_row,id,event_code,event_name,severity,description) VALUES($1,$2,$3,$4,$5,$6)',[next.row_id,next.id,helpPolicy.eventCode,helpPolicy.eventName,helpPolicy.severity,description]);
   }
   if(!validRate((await db.query(rateQuery,[helpPolicy.key])).rows)||!validAudit((await db.query(auditQuery,[helpPolicy.eventCode])).rows))throw Error('Policy readback differs');
  }
  await db.query(apply?'COMMIT':'ROLLBACK');return{apiId:794,alreadyRegistered:validRate(beforeRate)&&validAudit(beforeAudit),applied:apply&&(beforeRate.length===0||beforeAudit.length===0),quotaDefinitionsAdded:apply&&!beforeRate.length?1:0,auditDefinitionsAdded:apply&&!beforeAudit.length?1:0,grantsChanged:0,operationalRowsWritten:0,runtimeActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){const mode=process.argv[2];if(!['--plan','--apply'].includes(mode))throw Error('Explicit mode required');const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');if(mode==='--apply'){if(process.env.REGISTER_PC10_HELP_POLICY!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Exact policy scope required');const r=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});if(!r.ok||(await r.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale registration source');}const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000}),db=connect();try{await db.connect();const result=await registerHelpPolicy(db,{apply:mode==='--apply'});if(mode==='--apply'){const reader=connect();try{await reader.connect();if(!(await registerHelpPolicy(reader)).alreadyRegistered)throw Error('Independent policy readback differs');result.independentReadback=true;}finally{await reader.end();}}console.log('PC10_HELP_POLICY '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));}finally{await db.end();}}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help policy registration failed closed. '+JSON.stringify({sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null}));process.exitCode=1;});
