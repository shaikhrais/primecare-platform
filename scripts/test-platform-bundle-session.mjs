import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const importBundle=async options=>{
 const result=await build({...options,bundle:true,write:false,platform:'node',format:'esm'});
 return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
};
const {BundleClient}=await importBundle({entryPoints:['websites/typescript/src/platform-bundle/client.ts']});
const token='synthetic-session',gateway='https://gateway.invalid';
const deferred=()=>{let resolve,reject;const promise=new Promise((yes,no)=>{resolve=yes;reject=no;});return {promise,resolve,reject};};
function setup(t){
 const values=new Map([['primecare_session',token]]),redirects=[],downloads=[],objects=[],revoked=[],timers=[];
 t.mock.method(globalThis,'fetch',async()=>Response.json({ok:true}));
 t.mock.method(URL,'createObjectURL',blob=>{objects.push(blob);return 'blob:synthetic';});
 t.mock.method(URL,'revokeObjectURL',url=>revoked.push(url));
 t.mock.method(globalThis,'setTimeout',(work,delay)=>{timers.push({work,delay});return 1;});
 for(const [name,value] of Object.entries({sessionStorage:{getItem:key=>values.get(key)??null,removeItem:key=>values.delete(key)},location:{assign:path=>redirects.push(path)},document:{activeElement:null,createElement:()=>({click(){downloads.push({href:this.href,download:this.download});}})}})){
  const descriptor=Object.getOwnPropertyDescriptor(globalThis,name);Object.defineProperty(globalThis,name,{configurable:true,value});
  t.after(()=>{if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];});
 }
 return {values,redirects,downloads,objects,revoked,timers,client:new BundleClient(gateway,token)};
}
const change=(values,replacement)=>replacement===null?values.delete('primecare_session'):values.set('primecare_session',replacement);

test('bundle download retains endpoint, bearer, no-store, filename and object URL cleanup',async t=>{
 const {client,downloads,objects,revoked,timers}=setup(t),blob=new Blob(['synthetic PDF']);
 fetch.mock.mockImplementation(async()=>({ok:true,blob:async()=>blob}));
 await client.download('tenant-a','document-a','report.pdf');
 const [url,options]=fetch.mock.calls[0].arguments;
 assert.match(url,/\/tenants\/tenant-a\/documents\/document-a\/download$/);assert.equal(options.headers.authorization,'Bearer '+token);assert.equal(options.cache,'no-store');
 assert.deepEqual(objects,[blob]);assert.deepEqual(downloads,[{href:'blob:synthetic',download:'report.pdf'}]);assert.equal(timers[0].delay,1000);timers[0].work();assert.deepEqual(revoked,['blob:synthetic']);
});

test('bundle download rejects an already changed account without sending',async t=>{
 const {client,values,objects,downloads}=setup(t);values.set('primecare_session','replacement');
 await assert.rejects(client.download('tenant','doc','report.pdf'),/account_changed/);
 assert.equal(fetch.mock.callCount(),0);assert.deepEqual(objects,[]);assert.deepEqual(downloads,[]);
});

test('bundle download rejects changed response ownership before consuming its body',async t=>{
 const {client,values}=setup(t);let reads=0;
 fetch.mock.mockImplementation(async()=>{values.set('primecare_session','replacement');return {ok:true,blob:async()=>{reads++;return new Blob();}};});
 await assert.rejects(client.download('tenant','doc','report.pdf'),/account_changed/);assert.equal(reads,0);
});

for(const phase of ['fetch','body'])for(const reject of [false,true])for(const replacement of ['replacement',null]){
 test(`bundle ${phase} ${reject?'failure':'success'} cannot download across ${replacement===null?'logout':'replacement'}`,async t=>{
  const {client,values,redirects,objects,downloads}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch'){started.resolve();return pending.promise;}return {ok:true,blob:()=>{started.resolve();return pending.promise;}};});
  const rejected=assert.rejects(client.download('tenant','doc','report.pdf'),/account_changed/);
  await started.promise;change(values,replacement);
  if(reject)pending.reject(Error('synthetic failure'));else pending.resolve(phase==='body'?new Blob(['private']):new Response('private'));
  await rejected;assert.deepEqual(objects,[]);assert.deepEqual(downloads,[]);assert.deepEqual(redirects,[]);assert.equal(values.get('primecare_session')??null,replacement);
 });
}

