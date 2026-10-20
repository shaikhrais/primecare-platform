import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({entryPoints:['websites/typescript/src/maintenance-client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {MaintenanceClient}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
let current='original';globalThis.sessionStorage={getItem:()=>current,removeItem:()=>current=null};
for(const locale of ['en','fr','es'])for(const [method,message] of [
 ['save','Settings saved. Send a test email to check delivery.'],
 ['testEmail','Provider accepted the test. Check your inbox/spam to confirm delivery.'],
])await test(method+' requires its exact acknowledgement in '+locale,async()=>{
 const prior=globalThis.fetch,client=new MaintenanceClient('https://fixture/','original',locale),invoke=()=>method==='save'?client.save({sender:'sender@example.invalid',revision:0,templates:{}}):client.testEmail();
 try{
  for(const value of [null,[],{}, {message:null},{message:7},{message:'private server diagnostic'},{message:method==='save'?'Provider accepted the test. Check your inbox/spam to confirm delivery.':'Settings saved. Send a test email to check delivery.'}]){
   globalThis.fetch=async()=>Response.json(value);
   await assert.rejects(invoke(),error=>error.message===client.text('failed'));
  }
  globalThis.fetch=async(url,init)=>{assert.equal(url,'https://fixture/v1/auth/maintenance/configuration'+(method==='testEmail'?'/test-email':''));assert.equal(init.method,'POST');assert.equal(init.headers.authorization,'Bearer original');assert.equal(init.cache,'no-store');return Response.json({message});};
  assert.deepEqual(await invoke(),{message});
  for(const status of [400,403,409,429,503]){globalThis.fetch=async()=>Response.json({error:'private server diagnostic'},{status});await assert.rejects(invoke(),error=>error.message===client.text('failed'));assert.equal(current,'original');}
  globalThis.fetch=async()=>{throw new TypeError('private transport diagnostic');};await assert.rejects(invoke(),error=>error.message===client.text('cannotConnect'));
  globalThis.fetch=async()=>{current='replacement';return Response.json({message});};await assert.rejects(invoke(),error=>error.message===client.text('changed'));assert.equal(current,'replacement');
  let requests=0;globalThis.fetch=async()=>{requests++;return Response.json({message});};await assert.rejects(invoke(),error=>error.message===client.text('changed'));assert.equal(requests,0);
 }finally{current='original';globalThis.fetch=prior;}
});
