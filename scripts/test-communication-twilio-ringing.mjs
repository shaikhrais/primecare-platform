import {test} from 'node:test';import assert from 'node:assert/strict';import {EventEmitter} from 'node:events';
import {TwilioRingingCall} from '../packages/shared/src/communications/twilio-ringing.mjs';
import {CommunicationResourceBase} from '../packages/shared/src/communications/adapter-base.mjs';
function fixture(authorizeAnswer=async()=>true){let scope='session-a';const call=new EventEmitter();call.answers=0;call.rejects=0;call.ends=0;call.accept=()=>{call.answers++;call.emit('accept');};call.reject=()=>{call.rejects++;};call.disconnect=()=>{call.ends++;};call.mute=value=>call.muted=value;const states=[];const session=new TwilioRingingCall({call,authorizeAnswer,currentScope:()=>scope,onChange:s=>states.push(s)});return {session,call,states,logout(){scope=null;}};}
test('rings until explicit authorized answer; mute and end own cleanup',async()=>{const f=fixture();assert.ok(f.session instanceof CommunicationResourceBase);assert.equal(f.call.answers,0);assert.equal(f.session.state,'ringing');await f.session.answer();assert.equal(f.call.answers,1);assert.equal(f.session.state,'connected');f.session.mute(true);assert.equal(f.call.muted,true);f.session.hangup();assert.equal(f.call.ends,1);assert.equal(f.call.eventNames().length,0);});
test('decline rejects once and never answers',()=>{const f=fixture();f.session.decline();f.session.close();assert.equal(f.call.rejects,1);assert.equal(f.call.answers,0);});
test('caller cancellation ends ringing and late answer is unavailable',async()=>{const f=fixture();f.call.emit('cancel');assert.equal(f.session.state,'ended');await assert.rejects(f.session.answer());assert.equal(f.call.answers,0);});
test('denial and logout during answer authorization cannot accept',async()=>{const denied=fixture(async()=>false);await assert.rejects(denied.session.answer());assert.equal(denied.call.answers,0);let resolve;const f=fixture(()=>new Promise(r=>resolve=r));const pending=f.session.answer();f.logout();resolve(true);await assert.rejects(pending);assert.equal(f.call.answers,0);assert.equal(f.call.rejects,1);});
test('concurrent answer attempts invoke SDK accept once',async()=>{let resolve;const f=fixture(()=>new Promise(r=>resolve=r));const pending=f.session.answer();await assert.rejects(f.session.answer());resolve(true);await pending;assert.equal(f.call.answers,1);f.session.close();});
test('unexpected SDK acceptance disconnects and session change blocks mute',async()=>{const f=fixture();f.call.emit('accept');assert.equal(f.session.closed,true);assert.equal(f.call.ends,1);const g=fixture();await g.session.answer();g.logout();assert.throws(()=>g.session.mute(true));assert.equal(g.call.ends,1);});
test('logout during SDK accept disconnects late media instead of leaving it connected',async()=>{
 let resolve;const f=fixture();f.call.accept=()=>new Promise(r=>resolve=r);const pending=f.session.answer();await new Promise(r=>setImmediate(r));f.session.close();resolve();await assert.rejects(pending);assert.ok(f.call.ends>=1);assert.equal(f.session.state,'ended');
});
test('closing or changing session while rendering answering prevents SDK accept',async()=>{
 for(const action of ['close','scope','cancel']){
  let scope='a',session;const call=new EventEmitter();let accepts=0,ends=0;
  call.accept=()=>{accepts++;};call.reject=()=>{};call.disconnect=()=>{ends++;};call.mute=()=>{};
  session=new TwilioRingingCall({call,currentScope:()=>scope,authorizeAnswer:async()=>true,onChange:({state})=>{if(state==='answering'){if(action==='close')session.close();else if(action==='scope')scope='b';else call.emit('cancel');}}});
  await assert.rejects(session.answer());assert.equal(accepts,0);assert.equal(session.closed,true);assert.equal(call.eventNames().length,0);
 }
});
