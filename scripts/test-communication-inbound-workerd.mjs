// Actual workerd streams; synthetic Email Routing event and persistence port.
// No SMTP delivery, production mailbox, database, provider or network acceptance.
import assert from 'node:assert/strict';
import {mkdir,writeFile} from 'node:fs/promises';
import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
const bundle=await build({stdin:{contents:`
import {InboundEmailAdapter} from './packages/shared/src/communications/inbound-email.mjs';
import {BoundedBinaryAdapterBase} from './packages/shared/src/communications/adapter-base.mjs';
const check=value=>{if(!value)throw Error('Inbound runtime assertion failed');};
export default {async fetch(){
 let checks=0,stored=[],cancelled=0,reason;
 const adapter=new InboundEmailAdapter({async receive(value){stored.push(value);}},4);
 check(adapter instanceof BoundedBinaryAdapterBase);checks++;
 const message={from:'original@example.invalid',to:'owned@example.invalid',rawSize:2,setReject(){throw Error('Valid event rejected');}};
 message.raw=new ReadableStream({pull(c){message.from='changed@example.invalid';message.to='foreign@example.invalid';c.enqueue(new Uint8Array([1,2]));c.close();}},{highWaterMark:0});
 await adapter.receive(message);check(stored.length===1&&stored[0].from==='original@example.invalid'&&stored[0].to==='owned@example.invalid'&&stored[0].raw[1]===2&&!message.raw.locked);checks++;
 const rejected={from:'sender@example.invalid',to:'owned@example.invalid',rawSize:1,setReject(value){check(this===rejected);reason=value;}};
 rejected.raw=new ReadableStream({pull(c){rejected.setReject=()=>{throw Error('Replaced rejection callback');};c.enqueue(new Uint8Array([1,2]));},cancel(){cancelled++;throw Error('Private provider detail');}},{highWaterMark:0});
 await adapter.receive(rejected);check(reason==='Message size mismatch'&&cancelled===1&&!rejected.raw.locked&&stored.length===1);checks++;
 const oversized={from:'sender@example.invalid',to:'owned@example.invalid',rawSize:5,raw:new ReadableStream({pull(){throw Error('Rejected stream read');},cancel(){cancelled++;}},{highWaterMark:0}),setReject(value){reason=value;}};
 await adapter.receive(oversized);check(reason==='Message size not permitted'&&cancelled===2&&!oversized.raw.locked);checks++;
 let reads=0;const empty={from:'sender@example.invalid',to:'owned@example.invalid',rawSize:1,setReject(value){reason=value;}};
 empty.raw=new ReadableStream({pull(c){reads++;if(reads<1030)c.enqueue(new Uint8Array());else{c.enqueue(new Uint8Array([1]));c.close();}},cancel(){cancelled++;}},{highWaterMark:0});
 await adapter.receive(empty);check(reason==='Message stream limit exceeded'&&reads===1026&&cancelled===3&&!empty.raw.locked&&stored.length===1);checks++;
 const failure=Error('Synthetic infrastructure failure');
 const failing={from:'sender@example.invalid',to:'owned@example.invalid',rawSize:1,raw:new ReadableStream({pull(c){c.error(failure);}},{highWaterMark:0}),setReject(){throw Error('Infrastructure was rejected');}};
 try{await adapter.receive(failing);throw Error('Missing read failure');}catch(error){check(error===failure&&!failing.raw.locked);}checks++;
 const persist=new InboundEmailAdapter({async receive(){throw failure;}},4);
 try{await persist.receive({...failing,raw:new ReadableStream({start(c){c.enqueue(new Uint8Array([1]));c.close();}})});throw Error('Missing persistence failure');}catch(error){check(error===failure);}checks++;
 return Response.json({checks,passed:true});
}};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30'});
try{
 const response=await runtime.dispatchFetch('https://fixture.invalid/?enable-semantics=true');assert.equal(response.status,200,await response.clone().text());
 const result=await response.json();assert.deepEqual(result,{checks:7,passed:true});
 await mkdir('test-results/communication-inbound',{recursive:true});
 await writeFile('test-results/communication-inbound/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result,engine:'workerd',eventFixture:true,persistenceFixture:true,production:false,liveEmailVerified:false},null,2));
 console.log('WORKERD_COMMUNICATION_INBOUND_PASS '+result.checks);
}finally{await runtime.dispose();}
