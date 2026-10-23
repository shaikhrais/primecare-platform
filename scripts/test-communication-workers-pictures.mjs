import {test} from 'node:test';
import assert from 'node:assert/strict';
import {crc32,deflateSync} from 'node:zlib';
import {WorkersPrivatePictureRepository,boundedStaticPng} from '../packages/shared/src/communications/workers-pictures.mjs';
import {PrivatePictureRepository,PrivatePictureRepositoryBase} from '../packages/shared/src/communications/pictures.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';

// Independent native CRC implementation; actual raster decode is tested in CI.
const png=new Uint8Array(Buffer.concat([Buffer.from([137,80,78,71,13,10,26,10]),chunk('IHDR',Buffer.from([0,0,0,1,0,0,0,1,8,2,0,0,0])),chunk('IDAT',deflateSync(Buffer.from([0,255,0,0]))),chunk('IEND',Buffer.alloc(0))]));
function chunk(type,data){const bytes=Buffer.alloc(data.length+12);bytes.writeUInt32BE(data.length);bytes.write(type,4);bytes.set(data,8);bytes.writeUInt32BE(crc32(bytes.subarray(4,-4)),bytes.length-4);return bytes;}
function insert(type,data){return new Uint8Array(Buffer.concat([png.subarray(0,33),chunk(type,data),png.subarray(33)]));}
function fixture({output=png,info,scan=async()=>true}={}){
 const objects=new Map(),options=[];
 const bucket={async put(key,body,meta){objects.set(key,{body,size:body.length,...meta});},async head(key){return objects.get(key);},async get(key){return objects.get(key);}};
 const images={async info(stream){const bytes=new Uint8Array(await new Response(stream).arrayBuffer());return info??{format:'image/png',width:1,height:1,fileSize:bytes.length};},input(){return {async output(value){options.push(value);return {response:()=>new Response(output,{headers:{'content-type':'image/png'}})};}};}};
 return {repo:new WorkersPrivatePictureRepository({images,bucket,scan,maxPixels:100,maxBytes:1024}),objects,options,images,bucket};
}
const actor={id:'alice',tenantId:'tenant'};
test('Workers and Node picture codecs inherit the same private scan/storage boundary',()=>{
 const f=fixture();assert.ok(f.repo instanceof PrivatePictureRepositoryBase);assert.ok(f.repo instanceof BoundedBinaryAdapterBase);
 const node=new PrivatePictureRepository({sharp(){},bucket:f.bucket,scan(){},maxPixels:100,maxBytes:1024});assert.ok(node instanceof PrivatePictureRepositoryBase);
});
test('Workers codec stores only bounded static PNG pixel chunks after both scans',async()=>{
 const scans=[];const f=fixture({output:insert('tEXt',Buffer.from('PRIVATE_LOCATION')),scan:async bytes=>{scans.push(Uint8Array.from(bytes));return true;}});
 const result=await f.repo.prepare(actor,'thread',png,'image/png');assert.equal(scans.length,2);assert.deepEqual(f.options,[{format:'image/png',anim:false}]);
 const stored=await f.repo.open(actor,result.id,'thread');assert.deepEqual(stored.body,png);assert.equal(result.size,png.length);assert.ok(!new TextDecoder().decode(scans[1]).includes('PRIVATE_LOCATION'));
 await assert.rejects(f.repo.open({tenantId:'foreign'},result.id,'thread'),/unavailable/);await assert.rejects(f.repo.open(actor,result.id,'other'),/unavailable/);
});
test('container validation rejects animation, CRC corruption, truncation, trailing bytes and pixel overflow',()=>{
 for(const bytes of [insert('acTL',new Uint8Array(8)),insert('fcTL',new Uint8Array(26)),insert('fdAT',new Uint8Array(4)),png.slice(0,-1),new Uint8Array([...png,0]),Uint8Array.from(png,(v,i)=>i===45?v^1:v)])assert.throws(()=>boundedStaticPng(bytes,100),/raster/);
 assert.throws(()=>boundedStaticPng(png,undefined),/raster/);
 const large=Uint8Array.from(png);const ihdr=chunk('IHDR',Buffer.from(large.subarray(16,29)));ihdr.writeUInt32BE(1000,8);ihdr.writeUInt32BE(crc32(ihdr.subarray(4,-4)),ihdr.length-4);large.set(ihdr,8);assert.throws(()=>boundedStaticPng(large,100),/raster/);
});
test('mismatched provider metadata and codec errors never store a picture',async()=>{
 for(const info of [{format:'image/svg+xml',width:1,height:1,fileSize:png.length},{format:'image/png',width:1000,height:1000,fileSize:png.length},{format:'image/png',width:0,height:1,fileSize:png.length},{format:'image/png',width:1,height:1,fileSize:png.length+1}]){
  const f=fixture({info});await assert.rejects(f.repo.prepare(actor,'thread',png,'image/png'));assert.equal(f.objects.size,0);
 }
 const f=fixture();f.images.info=async()=>{throw Error('PRIVATE provider detail');};await assert.rejects(f.repo.prepare(actor,'thread',png,'image/png'),error=>error.message==='Picture processing unavailable');assert.equal(f.objects.size,0);
});
test('scan rejection and corrupt provider output cannot reach private storage',async()=>{
 for(const badStage of [1,2]){let n=0;const f=fixture({scan:async()=>++n!==badStage});await assert.rejects(f.repo.prepare(actor,'thread',png,'image/png'),/scan failed/);assert.equal(f.objects.size,0);}
 const f=fixture({output:new Uint8Array([1,2,3])});await assert.rejects(f.repo.prepare(actor,'thread',png,'image/png'),/raster/);assert.equal(f.objects.size,0);
});
test('oversized or inconsistent output cancels the stream without writing',async()=>{
 for(const declared of [null,'0','2000','2']){
  let canceled=0;const f=fixture();f.images.input=()=>({async output(){return {response:()=>new Response(new ReadableStream({start(c){c.enqueue(new Uint8Array(1025));},cancel(){canceled++;}}),{headers:{'content-type':'image/png',...(declared===null?{}:{'content-length':declared})}})};}});
  await assert.rejects(f.repo.prepare(actor,'thread',png,'image/png'));assert.equal(canceled,1);assert.equal(f.objects.size,0);
 }
});
test('input, processed output and tenant scope are owned across suspended scanning',async()=>{
 let release,entered;const waiting=new Promise(r=>{release=r;}),ready=new Promise(r=>{entered=r;});let n=0;
 const source=Uint8Array.from(png),who={...actor};const f=fixture({scan:async bytes=>{n++;if(n===1){entered();await waiting;}bytes.fill(0);return true;}});
 const work=f.repo.prepare(who,'thread',source,'image/png');await ready;source.fill(0);who.tenantId='foreign';release();
 const result=await work;assert.equal(result.tenantId,'tenant');assert.deepEqual((await f.repo.open(actor,result.id,'thread')).body,png);
});
test('missing Images, scanner or private bucket methods fail at composition',()=>{
 const f=fixture(),base={images:f.images,bucket:f.bucket,scan:()=>true,maxPixels:100,maxBytes:1024};
 for(const extra of [{images:null},{images:{info(){}}},{scan:null},{bucket:{put(){},head(){}}}])assert.throws(()=>new WorkersPrivatePictureRepository({...base,...extra}),/adapters required/);
});
