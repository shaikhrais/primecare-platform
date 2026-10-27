import {build} from 'esbuild';import {mkdir} from 'node:fs/promises';import {pathToFileURL} from 'node:url';import pg from 'pg';
const out='test-results/call-audit/runtime.mjs';await mkdir('test-results/call-audit',{recursive:true});
await build({stdin:{resolveDir:process.cwd(),contents:"export {reconcileCalls} from './cloudflare/workers/src/business-tasks/call-audit-reconciliation.ts';export {PostgresCallAudit} from './cloudflare/workers/src/business-tasks/call-audit.ts';export {nativePostgresOptions} from './cloudflare/workers/src/business-tasks/native-postgres.ts';"},outfile:out,bundle:true,format:'esm',platform:'node',external:['pg']});
const {reconcileCalls,PostgresCallAudit,nativePostgresOptions}=await import(pathToFileURL(process.cwd()+'/'+out));
const env={DB_URL:process.env.PRODUCTION_DATABASE_URL,VAPI_PRIVATE_API_KEY:process.env.VAPI_PRIVATE_API_KEY,TWILIO_ACCOUNT_SID:process.env.TWILIO_ACCOUNT_SID,TWILIO_API_KEY_SID:process.env.TWILIO_API_KEY_SID,TWILIO_API_KEY_SECRET:process.env.TWILIO_API_KEY_SECRET};
let pool;try{
 const backfill=await reconcileCalls(env,86400000);pool=new pg.Pool(nativePostgresOptions(env.DB_URL));const ledger=new PostgresCallAudit(pool);
 const ids=(await pool.query("SELECT DISTINCT call_id FROM communication_call_audit ORDER BY call_id LIMIT 10000")).rows;
 let entries=0;for(const {call_id} of ids){const checked=await ledger.verify(call_id);if(!checked.valid)throw Error('integrity_check_failed');entries+=checked.count;}
 const phases=(await pool.query("SELECT payload->>'phase' AS phase,payload->>'outcome' AS outcome,count(*)::int AS count FROM communication_call_audit GROUP BY 1,2")).rows;
 const reasons=(await pool.query("SELECT payload->>'reason' AS reason,count(*)::int AS count FROM communication_call_audit WHERE payload ? 'reason' GROUP BY 1")).rows;
 console.log('CALL_AUDIT_ACCEPTANCE '+JSON.stringify({backfill,streamsVerified:ids.length,eventsVerified:entries,chainIntegrity:true,phases,reasons,realSmsSent:false,realCallMade:false,liveWebhookDeliveryTested:false}));
}catch(e){console.log('CALL_AUDIT_ACCEPTANCE_FAILED '+(/^[a-z_]+$/.test(e.message??'')?e.message:'readback_failed'));process.exitCode=1;}finally{await pool?.end();}
