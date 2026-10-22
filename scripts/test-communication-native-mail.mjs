import {test} from 'node:test';
import assert from 'node:assert/strict';
import {NativeBusinessMailTransport} from '../cloudflare/workers/src/business-tasks/native-mail.ts';
const sender='sender@example.invalid';
const message=()=>({from:sender,to:'owned-inbox@example.invalid',subject:'Synthetic test',text:'Fixture body',html:'<p>Fixture body</p>'});
test('native binding receives only fixed-sender supported fields and acceptance receipt',async()=>{
 let count=0;const transport=new NativeBusinessMailTransport({async send(sent){count++;assert.deepEqual(sent,message());return {messageId:'fixture-receipt'};}},sender,4096);
 assert.deepEqual(await transport.send({...message(),extra:'not forwarded'}),{messageId:'fixture-receipt'});assert.equal(count,1);
});
test('native adapter rejects sender override, header injection and real byte overflow before sending',async()=>{
 const transport=new NativeBusinessMailTransport({async send(){assert.fail('must not send');}},sender,60);
 for(const bad of [{from:'other@example.invalid'},{to:'victim@example.invalid\r\nBcc:x@example.invalid'},{subject:'bad\nsubject'},{text:'😊'.repeat(20)},{html:null}])await assert.rejects(transport.send({...message(),...bad}),/^Error: Email delivery unavailable$/);
});
test('ambiguous provider failure is generic and never retried',async()=>{
 let count=0;const transport=new NativeBusinessMailTransport({async send(){count++;throw Error('private-provider-detail');}},sender,4096);
 await assert.rejects(transport.send(message()),/^Error: Email delivery unavailable$/);assert.equal(count,1);
});
test('malformed provider receipts fail closed without retries',async()=>{
 for(const receipt of [undefined,{}, {messageId:''},{messageId:' bad'},{messageId:'x\ny'},{messageId:5}]){
  let count=0;const transport=new NativeBusinessMailTransport({async send(){count++;return receipt;}},sender,4096);
  await assert.rejects(transport.send(message()),/^Error: Email delivery unavailable$/);assert.equal(count,1);
 }
});
test('native adapter requires configured callable binding, sender and byte limit',()=>{
 for(const args of [[{},sender,100],[{send(){}},'bad',100],[{send(){}},sender,0]])assert.throws(()=>new NativeBusinessMailTransport(...args));
});
