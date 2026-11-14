import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({stdin:{contents:`export {ApplicationSettingsPort} from './packages/shared/src/application-modules/settings-port';export {ApplicationProfilePort,applicationPreferenceTransport} from './packages/shared/src/application-modules/transport';export {dashboardPageTransport} from './websites/typescript/src/tenant-dashboard/dashboard-page-transport';`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'node',write:false});
const {ApplicationSettingsPort,ApplicationProfilePort,applicationPreferenceTransport,dashboardPageTransport}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const scope={tenantId:'tenant',userId:'user1',role:'psw',dataset:'live'},identity={status:'authenticated',tenantId:'tenant',userId:'user1',roles:'psw'},query={search:'',offset:0};
function profile(fetcher){let session={token:'captured',scope};const port=new ApplicationProfilePort('https://fixture.test','captured',scope,()=>session,{identity:'Identity'},fetcher);return {port,change:()=>{session={token:'other',scope};}};}
function delayed(){let finish,cancelled=false;const response=new Response(new ReadableStream({start(controller){finish=()=>{if(!cancelled)controller.enqueue(new TextEncoder().encode(JSON.stringify(identity)));};},cancel(){cancelled=true;}}));return {response,finish:()=>finish(),cancelled:()=>cancelled};}
test('profile owns its label snapshot across asynchronous reads',async()=>{
 let finish;const labels={identity:'Identity'},port=new ApplicationProfilePort('https://fixture.test','captured',scope,()=>({token:'captured',scope}),labels,()=>new Promise(resolve=>{finish=()=>resolve(Response.json(identity));}));
 const pending=port.read(query,new AbortController().signal);labels.identity='Changed by caller';finish();
 assert.equal((await pending).items[0].title,'Identity');port.dispose();
});
test('profile rejects invalid identity labels before dispatch, matching native validation',()=>{
 let calls=0;const fetcher=async()=>{calls++;return Response.json(identity);};
 for(const identityLabel of [undefined,null,5,'','   ','x'.repeat(501),'Identity\n','Identity\u0000','Identity\u007f']){
  assert.throws(()=>new ApplicationProfilePort('https://fixture.test','captured',scope,()=>({token:'captured',scope}),{identity:identityLabel},fetcher),e=>e.code==='invalid'&&e.status===400);
 }
 assert.equal(calls,0);
});
test('profile retains a valid maximum-length identity label',async()=>{
 const label='x'.repeat(500),port=new ApplicationProfilePort('https://fixture.test','captured',scope,()=>({token:'captured',scope}),{identity:label},async()=>Response.json(identity));
 assert.equal((await port.read(query,new AbortController().signal)).items[0].title,label);port.dispose();
});
for(const mode of ['throw','dispose'])test('profile host context '+mode+' prevents dispatch',async()=>{
 let calls=0,port;port=new ApplicationProfilePort('https://fixture.test','captured',scope,()=>{if(mode==='throw')throw Error('context unavailable');port.dispose();return{token:'captured',scope};},{identity:'Identity'},async()=>{calls++;return Response.json(identity);});
 await assert.rejects(()=>port.read(query,new AbortController().signal),e=>e.code===(mode==='throw'?'denied':'unavailable'));assert.equal(calls,0);port.dispose();
});
test('profile failed network request rechecks a throwing host context as denial',async()=>{
 let broken=false;const port=new ApplicationProfilePort('https://fixture.test','captured',scope,()=>{if(broken)throw Error('context unavailable');return{token:'captured',scope};},{identity:'Identity'},async()=>{broken=true;throw Error('offline');});
 await assert.rejects(()=>port.read(query,new AbortController().signal),e=>e.code==='denied');port.dispose();
});
test('profile rejects malformed search values before any transport dispatch',async()=>{
 let calls=0;const p=profile(async()=>{calls++;return Response.json(identity);});
 for(const search of [null,undefined,{},[],0,true])await assert.rejects(()=>p.port.read({search,offset:0},new AbortController().signal),e=>e.code==='invalid'&&e.status===400);
 assert.equal(calls,0);p.port.dispose();
});
test('profile projects registered self identity and sends no owner-selected parameters',async()=>{let captured;const {port}=profile(async(url,options)=>{captured={url:String(url),options};return Response.json(identity);});const raw=await port.read(query,new AbortController().signal);assert.equal(raw.items[0].id,'user1');assert.deepEqual(raw.items[0].actions,[]);assert.equal(captured.url,'https://fixture.test/v1/auth/me');assert.equal(captured.options.headers.authorization,'Bearer captured');await assert.rejects(()=>port.mutate(),e=>e.code==='denied');port.dispose();});
test('profile retains the original search while a caller changes its query during fetch',async()=>{
 let finish;const p=profile(()=>new Promise(resolve=>{finish=()=>resolve(Response.json(identity));})),input={search:'user1',offset:0};
 const pending=p.port.read(input,new AbortController().signal);input.search='not-the-original-search';finish();
 const result=await pending;assert.equal(result.items.length,1);assert.equal(result.items[0].id,'user1');p.port.dispose();
});
test('profile caller query mutation cannot break a pending valid read',async()=>{
 let finish;const p=profile(()=>new Promise(resolve=>{finish=()=>resolve(Response.json(identity));})),input={search:'user1',offset:0};
 const pending=p.port.read(input,new AbortController().signal);input.search={};finish();
 const result=await pending;assert.equal(result.items[0].id,'user1');p.port.dispose();
});
test('profile rejects logout while streaming and cancels the owned reader',async()=>{const delay=delayed(),p=profile(async()=>delay.response);const pending=p.port.read(query,new AbortController().signal);await new Promise(r=>setImmediate(r));p.change();delay.finish();await assert.rejects(()=>pending,e=>e.code==='denied');assert.equal(delay.cancelled(),true);});
test('profile disposal and cancellation reject pending replies',async()=>{for(const dispose of [true,false]){const delay=delayed(),p=profile(async()=>delay.response),abort=new AbortController();const pending=p.port.read(query,abort.signal);await new Promise(r=>setImmediate(r));if(dispose)p.port.dispose();else abort.abort();delay.finish();await assert.rejects(()=>pending,e=>e.code==='unavailable');assert.equal(delay.cancelled(),true);}});
test('profile bounds streamed and declared replies to the native 64 KiB limit',async()=>{for(const declared of [true,false]){let cancelled=false;const p=profile(async()=>new Response(new ReadableStream({pull(c){c.enqueue(new Uint8Array(65537));},cancel(){cancelled=true;}}),declared?{headers:{'content-length':'65537'}}:{}));await assert.rejects(()=>p.port.read(query,new AbortController().signal),e=>e.code==='error'&&e.status===502);assert.equal(cancelled,true);}});
test('profile validates pagination, search and abort before dispatch',async()=>{let calls=0;const p=profile(async()=>{calls++;return Response.json(identity);}),abort=new AbortController();abort.abort();await assert.rejects(()=>p.port.read(query,abort.signal),e=>e.code==='unavailable');for(const invalid of [{search:'',offset:1},{search:'x'.repeat(101),offset:0}])await assert.rejects(()=>p.port.read(invalid,new AbortController().signal),e=>e.code==='invalid');assert.equal(calls,0);});
test('profile malformed JSON and changed response identity never publish',async()=>{for(const response of [new Response('{bad'),Response.json({...identity,userId:'other'})]){const p=profile(async()=>response);await assert.rejects(()=>p.port.read(query,new AbortController().signal),e=>['error','denied'].includes(e.code));}});
test('dashboard rejects oversized bodies and token changes during streaming',async()=>{for(const oversized of [true,false]){let token='captured',cancelled=false;const read=dashboardPageTransport('https://fixture.test',token,'live',()=>token,async()=>new Response(new ReadableStream({pull(c){if(oversized)c.enqueue(new Uint8Array(1048577));else{token='changed';c.enqueue(new TextEncoder().encode('{}'));}},cancel(){cancelled=true;}})));await assert.rejects(()=>read(new AbortController().signal),oversized?/invalid_response/:/denied/);assert.equal(cancelled,true);}});
test('profile and dashboard retain valid replies at their exact byte limits',async()=>{const json=JSON.stringify(identity);const p=profile(async()=>new Response(json+' '.repeat(65536-Buffer.byteLength(json))));assert.equal((await p.port.read(query,new AbortController().signal)).items[0].id,'user1');const read=dashboardPageTransport('https://fixture.test','captured','live',()=> 'captured',async()=>new Response('{}'+' '.repeat(1048574)));assert.deepEqual(await read(new AbortController().signal),{});});
for(const mode of ['token-change','logout','abort'])test('dashboard failed dispatch rechecks '+mode,async()=>{
 let token='captured',reject;const caller=new AbortController(),read=dashboardPageTransport('https://fixture.test',token,'live',()=>token,()=>new Promise((_,fail)=>{reject=fail;}));
 const pending=read(caller.signal);if(mode==='abort')caller.abort();else token=mode==='logout'?null:'replacement';reject(Error('offline'));
 await assert.rejects(()=>pending,mode==='abort'?/^Error: aborted$/:/^Error: denied$/);
});
test('dashboard unchanged session preserves original network failure without retry',async()=>{
 const original=Error('offline');let calls=0;const read=dashboardPageTransport('https://fixture.test','captured','live',()=> 'captured',async()=>{calls++;throw original;});
 await assert.rejects(()=>read(new AbortController().signal),error=>error===original);assert.equal(calls,1);
});

test('settings maps rejected owned snapshot identity to denial rather than a retryable error',async()=>{const binding={scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:['1']}},port=new ApplicationSettingsPort(binding,async()=>({version:1,scope:{...scope,userId:'other'},kind:'shortcuts',resource:'navigation',revision:0,document:null}),{read:async()=>null,write:async()=>{},remove:async()=>{}},{'1':'Overview'},{shortcuts:'Shortcuts',editShortcuts:'Edit'});await assert.rejects(()=>port.read(query,new AbortController().signal),e=>e.code==='denied'&&e.status===403);port.dispose();});

