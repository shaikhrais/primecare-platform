import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
import {resolve} from 'node:path';
const source=await readFile(process.env.LOOK_REVIEW_SOURCE??'websites/typescript/src/look-review.ts','utf8');
const {outputFiles}=await build({stdin:{contents:source,loader:'ts',resolveDir:resolve('websites/typescript/src')},bundle:true,write:false,platform:'node',format:'esm'});
const {LookReviewClient}=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));
const token='synthetic-session',gateway='https://gateway.invalid';
const deferred=()=>{let resolve,reject;const promise=new Promise((yes,no)=>{resolve=yes;reject=no;});return {promise,resolve,reject};};
function setup(t){
 const values=new Map([['primecare_session',token]]),redirects=[];
 t.mock.method(globalThis,'fetch',async()=>Response.json({ok:true}));
 for(const [name,value] of Object.entries({sessionStorage:{getItem:key=>values.get(key)??null,removeItem:key=>values.delete(key)},location:{assign:path=>redirects.push(path)}})){
  const descriptor=Object.getOwnPropertyDescriptor(globalThis,name);Object.defineProperty(globalThis,name,{configurable:true,value});
  t.after(()=>{if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];});
 }
 return {values,redirects,client:new LookReviewClient(gateway,token)};
}
const change=(values,replacement)=>replacement===null?values.delete('primecare_session'):values.set('primecare_session',replacement);
const imageResponse=()=>new Response('synthetic PNG',{headers:{'content-type':'image/png'}});

test('review transport preserves endpoints, credentials, no-store and image bytes',async t=>{
 const {client}=setup(t);await client.request('/reviews','POST',{image:'synthetic'});
 fetch.mock.mockImplementation(async()=>imageResponse());assert.equal(await(await client.image('review-a')).text(),'synthetic PNG');
 const [json,image]=fetch.mock.calls.map(call=>call.arguments);
 assert.match(json[0],/\/reviews$/);assert.match(image[0],/\/reviews\/review-a\/image$/);
 assert.deepEqual(JSON.parse(json[1].body),{image:'synthetic'});assert.ok(json[1].headers['idempotency-key']);
 for(const [,options]of [json,image]){assert.equal(options.headers.authorization,'Bearer '+token);assert.equal(options.cache,'no-store');}
});

test('review operations reject an already changed account before sending',async t=>{
 const {client,values}=setup(t);values.set('primecare_session','replacement');
 await assert.rejects(client.request(),/account_changed/);await assert.rejects(client.image('review'),/account_changed/);assert.equal(fetch.mock.callCount(),0);
});

for(const method of ['request','image'])test(`${method} rejects replaced response ownership before consuming its body`,async t=>{
 const {client,values}=setup(t);let consumed=0;
 fetch.mock.mockImplementation(async()=>{values.set('primecare_session','replacement');return {ok:true,status:200,headers:new Headers({'content-type':'image/png'}),blob:async()=>{consumed++;return new Blob();},json:async()=>{consumed++;return {};}};});
 await assert.rejects(method==='image'?client.image('review'):client.request(),/account_changed/);assert.equal(consumed,0);
});

for(const method of ['request','image'])for(const phase of ['fetch','body'])for(const rejects of [false,true])for(const replacement of ['replacement',null]){
 test(`${method} ${phase} ${rejects?'failure':'success'} honors ${replacement===null?'logout':'replacement'}`,async t=>{
  const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch'){started.resolve();return pending.promise;}return {ok:true,status:200,headers:new Headers({'content-type':'image/png'}),json:()=>{started.resolve();return pending.promise;},blob:()=>{started.resolve();return pending.promise;}};});
  const rejected=assert.rejects(method==='image'?client.image('review'):client.request(),/account_changed/);
  await started.promise;change(values,replacement);
  if(rejects)pending.reject(Error('synthetic failure'));else pending.resolve(phase==='fetch'?(method==='image'?imageResponse():Response.json({private:'old'})):method==='image'?new Blob(['private']):{private:'old'});
  await rejected;assert.equal(values.get('primecare_session')??null,replacement);assert.deepEqual(redirects,[]);
 });
}

