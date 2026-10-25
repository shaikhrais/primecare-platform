import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
class NativePeerFixture extends EventTarget{
 iceGatheringState='new';signalingState='stable';localDescription=null;
 async setLocalDescription(description){this.localDescription=description;this.iceGatheringState='gathering';}
 close(){this.signalingState='closed';}
}
globalThis.RTCPeerConnection=NativePeerFixture;
const built=await build({entryPoints:['websites/typescript/src/infrastructure/webrtc/batched-peer.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {BatchedIcePeerConnection}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
test('complete ICE is included before SDP is returned while individual candidates stay local',async()=>{
 const peer=new BatchedIcePeerConnection({}),description={type:'offer',sdp:'pending'};let completed=false,trickled=false;
 peer.addEventListener('icecandidate',()=>{trickled=true;});const pending=peer.setLocalDescription(description).then(()=>{completed=true;});
 await new Promise(r=>setImmediate(r));assert.equal(completed,false);peer.dispatchEvent(new Event('icecandidate'));assert.equal(trickled,false);
 peer.localDescription={type:'offer',sdp:'gathered-candidates'};peer.iceGatheringState='complete';peer.dispatchEvent(new Event('icegatheringstatechange'));await pending;assert.equal(peer.localDescription.sdp,'gathered-candidates');peer.close();
});
test('closing a pending peer cancels ICE gathering immediately',async()=>{const peer=new BatchedIcePeerConnection({});const pending=peer.setLocalDescription({type:'answer',sdp:'pending'});await new Promise(r=>setImmediate(r));peer.close();await assert.rejects(pending,/Peer closed/);assert.equal(peer.signalingState,'closed');});
test('stalled gathering fails within its configured bound',async()=>{const peer=new BatchedIcePeerConnection({},100);try{await assert.rejects(peer.setLocalDescription({type:'offer',sdp:'pending'}),/timed out/);}finally{peer.close();}});
