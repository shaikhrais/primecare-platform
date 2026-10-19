import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const bundle=await build({stdin:{contents:`export {BaseSessionClient} from './websites/typescript/src/infrastructure/http/base-session-client';export {CareClient,CareHttpError} from './websites/typescript/src/care/client';export {GrowthClient} from './websites/typescript/src/growth/client';`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const {BaseSessionClient,CareClient,CareHttpError,GrowthClient}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const gateway='https://gateway.invalid',token='synthetic-session';
function setup(t){
 const values=new Map([['primecare_session',token]]),redirects=[];
 t.mock.method(globalThis,'fetch',async()=>Response.json({ok:true}));
 for(const [name,value] of Object.entries({sessionStorage:{getItem:key=>values.get(key)??null,removeItem:key=>values.delete(key)},location:{assign:path=>redirects.push(path)}})){
  const descriptor=Object.getOwnPropertyDescriptor(globalThis,name);Object.defineProperty(globalThis,name,{configurable:true,value});
  t.after(()=>{if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];});
 }
 return {values,redirects};
}
const domains=[['care',CareClient,(c,path,body)=>c.request(path,body)],['growth',GrowthClient,(c,path,body)=>c.request(path,body===undefined?'GET':'POST',body)]];
for(const [name,Client,request] of domains){
 test(`${name} preserves domain failures for non-object JSON error responses`,async t=>{
  setup(t);const c=new Client(gateway,token);
  for(const payload of [null,false,42,'unavailable',[]]){
   fetch.mock.mockImplementation(async()=>Response.json(payload,{status:502}));
   await assert.rejects(request(c,'/action',{note:'synthetic'}),e=>name==='care'?e instanceof CareHttpError&&e.status===502&&e.message==='unavailable':e.message==='error');
  }
 });
 test(`${name} inherits the common transport and preserves GET/POST payloads`,async t=>{
  setup(t);const c=new Client(gateway,token);assert.ok(c instanceof BaseSessionClient);
  await request(c,'?offset=20');await request(c,'/action',{note:'synthetic evidence'});
  const [[url,get],[postUrl,post]]=fetch.mock.calls.map(c=>c.arguments);
  assert.ok(url.startsWith(gateway+'/'));assert.ok(url.endsWith('?offset=20'));assert.equal(postUrl,url.split('?')[0]+'/action');
  assert.equal(get.method,'GET');assert.equal(get.cache,'no-store');assert.equal(get.headers.authorization,'Bearer '+token);assert.equal(get.headers['idempotency-key'],undefined);assert.equal(get.body,undefined);
  assert.equal(post.method,'POST');assert.equal(post.headers['content-type'],'application/json');assert.ok(post.headers['idempotency-key']);assert.deepEqual(JSON.parse(post.body),{note:'synthetic evidence'});
 });
 test(`${name} preserves retry keys after server/network/JSON failures and clears only after success`,async t=>{
  setup(t);const c=new Client(gateway,token),keys=[];let attempt=0;
  fetch.mock.mockImplementation(async(_url,init)=>{keys.push(init.headers['idempotency-key']);attempt++;if(attempt===1)throw Error('network');if(attempt===2)return new Response('invalid JSON');if(attempt===3)return Response.json({error:'conflict'},{status:409});return Response.json({ok:true});});
  for(let n=0;n<3;n++)await assert.rejects(request(c,'/action',{note:'same'}));
  await request(c,'/action',{note:'same'});await request(c,'/action',{note:'same'});
  assert.equal(new Set(keys.slice(0,4)).size,1);assert.notEqual(keys[4],keys[0]);
 });
 test(`${name} rejects changed accounts before sending and after response parsing`,async t=>{
  const {values}=setup(t),c=new Client(gateway,token);values.set('primecare_session','different');
  await assert.rejects(request(c,''),/account_changed/);assert.equal(fetch.mock.callCount(),0);
  values.set('primecare_session',token);fetch.mock.mockImplementation(async()=>{values.set('primecare_session','different');return Response.json({private:'synthetic'});});
  await assert.rejects(request(c,''),e=>e.message==='account_changed'&&(name!=='care'||e instanceof CareHttpError&&e.status===401));
 });
 test(`${name} keeps retry state isolated between client instances and payloads`,async t=>{
  setup(t);fetch.mock.mockImplementation(async()=>Response.json({error:'conflict'},{status:409}));
  const a=new Client(gateway,token),b=new Client(gateway,token);
  for(const [c,note] of [[a,'one'],[b,'one'],[a,'two'],[a,'one']])await assert.rejects(request(c,'/action',{note}));
  const keys=fetch.mock.calls.map(c=>c.arguments[1].headers['idempotency-key']);assert.equal(keys[0],keys[3]);assert.equal(new Set(keys.slice(0,3)).size,3);
 });
}
test('care retains typed failures without applying the growth login redirect',async t=>{
 const {redirects,values}=setup(t);fetch.mock.mockImplementation(async()=>Response.json({error:'forbidden'},{status:401}));
 await assert.rejects(new CareClient(gateway,token).request(),e=>e instanceof CareHttpError&&e.status===401&&e.message==='forbidden');assert.deepEqual(redirects,[]);assert.equal(values.get('primecare_session'),token);
});
test('growth retains uncertain delivery and its existing unauthorized redirect',async t=>{
 const {redirects,values}=setup(t);fetch.mock.mockImplementation(async()=>Response.json({state:'sending'},{status:503}));
 const c=new GrowthClient(gateway,token);await assert.rejects(c.request('/performance/email','POST',{}),/delivery_uncertain/);
 fetch.mock.mockImplementation(async()=>Response.json({error:'forbidden'},{status:401}));await assert.rejects(c.request(),/forbidden/);assert.deepEqual(redirects,['/login?enable-semantics=true']);assert.equal(values.has('primecare_session'),false);
});
test('growth report reset leaves unrelated mutation retry keys intact',async t=>{
 setup(t);fetch.mock.mockImplementation(async()=>Response.json({state:'unknown'},{status:503}));const c=new GrowthClient(gateway,token);
 for(const path of ['/performance/email','/other'])await assert.rejects(c.request(path,'POST',{}));c.resetReportRetry();
 for(const path of ['/performance/email','/other'])await assert.rejects(c.request(path,'POST',{}));
 const keys=fetch.mock.calls.map(c=>c.arguments[1].headers['idempotency-key']);assert.notEqual(keys[0],keys[2]);assert.equal(keys[1],keys[3]);
});
test('growth PDF reads retain content validation and session boundaries',async t=>{
 const {values}=setup(t),c=new GrowthClient(gateway,token);fetch.mock.mockImplementation(async()=>new Response('synthetic PDF',{headers:{'content-type':'application/pdf'}}));assert.equal(await (await c.blob('/report')).text(),'synthetic PDF');
 fetch.mock.mockImplementation(async()=>new Response('wrong',{headers:{'content-type':'text/html'}}));await assert.rejects(c.blob('/report'),/unavailable/);
 fetch.mock.mockImplementation(async()=>{values.set('primecare_session','different');return new Response('synthetic PDF',{headers:{'content-type':'application/pdf'}});});await assert.rejects(c.blob('/report'),/account_changed/);
});
