import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const bundle=await build({entryPoints:['websites/typescript/src/growth/client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {GrowthClient}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const token='synthetic-session',gateway='https://gateway.invalid';
function setup(t){
 const values=new Map([['primecare_session',token]]),redirects=[];
 t.mock.method(globalThis,'fetch',async()=>new Response('synthetic PDF',{headers:{'content-type':'application/pdf'}}));
 for(const [name,value] of Object.entries({sessionStorage:{getItem:key=>values.get(key)??null,removeItem:key=>values.delete(key)},location:{assign:path=>redirects.push(path)}})){
  const descriptor=Object.getOwnPropertyDescriptor(globalThis,name);Object.defineProperty(globalThis,name,{configurable:true,value});
  t.after(()=>{if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];});
 }
 return {values,redirects,client:new GrowthClient(gateway,token)};
}
const deferred=()=>{let resolve,reject;const promise=new Promise((yes,no)=>{resolve=yes;reject=no;});return {promise,resolve,reject};};
const change=(values,replacement)=>replacement===null?values.delete('primecare_session'):values.set('primecare_session',replacement);

test('binary requests preserve their endpoint, authentication, cache and PDF payload',async t=>{
 const {client}=setup(t),pdf=new Blob(['synthetic PDF'],{type:'application/pdf'});
 fetch.mock.mockImplementation(async()=>({ok:true,status:200,headers:new Headers({'content-type':'application/pdf; charset=binary'}),blob:async()=>pdf}));
 assert.equal(await client.blob('/performance/pdf?period=month'),pdf);
 const [url,init]=fetch.mock.calls[0].arguments;
 assert.equal(url,gateway+'/v1/governance/growth/performance/pdf?period=month');
 assert.equal(init.cache,'no-store');assert.equal(init.headers.authorization,'Bearer '+token);
});

test('binary requests reject changed accounts before sending or reading a response body',async t=>{
 const {client,values,redirects}=setup(t);values.set('primecare_session','replacement');
 await assert.rejects(client.blob('/performance/pdf'),/account_changed/);assert.equal(fetch.mock.callCount(),0);
 values.set('primecare_session',token);let bodyReads=0;
 fetch.mock.mockImplementation(async()=>{values.set('primecare_session','replacement');return {blob:async()=>{bodyReads++;return new Blob(['private']);}};});
 await assert.rejects(client.blob('/performance/pdf'),/account_changed/);
 assert.equal(bodyReads,0);assert.deepEqual(redirects,[]);
});

for(const phase of ['fetch','body'])for(const replacement of ['replacement',null]){
 test(`binary ${phase} rejection honors ${replacement===null?'logout':'account replacement'}`,async t=>{
  const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>{
   if(phase==='fetch'){started.resolve();return pending.promise;}
   return {blob:()=>{started.resolve();return pending.promise;}};
  });
  const rejected=assert.rejects(client.blob('/performance/pdf'),/account_changed/);
  await started.promise;change(values,replacement);pending.reject(Error('synthetic stream failure'));await rejected;
  assert.equal(values.get('primecare_session')??null,replacement);assert.deepEqual(redirects,[]);
 });
}

for(const replacement of ['replacement',null]){
 test(`successful binary body cannot cross ${replacement===null?'logout':'account replacement'}`,async t=>{
  const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>({ok:true,status:200,headers:new Headers({'content-type':'application/pdf'}),blob:()=>{started.resolve();return pending.promise;}}));
  const rejected=assert.rejects(client.blob('/performance/pdf'),/account_changed/);
  await started.promise;change(values,replacement);pending.resolve(new Blob(['private']));await rejected;
  assert.equal(values.get('primecare_session')??null,replacement);assert.deepEqual(redirects,[]);
 });
}

for(const status of [401,403])for(const rejects of [false,true])for(const replacement of ['replacement',null]){
 test(`binary HTTP ${status} ${rejects?'failed':'successful'} error decoding honors ${replacement===null?'logout':'account replacement'}`,async t=>{
  const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>({ok:false,status,blob:async()=>({text:()=>{started.resolve();return pending.promise;}})}));
  const rejected=assert.rejects(client.blob('/performance/pdf'),/account_changed/);
  await started.promise;change(values,replacement);
  if(rejects)pending.reject(Error('synthetic decode failure'));else pending.resolve('{"error":"private diagnostic"}');
  await rejected;assert.equal(values.get('primecare_session')??null,replacement);assert.deepEqual(redirects,[]);
 });
}

for(const phase of ['fetch','body']){
 test(`same-account binary ${phase} errors retain their exact identity`,async t=>{
  const {client,values,redirects}=setup(t),failure=Error('synthetic failure');
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch')throw failure;return {blob:async()=>{throw failure;}};});
  await assert.rejects(client.blob('/performance/pdf'),error=>error===failure);
  assert.equal(values.get('primecare_session'),token);assert.deepEqual(redirects,[]);
 });
}

for(const status of [401,403,503]){
 test(`same-account binary HTTP ${status} retains its error and existing login policy`,async t=>{
  const {client,values,redirects}=setup(t);
  fetch.mock.mockImplementation(async()=>Response.json({error:'registered_failure'},{status}));
  await assert.rejects(client.blob('/performance/pdf'),/^Error: registered_failure$/);
  assert.equal(values.get('primecare_session'),status===401?undefined:token);
  assert.deepEqual(redirects,status===401?['/login?enable-semantics=true']:[]);
 });
}

for(const status of [401,503])for(const body of ['malformed','rejected','null']){
 test(`same-account binary HTTP ${status} ${body} error body retains unavailable fallback`,async t=>{
  const {client,values,redirects}=setup(t);
  fetch.mock.mockImplementation(async()=>({ok:false,status,blob:async()=>({text:async()=>{if(body==='rejected')throw Error('synthetic');return body==='null'?'null':'not JSON';}})}));
  await assert.rejects(client.blob('/performance/pdf'),/^Error: unavailable$/);
  assert.equal(values.get('primecare_session'),status===401?undefined:token);
  assert.deepEqual(redirects,status===401?['/login?enable-semantics=true']:[]);
 });
}

test('same-account binary response still rejects a non-PDF content type',async t=>{
 const {client,values,redirects}=setup(t);fetch.mock.mockImplementation(async()=>new Response('<html>wrong</html>',{headers:{'content-type':'text/html'}}));
 await assert.rejects(client.blob('/performance/pdf'),/unavailable/);
 assert.equal(values.get('primecare_session'),token);assert.deepEqual(redirects,[]);
});
