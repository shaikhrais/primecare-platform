import assert from 'node:assert/strict';
import {test} from 'node:test';
import {setImmediate} from 'node:timers/promises';
import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
const built=await build({entryPoints:['websites/typescript/src/endpoint-management-panel.ts'],bundle:true,write:false,format:'esm',platform:'browser'});
const {mountEndpointManagement}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const settle=async()=>{for(let i=0;i<8;i++)await setImmediate();};
test('panel renders live estimates, shows limited benchmark scope, clears stale data and disposes refresh',async()=>{
 const dom=new JSDOM('<main id="panel"></main>',{pretendToBeVisual:true});
 const original={document:globalThis.document,fetch:globalThis.fetch,setInterval:globalThis.setInterval,clearInterval:globalThis.clearInterval};
 globalThis.document=dom.window.document;
 let refresh,available=true,active=true,calls=0,cleared=false;
 globalThis.setInterval=fn=>{refresh=fn;return 1;};globalThis.clearInterval=()=>{cleared=true;};
 const report={intervalSeconds:300,windowStartedAt:'2026-11-20T12:00:00Z',windowEndedAt:'2026-11-20T12:05:00Z',observedRequests:3,measurementKind:'sample_weighted_estimate',responseBodies:{status:'available',endpoints:[{endpoint:'GET /v1/test',completedResponses:3,completedBytes:4321,incompleteResponses:1,partialBytes:12}]},endpoints:[{endpoint:'GET /v1/test',observedRequests:3,statusCounts:{'200':2,'500':1},declaredRequestBytes:{knownBytes:0,unknownRequests:0},declaredResponseBytes:{knownBytes:100,unknownRequests:1},responseHeaderLatencyP95Ms:10}]};
 globalThis.fetch=async(url,init)=>{calls++;assert.equal(init.headers.authorization,'Bearer test');
  if(url.includes('api-service-status'))return Response.json({data:[{service:'test',declaredOperations:1,managementStates:{ready:0,blocked:0,maintenance:0,unverified:1}}],pagination:{total:1,hasMore:false},traffic:available?{status:'available',report}:{status:'unavailable'}});
  return Response.json({data:[{api:'GET /v1/test',service:'test',management:{implementation:'declared_implemented',protection:'unverified',readiness:'unverified',maintenance:'unknown'}}],pagination:{total:1,hasMore:false}});
 };
 let dispose;
 try{
  const panel=document.getElementById('panel');dispose=mountEndpointManagement(panel,'https://gateway.test','test','en',()=>active);await settle();
  assert.match(panel.textContent,/Measured response body bytes: 4,321/);assert.match(panel.textContent,/Completed bodies: 3/);assert.match(panel.textContent,/before gateway compression/);assert.match(panel.textContent,/Sample-weighted estimates/);assert.match(panel.textContent,/Registered declarations: 1/);
  assert.equal(panel.querySelector('tbody tr').cells[7].textContent,'3');
  const benchmark={releaseId:'fixture',environment:'staging',workload:'synthetic-read-mix',evidenceUrl:'https://example.com/fixture',measuredAt:new Date(Date.now()-1000).toISOString(),expiresAt:new Date(Date.now()+60000).toISOString(),sustainableRequestsPerSecond:10,p95LatencyMs:100,errorRate:0,targetP95LatencyMs:500,targetErrorRate:0.01,bottleneck:'unknown',measurementScope:'staging_http_read_mix'};
  const input=panel.querySelectorAll('input[type=file]')[1];Object.defineProperty(input,'files',{value:[{size:500,text:async()=>JSON.stringify(benchmark)}]});await input.onchange();
  assert.match(panel.textContent,/Measurement covers staging reads only/);
  available=false;refresh();await settle();
  assert.match(panel.textContent,/Live traffic reporting is unavailable/);assert.equal(panel.querySelector('tbody tr').cells[7].textContent,'—');
  active=false;dispose();dispose=undefined;const before=calls;refresh();await settle();assert.equal(calls,before);assert.equal(cleared,true);
 }finally{dispose?.();Object.assign(globalThis,original);dom.window.close();}
});
