import {test} from 'node:test';
import assert from 'node:assert/strict';
import {safeCollection,classify,startGateway,diagnose,validateCoverage} from './run-primecare-api-diagnostics.mjs';
const collection=apis=>({info:{name:'Fixture',schema:'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'},item:apis.map(api=>({name:api,request:{method:api.split(' ')[0],url:'https://production.invalid',header:[{key:'Authorization',value:'Bearer secret-should-not-exist'}],body:{mode:'raw',raw:'{"patient":"private"}'}},event:[{listen:'prerequest',script:{exec:['throw Error("must be removed")']}}]}))});
test('sanitizer preserves operation method and dynamic identity while removing credentials/scripts/body',()=>{
 const safe=safeCollection(collection(['PATCH /v1/client/invoices/{invoiceId}']),'http://127.0.0.1:1234');
 assert.equal(safe.item[0].name,'PATCH /v1/client/invoices/{invoiceId}');assert.equal(safe.item[0].request.method,'PATCH');assert.equal(safe.item[0].request.url,'http://127.0.0.1:1234/v1/client/invoices/diagnostic-record');assert.equal(safe.item[0].request.body.raw,'{}');assert.doesNotMatch(JSON.stringify(safe),/private|secret|production|event/);
 assert.throws(()=>safeCollection(collection(['GET /v1/auth/me']),'https://api.primecare.io'),/loopback/);
 const mismatch=collection(['GET /v1/auth/me']);mismatch.item[0].request.method='POST';assert.throws(()=>safeCollection(mismatch,'http://127.0.0.1:1'),/mismatch/);
 assert.throws(()=>safeCollection(collection(['GET /v1/auth/me','GET /v1/auth/me']),'http://127.0.0.1:1'),/Duplicate/);
});
test('classifications keep auth, routing, method, request and server failures distinct',()=>{
 assert.equal(classify(401),'authentication_required');assert.equal(classify(403),'authentication_required');assert.equal(classify(404),'route_not_found');assert.equal(classify(405),'method_rejected');assert.equal(classify(400),'request_contract_needed');assert.equal(classify(503),'unsupported_or_database_probe_blocked');assert.equal(classify(200),'response_observed_not_verified');assert.equal(classify(null,true),'transport_failure');
});
test('Newman executes actual bundled gateway and Workers without DB/network or method substitution',async()=>{
 const fixture=await startGateway();try{
 const apis=['GET /v1/provider/profile','GET /v1/does-not-exist','POST /v1/provider/profile','POST /v1/auth/login','GET /v1/auth/health'];
 const report=await diagnose(collection(apis),{baseUrl:fixture.baseUrl,guard:fixture.guard});
 assert.equal(report.executedUniqueOperations,5);assert.equal(report.authorizationVerified,false);assert.equal(report.productionVerified,false);
 const rows=Object.fromEntries(report.operations.map(r=>[r.api,r]));assert.equal(rows[apis[0]].status,401);assert.equal(rows[apis[1]].status,404);assert.equal(rows[apis[2]].status,405);assert.equal(rows[apis[3]].status,400);assert.equal(rows[apis[4]].status,500);assert.ok(fixture.guard.databaseAttempts>0);assert.equal(fixture.guard.externalNetworkAttempts,0);
 assert.deepEqual(fixture.guard.methodObservations.map(x=>x.method),['GET','GET','POST','POST','GET']);assert.doesNotMatch(JSON.stringify(report),/patient|Bearer|responseBody|requestBody|stack|SQL/);
 }finally{await fixture.close();}
});
test('Newman transport failures aggregate without raw error strings or missing operations',async()=>{
 const report=await diagnose(collection(['GET /v1/offline']),{baseUrl:'http://127.0.0.1:1'});
 assert.equal(report.classificationCounts.transport_failure,1);assert.equal(report.operations[0].status,null);assert.equal(report.operations[0].transportFailure,true);assert.doesNotMatch(JSON.stringify(report),/ECONNREFUSED|private|secret/);
});

test('finite coverage rejects same-size substitutions and retired identities',()=>{const c=collection(['GET /v1/auth/me']);const ledger={summary:{activeUniqueOperations:1},operations:[{api:'GET /v1/auth/me',stage:'unit_evidence_recorded'},{api:'POST /v1/auth',stage:'retired_with_evidence'}]};validateCoverage(c,ledger);assert.throws(()=>validateCoverage(collection(['POST /v1/auth']),ledger),/coverage/);assert.throws(()=>validateCoverage(collection(['GET /v1/other']),ledger),/coverage/);});

