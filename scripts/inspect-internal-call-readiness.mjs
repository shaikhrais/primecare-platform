// Read-only production inventory. Never print credentials, account identifiers,
// native user data, provider keys, session records or Worker secret values.
import pg from 'pg';import {mkdir,writeFile} from 'node:fs/promises';
import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
const report={source:process.env.GITHUB_SHA,readOnly:true,callingReady:false,tables:{},nativeWorkerDeployed:false,turnApiReadable:false,ownedTurnKeys:0,microphonePolicy:null};
try{
 const pool=new pg.Pool(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL));
 try{await pool.query('BEGIN READ ONLY');const rows=(await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name=ANY($1)",[['business_work_aggregates','business_work_commands','business_work_events','communication_voice_extensions']])).rows;for(const name of ['business_work_aggregates','business_work_commands','business_work_events','communication_voice_extensions'])report.tables[name]=rows.some(r=>r.table_name===name);if(report.tables.communication_voice_extensions){const r=(await pool.query('SELECT count(*)::int AS total,count(*) FILTER (WHERE active AND published)::int AS published FROM communication_voice_extensions')).rows[0];report.extensionCount=r.total;report.publishedExtensionCount=r.published;}await pool.query('ROLLBACK');}finally{await pool.end();}
 const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('missing_cloudflare_configuration');
 const cf=async path=>{const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{headers:{authorization:'Bearer '+token},redirect:'error',signal:AbortSignal.timeout(15000)});const d=await response.json();return {status:response.status,success:d.success===true,result:d.result,errorCodes:Array.isArray(d.errors)?d.errors.map(e=>e.code):[]};};
 const settings=await cf('/workers/scripts/primecare-internal-calls-api/settings');report.nativeWorkerDeployed=settings.success;report.nativeWorkerStatus=settings.status;
 const turn=await cf('/calls/turn_keys');report.turnApiReadable=turn.success;report.turnApiStatus=turn.status;report.turnApiErrorCodes=turn.errorCodes;report.ownedTurnKeys=turn.success&&Array.isArray(turn.result)?turn.result.filter(k=>k.name==='primecare-internal-calls-v1').length:0;
 const site=await fetch('https://primecare-clinic.pages.dev/login',{redirect:'error',signal:AbortSignal.timeout(15000)});report.microphonePolicy=site.headers.get('permissions-policy');await site.body?.cancel();
 report.inspectionCompleted=true;
}catch{report.inspectionCompleted=false;process.exitCode=1;}
await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/production-readiness.json',JSON.stringify(report,null,2)+'\n');console.log('INTERNAL_CALL_READINESS '+JSON.stringify(report));
