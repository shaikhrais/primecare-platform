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
 report.storageConstraints=(await db.query("SELECT pg_get_constraintdef(oid) AS definition FROM pg_constraint WHERE conrelid='public.business_work_aggregates'::regclass AND contype='c' ORDER BY conname")).rows;
 report.accountReservation=(await db.query("SELECT a.state->>'status' AS status,a.state->>'phone'=$1 AS matches_target,a.state ? 'callSid' AS provider_call_attached FROM business_work_aggregates a JOIN users u ON a.id='external-call:'||u.id::text AND a.tenant_id=u.tenant_id::text WHERE lower(u.email)=$2 AND a.state->>'kind'='external_call' LIMIT 2",['+12898873200','shkh.rais@gmail.com'])).rows;
 report.reservations=(await db.query("SELECT state->>'status' AS status,state->>'version' AS version,to_timestamp((state->>'expiresAt')::numeric/1000) AS expires_at, state ? 'callSid' AS provider_call_attached FROM business_work_aggregates WHERE state->>'kind'='external_call' AND state->>'phone'=$1 LIMIT 20",['+12898873200'])).rows;
 report.events=(await db.query("SELECT e.event_type,e.created_at,e.version FROM business_work_events e JOIN business_work_aggregates a ON a.tenant_id=e.tenant_id AND a.id=e.aggregate_id WHERE a.state->>'kind'='external_call' AND a.state->>'phone'=$1 AND e.created_at>now()-interval '24 hours' ORDER BY e.created_at DESC LIMIT 40",['+12898873200'])).rows;
 await db.query('ROLLBACK');
}catch(e){report.databaseError={code:/^[A-Z0-9]{5}$/.test(e.code??'')?e.code:undefined,category:'read_failed'};process.exitCode=1;}finally{await db.end().catch(()=>{});}
const sid=process.env.TWILIO_ACCOUNT_SID,auth=process.env.TWILIO_AUTH_TOKEN;
async function query(url){const r=await fetch(url,{headers:{authorization:'Basic '+Buffer.from(sid+':'+auth).toString('base64')},signal:AbortSignal.timeout(15000)});if(!r.ok){await r.body?.cancel();return {httpStatus:r.status};}return r.json();}
const calls=await query('https://api.twilio.com/2010-04-01/Accounts/'+sid+'/Calls.json?To=%2B12898873200&StartTime%3E=2026-10-26&PageSize=20');report.providerCalls=calls.calls?.map(c=>({status:c.status,direction:c.direction,start:c.start_time,end:c.end_time,duration:c.duration,hasParent:!!c.parent_call_sid}))??{httpStatus:calls.httpStatus};
const alerts=await query('https://monitor.twilio.com/v1/Alerts?PageSize=30&StartDate=2026-10-26');report.providerAlerts=alerts.alerts?.map(a=>({code:a.error_code,level:a.log_level,created:a.date_created,requestPath:(()=>{try{return new URL(a.request_url).pathname.replace(/\/AC[a-f0-9]{32}/ig,'/account');}catch{return undefined;}})()}))??{httpStatus:alerts.httpStatus};

report.providerAlertDetails=[];
for(const alert of (alerts.alerts??[]).filter(a=>a.request_url?.includes('/v1/external-calls/')).slice(0,5)){
 if(!/^NO[a-f0-9]{32}$/i.test(alert.sid))continue;
 const detail=await query('https://monitor.twilio.com/v1/Alerts/'+alert.sid);
 const info=new URLSearchParams(detail.alert_text??'');
 const summary={code:detail.error_code,created:detail.date_created,httpStatus:info.get('httpResponse')??info.get('status'),method:detail.request_method};
 // Only fixed diagnostic classifications; do not export webhook inputs or raw headers.
 const body=String(detail.response_body??'');
 summary.responseKind=body.includes('"forbidden"')?'forbidden':body.includes('"unavailable"')?'unavailable':body.includes('<Response')?'twiml':body.includes('1101')?'worker_exception':body.includes('1015')?'rate_limit':'other';
 summary.reportedStatus=/(?:HTTP.*?status.*?|status code)[^0-9]*(\\d{3})/i.exec(info.get('msg')??info.get('Msg')??'')?.[1];
 for(const key of ['ErrorCode','sourceComponent','httpResponse','ErrorType']){const value=info.get(key);if(value&&/^[a-zA-Z0-9_. -]{1,80}$/.test(value))summary[key]=value;}
 report.providerAlertDetails.push(summary);
}


if(process.env.CLOUDFLARE_ACCOUNT_ID&&process.env.CLOUDFLARE_API_TOKEN){
 try{
 const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+process.env.CLOUDFLARE_ACCOUNT_ID+'/workers/observability/telemetry/query',{method:'POST',headers:{authorization:'Bearer '+process.env.CLOUDFLARE_API_TOKEN,'content-type':'application/json'},body:JSON.stringify({queryId:'primecare-call-incident',view:'events',dry:true,limit:100,timeframe:{from:Date.parse('2026-10-26T15:56:15Z'),to:Date.parse('2026-10-26T15:56:40Z')},parameters:{needle:{value:'external_call_request',isRegex:false,matchCase:true}}}),signal:AbortSignal.timeout(20000)});
 report.workerLogs={httpStatus:response.status,entries:[]};
 if(response.ok){
 const data=await response.json();report.workerLogs.success=data.success;
 const visit=(value,depth=0)=>{if(depth>12||!value)return;if(typeof value==='string'){if(value.startsWith('{')){try{visit(JSON.parse(value),depth+1);}catch{}}return;}if(typeof value!=='object')return;
 if(value.event==='external_call_request'){const safe={};for(const key of ['event','operation','phase','status','elapsedMs','sqlState','reason']){const v=value[key];if(typeof v==='number'||typeof v==='string'&&/^[a-zA-Z0-9_. -]{1,80}$/.test(v))safe[key]=v;}report.workerLogs.entries.push(safe);return;}for(const v of Object.values(value))visit(v,depth+1);};visit(data.result?.events?.events??[]);
 }
 }catch{report.workerLogs={unavailable:true};}
}

await mkdir('test-results/external-call-incident',{recursive:true});await writeFile('test-results/external-call-incident/incident.json',JSON.stringify(report,null,2)+'\n');console.log('EXTERNAL_CALL_INCIDENT '+JSON.stringify(report));