for(const field of ['token','userId','tenantId','role','dataset'])test('settings failed dispatch denies changed '+field,async()=>{
 let current={token:'x'.repeat(43),scope};let reject;
 const send=applicationPreferenceTransport('https://fixture.test',current.token,scope,()=>current,()=>new Promise((_,r)=>{reject=r;}));
 const pending=send({},new AbortController().signal);
 current=field==='token'?{...current,token:'y'.repeat(43)}:{...current,scope:{...scope,[field]:field==='dataset'?'demo':'changed'}};reject(Error('offline'));
 await assert.rejects(()=>pending,e=>e.code==='scope_changed'&&e.status===403);
});
test('settings failed HTTP response rechecks identity before exposing a conflict',async()=>{
 let current={token:'x'.repeat(43),scope};
 const send=applicationPreferenceTransport('https://fixture.test',current.token,scope,()=>current,async()=>{current={...current,scope:{...scope,userId:'other'}};return Response.json({error:'revision_conflict',current:{secret:'old account'}},{status:409});});
 await assert.rejects(()=>send({},new AbortController().signal),e=>e.code==='scope_changed'&&e.status===403&&e.current===undefined);
});
test('settings unchanged identity preserves the original offline failure',async()=>{
 const current={token:'x'.repeat(43),scope},send=applicationPreferenceTransport('https://fixture.test',current.token,scope,()=>current,async()=>{throw Error('offline');});
 await assert.rejects(()=>send({},new AbortController().signal),e=>e.code==='offline'&&e.status===0);
});
for(const mode of ['logout','dispose','abort'])test('profile failed dispatch observes '+mode+' before surfacing network error',async()=>{
 let reject;const p=profile(()=>new Promise((_,r)=>{reject=r;})),abort=new AbortController();
 const pending=p.port.read(query,abort.signal);if(mode==='logout')p.change();else if(mode==='dispose')p.port.dispose();else abort.abort();reject(Error('offline'));
 await assert.rejects(()=>pending,e=>e.code===(mode==='logout'?'denied':'unavailable'));
 p.port.dispose();
});