test('bundle same-account binary failures retain their identity and never create a download',async t=>{
 const {client,objects,downloads}=setup(t),failure=Error('synthetic failure');
 for(const phase of ['fetch','body']){
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch')throw failure;return {ok:true,blob:async()=>{throw failure;}};});
  await assert.rejects(client.download('tenant','doc','report.pdf'),error=>error===failure);
 }
 fetch.mock.mockImplementation(async()=>new Response('denied',{status:403}));
 await assert.rejects(client.download('tenant','doc','report.pdf'),/^Error: failed$/);
 assert.deepEqual(objects,[]);assert.deepEqual(downloads,[]);
});

test('bundle JSON operations preserve request identity, server errors and normal unauthorized redirect',async t=>{
 const {client,values,redirects}=setup(t);let attempt=0;
 fetch.mock.mockImplementation(async()=>{attempt++;if(attempt===1)throw Error('network');return Response.json({ok:true});});
 await assert.rejects(client.send('/fixture',{note:'same'}),/network/);await client.send('/fixture',{note:'same'});await client.send('/fixture',{note:'same'});
 const calls=fetch.mock.calls.map(c=>c.arguments[1]);assert.equal(calls[0].headers['idempotency-key'],calls[1].headers['idempotency-key']);assert.notEqual(calls[1].headers['idempotency-key'],calls[2].headers['idempotency-key']);assert.equal(calls[0].method,'POST');assert.deepEqual(JSON.parse(calls[0].body),{note:'same'});
 fetch.mock.mockImplementation(async()=>Response.json({error:'forbidden'},{status:401}));
 await assert.rejects(client.send('/fixture'),/^Error: forbidden$/);assert.equal(values.has('primecare_session'),false);assert.deepEqual(redirects,['/login']);
});

test('bundle JSON rejects stale identity before sending and after asynchronous digest',async t=>{
 const {client,values}=setup(t);values.set('primecare_session','replacement');
 await assert.rejects(client.send('/fixture'),/account_changed/);assert.equal(fetch.mock.callCount(),0);
 values.set('primecare_session',token);const pending=deferred(),started=deferred();
 t.mock.method(crypto.subtle,'digest',()=>{started.resolve();return pending.promise;});
 const rejected=assert.rejects(client.send('/fixture',{note:'private'}),/account_changed/);
 await started.promise;values.set('primecare_session','replacement');pending.resolve(new Uint8Array(32).buffer);await rejected;assert.equal(fetch.mock.callCount(),0);
});

test('bundle JSON malformed unauthorized responses retain matching-session sign-out behavior',async t=>{
 const {client,values,redirects}=setup(t),failure=Error('invalid response body');
 fetch.mock.mockImplementation(async()=>({status:401,ok:false,json:async()=>{throw failure;}}));
 await assert.rejects(client.send('/fixture'),error=>error===failure);
 assert.equal(values.has('primecare_session'),false);assert.deepEqual(redirects,['/login']);
});

for(const phase of ['fetch','json'])for(const reject of [false,true]){
 test(`bundle JSON ${phase} ${reject?'failure':'success'} cannot clear a replacement session`,async t=>{
  const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch'){started.resolve();return pending.promise;}return {status:403,ok:false,json:()=>{started.resolve();return pending.promise;}};});
  const rejected=assert.rejects(client.send('/fixture'),/account_changed/);
  await started.promise;values.set('primecare_session','replacement');
  if(reject)pending.reject(Error('synthetic failure'));else pending.resolve(phase==='json'?{error:'forbidden'}:Response.json({error:'forbidden'},{status:401}));
  await rejected;assert.equal(values.get('primecare_session'),'replacement');assert.deepEqual(redirects,[]);
 });
}

test('bundle current 401 revokes immediately but its pending body cannot affect a later login',async t=>{
 const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
 fetch.mock.mockImplementation(async()=>({status:401,ok:false,json:()=>{started.resolve();return pending.promise;}}));
 const rejected=assert.rejects(client.send('/fixture'),/account_changed/);
 await started.promise;assert.equal(values.has('primecare_session'),false);assert.deepEqual(redirects,['/login']);
 values.set('primecare_session','replacement');pending.resolve({error:'forbidden'});await rejected;
 assert.equal(values.get('primecare_session'),'replacement');assert.deepEqual(redirects,['/login']);
});