for(const rejects of [false,true])test(`review JSON 401 ${rejects?'failure':'success'} cannot sign out a replacement account`,async t=>{
 const {client,values,redirects}=setup(t),pending=deferred(),started=deferred();
 fetch.mock.mockImplementation(async()=>({status:401,ok:false,json:()=>{started.resolve();return pending.promise;}}));
 const rejected=assert.rejects(client.request(),/account_changed/);await started.promise;values.set('primecare_session','replacement');
 if(rejects)pending.reject(Error('synthetic decode failure'));else pending.resolve({error:'forbidden'});
 await rejected;assert.equal(values.get('primecare_session'),'replacement');assert.deepEqual(redirects,[]);
});

for(const rejects of [false,true])test(`review mutation digest ${rejects?'failure':'success'} cannot dispatch an old actor`,async t=>{
 const {client,values}=setup(t),pending=deferred(),started=deferred();
 t.mock.method(crypto.subtle,'digest',()=>{started.resolve();return pending.promise;});
 const rejected=assert.rejects(client.request('/reviews','POST',{image:'private'}),/account_changed/);await started.promise;values.set('primecare_session','replacement');
 if(rejects)pending.reject(Error('synthetic digest failure'));else pending.resolve(new Uint8Array(32).buffer);
 await rejected;assert.equal(fetch.mock.callCount(),0);
});

test('same-session review errors, retry identity and confirmed-success reset remain intact',async t=>{
 const {client,values,redirects}=setup(t),failure=Error('synthetic failure');let attempt=0;
 fetch.mock.mockImplementation(async()=>{attempt++;if(attempt===1)throw failure;if(attempt===2)return new Response('invalid JSON');if(attempt===3)return Response.json({error:'conflict'},{status:409});return Response.json({ok:true});});
 await assert.rejects(client.request('/reviews','POST',{image:'same'}),error=>error===failure);
 await assert.rejects(client.request('/reviews','POST',{image:'same'}));
 await assert.rejects(client.request('/reviews','POST',{image:'same'}),error=>error.message==='conflict'&&error.status===409);
 await client.request('/reviews','POST',{image:'same'});await client.request('/reviews','POST',{image:'same'});
 const keys=fetch.mock.calls.map(call=>call.arguments[1].headers['idempotency-key']);assert.equal(new Set(keys.slice(0,4)).size,1);assert.notEqual(keys[0],keys[4]);assert.equal(values.get('primecare_session'),token);assert.deepEqual(redirects,[]);
});

test('same-session review 401 preserves its existing revocation and redirect',async t=>{
 const {client,values,redirects}=setup(t);fetch.mock.mockImplementation(async()=>Response.json({error:'forbidden'},{status:401}));
 await assert.rejects(client.request(),error=>error.message==='forbidden'&&error.status===401);assert.equal(values.has('primecare_session'),false);assert.deepEqual(redirects,['/login?enable-semantics=true']);
});

test('same-session image errors retain content checks and original transport exceptions',async t=>{
 const {client}=setup(t),failure=Error('synthetic failure');
 for(const phase of ['fetch','body']){
  fetch.mock.mockImplementation(async()=>{if(phase==='fetch')throw failure;return {ok:true,headers:new Headers({'content-type':'image/png'}),blob:async()=>{throw failure;}};});
  await assert.rejects(client.image('review'),error=>error===failure);
 }
 for(const response of [new Response('denied',{status:403}),new Response('not PNG',{headers:{'content-type':'text/html'}})]){
  fetch.mock.mockImplementation(async()=>response);await assert.rejects(client.image('review'),/^Error: image_unavailable$/);
 }
});

for(const status of [200,401,403])test(`queued replacement after JSON helper cannot consume HTTP ${status} for the old actor`,async t=>{
 const {client,values,redirects}=setup(t);
 fetch.mock.mockImplementation(async()=>({status,ok:status===200,json:()=>{
  queueMicrotask(()=>queueMicrotask(()=>values.set('primecare_session','replacement')));
  return Promise.resolve(status===200?{private:'old account'}:{error:'forbidden'});
 }}));
 await assert.rejects(client.request(),/account_changed/);
 assert.equal(values.get('primecare_session'),'replacement');assert.deepEqual(redirects,[]);
});
