import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {gunzipSync} from 'node:zlib';
const compiled=await build({entryPoints:['cloudflare/workers/src/endpoint-body-traffic.ts','cloudflare/workers/src/gateway.ts'],bundle:true,write:false,platform:'node',format:'esm',outdir:'/tmp/ems-body-tests'});
const moduleFor=async name=>import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles.find(f=>f.path.endsWith(name)).text).toString('base64'));
const {observeEndpointResponseBody}=await moduleFor('endpoint-body-traffic.js'),{default:gateway}=await moduleFor('gateway.js');
const request=()=>new Request('https://gateway.test/v1/auth/me?private=secret',{headers:{authorization:'Bearer hidden'}});
test('streamed Unicode body bytes are counted only as consumed, with no buffering or caller data',async()=>{
 let pulls=0;const points=[],chunks=[new TextEncoder().encode('hello'),new TextEncoder().encode('é🐦')];
 const source=new ReadableStream({pull(c){pulls++;if(chunks.length)c.enqueue(chunks.shift());else c.close();}},{highWaterMark:0});
 const observed=observeEndpointResponseBody(request(),new Response(source,{status:201,headers:{'x-preserve':'yes'}}),{writeDataPoint:p=>points.push(p)});
 assert.equal(pulls,0);assert.equal(points.length,0);assert.equal(observed.status,201);assert.equal(observed.headers.get('x-preserve'),'yes');assert.equal(await observed.text(),'helloé🐦');
 assert.equal(points.length,1);assert.equal(points[0].doubles[0],11);assert.equal(points[0].blobs[1],'complete');assert.doesNotMatch(JSON.stringify(points),/private|secret|hidden|hello/);
});
test('client cancellation records one incomplete body and releases the upstream',async()=>{
 const points=[];let cancelled=false;const source=new ReadableStream({pull(c){c.enqueue(new Uint8Array([1,2,3]));},cancel(){cancelled=true;}},{highWaterMark:0});
 const observed=observeEndpointResponseBody(request(),new Response(source),{writeDataPoint:p=>points.push(p)}),reader=observed.body.getReader();
 await reader.read();assert.equal(points.length,0);await reader.cancel('stop');assert.equal(cancelled,true);assert.equal(points.length,1);assert.equal(points[0].doubles[0],3);assert.equal(points[0].blobs[1],'incomplete');
});
test('body errors propagate unchanged, while telemetry writer failures never fail a response',async()=>{
 const points=[];const source=new ReadableStream({pull(c){c.error(Error('source failure'));}},{highWaterMark:0});
 await assert.rejects(observeEndpointResponseBody(request(),new Response(source),{writeDataPoint:p=>points.push(p)}).text(),/source failure/);assert.equal(points[0].blobs[1],'incomplete');
 assert.equal(await observeEndpointResponseBody(request(),new Response('ok'),{writeDataPoint(){throw Error('provider');}}).text(),'ok');
});
test('disabled observation, encoded responses and SSE remain untouched; HEAD and no-body record zero',()=>{
 for(const headers of [{'content-encoding':'gzip'},{'content-type':'text/event-stream; charset=utf-8'}]){const response=new Response('source',{headers});assert.equal(observeEndpointResponseBody(request(),response,{writeDataPoint:()=>assert.fail('Excluded body observed')}),response);}
 const untouched=new Response('x');assert.equal(observeEndpointResponseBody(request(),untouched),untouched);
 const points=[];observeEndpointResponseBody(new Request('https://gateway.test/v1/auth/me',{method:'HEAD'}),new Response('ignored'),{writeDataPoint:p=>points.push(p)});observeEndpointResponseBody(request(),new Response(null,{status:204}),{writeDataPoint:p=>points.push(p)});assert.deepEqual(points.map(p=>p.doubles[0]),[0,0]);
});
test('gateway compression stays valid and body completions never double-count header requests',async()=>{
 const payload=JSON.stringify({text:'test'.repeat(1000)}),headers=[],bodies=[],original=console.log;console.log=()=>{};
 try{
  const r=await gateway.fetch(new Request('https://gateway.test/v1/auth/me',{headers:{'accept-encoding':'gzip'}}),{AUTH:{fetch:async()=>new Response(payload,{headers:{'content-type':'application/json'}})},ENDPOINT_TRAFFIC_ENABLED:'1',ENDPOINT_ANALYTICS:{writeDataPoint:p=>headers.push(p)},ENDPOINT_BODY_ANALYTICS:{writeDataPoint:p=>bodies.push(p)}});
  assert.equal(headers.length,1);assert.equal(r.headers.get('content-encoding'),'gzip');assert.equal(gunzipSync(Buffer.from(await r.arrayBuffer())).toString(),payload);assert.equal(headers.length,1);assert.equal(bodies.length,1);assert.equal(bodies[0].doubles[0],new TextEncoder().encode(payload).byteLength);
 }finally{console.log=original;}
});
