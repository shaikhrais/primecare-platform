import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {build} from 'esbuild';
import {reviewedMethodBlocker,reviewedBlockedGroups,auditReachability,METHOD_BLOCKER_SOURCE_HASHES} from './audit-api-reachability.mjs';

const sources=Object.fromEntries(Object.keys(METHOD_BLOCKER_SOURCE_HASHES).map(p=>[p,readFileSync(p,'utf8')]));
const cases=[
 {id:12,path:'/v1/admin/users/churn-heatmap',binding:'AUTH',workerPath:'/admin/users/churn-heatmap',target:'churn-heatmap',classification:'workflow_name_captured_as_record_id'},
 {id:251,path:'/v1/client/feedback',binding:'CLIENT',workerPath:'/feedback',target:null,classification:'unsupported_feedback_submission'},
 {id:252,path:'/v1/client/feedback/surveys',binding:'CLIENT',workerPath:'/feedback/surveys',target:'surveys',classification:'workflow_name_captured_as_record_id'},
 {id:253,path:'/v1/client/feedback/analytics',binding:'CLIENT',workerPath:'/feedback/analytics',target:'analytics',classification:'workflow_name_captured_as_record_id'},
];
const observation=c=>({api:'POST '+c.path,probePath:c.path,declarationIds:[c.id],status:405,allow:'GET',databaseConnectionAttempts:0,forwarded:[{binding:c.binding,workerPath:c.workerPath}]});
for(const c of cases){
 test(c.path+' classification requires exact reviewed observation and sources',()=>{
  const result=reviewedMethodBlocker(observation(c),sources);
  assert.equal(result?.classification,c.classification);assert.equal(result.workflowImplemented,false);assert.equal(result.matchedHandler.value,c.target);
  for(const patch of [{api:'GET '+c.path},{probePath:c.path+'/wrong'},{declarationIds:[999]},{declarationIds:[c.id,999]},{status:200},{allow:'GET, POST'},{databaseConnectionAttempts:1},{forwarded:[{binding:'BILLING',workerPath:c.workerPath}]},{forwarded:[{binding:c.binding,workerPath:'/wrong'}]},{forwarded:[]}])assert.equal(reviewedMethodBlocker({...observation(c),...patch},sources),null);
  for(const path of Object.keys(sources))assert.equal(reviewedMethodBlocker(observation(c),{...sources,[path]:sources[path]+'\n// unreviewed source drift'}),null);
 });
}
test('unreviewed wildcard-looking declaration cannot inherit blocker disposition',()=>{
 assert.equal(reviewedMethodBlocker({...observation(cases[2]),api:'POST /v1/client/feedback/other',probePath:'/v1/client/feedback/other'},sources),null);
});
test('malformed observations fail closed without throwing',()=>{
 for(const invalid of [null,{}, {...observation(cases[0]),forwarded:[null]}, {...observation(cases[0]),declarationIds:null}])assert.equal(reviewedMethodBlocker(invalid,sources),null);
 assert.equal(reviewedMethodBlocker(observation(cases[0]),null),null);
});
const blockedInventory=()=>cases.map(c=>({id:c.id,api:'POST '+c.path,route:c.path,method:'POST',service:'PRISMA',declaredImplementation:'blocked',verificationState:'blocked',screens:[],roles:[]}));
test('reviewed blocked inventory rejects partial, duplicate, or changed identities and authority',()=>{
 assert.equal(reviewedBlockedGroups(blockedInventory()).size,4);
 assert.equal(reviewedBlockedGroups([{id:999,verificationState:'blocked'}]).size,0);
 for(const patch of [{api:'POST /wrong'},{method:'GET'},{route:'/wrong'},{service:'auth'},{declaredImplementation:'active'},{screens:[1]},{roles:[1]}]){
  const rows=blockedInventory();rows[0]={...rows[0],...patch};assert.throws(()=>reviewedBlockedGroups(rows),/drift/);
 }
 assert.throws(()=>reviewedBlockedGroups(blockedInventory().slice(1)),/exactly four/);
 assert.throws(()=>reviewedBlockedGroups([...blockedInventory(),blockedInventory()[0]]),/exactly four/);
});
test('actual audit separately probes four blockers without changing pending denominator',async()=>{
 const pending={id:999,api:'POST /v1/not-a-service/path',route:'/v1/not-a-service/path',method:'POST',verificationState:'verification_pending'};
 const report=await auditReachability({inventoryData:[...blockedInventory(),pending,{id:1000,verificationState:'blocked'}],writeReport:false});
 assert.equal(report.summary.uniquePendingOperations,1);assert.equal(report.summary.reviewed,1);assert.equal(report.operations.length,1);
 assert.deepEqual(report.reviewedBlockedSummary,{uniqueReviewedBlockedOperations:4,reviewed:4,classifications:{workflow_name_captured_as_record_id:3,unsupported_feedback_submission:1}});
 assert.equal(report.reviewedBlockedOperations.length,4);
 assert.ok(report.reviewedBlockedOperations.every(r=>r.status===405&&r.allow==='GET'&&r.databaseConnectionAttempts===0&&r.workflowImplemented===false&&r.businessOperationVerified===false));
 assert.ok(report.sourceHashes['packages/domain/src/registries/FormRegistry/client-forms.ts']);
 assert.deepEqual(report.reviewedBlockedOperations.map(r=>r.declarationIds[0]).sort((a,b)=>a-b),[12,251,252,253]);
});

