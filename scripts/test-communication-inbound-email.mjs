import {test} from 'node:test';
import assert from 'node:assert/strict';
import {InboundEmailAdapter,createInboundEmailHandler} from '../packages/shared/src/communications/inbound-email.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
test('inbound event owns the SMTP envelope before raw stream suspension',async()=>{
 let release,entered;const suspended=new Promise(r=>{entered=r;}),pending=new Promise(r=>{release=r;}),received=[];
 const raw=new ReadableStream({async pull(c){entered();await pending;c.enqueue(new Uint8Array([1,2]));c.close();}},{highWaterMark:0});
 const message={from:'outside@example.invalid',to:'owned@example.invalid',rawSize:2,raw,setReject(){assert.fail('Valid message rejected');}};
 const adapter=new InboundEmailAdapter({async receive(value){received.push(value);}},4);assert.ok(adapter instanceof BoundedBinaryAdapterBase);
 const operation=adapter.receive(message);await suspended;
 message.from='forged@example.invalid';message.to='foreign@example.invalid';message.rawSize=3;release();await operation;
 assert.deepEqual(received,[{from:'outside@example.invalid',to:'owned@example.invalid',raw:new Uint8Array([1,2])}]);
});
test('rejection uses the original bound callback and never enters the mail service',async()=>{
 let release,entered,cancelled=0,reason;const suspended=new Promise(r=>{entered=r;}),pending=new Promise(r=>{release=r;});
 const raw=new ReadableStream({async pull(c){entered();await pending;c.enqueue(new Uint8Array([1,2]));},cancel(){cancelled++;}},{highWaterMark:0});
 const message={from:'outside@example.invalid',to:'owned@example.invalid',rawSize:1,raw,setReject(value){assert.equal(this,message);reason=value;}};
 const operation=createInboundEmailHandler({async receive(){assert.fail('Rejected event stored');}},4)(message);await suspended;
 message.setReject=()=>assert.fail('Replaced callback used');release();await operation;
 assert.equal(reason,'Message size mismatch');assert.equal(cancelled,1);assert.equal(raw.locked,false);
});
test('size, chunk and missing stream failures reject without storing or exposing provider details',async()=>{
 for(const [rawSize,raw,expected] of [[5,new ReadableStream({cancel(){throw Error('private failure');}}),'Message size not permitted'],[1,undefined,'Invalid message stream'],[1,new ReadableStream({start(c){c.enqueue('bad');}}),'Invalid message stream']]){
  let reason;await createInboundEmailHandler({async receive(){assert.fail('Invalid message stored');}},4)({from:'outside@example.invalid',to:'owned@example.invalid',rawSize,raw,setReject(value){reason=value;}});assert.equal(reason,expected);
 }
});
test('provider read and mail persistence failures propagate for retry without SMTP input rejection',async()=>{
 const failure=Error('provider temporarily unavailable');
 await assert.rejects(createInboundEmailHandler({async receive(){assert.fail('Failed stream stored');}},4)({from:'outside@example.invalid',to:'owned@example.invalid',rawSize:1,raw:new ReadableStream({pull(c){c.error(failure);}}),setReject(){assert.fail('Infrastructure failure rejected');}}),error=>error===failure);
 await assert.rejects(createInboundEmailHandler({async receive(){throw failure;}},4)({from:'outside@example.invalid',to:'owned@example.invalid',rawSize:1,raw:new ReadableStream({start(c){c.enqueue(new Uint8Array([1]));c.close();}}),setReject(){assert.fail('Persistence failure rejected');}}),error=>error===failure);
});
