// Local route triage only. No credentials, real database, mail or network.
import {build} from 'esbuild';
import {readFileSync,readdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
const source='docs/api/api-execution-inventory.json',inventory=JSON.parse(readFileSync(source));
const grouped=new Map();
for(const r of inventory.data)if(r.verificationState==='verification_pending'){
 if(!grouped.has(r.api))grouped.set(r.api,[]);grouped.get(r.api).push(r);
}
let connections=0,forwarded=[];
const plugin={name:'offline-audit',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){globalThis.__auditConnect();throw Error("Offline audit: database disabled")} async end(){} async query(){throw Error("Offline audit: SQL prohibited")}}',loader:'js'}));}};
globalThis.__auditConnect=()=>{connections++;};
async function bundle(path,plugins=[]){const result=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));}
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts'),{default:worker}=await bundle('cloudflare/workers/src/service.ts',[plugin]);
const services={AUTH:'auth',CLIENT:'client',PROVIDER:'provider',VISIT:'visit',NOTES:'notes',BILLING:'billing',SCHEDULING:'scheduling',NOTIFICATION:'notification',VERIFICATION:'verification',COMPLIANCE:'compliance',GOVERNANCE:'governance',FRANCHISE_REPORTING:'franchise-reporting'};
const env=Object.fromEntries(Object.entries(services).map(([binding,name])=>[binding,{fetch:async request=>{
 forwarded.push({binding,workerPath:new URL(request.url).pathname});
 return worker.fetch(request,{SERVICE_NAME:name,DB_URL:'offline-fixture',AUTH_SOURCE_LIMIT:{limit:async()=>({success:true})}});
}}]));
const operations=[],counts={};const previousError=console.error;console.error=()=>{};
try{for(const [api,rows] of grouped){
 const first=rows[0],probePath=first.route.replace(/\{[^}]+\}/g,'audit-record');connections=0;forwarded=[];
 const response=await gateway.fetch(new Request('https://fixture'+probePath,{method:first.method,headers:{'cf-connecting-ip':'203.0.113.20',...(['GET','HEAD'].includes(first.method)?{}:{'content-type':'application/json'})},...(['GET','HEAD'].includes(first.method)?{}:{body:'{}'})}),env);
 const body=await response.json();
 const classification=response.status===404?(forwarded.length?'worker_route_not_found':'gateway_route_not_found'):
  response.status===405?'declared_method_rejected':
  [401,403].includes(response.status)?'credential_or_authority_required':
  response.status===200&&body.status==='ok'&&typeof body.service==='string'?'service_status_only':
  connections>0?'requires_database_probe':response.status===400?'request_validation_reached':'requires_further_review';
 counts[classification]=(counts[classification]??0)+1;
 operations.push({api,probePath,declarationIds:rows.map(r=>r.id),classification,status:response.status,allow:response.headers.get('allow'),forwarded,databaseConnectionAttempts:connections,businessOperationVerified:false,productionVerified:false});
}}finally{console.error=previousError;}
const files=[source,'scripts/audit-api-reachability.mjs',...readdirSync('cloudflare/workers/src').filter(f=>/\.(ts|json)$/.test(f)).sort().map(f=>'cloudflare/workers/src/'+f)];
const sourceHashes=Object.fromEntries(files.map(path=>[path,createHash('sha256').update(readFileSync(path)).digest('hex')]));
const report={scope:'local_unauthenticated_route_triage',request:'Declared method with no bearer/cookie/tenant override; GET has no body, other methods use empty JSON; path parameters use synthetic audit-record IDs.',database:'Connections disabled before SQL; no email or external requests.',summary:{uniquePendingOperations:grouped.size,reviewed:operations.length,classifications:counts},sourceHashes,operations};
if(operations.length!==grouped.size)throw Error('Incomplete reachability audit');
writeFileSync('docs/api/api-reachability-audit.json',JSON.stringify(report,null,2)+'\n');
const lines=['# Remaining API route triage','',`**${operations.length}/${grouped.size} unique pending declarations probed locally.**`,
 '', 'These probes use the declared method without credentials. They classify routing behavior, not business completion. Database connections are stopped before SQL, no email is sent, and production is not contacted. A 404 is specific to this probe; a 401/403 requires authenticated verification. A 405 identifies a method mismatch, not a completed write. Dynamic ID handlers can capture workflow-like names: a protected or method-rejected response does not prove that the advertised workflow exists. Do not switch callers to GET blindly. Service status is not an auth workflow.','',
 '| Probe classification | Operations |','| --- | ---: |',...Object.entries(counts).sort().map(([k,v])=>`| ${k} | ${v} |`),'',
 'The JSON contains every exact method/path, HTTP status, allowed method, forwarding destination and source hashes. Retire or replace stale declarations only after checking callers and intended workflows. Register business authority and contracts before implementing missing actions. Existing unit-evidence operations and registered blockers are excluded from this pending-only triage.',''];
writeFileSync('docs/api/API_REACHABILITY_AUDIT.md',lines.join('\n'));
console.log(JSON.stringify(report.summary));
