import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,mkdirSync,writeFileSync} from 'node:fs';
import {createServer} from 'node:http';
import sharp from 'sharp';
import {chromium} from 'playwright';
import {PrivatePictureRepository} from '../packages/shared/src/communications/pictures.mjs';
import {createInboundEmailHandler} from '../packages/shared/src/communications/inbound-email.mjs';

test('real raster decoding strips metadata and rejects corrupt, oversized, unscanned and foreign images',async()=>{
 const objects=new Map();
 const bucket={async put(key,body,meta){objects.set(key,{body,...meta});},async head(key){return objects.get(key);},async get(key){return objects.get(key);}};
 let scans=0,clean=true;
 const repo=new PrivatePictureRepository({sharp,bucket,scan:async()=>{scans++;return clean;},maxPixels:4096,maxBytes:65536});
 const actor={id:'fixture',tenantId:'synthetic'};
 const bytes=await sharp({create:{width:16,height:16,channels:3,background:'#445566'}}).jpeg().withMetadata().toBuffer();
 const record=await repo.prepare(actor,'thread',bytes,'image/jpeg');
 assert.equal(scans,2);assert.equal(record.mediaType,'image/png');
 const stored=await repo.open(actor,record.id);const metadata=await sharp(stored.body).metadata();
 assert.equal(metadata.exif,undefined);assert.equal(metadata.icc,undefined);assert.equal(metadata.width,16);
 await assert.rejects(repo.get({id:'other',tenantId:'foreign'},record.id),/unavailable/);
 await assert.rejects(repo.prepare(actor,'thread',new Uint8Array([137,80,78,71]),'image/png'));
 await assert.rejects(repo.prepare(actor,'thread',bytes,'image/png'),/raster/);
 const huge=await sharp({create:{width:100,height:100,channels:3,background:'white'}}).png().toBuffer();
 await assert.rejects(repo.prepare(actor,'thread',huge,'image/png'));
 clean=false;await assert.rejects(repo.prepare(actor,'thread',bytes,'image/jpeg'),/scan failed/);
 assert.equal(objects.size,1);
});
test('inbound handler bounds actual streamed bytes and propagates storage failure',async()=>{
 const received=[];const rejected=[];
 const handler=createInboundEmailHandler({async receive(message){received.push(message);}},10);
 const message=bytes=>({from:'sender@example.invalid',to:'owned@example.invalid',rawSize:bytes.length,raw:new ReadableStream({start(controller){controller.enqueue(new Uint8Array(bytes));controller.close();}}),setReject:reason=>rejected.push(reason)});
 await handler(message([1,2,3]));assert.equal(received.length,1);
 await handler(message(new Array(11).fill(1)));assert.equal(rejected.length,1);
 const lying=message([1,2,3]);lying.rawSize=2;await handler(lying);assert.equal(rejected.length,2);
 const failing=createInboundEmailHandler({async receive(){throw Error('storage unavailable');}},10);
 await assert.rejects(failing(message([1,2,3])),/storage unavailable/);
});
test('two real Chromium peers exchange audio packets, mute and release tracks',async()=>{
 const source=readFileSync('packages/shared/src/communications/audio-call.mjs');
 const base=readFileSync('packages/shared/src/communications/adapter-base.mjs');
 const server=createServer((request,response)=>{
  const module=request.url.startsWith('/audio-call.mjs')?source:request.url.startsWith('/adapter-base.mjs')?base:null;
  response.setHeader('Content-Type',module?'text/javascript':'text/html');
  response.end(module??'<!doctype html><title>Isolated audio transport test</title>');
 });
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 let browser;
 try {
  browser=await chromium.launch({...(process.env.BUSINESS_TEST_CHROMIUM_EXECUTABLE?{executablePath:process.env.BUSINESS_TEST_CHROMIUM_EXECUTABLE}:{}),args:['--no-sandbox','--disable-dev-shm-usage','--use-fake-device-for-media-stream','--use-fake-ui-for-media-stream','--allow-loopback-in-peer-connection','--disable-features=WebRtcHideLocalIpsWithMdns']});
  const page=await browser.newPage();await page.goto('http://127.0.0.1:'+server.address().port+'/?enable-semantics=true');
  await page.evaluate(async()=>{
   const {BrowserAudioCall}=await import('/audio-call.mjs');
   const errors=[];const queue=[Promise.resolve(),Promise.resolve()];const peers=[];
   const signal=recipient=>async message=>{queue[recipient]=queue[recipient].then(()=>peers[recipient].receive(message)).catch(error=>errors.push(error.message));};
   for(let index=0;index<2;index++)peers.push(new BrowserAudioCall({sendSignal:signal(1-index),getUserMedia:constraints=>navigator.mediaDevices.getUserMedia(constraints),createPeer:configuration=>new RTCPeerConnection(configuration),configuration:{iceServers:[]}}));
   await peers[0].start();await peers[1].start();await peers[0].offer();
   window.fixture={peers,errors};
  });
  let transport=[];
  const deadline=Date.now()+20000;
  do {
   transport=await page.evaluate(async()=>{
    if(window.fixture.errors.length)throw Error(window.fixture.errors.join(';'));
    const result=[];
    for(const item of window.fixture.peers){const stats=await item.peer.getStats();const packets=[...stats.values()].filter(report=>report.type==='inbound-rtp'&&report.kind==='audio').reduce((total,report)=>total+(report.packetsReceived??0),0);result.push({state:item.peer.connectionState,audioPacketsReceived:packets,signalingState:item.peer.signalingState,iceState:item.peer.iceConnectionState,gatheringState:item.peer.iceGatheringState,localType:item.peer.localDescription?.type??null,remoteType:item.peer.remoteDescription?.type??null,localAudio:!!item.peer.localDescription?.sdp.includes('m=audio'),remoteAudio:!!item.peer.remoteDescription?.sdp.includes('m=audio'),tracks:item.stream.getTracks().length});}return result;
   });
   if(transport.length===2&&transport.every(peer=>peer.audioPacketsReceived>0))break;
   await new Promise(resolve=>setTimeout(resolve,100));
  }while(Date.now()<deadline);
  assert.equal(transport.length,2);
  const result=await page.evaluate(async()=>{
   const peers=window.fixture.peers;peers[0].mute(true);const muted=peers[0].stream.getAudioTracks().every(track=>!track.enabled);
   peers[0].mute(false);const unmuted=peers[0].stream.getAudioTracks().every(track=>track.enabled);
   peers.forEach(peer=>peer.close());return {muted,unmuted,stopped:peers.every(peer=>peer.stream.getTracks().every(track=>track.readyState==='ended'))};
  });
  assert.equal(result.muted,true);assert.equal(result.unmuted,true);assert.equal(result.stopped,true);
  result.transport=transport;
  result.audioPassed=transport.every(peer=>peer.audioPacketsReceived>0);
  result.browserVersion=browser.version();
  mkdirSync('test-results/business-communications-media',{recursive:true});
  writeFileSync('test-results/business-communications-media/audio-transport-test.json',JSON.stringify({synthetic:true,productUi:false,...result},null,2));
  // This records a transport test result, not a product UI or deployed Flutter screenshot.
  await page.evaluate(result=>{
   document.body.replaceChildren();document.body.style.cssText='font:20px system-ui;padding:40px;max-width:900px;color:#172d3b';
   const heading=document.createElement('h1');heading.textContent=result.audioPassed?'Audio transport test — passed':'Audio transport test — media connection failed';document.body.append(heading);
   const note=document.createElement('p');note.textContent='Isolated Chromium peers using synthetic microphones. This is a test report, not the PrimeCare product screen.';document.body.append(note);
   const list=document.createElement('ul');
   for(const [index,peer] of result.transport.entries()){const item=document.createElement('li');item.textContent='Peer '+(index+1)+': '+peer.state+'; '+peer.audioPacketsReceived+' audio packets received';list.append(item);}
   for(const text of ['Mute: passed','Unmute: passed','Microphone tracks released: passed']){const item=document.createElement('li');item.textContent=text;list.append(item);}document.body.append(list);
   const pending=document.createElement('p');pending.textContent='Still pending: registered Flutter controls, live signaling/relay, physical devices and production acceptance.';document.body.append(pending);
  },result);
  await page.screenshot({path:'test-results/business-communications-media/audio-transport-test.png'});
  assert.equal(result.audioPassed,true,JSON.stringify(transport));
 } finally {await browser?.close();await new Promise(resolve=>server.close(resolve));}
});
