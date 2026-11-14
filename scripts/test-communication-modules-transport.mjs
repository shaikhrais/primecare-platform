import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const b=await build({entryPoints:['packages/shared/src/communications/module-transport.ts'],bundle:true,platform:'node',format:'esm',write:false});const {RegisteredModuleTransport}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
const scope={tenantId:'tenant',userId:'user1',role:'psw',dataset:'live'};
function transport(fetcher){let current={token:'captured',scope};return {wire:new RegisteredModuleTransport('https://fixture.test','captured',scope,()=>current,fetcher),change:(replacement={token:'other',scope})=>{current=replacement;}};}
test('registered operations preserve paths, query semantics and original message receipt',async()=>{const calls=[],t=transport(async(url,options)=>{calls.push({url:String(url),options});return Response.json({ok:true});}),signal=new AbortController().signal;for(const [op,value]of [['message.inbox',{limit:100}],['message.read',{id:'thread1'}],['message.send',{id:'thread1',key:'original',version:2,text:'Body',pictureIds:[]}],['message.mark_read',{id:'thread1',key:'read-key',version:2,sequence:1}],['email.inbox',{direction:'outbound',limit:100}],['email.read',{id:'mail1'}]])assert.deepEqual(await t.wire.execute(op,value,signal),{ok:true});assert.deepEqual(calls.map(x=>new URL(x.url).pathname),['/v1/messages/inbox','/v1/messages','/v1/messages','/v1/messages','/v1/messages/email/inbox','/v1/messages/email']);assert.equal(JSON.parse(calls[2].options.body).key,'original');for(const c of calls){assert.equal(c.options.redirect,'error');assert.equal(c.options.headers.authorization,'Bearer captured');}t.wire.close();});
test('identity aliases, unsupported providers and cancelled calls cannot reach fetch',async()=>{let calls=0;const t=transport(async()=>{calls++;return Response.json({});});for(const key of ['actor','actorId','userId','tenantId','role','roles','dataset'])await assert.rejects(()=>t.wire.execute('message.read',{id:'thread1',[key]:'other'},new AbortController().signal));await assert.rejects(()=>t.wire.execute('email.queue',{to:'someone@example.invalid'},new AbortController().signal));const abort=new AbortController();abort.abort();await assert.rejects(()=>t.wire.execute('message.inbox',{},abort.signal));assert.equal(calls,0);t.wire.close();});
test('scope changes and disposal while reading cannot publish old replies',async()=>{for(const close of [false,true]){let finish,cancelled=false;const t=transport(async()=>new Response(new ReadableStream({start(c){finish=()=>c.enqueue(new TextEncoder().encode('{}'));},cancel(){cancelled=true;}})));const pending=t.wire.execute('message.inbox',{},new AbortController().signal);await new Promise(r=>setImmediate(r));if(close)t.wire.close();else t.change();if(!cancelled)finish();await assert.rejects(()=>pending);assert.equal(cancelled,true);}});
test('oversized and malformed replies fail without replaying a message mutation',async()=>{for(const mode of ['large','declared','json','utf8']){let calls=0,cancelled=false;const t=transport(async()=>{calls++;if(mode==='json')return new Response('{bad');if(mode==='utf8')return new Response(new Uint8Array([123,255,125]));return new Response(new ReadableStream({pull(c){c.enqueue(new Uint8Array(1048577));},cancel(){cancelled=true;}}),mode==='declared'?{headers:{'content-length':'1048577'}}:{});});await assert.rejects(()=>t.wire.execute('message.send',{id:'thread1',key:'original',version:2,text:'Body',pictureIds:[]},new AbortController().signal),e=>e.code==='error'&&e.status===502);assert.equal(calls,1);if(['large','declared'].includes(mode))assert.equal(cancelled,true);t.wire.close();}});
test('HTTP deny/conflict failures retain their codes and stream cleanup checks captured scope',async()=>{for(const [status,code]of [[403,'denied'],[409,'conflict'],[400,'invalid']]){const t=transport(async()=>new Response('{}',{status}));await assert.rejects(()=>t.wire.execute('message.inbox',{},new AbortController().signal),e=>e.code===code&&e.status===status);t.wire.close();}const t=transport(async()=>{const response=Response.json({ok:true}),reader=response.body.getReader(),cancel=reader.cancel.bind(reader);reader.cancel=async()=>{await cancel();t.change();};response.body.getReader=()=>reader;return response;});await assert.rejects(()=>t.wire.execute('message.inbox',{},new AbortController().signal),e=>e.code==='denied');});
test('closing transport aborts its pending fetch without aborting the caller signal',async()=>{
 const caller=new AbortController();let requestSignal,started;
 const ready=new Promise(resolve=>started=resolve);
 const t=transport(async(_url,options)=>new Promise((_resolve,reject)=>{
  requestSignal=options.signal;requestSignal.addEventListener('abort',()=>reject(Error('fixture aborted')),{once:true});started();
 }));
 const pending=t.wire.execute('message.inbox',{},caller.signal);
 // Attach rejection handling before closing, without blocking on an unresponsive fixture.
 const failure=assert.rejects(pending);
 await ready;t.wire.close();
 try{assert.equal(requestSignal.aborted,true);assert.equal(caller.signal.aborted,false);}finally{caller.abort();await failure;}
});
test('transport lifetimes remain independent when callers share an abort signal',async()=>{
 const caller=new AbortController(),signals=[];
 const a=transport(async(_url,options)=>{signals.push(options.signal);return Response.json({ok:true});});
 const b=transport(async(_url,options)=>{signals.push(options.signal);return Response.json({ok:true});});
 await a.wire.execute('message.inbox',{},caller.signal);await b.wire.execute('message.inbox',{},caller.signal);
 a.wire.close();
 try{assert.equal(signals[0].aborted,true);assert.equal(signals[1].aborted,false);assert.equal(caller.signal.aborted,false);assert.deepEqual(await b.wire.execute('message.inbox',{},caller.signal),{ok:true});}finally{a.wire.close();b.wire.close();}
});
test('caller cancellation still aborts the pending request in its transport lifetime',async()=>{
 const caller=new AbortController();let requestSignal;
 const t=transport(async(_url,options)=>new Promise((_resolve,reject)=>{
  requestSignal=options.signal;requestSignal.addEventListener('abort',()=>reject(Error('fixture caller abort')),{once:true});
 }));
 const pending=t.wire.execute('message.inbox',{},caller.signal),failure=assert.rejects(pending);
 caller.abort();await failure;assert.equal(requestSignal.aborted,true);t.wire.close();
});
for(const mode of ['caller abort','transport close'])test('stalled message response releases its reader on '+mode+' without replay',async()=>{
 const caller=new AbortController();let source,cancelled=0,calls=0,captured;
 const t=transport(async(_url,options)=>{calls++;captured=JSON.parse(options.body);return new Response(new ReadableStream({start(controller){source=controller;},cancel(){cancelled++;}}));});
 const pending=t.wire.execute('message.send',{id:'thread1',key:'original-receipt',version:2,text:'Body',pictureIds:[]},caller.signal).then(value=>({value}),error=>({error}));
 await new Promise(resolve=>setImmediate(resolve));
 if(mode==='caller abort')caller.abort();else t.wire.close();
 let timer;const stalled=Symbol('stalled'),result=await Promise.race([pending,new Promise(resolve=>{timer=setTimeout(()=>resolve(stalled),100);})]);clearTimeout(timer);
 try{
  assert.notEqual(result,stalled,'retiring a stalled response must settle before another byte arrives');
  assert.ok(result.error);if(mode==='caller abort')assert.equal(result.error.code,'unavailable');
  assert.equal(cancelled,1);assert.equal(calls,1);assert.equal(captured.key,'original-receipt');
  assert.equal(caller.signal.aborted,mode==='caller abort');
 }finally{
  if(result===stalled){source.enqueue(new TextEncoder().encode('{}'));await pending;}
  t.wire.close();
 }
});

