import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {readFileSync,mkdirSync,writeFileSync} from 'node:fs';
import {chromium} from 'playwright';

test('compiled Dart adapter loads the shared media asset and two Chromium peers exchange real audio',async()=>{
 const js=readFileSync(process.env.COMMUNICATION_DART_BROWSER_BUNDLE??'test-results/communication-dart-browser.js');
 const media=readFileSync('packages/flutter_core/assets/communications/audio-bridge.js');
 const server=createServer((request,response)=>{
  response.setHeader('Content-Type',request.url.includes('.js')?'text/javascript':'text/html');
  if(request.url==='/fixture.js')return response.end(js);
  if(request.url==='/assets/packages/flutter_core/assets/communications/audio-bridge.js')return response.end(media);
  response.end('<!doctype html><base href="/"><title>Compiled Dart media acceptance</title><script src="/fixture.js" defer></script>');
 });
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));let browser;
 try{
  browser=await chromium.launch({executablePath:process.env.BUSINESS_TEST_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage','--use-fake-device-for-media-stream','--use-fake-ui-for-media-stream','--allow-loopback-in-peer-connection','--disable-features=WebRtcHideLocalIpsWithMdns']});
  const page=await browser.newPage();
  await page.addInitScript(()=>{
   window.actualPeers=[];window.actualStreams=[];
   const NativePeer=window.RTCPeerConnection;
   window.RTCPeerConnection=class extends NativePeer {constructor(configuration){super(configuration);window.actualPeers.push(this);}};
   const get=navigator.mediaDevices.getUserMedia.bind(navigator.mediaDevices);
   navigator.mediaDevices.getUserMedia=async constraints=>{const stream=await get(constraints);window.actualStreams.push(stream);return stream;};
  });
  await page.goto('http://127.0.0.1:'+server.address().port+'/?enable-semantics=true');
  await page.waitForFunction(()=>!!window.primecareFlutterAudio);
  assert.equal(await page.evaluate(()=>window.primecareFlutterAudio.start()),true);
  await page.waitForFunction(async()=>{
   if(window.actualPeers.length!==2)return false;
   const counts=await Promise.all(window.actualPeers.map(async peer=>[...((await peer.getStats()).values())].filter(r=>r.type==='inbound-rtp'&&r.kind==='audio').reduce((n,r)=>n+(r.packetsReceived??0),0)));
   return counts.every(n=>n>0);
  },null,{timeout:25000});
  const evidence=await page.evaluate(async()=>{
   const counts=await Promise.all(window.actualPeers.map(async peer=>[...((await peer.getStats()).values())].filter(r=>r.type==='inbound-rtp'&&r.kind==='audio').reduce((n,r)=>n+(r.packetsReceived??0),0)));
   window.primecareFlutterAudio.mute(true);const muted=window.actualStreams[0].getAudioTracks().every(t=>!t.enabled);
   window.primecareFlutterAudio.mute(false);const unmuted=window.actualStreams[0].getAudioTracks().every(t=>t.enabled);
   window.primecareFlutterAudio.close();
   return {packets:counts,muted,unmuted,tracksStopped:window.actualStreams.every(s=>s.getTracks().every(t=>t.readyState==='ended')),peersClosed:window.actualPeers.every(p=>p.connectionState==='closed'),audioElementsRemoved:document.querySelectorAll('audio').length===0};
  });
  assert.equal(evidence.muted,true);assert.equal(evidence.unmuted,true);assert.equal(evidence.tracksStopped,true);assert.equal(evidence.peersClosed,true);assert.equal(evidence.audioElementsRemoved,true);
  mkdirSync('test-results/communication-flutter-browser',{recursive:true});writeFileSync('test-results/communication-flutter-browser/compiled-dart-audio.json',JSON.stringify({syntheticTransport:true,productUi:false,browser:browser.version(),...evidence},null,2));
 }finally{await browser?.close();await new Promise(resolve=>server.close(resolve));}
});