test('settings invalidated current scope fails closed as denial',async()=>{
 let current={token:'x'.repeat(43),scope};const send=applicationPreferenceTransport('https://fixture.test',current.token,scope,()=>current,async()=>{current={...current,scope:{}};throw Error('offline');});
 await assert.rejects(()=>send({},new AbortController().signal),e=>e.code==='scope_changed'&&e.status===403);
});
test('profile unchanged identity preserves the original dispatch failure',async()=>{
 const error=Error('offline'),p=profile(async()=>{throw error;});await assert.rejects(()=>p.port.read(query,new AbortController().signal),e=>e===error);p.port.dispose();
});

test('profile disposal immediately aborts owned pending fetches without waiting for a response',async()=>{
 let transportSignal,finish;const p=profile((url,options)=>{transportSignal=options.signal;return new Promise((resolve,reject)=>{finish=()=>resolve(Response.json(identity));options.signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true});});});
 const pending=p.port.read(query,new AbortController().signal);p.port.dispose();
 const aborted=transportSignal.aborted;if(!aborted)finish();await assert.rejects(()=>pending,e=>e.code==='unavailable');assert.equal(aborted,true);p.port.dispose();
});
test('profile aborts all owned concurrent fetches and retains the caller signal',async()=>{
 const signals=[],finish=[];const p=profile((url,options)=>{signals.push(options.signal);return new Promise((resolve,reject)=>{finish.push(()=>resolve(Response.json(identity)));options.signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true});});}),caller=new AbortController();
 const first=p.port.read(query,caller.signal),second=p.port.read(query,caller.signal);p.port.dispose();const aborted=signals.map(s=>s.aborted);for(let i=0;i<signals.length;i++)if(!aborted[i])finish[i]();
 await Promise.all([assert.rejects(()=>first,e=>e.code==='unavailable'),assert.rejects(()=>second,e=>e.code==='unavailable')]);assert.deepEqual(aborted,[true,true]);assert.equal(caller.signal.aborted,false);
});
test('profile releases caller abort subscription on successful and rejected requests',async()=>{
 for(const fail of [false,true]){const caller=new AbortController(),add=caller.signal.addEventListener.bind(caller.signal),remove=caller.signal.removeEventListener.bind(caller.signal);let balance=0;
 caller.signal.addEventListener=(type,fn,options)=>{if(type==='abort')balance++;return add(type,fn,options);};caller.signal.removeEventListener=(type,fn,options)=>{if(type==='abort')balance--;return remove(type,fn,options);};
 const p=profile(async()=>{if(fail)throw Error('offline');return Response.json(identity);});if(fail)await assert.rejects(()=>p.port.read(query,caller.signal));else await p.port.read(query,caller.signal);assert.equal(balance,0);p.port.dispose();
 }
});
test('profile disposal leaves completed fetch signals retired and caller cancellation still forwards',async()=>{
 let completedSignal;const done=profile(async(url,options)=>{completedSignal=options.signal;return Response.json(identity);});await done.port.read(query,new AbortController().signal);done.port.dispose();assert.equal(completedSignal.aborted,false);
 let activeSignal;const caller=new AbortController(),p=profile((url,options)=>{activeSignal=options.signal;return new Promise((resolve,reject)=>options.signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true}));});const pending=p.port.read(query,caller.signal);caller.abort();assert.equal(activeSignal.aborted,true);await assert.rejects(()=>pending,e=>e.code==='unavailable');p.port.dispose();
});

