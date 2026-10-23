import {test} from 'node:test';
import assert from 'node:assert/strict';
import {PrivatePictureRepository} from '../packages/shared/src/communications/pictures.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
const actor={id:'alice',tenantId:'tenant'};
const id='12345678-1234-4234-8234-123456789abc';
const record={id,tenantId:'tenant',threadId:'thread',mediaType:'image/png',size:3,status:'clean'};
const object=(value=record,extra={})=>({customMetadata:{record:JSON.stringify(value)},httpMetadata:{contentType:'image/png'},size:3,body:new Uint8Array([1,2,3]),...extra});
const repo=bucket=>new PrivatePictureRepository({sharp:()=>assert.fail('Read does not decode'),scan:()=>assert.fail('Read does not scan'),bucket:{put:async()=>{},head:async()=>object(),get:async()=>object(),...bucket},maxPixels:100,maxBytes:10});
test('inherited private picture repository validates the downloaded object without trusting HEAD',async()=>{
 let heads=0,gets=0;const downloaded=object();
 const pictures=repo({head:async()=>{heads++;return object();},get:async()=>{gets++;return downloaded;}});
 assert.ok(pictures instanceof BoundedBinaryAdapterBase);
 assert.equal(await pictures.open(actor,id,'thread'),downloaded);assert.equal(heads,0);assert.equal(gets,1);
 assert.ok(Object.isFrozen(await pictures.get(actor,id)));assert.equal(heads,1);
});
test('a valid prior metadata check cannot authorize a replaced foreign or cross-thread body',async()=>{
 for(const replacement of [{...record,tenantId:'foreign'},{...record,threadId:'other-thread'},{...record,id:crypto.randomUUID()},{...record,status:'pending'}]){
  const pictures=repo({get:async()=>object(replacement)});
  assert.equal((await pictures.get(actor,id)).status,'clean');
  await assert.rejects(pictures.open(actor,id,'thread'),/Picture unavailable/);
 }
});
test('malformed picture metadata, sizes, types and missing bodies never reach a caller',async()=>{
 for(const downloaded of [null,object(null),object({...record,size:11}),object({...record,size:0}),object({...record,size:1.5}),object({...record,threadId:''}),object({...record,mediaType:'text/html'}),object(record,{size:4}),object(record,{size:'3'}),object(record,{httpMetadata:{contentType:'text/html'}}),object(record,{customMetadata:{record:'{broken'}}),object(record,{body:null})]){
  await assert.rejects(repo({get:async()=>downloaded}).open(actor,id,'thread'),/Picture unavailable/);
 }
});
test('rejected picture bodies are canceled and cleanup errors never replace the denial',async()=>{
 let canceled=0;
 const body=new ReadableStream({cancel(){canceled++;throw Error('PRIVATE cleanup detail');}});
 await assert.rejects(repo({get:async()=>object({...record,tenantId:'foreign'},{body})}).open(actor,id,'thread'),error=>error.message==='Picture unavailable');
 assert.equal(canceled,1);
});
test('picture IDs and conversation scope are required before downloading',async()=>{
 let gets=0;const pictures=repo({get:async()=>{gets++;return object();}});
 for(const value of ['',null,'-'.repeat(36),'../private',id+'/other'])await assert.rejects(pictures.open(actor,value,'thread'),/Picture unavailable/);
 for(const thread of ['',null,undefined])await assert.rejects(pictures.open(actor,id,thread),/Picture unavailable/);
 assert.equal(gets,0);
});
test('private picture records expose only a validated immutable projection',async()=>{
 const pictures=repo({head:async()=>object({...record,private:'SECRET',ownerId:'wrong'})});
 assert.deepEqual(await pictures.get(actor,id),record);
 for(const actor of [null,{}, {tenantId:''},{tenantId:'foreign'}])await assert.rejects(pictures.get(actor,id),/Picture unavailable/);
});
test('incomplete bucket adapters cannot silently start picture storage',()=>{
 for(const method of ['head','get','put'])assert.throws(()=>repo({[method]:null}),/Picture adapters required/);
});
