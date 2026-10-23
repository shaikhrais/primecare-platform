import {test} from 'node:test';
import assert from 'node:assert/strict';
import {CommunicationResourceBase,BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import {BrowserAudioCall} from '../packages/shared/src/communications/audio-call.mjs';
function audioFixture() {
 const actions=[],signals=[],tracks=[new EventTarget(),new EventTarget()];let stopped=0,closed=0,delivered=0;
 for(const track of tracks){track.stop=()=>{stopped++;};track.enabled=true;}
 const peer={localDescription:null,remoteDescription:null,
  addTrack(){},close(){closed++;},
  async createOffer(){actions.push('createOffer');return {type:'offer',sdp:'fixture'};},
  async createAnswer(){actions.push('createAnswer');return {type:'answer',sdp:'fixture'};},
  async setLocalDescription(value){actions.push('setLocalDescription');this.localDescription={...value,toJSON:()=>value};},
  async setRemoteDescription(value){actions.push('setRemoteDescription');this.remoteDescription=value;},
  async addIceCandidate(){actions.push('addIceCandidate');}
 };
 const call=new BrowserAudioCall({sendSignal:async signal=>signals.push(signal),getUserMedia:async()=>({getTracks:()=>tracks,getAudioTracks:()=>tracks}),createPeer:()=>peer,configuration:{iceServers:[]},onTrack(){delivered++;}});
 return {call,peer,tracks,actions,signals,stats:()=>({stopped,closed,delivered})};
}
for(const stage of ['createOffer','setLocalDescription','setRemoteDescription','addIceCandidate','createAnswer','answerLocalDescription'])test('closed audio cannot continue negotiation after '+stage,async()=>{
 const f=audioFixture();await f.call.start();let release,entered;
 const started=new Promise(resolve=>{entered=resolve;});const pending=new Promise(resolve=>{release=resolve;});
 const method=stage==='answerLocalDescription'?'setLocalDescription':stage;
 const original=f.peer[method].bind(f.peer);
 f.peer[method]=async(...args)=>{const result=await original(...args);entered();await pending;return result;};
 if(stage==='addIceCandidate')await f.call.receive({type:'candidate',candidate:{candidate:'queued'}});
 const operation=['createOffer','setLocalDescription'].includes(stage)?f.call.offer():f.call.receive({type:'offer',description:{type:'offer',sdp:'fixture'}});
 await started;f.call.close();const before=[...f.actions];release();
 await assert.rejects(operation,/closed/);assert.deepEqual(f.actions,before);assert.deepEqual(f.signals,[]);assert.deepEqual(f.stats(),{stopped:2,closed:1,delivered:0});
});
test('unexpected microphone track ending closes every resource exactly once',async()=>{
 const f=audioFixture();await f.call.start();f.tracks[0].dispatchEvent(new Event('ended'));
 assert.equal(f.call.closed,true);assert.deepEqual(f.stats(),{stopped:2,closed:1,delivered:0});
 f.tracks[1].dispatchEvent(new Event('ended'));f.call.close();assert.equal(f.stats().stopped,2);
});
test('already ended microphone tracks fail startup without creating signaling',async()=>{
 const f=audioFixture();f.tracks[0].readyState='ended';
 await assert.rejects(f.call.start(),/Microphone ended/);assert.deepEqual(f.signals,[]);assert.deepEqual(f.stats(),{stopped:2,closed:1,delivered:0});
});
test('captured late media callbacks cannot signal or attach audio after close',async()=>{
 const f=audioFixture();await f.call.start();const candidate=f.peer.onicecandidate,track=f.peer.ontrack;
 f.call.close();candidate({candidate:{toJSON:()=>({candidate:'late'})}});track({streams:[{}]});
 await new Promise(resolve=>setImmediate(resolve));assert.deepEqual(f.signals,[]);assert.equal(f.stats().delivered,0);
});
test('synchronous candidate transport failure closes resources without an uncaught event error',async()=>{
 const f=audioFixture();await f.call.start();f.call.sendSignal=()=>{throw Error('fixture failure');};
 assert.doesNotThrow(()=>f.peer.onicecandidate({candidate:{toJSON:()=>({candidate:'fixture'})}}));
 await new Promise(resolve=>setImmediate(resolve));assert.equal(f.call.closed,true);assert.equal(f.stats().stopped,2);
});
test('resource cleanup runs once and continues after an individual cleanup failure',()=>{
 const resource=new CommunicationResourceBase();let cleaned=0;
 resource.registerCleanup(()=>{cleaned++;});resource.registerCleanup(()=>{throw Error('fixture failure');});
 assert.equal(resource.close().length,1);resource.close();assert.equal(cleaned,1);
 resource.registerCleanup(()=>{cleaned++;});assert.equal(cleaned,2);
 assert.throws(()=>resource.assertOpen(),/closed/);
});
test('call closed during microphone permission releases the late stream without creating a peer',async()=>{
 let resolve,stops=0,closed=0;
 const pending=new Promise(done=>{resolve=done;});
 const call=new BrowserAudioCall({sendSignal:async()=>{},getUserMedia:()=>pending,createPeer:()=>assert.fail('No peer after close'),configuration:{iceServers:[]},onState:state=>{if(state==='closed')closed++;}});
 assert.ok(call instanceof CommunicationResourceBase);
 const started=call.start();call.close();resolve({getTracks:()=>[{stop(){stops++;}}]});
 await assert.rejects(started,/closed/);assert.equal(stops,1);assert.equal(closed,1);
});
test('denied microphone permission closes without attempting signaling',async()=>{
 const call=new BrowserAudioCall({sendSignal:async()=>assert.fail('No signaling'),getUserMedia:async()=>{throw Error('Permission denied');},createPeer:()=>assert.fail('No peer'),configuration:{iceServers:[]}});
 await assert.rejects(call.start(),/Permission denied/);assert.equal(call.closed,true);
});
test('bad remote signaling and terminal peer failures release microphone resources',async()=>{
 let stops=0,peersClosed=0;
 const peer={connectionState:'new',addTrack(){},close(){peersClosed++;},async setRemoteDescription(){throw Error('Invalid description');}};
 const make=()=>new BrowserAudioCall({sendSignal:async()=>{},getUserMedia:async()=>({getTracks:()=>[{stop(){stops++;}}]}),createPeer:()=>peer,configuration:{iceServers:[]}});
 const badSignal=make();await badSignal.start();
 await assert.rejects(badSignal.receive({type:'answer',description:{type:'answer',sdp:'bad'}}),/Invalid description/);
 assert.equal(stops,1);assert.equal(peersClosed,1);
 const failedPeer=make();await failedPeer.start();failedPeer.onState=state=>{if(state==='failed')throw Error('Fixture display failure');};peer.connectionState='failed';
 assert.throws(()=>peer.onconnectionstatechange(),/display failure/);
 assert.equal(stops,2);assert.equal(peersClosed,2);assert.equal(failedPeer.closed,true);
});
test('binary stream base measures real bytes, cancels overflow and releases the reader',async()=>{
 const base=new BoundedBinaryAdapterBase(4);let cancelled=0;
 const stream=new ReadableStream({start(controller){controller.enqueue(new Uint8Array([1,2,3,4,5]));},cancel(){cancelled++;}});
 await assert.rejects(base.readBoundedStream(stream,4),/size not permitted/);assert.equal(cancelled,1);assert.equal(stream.locked,false);
 assert.throws(()=>base.validateBytes(new Uint8Array(5)),/size not permitted/);
 assert.throws(()=>new BoundedBinaryAdapterBase(0),/limit/);
});
test('binary stream base owns each reused producer buffer before the next read',async()=>{
 const bytes=new Uint8Array(2);let index=0;
 const stream=new ReadableStream({pull(controller){
  if(index===2){controller.close();return;}
  bytes.set(index++===0?[1,2]:[3,4]);controller.enqueue(bytes);
 }},{highWaterMark:0});
 assert.deepEqual(await new BoundedBinaryAdapterBase(4).readBoundedStream(stream,4),new Uint8Array([1,2,3,4]));assert.equal(stream.locked,false);
});
test('declared-size overflow cancels immediately and cannot expose cancellation errors',async()=>{
 let reads=0,cancelled=0;
 const stream=new ReadableStream({pull(controller){reads++;controller.enqueue(new Uint8Array([1,2,3,4]));},cancel(){cancelled++;throw Error('private provider detail');}},{highWaterMark:0});
 await assert.rejects(new BoundedBinaryAdapterBase(8).readBoundedStream(stream,3),error=>error.message==='Message size mismatch');
 assert.equal(reads,1);assert.equal(cancelled,1);assert.equal(stream.locked,false);
});
test('invalid stream chunks are cancelled and empty chunks do not change the content',async()=>{
 let cancelled=0;
 const invalid=new ReadableStream({start(controller){controller.enqueue('not binary');},cancel(){cancelled++;}});
 await assert.rejects(new BoundedBinaryAdapterBase(4).readBoundedStream(invalid,1),/Invalid message stream/);assert.equal(cancelled,1);assert.equal(invalid.locked,false);
 let remaining=1000;
 const empty=new ReadableStream({pull(controller){if(remaining-->0)controller.enqueue(new Uint8Array());else if(remaining===-1)controller.enqueue(new Uint8Array([7]));else controller.close();}},{highWaterMark:0});
 assert.deepEqual(await new BoundedBinaryAdapterBase(4).readBoundedStream(empty,1),new Uint8Array([7]));
});
test('invalid declared sizes cancel unread bodies without leaking provider failures',async()=>{
 for(const declared of [0,-1,5,NaN,Infinity,'1']){
  let cancelled=0,reads=0;
  const stream=new ReadableStream({pull(){reads++;},cancel(){cancelled++;throw Error('private cancellation detail');}},{highWaterMark:0});
  await assert.rejects(new BoundedBinaryAdapterBase(4).readBoundedStream(stream,declared),error=>error.message==='Message size not permitted');
  assert.equal(cancelled,1);assert.equal(reads,0);assert.equal(stream.locked,false);
 }
});
test('empty-chunk producers cannot exceed the declared-byte read budget',async()=>{
 let reads=0,cancelled=0;
 const stream=new ReadableStream({pull(c){reads++;if(reads<=1030)c.enqueue(new Uint8Array());else if(reads===1031)c.enqueue(new Uint8Array([7]));else c.close();},cancel(){cancelled++;}},{highWaterMark:0});
 await assert.rejects(new BoundedBinaryAdapterBase(4).readBoundedStream(stream,1),/stream limit exceeded/);
 assert.equal(reads,1026);assert.equal(cancelled,1);assert.equal(stream.locked,false);
});
test('the exact empty-chunk budget preserves a valid byte and releases its lock',async()=>{
 let reads=0;
 const stream=new ReadableStream({pull(c){if(reads++<1024)c.enqueue(new Uint8Array());else if(reads===1026)c.close();else c.enqueue(new Uint8Array([7]));}},{highWaterMark:0});
 assert.deepEqual(await new BoundedBinaryAdapterBase(4).readBoundedStream(stream,1),new Uint8Array([7]));assert.equal(stream.locked,false);
});
test('missing or already locked streams fail generically without stealing a reader',async()=>{
 const base=new BoundedBinaryAdapterBase(4);
 for(const stream of [undefined,null,{}])await assert.rejects(base.readBoundedStream(stream,1),error=>error.message==='Invalid message stream');
 const stream=new ReadableStream(),reader=stream.getReader();
 await assert.rejects(base.readBoundedStream(stream,1),error=>error.message==='Invalid message stream');
 assert.equal(stream.locked,true);await reader.cancel();reader.releaseLock();
});
test('allocation failure also cancels and releases an acquired reader',async()=>{
 let cancelled=0;
 const stream=new ReadableStream({cancel(){cancelled++;}},{highWaterMark:0});
 await assert.rejects(new BoundedBinaryAdapterBase(Number.MAX_SAFE_INTEGER).readBoundedStream(stream,Number.MAX_SAFE_INTEGER),RangeError);
 assert.equal(cancelled,1);assert.equal(stream.locked,false);
});
