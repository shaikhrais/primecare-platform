// Real local workerd Images + R2 bindings. Scanner decisions are synthetic;
// this is neither a live account/bucket nor remote Images/antivirus acceptance.
import assert from 'node:assert/strict';
import {mkdir,writeFile} from 'node:fs/promises';
import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
import sharp from 'sharp';
const bundle=await build({stdin:{contents:`
import {WorkersPrivatePictureRepository} from './packages/shared/src/communications/workers-pictures.mjs';
import {WorkersCommunicationWorker} from './cloudflare/workers/src/business-tasks/workers-runtime.ts';
import {PostgresCommunicationWorker} from './cloudflare/workers/src/business-tasks/runtime.ts';
import pin from './tools/governance-production/production-pin.json';
export default {async fetch(request,env){
 const url=new URL(request.url),mode=url.searchParams.get('mode');let scans=0,queries=0;
 const worker=new WorkersCommunicationWorker({businessPool:{async query(){queries++;return {rows:[{id:'fixture',tenant_id:'synthetic'}]};},async connect(){throw Error('Unexpected business query');}},governancePool:{async connect(){return {async query(sql){queries++;return {rows:sql.startsWith('SELECT manifest')?[{manifest_sha256:pin.manifestSha256}]:[]};},release(){}};}},images:env.IMAGES,pictureBucket:env.PICTURES,scanPicture:async()=>{scans++;return mode==='deny-input'?scans!==1:mode==='deny-output'?scans!==2:true;},maxPicturePixels:4096,limits:{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:65536,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384},nativeEmail:{async send(){throw Error('No live mail');}},sender:'sender@example.invalid',maxMailBytes:100,maxRenderedMailBytes:1000,maxRequestBytes:131072});
 const service=worker.dependencies.core.channels.picture.service,repo=service.pictures;
 try{
  if(mode==='composition')return Response.json({inherited:worker instanceof PostgresCommunicationWorker,native:repo instanceof WorkersPrivatePictureRepository,codecBound:repo.maxBytes,serviceBound:service.limits.maxPictureBytes});
  if(mode==='unauthenticated'||mode==='ungranted'){
   const response=await worker.fetch(new Request('https://fixture.invalid/v1/messages',{method:'POST',headers:mode==='ungranted'?{authorization:'Bearer '+'a'.repeat(43)}:{},body:'not JSON'}),env);
   return Response.json({status:response.status,scans,queries});
  }
  if(mode==='email-bounds'){
   let cancelled=0,reason;await worker.email({from:'outside@example.invalid',to:'owned@example.invalid',rawSize:101,raw:new ReadableStream({cancel(){cancelled++;}},{highWaterMark:0}),setReject(value){reason=value;}},env);
   return Response.json({cancelled,reason,queries});
  }
  if(mode==='list')return Response.json({count:(await env.PICTURES.list()).objects.length});
  if(mode==='open'||mode==='foreign'){
   const object=await repo.open({id:'fixture',tenantId:mode==='foreign'?'foreign':'synthetic'},url.searchParams.get('id'),'thread');
   return new Response(object.body,{headers:{'content-type':object.httpMetadata.contentType}});
  }
  const record=await repo.prepare({id:'fixture',tenantId:'synthetic'},'thread',new Uint8Array(await request.arrayBuffer()),request.headers.get('content-type'));
  return Response.json({record,scans});
 }catch{return Response.json({error:'unavailable'},{status:503});}
}};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',external:['node:*'],write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat'],images:{binding:'IMAGES'},r2Buckets:['PICTURES']});
const base='https://fixture.invalid/?enable-semantics=true';let checks=0;
try{
 assert.deepEqual(await (await runtime.dispatchFetch(base+'&mode=composition')).json(),{inherited:true,native:true,codecBound:65536,serviceBound:65536});checks++;
 assert.deepEqual(await (await runtime.dispatchFetch(base+'&mode=unauthenticated')).json(),{status:401,scans:0,queries:0});checks++;
 const ungranted=await (await runtime.dispatchFetch(base+'&mode=ungranted')).json();assert.equal(ungranted.status,403);assert.equal(ungranted.scans,0);assert.ok(ungranted.queries>0);checks++;
 assert.deepEqual(await (await runtime.dispatchFetch(base+'&mode=email-bounds')).json(),{cancelled:1,reason:'Message size not permitted',queries:0});checks++;
 const source=await sharp({create:{width:16,height:16,channels:3,background:'#445566'}}).jpeg().withMetadata().toBuffer();
 const upload=await runtime.dispatchFetch(base,{method:'POST',headers:{'content-type':'image/jpeg'},body:source});assert.equal(upload.status,200,await upload.clone().text());
 const result=await upload.json();assert.equal(result.scans,2);assert.equal(result.record.mediaType,'image/png');checks++;
 const opened=await runtime.dispatchFetch(base+'&mode=open&id='+result.record.id);assert.equal(opened.status,200);
 const bytes=Buffer.from(await opened.arrayBuffer()),metadata=await sharp(bytes).metadata();assert.equal(metadata.width,16);assert.equal(metadata.height,16);assert.equal(metadata.exif,undefined);assert.equal(metadata.icc,undefined);assert.equal(metadata.xmp,undefined);assert.equal(bytes.length,result.record.size);checks++;
 assert.equal((await runtime.dispatchFetch(base+'&mode=foreign&id='+result.record.id)).status,503);checks++;
 const transparent=await sharp({create:{width:16,height:16,channels:4,background:{r:20,g:80,b:120,alpha:0.5}}}).png({palette:true}).toBuffer();
 const alphaResponse=await runtime.dispatchFetch(base,{method:'POST',headers:{'content-type':'image/png'},body:transparent});assert.equal(alphaResponse.status,200,await alphaResponse.clone().text());
 const alpha=await alphaResponse.json();const alphaRead=await runtime.dispatchFetch(base+'&mode=open&id='+alpha.record.id);const alphaBytes=Buffer.from(await alphaRead.arrayBuffer());
 assert.equal((await sharp(alphaBytes).metadata()).hasAlpha,true);const raw=await sharp(alphaBytes).ensureAlpha().raw().toBuffer();assert.ok(raw[3]>=127&&raw[3]<=129);checks++;
 for(const mode of ['deny-input','deny-output']){const denied=await runtime.dispatchFetch(base+'&mode='+mode,{method:'POST',headers:{'content-type':'image/jpeg'},body:source});assert.equal(denied.status,503);checks++;}
 for(const [body,type] of [[Buffer.from('not a raster'),'image/png'],[source,'image/png']]){assert.equal((await runtime.dispatchFetch(base,{method:'POST',headers:{'content-type':type},body})).status,503);checks++;}
 assert.equal((await (await runtime.dispatchFetch(base+'&mode=list')).json()).count,2);checks++;
 await mkdir('test-results/communication-worker-pictures',{recursive:true});
 await writeFile('test-results/communication-worker-pictures/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,passed:true,checks,engine:'workerd',compatibilityFlags:['nodejs_compat'],runtimeComposition:'WorkersCommunicationWorker',bindings:['local Images','local R2'],databasePorts:'synthetic',actualRasterDecode:true,metadataStripped:true,alphaPreserved:true,scanner:'synthetic',production:false,remoteProviderVerified:false},null,2));
 console.log('WORKERD_COMMUNICATION_PICTURES_PASS '+checks);
}finally{await runtime.dispose();}
