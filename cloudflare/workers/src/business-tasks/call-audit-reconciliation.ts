import pg from 'pg';
import {nativePostgresOptions} from './native-postgres.ts';
import {PostgresCallAudit,uuid} from './call-audit.ts';
import {canonicalSnapshot,snapshotKey,providerJson,phoneId,orgId,assistantIds,type AuditEnv} from './call-audit-provider.ts';
/** Provider calls are copied into our PostgreSQL. Missing completions are flagged,
 * never replayed. Bounded pagination reports saturation instead of silent loss. */
export async function reconcileCalls(env:AuditEnv,lookbackMs?:number){
 const pool=new pg.Pool(nativePostgresOptions(env.DB_URL));pool.on('error',()=>{});const ledger=new PostgresCallAudit(pool);let scanned=0,matched=0,pages=0;
 try{
  const last=(await pool.query("SELECT payload->>'at' AS at FROM public.communication_call_audit WHERE call_id='system:reconciliation' ORDER BY sequence DESC LIMIT 1")).rows[0]?.at;
  const boundary=lookbackMs!==undefined?Date.now()-lookbackMs:last?Date.parse(last)-300000:Date.now()-86400000;
  if(!Number.isFinite(boundary))throw Error('invalid_reconciliation_watermark');
  const since=new Date(boundary).toISOString();let before=new Date().toISOString();
  while(pages++<20){
   const list=await providerJson('https://api.vapi.ai/call?'+new URLSearchParams({limit:'100',createdAtGt:since,createdAtLt:before}),'Bearer '+env.VAPI_PRIVATE_API_KEY);
   if(!Array.isArray(list)||list.length>100)throw Error('invalid_call_inventory');scanned+=list.length;
   for(const c of list.filter(c=>c.orgId===orgId&&c.phoneNumberId===phoneId&&assistantIds.includes(c.assistantId))){
    if(!uuid(c.id))throw Error('invalid_call_inventory');const snapshot=await canonicalSnapshot(c.id,env);await ledger.append(c.id,await snapshotKey(snapshot),snapshot);matched++;
   }
   if(list.length<100)break;
   const oldest=list.map(c=>c.createdAt).sort()[0];if(typeof oldest!=='string'||oldest>=before)throw Error('inventory_cursor_failed');before=oldest;
   if(pages===20)throw Error('reconciliation_saturated');
  }
  const unfinished=(await pool.query(`SELECT a.call_id,a.payload FROM public.communication_call_audit a WHERE a.payload->>'phase'='started' AND a.received_at<now()-interval '2 minutes' AND a.received_at>now()-interval '1 day' AND NOT EXISTS(SELECT 1 FROM public.communication_call_audit b WHERE b.call_id=a.call_id AND b.payload->>'traceId'=a.payload->>'traceId' AND b.payload->>'phase' IN ('finished','unknown')) LIMIT 100`)).rows;
  for(const row of unfinished)await ledger.append(row.call_id,'gap:'+row.payload.traceId,{kind:'audit_gap',source:'primecare_reconciliation',at:row.payload.at,traceId:row.payload.traceId,reason:'tool_completion_unobserved',outcome:'unknown'});
  const bucket=new Date(Math.floor(Date.now()/300000)*300000).toISOString();
  await ledger.append('system:reconciliation','heartbeat:'+bucket,{kind:'reconciliation',source:'primecare_scheduler',at:bucket,outcome:'completed'});
  return {scanned,matched,pages,unfinished:unfinished.length};
 }finally{await pool.end();}
}