const fixtures={
 './panel':`export const bundlePanel=(data)=>data?'private:'+JSON.stringify(data):'';`,
 './attention-panel':`export const attentionPanel=()=>'';`,
 './history-controller':`export class BundleHistoryController {reset(){globalThis.__historyResets++;}markup(){return '';}bind(){}}`,
 '../form-draft':`export class FormDraft {capture(){}restore(){}}`,
 '../focus':`export const focusInWorkspace=()=>{};`,
};
const {BundleController}=await importBundle({entryPoints:['websites/typescript/src/platform-bundle/controller.ts'],plugins:[{name:'bundle-view-fixtures',setup(builder){
 builder.onResolve({filter:/.*/},args=>args.importer.replaceAll('\\', '/').endsWith('/platform-bundle/controller.ts')&&fixtures[args.path]?{path:args.path,namespace:'fixture'}:null);
 builder.onLoad({filter:/.*/,namespace:'fixture'},args=>({contents:fixtures[args.path],loader:'js'}));
}}]});
class Root {
 html='';button={};contains(){return false;}
 set innerHTML(value){this.html=value;this.button={disabled:false};}get innerHTML(){return this.html;}
 replaceChildren(){this.html='';this.button={};}querySelectorAll(){return [];}
 querySelector(selector){return selector==='[data-cy="bundle-download-document-a"]'?this.button:null;}
}
async function mounted(t){
 const state=setup(t);globalThis.__historyResets=0;
 fetch.mock.mockImplementation(async()=>Response.json({tenantId:'tenant-a',documents:[{id:'document-a',filename:'private.pdf'}]}));
 const controller=new BundleController(gateway,token),root=new Root();await controller.load();controller.mount(root,'en');assert.match(root.innerHTML,/private.pdf/);
 return {...state,controller,root};
}
test('bundle controller clears cached content instead of starting an old-account download',async t=>{
 const {root,values,downloads}=await mounted(t),before=fetch.mock.callCount();values.set('primecare_session','replacement');
 root.button.onclick();await new Promise(resolve=>setImmediate(resolve));
 assert.equal(fetch.mock.callCount(),before);assert.equal(root.innerHTML,'');assert.deepEqual(downloads,[]);assert.ok(globalThis.__historyResets>=2);
});
for(const reject of [false,true]){
 test(`bundle controller does not redraw old data after a pending download ${reject?'fails':'completes'} for another account`,async t=>{
  const {root,values,downloads}=await mounted(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>({ok:true,blob:()=>{started.resolve();return pending.promise;}}));
  root.button.onclick();await started.promise;values.set('primecare_session','replacement');
  if(reject)pending.reject(Error('synthetic failure'));else pending.resolve(new Blob(['private']));
  await new Promise(resolve=>setImmediate(resolve));
  assert.equal(root.innerHTML,'');assert.deepEqual(downloads,[]);assert.ok(globalThis.__historyResets>=2);
 });
}

for(const replaced of [false,true]){
 test(`bundle attention navigation ${replaced?'blocks stale':'retains matching'} account item`,async t=>{
  const {values}=setup(t),opened=[],item={key:'private-item',id:'ticket-private',destination:'support',tenant:{id:'tenant-private',name:'Private tenant'}};
  const controller=new BundleController(gateway,token,item=>opened.push(item));
  // Only the view adapter is stubbed; exercise the actual controller's bound navigation handler.
  controller.attention={items:[item]};controller.tab='attention';globalThis.__historyResets=0;
  const button={dataset:{attentionOpen:item.key}},root=new Root();root.querySelectorAll=selector=>selector==='[data-attention-open]'?[button]:[];
  controller.mount(root,'en');if(replaced)values.set('primecare_session','replacement');button.onclick();
  assert.deepEqual(opened,replaced?[]:[item]);if(replaced){assert.equal(root.innerHTML,'');assert.equal(globalThis.__historyResets,1);}
 });
}

for(const operation of ['json','download'])test(`bundle queued replacement after ${operation} helper is rejected before consumption`,async t=>{
 const {client,values,downloads,objects,redirects}=setup(t);
 const replacement=()=>queueMicrotask(()=>queueMicrotask(()=>values.set('primecare_session','replacement')));
 fetch.mock.mockImplementation(async()=>operation==='json'?{ok:true,status:200,json:()=>{replacement();return Promise.resolve({private:'old account'});}}:{ok:true,status:200,blob:()=>{replacement();return Promise.resolve(new Blob(['private']));}});
 await assert.rejects(operation==='json'?client.send('/fixture'):client.download('tenant','doc','private.pdf'),/account_changed/);
 assert.equal(values.get('primecare_session'),'replacement');assert.deepEqual(downloads,[]);assert.deepEqual(objects,[]);assert.deepEqual(redirects,[]);
});
