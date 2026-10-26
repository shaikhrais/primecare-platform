// Read-only incident diagnostic. Never prints tokens, tickets, identities or payloads.
import pg from 'pg';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
if(!/^[a-z0-9_]+$/.test(pin.schema)||!/^govt_[a-z_]+$/.test(pin.manifestTable))throw Error('Invalid pin');
const report={source:process.env.GITHUB_SHA,readOnly:true,callsPlaced:0,targetSuffix:'3200'},db=new pg.Client(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL));
try{
 await db.connect();await db.query('BEGIN READ ONLY');await db.query("SET LOCAL statement_timeout='15s'");
 const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`)).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');
 report.reservations=(await db.query("SELECT state->>'status' AS status,state->>'version' AS version,to_timestamp((state->>'expiresAt')::numeric/1000) AS expires_at, state ? 'callSid' AS provider_call_attached FROM business_work_aggregates WHERE state->>'kind'='external_call' AND state->>'phone'=$1 LIMIT 20",['+12898873200'])).rows;
 report.events=(await db.query("SELECT e.event_type,e.created_at,e.version FROM business_work_events e JOIN business_work_aggregates a ON a.tenant_id=e.tenant_id AND a.id=e.aggregate_id WHERE a.state->>'kind'='external_call' AND a.state->>'phone'=$1 AND e.created_at>now()-interval '24 hours' ORDER BY e.created_at DESC LIMIT 40",['+12898873200'])).rows;
 await db.query('ROLLBACK');
}catch(e){report.databaseError={code:/^[A-Z0-9]{5}$/.test(e.code??'')?e.code:undefined,category:'read_failed'};process.exitCode=1;}finally{await db.end().catch(()=>{});}
const sid=process.env.TWILIO_ACCOUNT_SID,auth=process.env.TWILIO_AUTH_TOKEN;
async function query(url){const r=await fetch(url,{headers:{authorization:'Basic '+Buffer.from(sid+':'+auth).toString('base64')},signal:AbortSignal.timeout(15000)});if(!r.ok){await r.body?.cancel();return {httpStatus:r.status};}return r.json();}
const calls=await query('https://api.twilio.com/2010-04-01/Accounts/'+sid+'/Calls.json?To=%2B12898873200&StartTime%3E=2026-10-26&PageSize=20');report.providerCalls=calls.calls?.map(c=>({status:c.status,direction:c.direction,start:c.start_time,end:c.end_time,duration:c.duration,hasParent:!!c.parent_call_sid}))??{httpStatus:calls.httpStatus};
const alerts=await query('https://monitor.twilio.com/v1/Alerts?PageSize=30&StartDate=2026-10-26');report.providerAlerts=alerts.alerts?.map(a=>({code:a.error_code,level:a.log_level,created:a.date_created,requestPath:(()=>{try{return new URL(a.request_url).pathname.replace(/\/AC[a-f0-9]{32}/ig,'/account');}catch{return undefined;}})()}))??{httpStatus:alerts.httpStatus};
await mkdir('test-results/external-call-incident',{recursive:true});await writeFile('test-results/external-call-incident/incident.json',JSON.stringify(report,null,2)+'\n');console.log('EXTERNAL_CALL_INCIDENT '+JSON.stringify(report));
