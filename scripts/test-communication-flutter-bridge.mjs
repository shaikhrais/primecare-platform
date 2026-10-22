import {test} from 'node:test';
import assert from 'node:assert/strict';
import {FlutterBrowserAudioSession} from '../packages/shared/src/communications/flutter-audio-bridge.mjs';
import {CommunicationResourceBase} from '../packages/shared/src/communications/adapter-base.mjs';
function fixture(){
 const record={id:'thread',tenantId:'tenant',kind:'conversation',version:1,members:['alice','bob'],calls:[{id:'call',callerId:'alice',recipientId:'bob',status:'accepted',signals:[]}]};
 let stops=0,closes=0,removed=0,paused=0,gets=0;
 const states=[],listeners=new Map(),requests=[];
 const audio={async play(){},pause(){paused++;},remove(){removed++;}};
 const peer={addTrack(){},close(){closes++;},async createOffer(){return {type:'offer',sdp:'fixture'};},async setLocalDescription(value){this.localDescription={toJSON:()=>value};}};
 const options={userId:'alice',tenantId:'tenant',threadId:'thread',callId:'call',configuration:{iceServers:[]}};
 const adapters={document:{body:{appendChild(){}},createElement:()=>audio},events:{addEventListener:(key,fn)=>listeners.set(key,fn),removeEventListener:key=>listeners.delete(key)},navigator:{mediaDevices:{getUserMedia:async()=>{gets++;return {getTracks:()=>[{stop(){stops++;}}],getAudioTracks:()=>[]};}}},createPeer:()=>peer};
 const execute=async(channel,input)=>{
  const request=JSON.parse(input);requests.push({channel,...request});
  if(channel==='message')return JSON.stringify({ok:true,value:record});
  record.version++;record.calls[0].signals.push({actorId:'alice',sequence:record.calls[0].signals.length+1,signal:request.signal});
  return JSON.stringify({ok:true,value:{id:'thread',version:record.version}});
 };
 const session=new FlutterBrowserAudioSession(execute,state=>states.push(state),options,adapters);
 return {session,record,audio,adapters,options,requests,states,listeners,stats:()=>({stops,closes,removed,paused,gets})};
}
test('Flutter bridge inherits resource cleanup and pagehide releases all media and listeners',async()=>{
 const f=fixture();assert.ok(f.session instanceof CommunicationResourceBase);await f.session.start();f.listeners.get('pagehide')();f.session.close();
 assert.deepEqual(f.stats(),{stops:1,closes:1,removed:1,paused:1,gets:1});assert.equal(f.listeners.size,0);assert.equal(f.audio.srcObject,null);assert.equal(f.states.filter(s=>s==='closed').length,1);
});
test('Flutter bridge rejects a cross-tenant conversation before microphone permission',async()=>{
 const f=fixture();f.record.tenantId='foreign';await assert.rejects(f.session.start(),/scope/);assert.equal(f.stats().gets,0);assert.equal(f.stats().removed,1);
});
test('Flutter bridge preserves definitive HTTP status and never leaks provider strings',async()=>{
 const f=fixture();f.session.session.transport.execute=async()=>{throw Object.assign(Error('Communication unavailable'),{status:403});};
 await assert.rejects(f.session.start(),error=>error.message==='Communication unavailable'&&error.status===403);assert.equal(f.stats().gets,0);assert.equal(f.session.closed,true);
});
test('remote playback rejection closes microphone and peer instead of pretending audio connected',async()=>{
 const f=fixture();await f.session.start();f.audio.play=async()=>{throw Error('Autoplay denied');};f.session.session.audio.peer.ontrack({streams:[{}]});await new Promise(resolve=>setImmediate(resolve));assert.equal(f.session.closed,true);assert.equal(f.stats().stops,1);assert.equal(f.stats().removed,1);assert.ok(f.states.includes('failed'));
});
test('closing Flutter bridge during permission stops the late real resource without making a peer',async()=>{
 const f=fixture();let release;f.adapters.navigator.mediaDevices.getUserMedia=()=>new Promise(resolve=>{release=resolve;});const starting=f.session.start();await new Promise(resolve=>setImmediate(resolve));f.session.close();let stopped=0;release({getTracks:()=>[{stop(){stopped++;}}]});await assert.rejects(starting,/closed/);assert.equal(stopped,1);assert.equal(f.stats().closes,0);
});
