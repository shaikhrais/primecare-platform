import {test} from 'node:test';
import assert from 'node:assert/strict';
import {CommunicationResourceBase,BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import {BrowserAudioCall} from '../packages/shared/src/communications/audio-call.mjs';
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
test('binary stream base measures real bytes, cancels overflow and releases the reader',async()=>{
 const base=new BoundedBinaryAdapterBase(4);let cancelled=0;
 const stream=new ReadableStream({start(controller){controller.enqueue(new Uint8Array([1,2,3,4,5]));},cancel(){cancelled++;}});
 await assert.rejects(base.readBoundedStream(stream,4),/size not permitted/);assert.equal(cancelled,1);assert.equal(stream.locked,false);
 assert.throws(()=>base.validateBytes(new Uint8Array(5)),/size not permitted/);
 assert.throws(()=>new BoundedBinaryAdapterBase(0),/limit/);
});