let queries=[],connections=0,forwarded=[];
const plugin={name:'method-capture-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){globalThis.__captureConnect()} async end(){} async query(sql,values){return globalThis.__captureQuery(sql,values)}}',loader:'js'}));}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const {default:worker}=await bundle('cloudflare/workers/src/service.ts',[plugin]);
const {parseAccountAdminRequest}=await bundle('cloudflare/workers/src/account-admin.ts');
function fixture(){queries=[];connections=0;forwarded=[];globalThis.__captureConnect=()=>{connections++;};globalThis.__captureQuery=async(sql,values)=>{
 queries.push({sql,values});
 if(sql.startsWith('SELECT u.id'))return {rows:[{id:'actor',roles:'ceo',tenant_id:'tenant'}]};
 if(sql.startsWith('SELECT id,full_name'))return {rows:[{id:'owned-profile'}]};
 if(sql.startsWith('SELECT COUNT'))return {rows:[{count:0}]};
 if(sql.startsWith('SELECT ')&&(sql.includes(' FROM feedbacks ')||sql.includes('FROM users WHERE')))return {rows:[]};
 if(sql.startsWith('BEGIN')||sql==='ROLLBACK')return {rows:[]};
 throw Error('Unexpected fixture query: '+sql);
};}
const env=Object.fromEntries([['AUTH','auth'],['CLIENT','client']].map(([binding,service])=>[binding,{fetch:async r=>{forwarded.push({binding,workerPath:new URL(r.url).pathname});return worker.fetch(r,{SERVICE_NAME:service,DB_URL:'fixture'});}}]));
const call=(c,method,token=true)=>gateway.fetch(new Request('https://fixture'+c.path,{method,headers:{...(token?{authorization:'Bearer '+'a'.repeat(43)}:{}),...(method==='POST'?{'content-type':'application/json'}:{})},...(method==='POST'?{body:'{}'}:{})}),env);
for(const c of cases){
 test('actual gateway POST '+c.path+' rejects before SQL instead of implementing workflow',async()=>{
  fixture();const response=await call(c,'POST');assert.equal(response.status,405);assert.equal(response.headers.get('allow'),'GET');assert.equal(connections,0);assert.deepEqual(queries,[]);assert.deepEqual(forwarded,[{binding:c.binding,workerPath:c.workerPath}]);
 });
 test('actual gateway GET '+c.path+' executes resource read shape, never advertised workflow',async()=>{
  fixture();const response=await call(c,'GET');
  if(c.binding==='AUTH'){
   assert.equal(response.status,404);const parsed=parseAccountAdminRequest(new Request('https://fixture'+c.path),c.workerPath);assert.equal(parsed.input.operation,'account_read');assert.equal(parsed.input.userId,c.target);assert.ok(queries.some(q=>q.sql.includes('FROM users WHERE id::text=$1 AND tenant_id::text=$2')&&q.values[0]===c.target&&q.values[1]==='tenant'));
  }else if(c.target){
   assert.equal(response.status,404);assert.ok(queries.some(q=>q.sql.includes(' FROM feedbacks WHERE client_id::text=$1 AND tenant_id::text=$2 AND id::text=$3')&&JSON.stringify(q.values)===JSON.stringify(['owned-profile','tenant',c.target])));
  }else{assert.equal(response.status,200);const body=await response.json();assert.deepEqual(body.feedback,[]);assert.ok(body.pagination);}
  assert.ok(queries.every(q=>!/^INSERT|^UPDATE|^DELETE/.test(q.sql)));assert.equal(queries.at(-1).sql,'ROLLBACK');
 });
 test('actual gateway unauthenticated GET '+c.path+' requires credentials with no SQL',async()=>{
  fixture();assert.equal((await call(c,'GET',false)).status,401);assert.equal(connections,0);assert.deepEqual(queries,[]);
 });
}
