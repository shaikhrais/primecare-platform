// Local route triage only. No credentials, real database, mail or network.
import {build} from 'esbuild';
import {readFileSync,readdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';

// Exact reviewed declarations only. A 405 on a wildcard detail route is not a
// workflow implementation, and a real feedback submission is not a read alias.
export const METHOD_BLOCKER_SOURCE_HASHES = {"cloudflare/workers/src/gateway.ts": "c023259fa073c3efeca3de80a3cc684da8deecf22982d187f5623f56c8473e2b", "cloudflare/workers/src/account-admin.ts": "b93b16c000f0c02e387fef5b3566b79f2c786f8b62fb23176471b506390d9b92", "cloudflare/workers/src/client-self.ts": "61f8bb9dd63b7d99f0760f9364c4bef709e73a451db8c68f526e82f39d69f9a5", "cloudflare/workers/src/client-records-registry.json": "376620e3a45a9276bd751e79e000b223ac8dd280395b13ac46773bbb618738f5", "packages/domain/src/registries/FormRegistry/client-forms.ts": "f05ee6ccd060907a6672b869434782508ac7f65a1d2cfaacf3391e0953799516", "cloudflare/workers/src/core/base-worker.ts": "58c2df259e14e6078a6476407de0946f8efa159c1685931b5f8bba30c055803c", "cloudflare/workers/src/service.ts": "fa19183dee1ef774c35db7205c03d9ba24e508b09699e36a15bbaed8f832e37e", "cloudflare/workers/src/business-modules.ts": "0b794f814aa5aa96414b55d93acf56d2a020d4545e2c03303e60e2fddd8a6339", "cloudflare/workers/src/runtime/worker-application.ts": "d15343e639df5523847767854bdc535658b577120bd7f3b8b9cc9e229e8cd288", "cloudflare/workers/src/runtime/handler-pipeline.ts": "d5f3241e46fc9455df12c5c7c2ee674b2bcec723f6590c1ed56b38c8a42acd41", "cloudflare/workers/src/service-application.ts": "75ccdd8a409fd82b1162b2643066ce1f8549c632568f679457a30da9ec70e721"};
export function reviewedMethodBlocker(observation, sources) {
 if(!observation||typeof observation!=='object'||!sources||typeof sources!=='object'||!Array.isArray(observation.declarationIds)||!Array.isArray(observation.forwarded)||observation.forwarded.some(f=>!f||typeof f!=='object'))return null;
 for(const [path,expected] of Object.entries(METHOD_BLOCKER_SOURCE_HASHES))if(typeof sources[path]!=='string'||createHash('sha256').update(sources[path]).digest('hex')!==expected)return null;
 const definitions = {
  'POST /v1/admin/users/churn-heatmap': {id:12,binding:'AUTH',workerPath:'/admin/users/churn-heatmap',classification:'workflow_name_captured_as_record_id',source:'cloudflare/workers/src/account-admin.ts',pattern:'/admin/users/{userId}',parameter:'userId',value:'churn-heatmap',needles:['const detail=!audit&&!creationAudit&&!sessions?',"operation:Operation=audit?'audit_read':creationAudit?'creation_audit_read':detail?'account_read'",'detail?.[1]']},
  'POST /v1/client/feedback/surveys': {id:252,binding:'CLIENT',workerPath:'/feedback/surveys',classification:'workflow_name_captured_as_record_id',source:'cloudflare/workers/src/client-self.ts',pattern:'/feedback/{recordId}',parameter:'recordId',value:'surveys',needles:["path.startsWith(r.path+'/')",'path.slice(record.path.length+1):null']},
  'POST /v1/client/feedback/analytics': {id:253,binding:'CLIENT',workerPath:'/feedback/analytics',classification:'workflow_name_captured_as_record_id',source:'cloudflare/workers/src/client-self.ts',pattern:'/feedback/{recordId}',parameter:'recordId',value:'analytics',needles:["path.startsWith(r.path+'/')",'path.slice(record.path.length+1):null']},
  'POST /v1/client/feedback': {id:251,binding:'CLIENT',workerPath:'/feedback',classification:'unsupported_feedback_submission',source:'cloudflare/workers/src/client-self.ts',pattern:'/feedback',parameter:null,value:null,needles:['path===r.path',"request.method!=='GET'"]},
 };
 const d=definitions[observation.api];
 if(!d||observation.probePath!==observation.api.slice(5)||observation.status!==405||observation.allow!=='GET'||observation.databaseConnectionAttempts!==0||observation.declarationIds.length!==1||observation.declarationIds[0]!==d.id||observation.forwarded.length!==1||observation.forwarded[0].binding!==d.binding||observation.forwarded[0].workerPath!==d.workerPath)return null;
 const content=sources[d.source];
 if(typeof content!=='string'||!d.needles.every(needle=>content.includes(needle)))return null;
 if(d.binding==='AUTH'&&!content.includes('^\\/admin\\/users\\/([^/]+)$'))return null;
 if(d.binding==='CLIENT') {
  try {const registry=JSON.parse(sources['cloudflare/workers/src/client-records-registry.json']);if(!registry.some(r=>r.path==='/feedback'&&r.table==='feedbacks'&&r.ownerField==='client_id'))return null;}catch{return null;}
 }
 if(d.id===251&&!sources['packages/domain/src/registries/FormRegistry/client-forms.ts']?.includes("apiEndpoint: '/v1/client/feedback',\n        method: 'POST'"))return null;
 return {classification:d.classification,matchedHandler:{pattern:d.pattern,parameter:d.parameter,value:d.value,source:d.source,sourceSha256:createHash('sha256').update(content).digest('hex')},workflowImplemented:false,reason:d.id===251?'Defined submission caller has no governed write handler; existing handler is owner GET only':'Named business workflow is captured as a resource identifier; GET is not workflow-equivalent'};
}

export function reviewedBlockedGroups(data) {
 const exact = new Map([[12,'POST /v1/admin/users/churn-heatmap'],[251,'POST /v1/client/feedback'],[252,'POST /v1/client/feedback/surveys'],[253,'POST /v1/client/feedback/analytics']]);
 const candidates=data.filter(r=>exact.has(r.id));
 const blocked=candidates.filter(r=>r.verificationState==='blocked');
 if(!blocked.length)return new Map();
 if(blocked.length!==4||candidates.length!==4)throw Error('Reviewed blocker inventory must contain exactly four atomic declarations');
 const grouped=new Map();
 for(const r of blocked){
  if(r.api!==exact.get(r.id)||r.method!=='POST'||r.route!==r.api.slice(5)||r.service!=='PRISMA'||r.declaredImplementation!=='blocked'||r.screens?.length||r.roles?.length)throw Error('Reviewed blocker inventory identity or authority drift: '+r.id);
  grouped.set(r.api,[r]);
 }
 if(grouped.size!==4)throw Error('Duplicate reviewed blocker declaration');
 return grouped;
}

export async function auditReachability({inventoryData=null,writeReport=true}={}) {
const source='docs/api/api-execution-inventory.json',inventory={data:inventoryData??JSON.parse(readFileSync(source)).data};
const grouped=new Map();
for(const r of inventory.data)if(r.verificationState==='verification_pending'){
 if(!grouped.has(r.api))grouped.set(r.api,[]);grouped.get(r.api).push(r);
}
const blockedGroups=reviewedBlockedGroups(inventory.data);
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
const operations=[],counts={},reviewedBlockedOperations=[],blockedCounts={};const previousError=console.error;console.error=()=>{};
const reviewedSources=Object.fromEntries(Object.keys(METHOD_BLOCKER_SOURCE_HASHES).map(p=>[p,readFileSync(p,'utf8')]));
try{for(const [api,rows] of [...grouped,...blockedGroups]){
 const first=rows[0],probePath=first.route.replace(/\{[^}]+\}/g,'audit-record');connections=0;forwarded=[];
 const response=await gateway.fetch(new Request('https://fixture'+probePath,{method:first.method,headers:{'cf-connecting-ip':'203.0.113.20',...(['GET','HEAD'].includes(first.method)?{}:{'content-type':'application/json'})},...(['GET','HEAD'].includes(first.method)?{}:{body:'{}'})}),env);
 const body=await response.json();
 const observation={api,probePath,declarationIds:rows.map(r=>r.id),status:response.status,allow:response.headers.get('allow'),forwarded,databaseConnectionAttempts:connections};
 const blocker=reviewedMethodBlocker(observation,reviewedSources);
 if(blockedGroups.has(api)&&!blocker)throw Error('Reviewed blocked workflow route/source drift: '+api);
 const classification=blocker?.classification??(response.status===404?(forwarded.length?'worker_route_not_found':'gateway_route_not_found'):
  response.status===405?'declared_method_rejected':
  [401,403].includes(response.status)?'credential_or_authority_required':
  response.status===200&&body.status==='ok'&&typeof body.service==='string'?'service_status_only':
  connections>0?'requires_database_probe':response.status===400?'request_validation_reached':'requires_further_review');
 const targetCounts=blockedGroups.has(api)?blockedCounts:counts;targetCounts[classification]=(targetCounts[classification]??0)+1;
 (blockedGroups.has(api)?reviewedBlockedOperations:operations).push({...blocker,api,probePath,declarationIds:rows.map(r=>r.id),classification,status:response.status,allow:response.headers.get('allow'),forwarded,databaseConnectionAttempts:connections,businessOperationVerified:false,productionVerified:false});
}}finally{console.error=previousError;}
const files=[source,'cloudflare/workers/src/core/base-worker.ts','cloudflare/workers/src/runtime/worker-application.ts','cloudflare/workers/src/runtime/handler-pipeline.ts','scripts/audit-api-reachability.mjs','packages/domain/src/registries/FormRegistry/client-forms.ts',...readdirSync('cloudflare/workers/src').filter(f=>/\.(ts|json)$/.test(f)).sort().map(f=>'cloudflare/workers/src/'+f)];
const sourceHashes=Object.fromEntries(files.map(path=>[path,createHash('sha256').update(readFileSync(path)).digest('hex')]));
const report={scope:'local_unauthenticated_route_triage',request:'Declared method with no bearer/cookie/tenant override; GET has no body, other methods use empty JSON; path parameters use synthetic audit-record IDs.',database:'Connections disabled before SQL; no email or external requests.',summary:{uniquePendingOperations:grouped.size,reviewed:operations.length,classifications:counts},sourceHashes,operations,reviewedBlockedOperations,reviewedBlockedSummary:{uniqueReviewedBlockedOperations:blockedGroups.size,reviewed:reviewedBlockedOperations.length,classifications:blockedCounts}};
if(operations.length!==grouped.size||reviewedBlockedOperations.length!==blockedGroups.size)throw Error('Incomplete reachability audit');
if(!writeReport)return report;
writeFileSync('docs/api/api-reachability-audit.json',JSON.stringify(report,null,2)+'\n');
const lines=['# Remaining API route triage','',`**${operations.length}/${grouped.size} unique pending declarations probed locally.**`,
 '', 'These probes use the declared method without credentials. They classify routing behavior, not business completion. Database connections are stopped before SQL, no email is sent, and production is not contacted. A 404 is specific to this probe; a 401/403 requires authenticated verification. A 405 identifies a method mismatch, not a completed write. Dynamic ID handlers can capture workflow-like names: a protected or method-rejected response does not prove that the advertised workflow exists. Do not switch callers to GET blindly. Service status is not an auth workflow.','',
 '| Probe classification | Operations |','| --- | ---: |',...Object.entries(counts).sort().map(([k,v])=>`| ${k} | ${v} |`),'',
 'The JSON contains every exact method/path, HTTP status, allowed method, forwarding destination and source hashes. Retire or replace stale declarations only after checking callers and intended workflows. Register business authority and contracts before implementing missing actions. Existing unit-evidence operations are excluded. The four specifically reviewed method/workflow blockers are probed in a separate reviewedBlockedOperations array and never enter the pending denominator.',''];
lines.push(`Separately reviewed blockers: ${reviewedBlockedOperations.length}/${blockedGroups.size}. These remain blocked and do not add pending operations or implemented API credit.`, '');
writeFileSync('docs/api/API_REACHABILITY_AUDIT.md',lines.join('\n'));
console.log(JSON.stringify(report.summary));
return report;

}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)await auditReachability();