for(const mode of ['abort','dispose'])test('profile '+mode+' releases a stalled response without another byte',async()=>{
 let source,cancelled=0,calls=0;
 const p=profile(async()=>{calls++;return calls===1?new Response(new ReadableStream({start(c){source=c;},cancel(){cancelled++;}})):Response.json(identity);}),caller=new AbortController();
 const pending=p.port.read(query,caller.signal).then(value=>({value}),error=>({error}));
 await new Promise(r=>setImmediate(r));if(mode==='dispose')p.port.dispose();else caller.abort();
 let timer;const observed=await Promise.race([pending,new Promise(r=>timer=setTimeout(()=>r(null),100))]);clearTimeout(timer);
 // Clean up the deliberately stalled old implementation before reporting a failed regression.
 if(observed===null){source.enqueue(new TextEncoder().encode(JSON.stringify(identity)));await pending;}
 assert.notEqual(observed,null,'cancellation must settle before any further response byte');
 assert.equal(observed.error?.code,'unavailable');assert.equal(cancelled,1);assert.equal(calls,1);assert.equal(caller.signal.aborted,mode==='abort');
 if(mode==='abort'){assert.equal((await p.port.read(query,new AbortController().signal)).items[0].id,'user1');assert.equal(calls,2);}p.port.dispose();
});