for(const operation of ['message.inbox','message.send'])for(const change of ['token','tenantId','userId','role','dataset','invalid','abort','current'])test(operation+' rejected dispatch rechecks '+change+' without replay',async()=>{
 const caller=new AbortController(),original=Error('offline');let rejectFetch,calls=0,captured;
 const value=operation==='message.inbox'?{limit:100}:{id:'thread1',key:'original-receipt',version:2,text:'Body',pictureIds:[]};
 const t=transport((url,options)=>{calls++;captured={url:String(url),options};return new Promise((_,reject)=>rejectFetch=reject);});
 const pending=t.wire.execute(operation,value,caller.signal);
 if(change==='abort')caller.abort();else if(change==='token')t.change();else if(change==='invalid')t.change({token:'captured',scope:null});else if(change!=='current')t.change({token:'captured',scope:{...scope,[change]:change==='dataset'?'demo':'other'}});
 rejectFetch(original);
 try{
  await assert.rejects(()=>pending,error=>change==='current'?error===original:change==='abort'?error.code==='unavailable':error.code==='denied'&&error.status===401);
  assert.equal(calls,1);assert.equal(captured.options.signal.aborted,change==='abort');assert.equal(captured.options.headers.authorization,'Bearer captured');
  assert.equal(captured.options.redirect,'error');assert.equal(captured.options.cache,'no-store');assert.equal(caller.signal.aborted,change==='abort');
  assert.equal(new URL(captured.url).pathname,operation==='message.inbox'?'/v1/messages/inbox':'/v1/messages');
  if(operation==='message.send')assert.deepEqual(JSON.parse(captured.options.body),{...value,action:'send'});else assert.equal(captured.options.body,undefined);
 }finally{t.wire.close();}
});
