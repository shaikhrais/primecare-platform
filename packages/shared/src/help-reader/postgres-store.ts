import pin from '../../../../tools/governance-production/production-pin.json';
import policy from '../../../../tools/governance-production/pc10-help-policy.definition.json';
import {HelpReadFailure,helpScope,helpInteger} from './protocol';
import type {HelpOperationalStore} from './operational-effects';
type Database={query:(sql:string,values?:any[])=>Promise<{rows:any[]}>};
const table=(n:string)=>`"${pin.schema}"."${pin.tablePrefix}${n}"`;
type Expected=Parameters<HelpOperationalStore['verifyPolicy']>[0];
const expected:Expected=Object.freeze({apiId:policy.apiId,key:policy.key,maxReads:policy.maxReads,windowSeconds:policy.windowSeconds,auditRetentionSeconds:policy.auditRetentionSeconds});
const auditDescription=JSON.stringify({...expected,auditFields:policy.auditFields,runtimeActivation:false});
const unavailable=()=>new HelpReadFailure('unavailable',503);
function capture(db:Database){if(!db||typeof db.query!=='function')throw unavailable();return db.query.bind(db);}
async function verified(query:Database['query'],value:Expected){
 if(!value||Object.keys(expected).some(k=>value[k as keyof Expected]!==expected[k as keyof Expected]))return false;
 const manifest=(await query('SELECT manifest_sha256 FROM '+table('source_manifest')+' FOR SHARE')).rows;
 if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)return false;
 const rate=(await query('SELECT api_id,runtime_artifact_id,limit_key,max_requests,time_window FROM '+table('api_rate_limits')+" WHERE api_id #>> '{}'=$1 OR api_id->>'v'=$1 OR limit_key #>> '{}'=$2 OR limit_key->>'v'=$2 FOR SHARE",[String(policy.apiId),policy.key])).rows;
 const audit=(await query('SELECT event_name,severity,description FROM '+table('audit_event_definitions')+' WHERE event_code=$1 FOR SHARE',[policy.eventCode])).rows;
 return rate.length===1&&rate[0].api_id===policy.apiId&&rate[0].runtime_artifact_id===null&&rate[0].limit_key===policy.key&&rate[0].max_requests===policy.maxReads&&rate[0].time_window===policy.windowSeconds&&audit.length===1&&audit[0].event_name===policy.eventName&&audit[0].severity===policy.severity&&audit[0].description===auditDescription;
}
// Promoted registered storage operations. The quota connection is dedicated to
// autocommit reservations; the reader owns its separate transaction and audit.
export const helpQuotaSql=`INSERT INTO public.help_reader_rate(tenant_id,user_id,attempts,reset_at)
 VALUES($1,$2,1,statement_timestamp()+interval '60 seconds')
 ON CONFLICT(tenant_id,user_id) DO UPDATE SET
 attempts=CASE WHEN help_reader_rate.reset_at<=statement_timestamp() THEN 1 ELSE LEAST(help_reader_rate.attempts+1,31) END,
 reset_at=CASE WHEN help_reader_rate.reset_at<=statement_timestamp() THEN statement_timestamp()+interval '60 seconds' ELSE help_reader_rate.reset_at END
 RETURNING attempts<=30 AS allowed,CASE WHEN attempts<=30 THEN 0 ELSE GREATEST(1,LEAST(60,CEIL(EXTRACT(EPOCH FROM reset_at-statement_timestamp()))::integer)) END AS retry_after_seconds`;
export const helpAuditSql=`INSERT INTO public.help_reader_audit(tenant_id,user_id,action,locale,returned) VALUES($1,$2,$3,$4,$5) RETURNING id,created_at,expires_at`;
export async function verifyHelpPostgresPolicy(db:Database){try{return await verified(capture(db),expected);}catch{throw unavailable();}}
export function createHelpPostgresStore(reader:Database,autocommitQuota:Database):HelpOperationalStore{
 if(reader===autocommitQuota)throw unavailable();const query=capture(reader),quota=capture(autocommitQuota);
 const safe=async<T>(run:()=>Promise<T>)=>{try{return await run();}catch{throw unavailable();}};
 return Object.freeze({
  verifyPolicy:(value:Expected)=>safe(()=>verified(query,value)),
  reserveRead:(actor,key,maxReads,windowSeconds)=>safe(async()=>{
   const scope=helpScope(actor);if(key!==policy.key||maxReads!==30||windowSeconds!==60)throw unavailable();
   const rows=(await quota(helpQuotaSql,[scope.tenantId,scope.userId])).rows,r=rows[0];
   if(rows.length!==1||typeof r.allowed!=='boolean'||!helpInteger(r.retry_after_seconds,r.allowed?0:1,r.allowed?0:60))throw unavailable();
   return Object.freeze({allowed:r.allowed,retryAfterSeconds:r.retry_after_seconds});
  }),
  appendAudit:(event,retentionSeconds)=>safe(async()=>{
   if(!event||!['list','read'].includes(event.action)||!['en','fr','es'].includes(event.locale)||!helpInteger(event.returned,0,100)||(event.action==='read'&&event.returned!==1)||retentionSeconds!==2592000)throw unavailable();
   const scope=helpScope({tenantId:event.tenantId,userId:event.userId,role:'psw',dataset:'live'});
   // Project scalar approved fields before any await; never forward extra data.
   const values=[scope.tenantId,scope.userId,event.action,event.locale,event.returned];
   const rows=(await query(helpAuditSql,values)).rows;
   if(rows.length!==1)throw unavailable();
   const created=new Date(rows[0].created_at).getTime(),expires=new Date(rows[0].expires_at).getTime();
   if(!Number.isFinite(created)||expires-created!==2592000000)throw unavailable();
  })
 });
}
/** Dedicated scheduler connection only; never call inside a reader transaction. */
export async function purgeExpiredHelpAudit(db:Database,limit=1000){
 if(!helpInteger(limit,1,1000))throw unavailable();const query=capture(db);let begun=false;
 try{
  await query('BEGIN');begun=true;await query("SET LOCAL statement_timeout='15s'");await query("SET LOCAL lock_timeout='5s'");
  if(!await verified(query,expected))throw unavailable();
  const rows=(await query(`WITH expired AS (SELECT id FROM public.help_reader_audit WHERE expires_at<=statement_timestamp() ORDER BY expires_at,id LIMIT $1 FOR UPDATE SKIP LOCKED)
 DELETE FROM public.help_reader_audit a USING expired e WHERE a.id=e.id RETURNING a.id`,[limit])).rows;
  if(rows.length>limit)throw unavailable();await query('COMMIT');begun=false;return Object.freeze({deleted:rows.length});
 }catch{if(begun)await query('ROLLBACK').catch(()=>{});throw unavailable();}
}