function settingsPort(transport){
 const binding={scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:['1']}};
 return new ApplicationSettingsPort(binding,transport,{read:async()=>null,write:async()=>{},remove:async()=>{}},{'1':'Overview'},{shortcuts:'Shortcuts',editShortcuts:'Edit'});
}
test('settings disposal aborts its owned stalled reads without aborting callers',async()=>{
 let transportSignal,release;const caller=new AbortController(),port=settingsPort((request,signal)=>{transportSignal=signal;return new Promise((resolve,reject)=>{release=()=>resolve({version:1,scope,kind:'shortcuts',resource:'navigation',revision:0,document:null});signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true});});});
 const pending=port.readItem('navigation',caller.signal).then(value=>({value}),error=>({error}));
 await new Promise(r=>setImmediate(r));port.dispose();const aborted=transportSignal.aborted;if(!aborted)release();
 const observed=await pending;assert.equal(aborted,true);assert.equal(observed.error?.code,'unavailable');assert.equal(caller.signal.aborted,false);
});
test('settings disposal aborts every concurrent owned read',async()=>{
 const signals=[],release=[];const port=settingsPort((request,signal)=>{signals.push(signal);return new Promise((resolve,reject)=>{release.push(()=>resolve({version:1,scope,kind:'shortcuts',resource:'navigation',revision:0,document:null}));signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true});});}),caller=new AbortController();
 const pending=[port.readItem('navigation',caller.signal),port.readItem('navigation',caller.signal)].map(value=>value.then(result=>({result}),error=>({error})));
 await new Promise(r=>setImmediate(r));port.dispose();const aborted=signals.map(signal=>signal.aborted);for(let i=0;i<signals.length;i++)if(!aborted[i])release[i]();
 const observed=await Promise.all(pending);assert.deepEqual(aborted,[true,true]);assert.deepEqual(observed.map(value=>value.error?.code),['unavailable','unavailable']);assert.equal(caller.signal.aborted,false);
});
test('settings caller cancellation forwards and completed read signals retire',async()=>{
 let activeSignal;const caller=new AbortController(),active=settingsPort((request,signal)=>{activeSignal=signal;return new Promise((resolve,reject)=>signal.addEventListener('abort',()=>reject(Error('aborted')),{once:true}));});
 const pending=active.readItem('navigation',caller.signal);caller.abort();assert.equal(activeSignal.aborted,true);await assert.rejects(()=>pending,error=>error.code==='unavailable');active.dispose();
 let completedSignal;const done=settingsPort(async(request,signal)=>{completedSignal=signal;return {version:1,scope,kind:'shortcuts',resource:'navigation',revision:0,document:null};});
 await done.readItem('navigation',new AbortController().signal);done.dispose();assert.equal(completedSignal.aborted,false);
});
test('settings releases caller abort subscriptions after success and failure',async()=>{
 for(const fail of [false,true]){const caller=new AbortController(),add=caller.signal.addEventListener.bind(caller.signal),remove=caller.signal.removeEventListener.bind(caller.signal);let balance=0;
  caller.signal.addEventListener=(type,fn,options)=>{if(type==='abort')balance++;return add(type,fn,options);};caller.signal.removeEventListener=(type,fn,options)=>{if(type==='abort')balance--;return remove(type,fn,options);};
  const port=settingsPort(async()=>{if(fail)throw Error('offline');return {version:1,scope,kind:'shortcuts',resource:'navigation',revision:0,document:null};});
  if(fail)await assert.rejects(()=>port.readItem('navigation',caller.signal));else await port.readItem('navigation',caller.signal);assert.equal(balance,0);port.dispose();
 }
});
