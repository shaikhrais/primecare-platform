import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({entryPoints:['websites/typescript/src/tenant-dashboard/work-module-transport.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {tenantTaskModuleTransport}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
let token='captured';Object.defineProperty(globalThis,'sessionStorage',{value:{getItem:()=>token},configurable:true});
const req={method:'GET',filters:{dataset:'live',status:'all'}};
const failure=code=>e=>e.code===code;
function make(fetcher){token='captured';return tenantTaskModuleTransport('https://fixture.test','captured',fetcher);}
test('existing endpoint, filters, bearer and exact mutation receipt are preserved',async()=>{const calls=[],send=make(async(url,options)=>{calls.push({url:String(url),options});return Response.json({ok:true});});const signal=new AbortController().signal;assert.deepEqual(await send(req,signal),{ok:true});const body={action:'edit',id:'task1',version:2,value:{notes:'Owned draft'}},requestId='00000000-0000-4000-8000-000000000001';await send({method:'POST',filters:{dataset:'live'},body,requestId},signal);assert.equal(new URL(calls[0].url).pathname,'/v1/governance/tenant-dashboard');assert.equal(new URL(calls[0].url).searchParams.get('status'),'all');assert.equal(calls[1].options.headers.authorization,'Bearer captured');assert.equal(calls[1].options.headers['idempotency-key'],requestId);assert.deepEqual(JSON.parse(calls[1].options.body),body);assert.equal(calls[1].options.redirect,'error');assert.equal(calls[1].options.cache,'no-store');});
test('logout before dispatch sends nothing',async()=>{let calls=0;const send=make(async()=>{calls++;return Response.json({});});token='changed';await assert.rejects(()=>send(req,new AbortController().signal),failure('denied'));assert.equal(calls,0);});
test('logout while response body is pending rejects stale data and cancels reader',async()=>{let resolveRead,cancelled=false;const send=make(async()=>new Response(new ReadableStream({start(controller){resolveRead=()=>{token='changed';controller.enqueue(new TextEncoder().encode('{"old":true}'));};},cancel(){cancelled=true;}})));const pending=send(req,new AbortController().signal);await new Promise(r=>setImmediate(r));resolveRead();await assert.rejects(()=>pending,failure('denied'));assert.equal(cancelled,true);});
test('aborted transports cannot publish even when fetch ignores abort',async()=>{const abort=new AbortController(),send=make(async()=>{abort.abort();return Response.json({});});await assert.rejects(()=>send(req,abort.signal),failure('unavailable'));});
test('declared and streamed oversized replies fail and cancel without replay',async()=>{for(const declared of [true,false]){let calls=0,cancelled=false;const send=make(async()=>{calls++;return new Response(new ReadableStream({pull(c){c.enqueue(new Uint8Array(1048577));},cancel(){cancelled=true;}}),declared?{headers:{'content-length':'1048577'}}:{});});await assert.rejects(()=>send({...req,method:'POST',body:{action:'edit'},requestId:'original'},new AbortController().signal),e=>e.code==='error'&&e.status===502);assert.equal(calls,1);assert.equal(cancelled,true);}});
test('malformed JSON and invalid UTF-8 never become successful data',async()=>{for(const bytes of ['{invalid',new Uint8Array([123,34,120,34,58,34,255,34,125])]){const send=make(async()=>new Response(bytes));await assert.rejects(()=>send(req,new AbortController().signal),e=>e.code==='error'&&e.status===502);}});
test('HTTP denied, conflict and invalid responses retain typed failures',async()=>{for(const [status,code]of [[401,'denied'],[403,'denied'],[409,'conflict'],[400,'invalid'],[500,'error']]){const send=make(async()=>new Response('private error',{status}));await assert.rejects(()=>send(req,new AbortController().signal),e=>e.code===code&&e.status===status);}});
test('invalid origins and header-breaking tokens reject construction',()=>{for(const origin of ['http://remote.test','https://u:p@fixture.test','https://fixture.test/path','https://fixture.test/?x=y'])assert.throws(()=>tenantTaskModuleTransport(origin,'captured'));for(const value of ['', 'bad\r\ntoken','bad token'])assert.throws(()=>tenantTaskModuleTransport('https://fixture.test',value));});

test('session changes during asynchronous stream cleanup cannot publish',async()=>{const send=make(async()=>{const response=Response.json({old:true}),reader=response.body.getReader(),cancel=reader.cancel.bind(reader);reader.cancel=async()=>{await cancel();token='changed';};response.body.getReader=()=>reader;return response;});await assert.rejects(()=>send(req,new AbortController().signal),failure('denied'));});

for(const method of ['GET','POST'])test('stalled '+method+' task reply cancels before another byte without replaying its receipt',async()=>{
 const caller=new AbortController();let source,cancelled=0,calls=0,captured,response;
 const request=method==='GET'?req:{method:'POST',filters:{dataset:'live'},body:{action:'edit',id:'task1',version:2,value:{notes:'Owned draft'}},requestId:'00000000-0000-4000-8000-000000000001'};
 const send=make(async(url,options)=>{calls++;captured={url:String(url),options};response=new Response(new ReadableStream({start(controller){source=controller;},cancel(){cancelled++;}}));return response;});
 const pending=send(request,caller.signal).then(value=>({value}),error=>({error}));
 await new Promise(resolve=>setImmediate(resolve));caller.abort();
 let timer;const stalled=Symbol('stalled'),result=await Promise.race([pending,new Promise(resolve=>{timer=setTimeout(()=>resolve(stalled),100);})]);clearTimeout(timer);
 try{
  assert.notEqual(result,stalled,'aborted task read must settle before another response byte');
  assert.equal(result.error?.code,'unavailable');assert.equal(cancelled,1);assert.equal(response.body.locked,false);assert.equal(calls,1);
  assert.equal(captured.options.signal,caller.signal);assert.equal(captured.options.method,method);assert.equal(captured.options.headers.authorization,'Bearer captured');
  assert.equal(captured.options.cache,'no-store');assert.equal(captured.options.redirect,'error');
  assert.equal(new URL(captured.url).pathname,'/v1/governance/tenant-dashboard');
  if(method==='POST'){assert.equal(captured.options.headers['idempotency-key'],request.requestId);assert.deepEqual(JSON.parse(captured.options.body),request.body);}else assert.equal(captured.options.body,undefined);
 }finally{if(result===stalled){source.enqueue(new TextEncoder().encode('{}'));await pending;}}
});

for(const method of ['GET','POST'])for(const change of ['logout','abort','current'])test(method+' rejected fetch rechecks '+change+' ownership without replay',async()=>{
 const caller=new AbortController(),original=Error('offline');let rejectFetch,calls=0,captured;
 const request=method==='GET'?req:{method:'POST',filters:{dataset:'live'},body:{action:'edit',id:'task1',version:2,value:{notes:'Owned draft'}},requestId:'00000000-0000-4000-8000-000000000001'};
 const send=make((url,options)=>{calls++;captured={url:String(url),options};return new Promise((_,reject)=>{rejectFetch=reject;});});
 const pending=send(request,caller.signal);
 if(change==='logout')token='other-session';else if(change==='abort')caller.abort();
 rejectFetch(original);
 await assert.rejects(()=>pending,error=>change==='current'?error===original:change==='logout'?error.code==='denied'&&error.status===401:error.code==='unavailable');
 assert.equal(calls,1);assert.equal(captured.options.signal,caller.signal);assert.equal(captured.options.method,method);
 assert.equal(captured.options.headers.authorization,'Bearer captured');assert.equal(captured.options.cache,'no-store');assert.equal(captured.options.redirect,'error');
 assert.equal(new URL(captured.url).pathname,'/v1/governance/tenant-dashboard');
 if(method==='POST'){assert.equal(captured.options.headers['idempotency-key'],request.requestId);assert.deepEqual(JSON.parse(captured.options.body),request.body);}else assert.equal(captured.options.body,undefined);
});
