import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,rm} from 'node:fs/promises';
import {readFileSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {build} from 'esbuild';
const temp=await mkdtemp(join(tmpdir(),'workers-communication-runtime-'));after(()=>rm(temp,{recursive:true,force:true}));
await build({stdin:{contents:`export {WorkersCommunicationWorker} from './cloudflare/workers/src/business-tasks/workers-runtime.ts';export {PostgresCommunicationWorker} from './cloudflare/workers/src/business-tasks/runtime.ts';export {CommunicationHttpWorker} from './cloudflare/workers/src/business-tasks/http.ts';export {WorkersPrivatePictureRepository} from './packages/shared/src/communications/workers-pictures.mjs';`,resolveDir:process.cwd()},outfile:join(temp,'runtime.mjs'),bundle:true,platform:'node',format:'esm'});
const {WorkersCommunicationWorker,PostgresCommunicationWorker,CommunicationHttpWorker,WorkersPrivatePictureRepository}=await import(pathToFileURL(join(temp,'runtime.mjs')).href);
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
function fixture(){
 const calls=[];const forbidden=()=>assert.fail('Unauthorized native capability reached');
 const dependencies={businessPool:{async query(sql){calls.push('session');return {rows:[{id:'fixture',tenant_id:'tenant'}]};},async connect(){forbidden();}},governancePool:{async connect(){return {async query(sql){calls.push('governance');return {rows:sql.startsWith('SELECT manifest')?[{manifest_sha256:pin.manifestSha256}]:[]};},release(){calls.push('release');}};}},images:{info:forbidden,input:forbidden},pictureBucket:{put:forbidden,head:forbidden,get:forbidden},scanPicture:forbidden,maxPicturePixels:4096,limits:{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384},nativeEmail:{send:forbidden},sender:'sender@example.invalid',maxMailBytes:100,maxRenderedMailBytes:1000,maxRequestBytes:4096};
 return {dependencies,calls};
}
test('Workers composition inherits all channels and constructs one native bounded repository',()=>{
 const f=fixture(),worker=new WorkersCommunicationWorker(f.dependencies),core=worker.dependencies.core;
 assert.ok(worker instanceof PostgresCommunicationWorker);assert.ok(worker instanceof CommunicationHttpWorker);
 assert.deepEqual(Object.keys(core.channels).sort(),['audio','email','message','picture']);
 const service=core.channels.message.service;assert.equal(core.channels.picture.service,service);assert.equal(core.channels.audio.service,service);
 assert.ok(service.pictures instanceof WorkersPrivatePictureRepository);assert.equal(service.pictures.maxBytes,service.limits.maxPictureBytes);assert.deepEqual(f.calls,[]);
});
test('missing capabilities, conflicting repositories and invalid bounds fail during composition',()=>{
 for(const change of [{images:null},{pictureBucket:{}},{scanPicture:undefined},{maxPicturePixels:0},{limits:{maxPictureBytes:0}},{pictures:{}},{nativeEmail:{}},{maxRequestBytes:0}]){
  const f=fixture();assert.throws(()=>new WorkersCommunicationWorker({...f.dependencies,...change}));assert.deepEqual(f.calls,[]);
 }
 assert.throws(()=>new WorkersCommunicationWorker(null));
});
test('host limit mutation cannot create divergent service and codec byte bounds',()=>{
 const f=fixture(),worker=new WorkersCommunicationWorker(f.dependencies),service=worker.dependencies.core.channels.picture.service;
 f.dependencies.limits.maxPictureBytes=1;f.dependencies.maxPicturePixels=1;
 assert.equal(service.limits.maxPictureBytes,1024);assert.equal(service.pictures.maxBytes,1024);assert.equal(service.pictures.maxPixels,4096);
});
test('inherited authentication and current grant checks precede all image, scanner and mail capabilities',async()=>{
 const f=fixture(),worker=new WorkersCommunicationWorker(f.dependencies);
 for(const [headers,status] of [[{},401],[{cookie:'session_token='+'a'.repeat(43)},401],[{authorization:'Bearer '+'a'.repeat(43),'x-tenant-id':'forged'},403],[{authorization:'Bearer '+'a'.repeat(43)},403]]){
  const response=await worker.fetch(new Request('https://fixture.invalid/v1/messages',{method:'POST',headers,body:'not JSON'}),{});assert.equal(response.status,status);
 }
 assert.ok(f.calls.includes('governance'));assert.equal(f.calls.at(-1),'release');
});
test('inherited trusted email rejects oversized streams without reading or database access',async()=>{
 const f=fixture(),worker=new WorkersCommunicationWorker(f.dependencies);let cancelled=0,reason;
 const raw=new ReadableStream({pull(){assert.fail('Oversized email read');},cancel(){cancelled++;}},{highWaterMark:0});
 await worker.email({from:'outside@example.invalid',to:'owned@example.invalid',raw,rawSize:101,setReject(value){reason=value;}},{});
 assert.equal(reason,'Message size not permitted');assert.equal(cancelled,1);assert.equal(raw.locked,false);assert.deepEqual(f.calls,[]);
});
test('native session failures remain generic unavailable responses in the derived runtime',async()=>{
 const f=fixture();f.dependencies.businessPool.query=async()=>{throw Error('private connection detail');};
 const worker=new WorkersCommunicationWorker(f.dependencies),response=await worker.fetch(new Request('https://fixture.invalid/v1/messages',{method:'POST',headers:{authorization:'Bearer '+'a'.repeat(43)},body:'{}'}),{});
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
});
