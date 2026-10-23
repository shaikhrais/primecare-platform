import {test} from 'node:test';
import assert from 'node:assert/strict';
import {BrowserAudioSession} from '../packages/shared/src/communications/audio-session.mjs';
import {CommunicationResourceBase} from '../packages/shared/src/communications/adapter-base.mjs';

function fixture({userId='a',status='accepted',execute}={}) {
 const commands=[],received=[];let stops=0,peerCloses=0,gets=0;
 const record={id:'thread',kind:'conversation',version:3,members:['a','b'],calls:[{id:'call',callerId:'a',recipientId:'b',status,signals:[]}]};
 const peer={localDescription:null,remoteDescription:null,addTrack(){},close(){peerCloses++;},
  async createOffer(){return {type:'offer',sdp:'fixture-offer'};},async createAnswer(){return {type:'answer',sdp:'fixture-answer'};},
  async setLocalDescription(value){this.localDescription={...value,toJSON:()=>value};},
  async setRemoteDescription(value){received.push(value);this.remoteDescription=value;},async addIceCandidate(value){received.push(value);}};
 const transport={async execute(channel,input){
  commands.push({channel,...structuredClone(input)});
  if(execute){const result=await execute(channel,input,{record});if(result!==undefined)return result;}
  if(channel==='message')return structuredClone(record);
  assert.equal(input.version,record.version);record.version++;
  if(input.action==='signal')record.calls[0].signals.push({sequence:record.calls[0].signals.length+1,actorId:userId,signal:structuredClone(input.signal)});
  else record.calls[0].status='ended';
  return {id:record.id,version:record.version};
 }};
 let serial=0;
 const options={transport,userId,threadId:'thread',callId:'call',key:()=>String(++serial),intervalMilliseconds:10000,media:{configuration:{iceServers:[]},getUserMedia:async()=>{gets++;return {getTracks:()=>[{stop(){stops++;}}],getAudioTracks:()=>[]};},createPeer:()=>peer}};
 return {session:new BrowserAudioSession(options),record,commands,received,options,stats:()=>({stops,peerCloses,gets})};
}
test('shared inherited session checks server acceptance before microphone access',async()=>{
 const f=fixture({status:'ringing'});assert.ok(f.session instanceof CommunicationResourceBase);
 await assert.rejects(f.session.start(),/not accepted/);assert.equal(f.stats().gets,0);assert.equal(f.session.closed,true);
 const outsider=fixture({userId:'outsider'});await assert.rejects(outsider.session.start(),/unavailable/);assert.equal(outsider.stats().gets,0);
});
test('caller offer uses current version and does not replay its own signals during refresh',async()=>{
 const f=fixture();try{
  await f.session.start();assert.equal(f.commands.filter(c=>c.action==='signal').length,1);assert.equal(f.received.length,0);
  f.record.calls[0].signals.push({sequence:2,actorId:'b',signal:{type:'answer',description:{type:'answer',sdp:'fixture-answer'}}});
  await Promise.all([f.session.refresh(),f.session.refresh()]);await f.session.refresh();
  assert.equal(f.received.length,1);assert.equal(f.session.lastSequence,2);
 }finally{f.session.close();}assert.deepEqual(f.stats(),{stops:1,peerCloses:1,gets:1});
});
test('recipient processes a stored offer and queues its answer without deadlocking refresh',async()=>{
 const f=fixture({userId:'b'});f.record.calls[0].signals.push({sequence:1,actorId:'a',signal:{type:'offer',description:{type:'offer',sdp:'fixture-offer'}}});
 try{await f.session.start();assert.equal(f.received.length,1);assert.equal(f.commands.filter(c=>c.action==='signal'&&c.signal.type==='answer').length,1);}finally{f.session.close();}
});
test('remote hangup and denied polling immediately release the microphone and timer',async()=>{
 const f=fixture();await f.session.start();f.record.calls[0].status='ended';await f.session.refresh();
 assert.equal(f.session.closed,true);assert.equal(f.session.timer,null);assert.equal(f.stats().stops,1);
 let denied=false;const revoked=fixture({execute(channel){if(denied&&channel==='message')throw Object.assign(Error('denied'),{status:403});}});
 await revoked.session.start();denied=true;await assert.rejects(revoked.session.refresh(),/denied/);assert.equal(revoked.stats().stops,1);
});
test('late microphone permission checks current accepted state before emitting an offer',async()=>{
 const f=fixture();let release;
 const waiting=new Promise(resolve=>{release=resolve;});f.session.audio.getUserMedia=()=>waiting;
 const started=f.session.start();await new Promise(resolve=>setImmediate(resolve));
 f.record.calls[0].status='ended';let stops=0;release({getTracks:()=>[{stop(){stops++;}}]});
 await assert.rejects(started,/not accepted/);assert.equal(stops,1);assert.equal(f.commands.filter(c=>c.action==='signal').length,0);
});
test('explicit version conflict rereads and uses a new key; network ambiguity never retries',async()=>{
 let attempts=0;
 const f=fixture({execute(channel,input,{record}){
  if(channel==='audio'&&++attempts===1){record.version++;throw Object.assign(Error('conflict'),{status:409});}
 }});
 try{await f.session.start();const writes=f.commands.filter(c=>c.action==='signal');assert.equal(writes.length,2);assert.notEqual(writes[0].key,writes[1].key);assert.equal(writes[1].version,writes[0].version+1);}finally{f.session.close();}
 let sends=0;const ambiguous=fixture({execute(channel){if(channel==='audio'){sends++;throw Error('lost acknowledgement');}}});
 await assert.rejects(ambiguous.session.start(),/lost acknowledgement/);assert.equal(sends,1);assert.equal(ambiguous.stats().stops,1);
});
test('hangup releases local resources before a slow server read and never resends',async()=>{
 const f=fixture();await f.session.start();let release;
 const original=f.session.transport.execute;f.session.transport.execute=(channel,input)=>channel==='message'?new Promise(resolve=>{release=()=>resolve(structuredClone(f.record));}):original(channel,input);
 const ended=f.session.hangUp();assert.equal(f.stats().stops,1);assert.equal(f.session.closed,true);
 await new Promise(resolve=>setImmediate(resolve));release();await ended;await f.session.hangUp();
 assert.equal(f.commands.filter(c=>c.action==='end').length,1);assert.equal(f.session.timer,null);
});
test('malformed, truncated or third-party signaling fails closed rather than skipping',async()=>{
 for(const signals of [[{sequence:2,actorId:'b',signal:{}}],[{sequence:1,actorId:'outside',signal:{}}]]){
  const f=fixture();await f.session.start();f.record.calls[0].signals=signals;
  await assert.rejects(f.session.refresh(),/Invalid call signaling/);assert.equal(f.stats().stops,1);
 }
 const f=fixture();await f.session.start();f.record.calls[0].signals=[];
 await assert.rejects(f.session.refresh(),/regressed/);assert.equal(f.stats().stops,1);
});
test('reload refuses an already negotiated call instead of sending a duplicate offer',async()=>{
 const f=fixture();f.record.calls[0].offered=true;await assert.rejects(f.session.start(),/already negotiated/);assert.equal(f.stats().gets,0);
});
test('explicit close during polling is quiet, while a live denial is reported once',async()=>{
 const f=fixture();await f.session.start();const errors=[];f.session.onError=error=>errors.push(error.message);
 let release;f.session.transport.execute=()=>new Promise(resolve=>{release=resolve;});
 const polling=f.session.refresh();f.session.close();release(structuredClone(f.record));
 await assert.rejects(polling,/closed/);assert.deepEqual(errors,[]);
 const denied=fixture();await denied.session.start();denied.session.onError=error=>errors.push(error.message);
 denied.session.transport.execute=async()=>{throw Error('revoked');};
 await assert.rejects(denied.session.refresh(),/revoked/);assert.deepEqual(errors,['revoked']);assert.equal(denied.stats().stops,1);
});
test('unexpected microphone ending closes the inherited session and timer without a server mutation',async()=>{
 const f=fixture();const track=new EventTarget();let stopped=0;
 track.stop=()=>{stopped++;};
 f.session.audio.getUserMedia=async()=>({getTracks:()=>[track],getAudioTracks:()=>[track]});
 await f.session.start();assert.ok(f.session.timer);const before=f.commands.length;
 track.dispatchEvent(new Event('ended'));
 assert.equal(f.session.closed,true);assert.equal(f.session.timer,null);assert.equal(f.session.audio.closed,true);assert.equal(stopped,1);assert.equal(f.stats().peerCloses,1);assert.equal(f.commands.length,before);
});
test('a short competing signal burst yields before retry instead of exhausting conflicts immediately',async()=>{
 let contending=true,attempts=0;const release=setTimeout(()=>{contending=false;},10);
 const f=fixture({execute(channel){if(channel==='audio'){attempts++;if(contending)throw Object.assign(Error('version conflict'),{status:409});}}});
 try{await f.session.start();assert.ok(attempts>=2&&attempts<=3);assert.equal(f.session.closed,false);}finally{clearTimeout(release);f.session.close();}
});
test('closure cancels a conflict wait and cannot submit another signal',async()=>{
 let attempts=0;const f=fixture({execute(channel){if(channel==='audio'){attempts++;throw Object.assign(Error('version conflict'),{status:409});}}});
 const pending=f.session.start();await new Promise(resolve=>setImmediate(resolve));assert.equal(typeof f.session.conflictWait,'function');f.session.close();await assert.rejects(pending);assert.equal(attempts,1);assert.equal(f.session.conflictWait,null);assert.equal(f.stats().stops,1);
});