test('generated Postman collection scripts execute in the real Newman sandbox',async()=>{
 const {readFileSync}=await import('node:fs');const {flatten,loadNewman}=await import('./run-primecare-api-diagnostics.mjs');
 const original=JSON.parse(readFileSync('docs/api/PrimeCare.postman_collection.json','utf8'));
 const fixture=await startGateway();try{
 const sample={...original,item:flatten(original.item).filter(x=>['GET /v1/provider/profile','POST /v1/user/preferences'].includes(x.name))};assert.equal(sample.item.length,2);
 const scriptResults=[];const result=await new Promise((resolve,reject)=>loadNewman().run({collection:sample,reporters:[],environment:{values:[{key:'baseUrl',value:fixture.baseUrl},{key:'allowRemote',value:'false'}]},ignoreRedirects:true,timeoutRequest:5000},(error,summary)=>error?reject(error):resolve(summary)).on('script',(error,args)=>{scriptResults.push(args.execution);}));
 assert.equal(result.run.failures.length,0,'Generated sandbox scripts must succeed');assert.equal(result.run.stats.requests.total,2);assert.equal(fixture.guard.methodObservations.length,2);
 const variables=scriptResults.at(-1).collectionVariables.values;const aggregated=JSON.parse(variables.find(v=>v.key==='operationResults').value);assert.equal(aggregated.length,2);assert.ok(aggregated.every(r=>r.businessVerified===false&&typeof r.status==='number'));assert.deepEqual(new Set(aggregated.map(r=>r.outcome)),new Set(['requires_auth','routing_failure']));assert.equal(JSON.parse(variables.find(v=>v.key==='errorReport').value).length,2);assert.doesNotMatch(JSON.stringify(aggregated),/Bearer|password|patient/);
 }finally{await fixture.close();}
});

test('generated remote guard skips credential-bearing loopback URL before dispatch',async()=>{const {readFileSync}=await import('node:fs');const {flatten,loadNewman}=await import('./run-primecare-api-diagnostics.mjs');const original=JSON.parse(readFileSync('docs/api/PrimeCare.postman_collection.json','utf8'));const fixture=await startGateway();try{const sample={...original,item:flatten(original.item).slice(0,1)};const summary=await new Promise((resolve,reject)=>loadNewman().run({collection:sample,reporters:[],environment:{values:[{key:'baseUrl',value:fixture.baseUrl.replace('http://','http://invalid-user@')},{key:'allowRemote',value:'false'}]},ignoreRedirects:true,timeoutRequest:1000},(error,result)=>error?reject(error):resolve(result)));assert.equal(summary.run.stats.requests.total,0);assert.equal(fixture.guard.methodObservations.length,0);}finally{await fixture.close();}});

test('reviewed bodyless mutations reach auth; injected JSON bodies are rejected by actual handlers',async()=>{
 const apis=['DELETE /v1/user/sessions','DELETE /v1/admin/users/{userId}/sessions','POST /v1/client/booking-requests/{requestId}/cancel'];
 const fixture=await startGateway();try{
 const safe=safeCollection(collection(apis),fixture.baseUrl);assert.ok(safe.item.every(i=>!Object.hasOwn(i.request,'body')));
 const report=await diagnose(collection(apis),{baseUrl:fixture.baseUrl,guard:fixture.guard});assert.deepEqual(report.operations.map(o=>o.status),[401,401,401]);
 const {loadNewman}=await import('./run-primecare-api-diagnostics.mjs');for(const i of safe.item)i.request.body={mode:'raw',raw:'{}'};
 const result=await new Promise((resolve,reject)=>loadNewman().run({collection:safe,reporters:[],ignoreRedirects:true,timeoutRequest:5000},(error,summary)=>error?reject(error):resolve(summary)));
 assert.deepEqual(result.run.executions.map(e=>e.response.code),[400,400,400]);assert.equal(fixture.guard.databaseAttempts,0);assert.equal(fixture.guard.externalNetworkAttempts,0);
 }finally{await fixture.close();}
});
