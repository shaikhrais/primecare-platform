import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFileSync} from 'node:fs';
const built=await build({entryPoints:['cloudflare/workers/src/email.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {sendEmail,mailReady,emailSender,renderEmail}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const templates=JSON.parse(readFileSync('cloudflare/workers/src/email-templates.json','utf8'));
const variables={message:'Fixture <script>& notice',support:'Fixture support'};
test('batch 297 rejects malformed native send receipts with a generic error',async()=>{
 for(const result of [null,undefined,true,[],{}, {messageId:1},{messageId:true},{messageId:{}},{messageId:[]},{messageId:''},{messageId:' '},{messageId:' id'},{messageId:'private\nreceipt'},{messageId:'private\0receipt'}]){
  const env={EMAIL_FROM:'mail@example.invalid',EMAIL:{send:async()=>result}};
  await assert.rejects(sendEmail(env,'recipient@example.invalid','security_notice',variables,'fixture-key'),error=>error.message==='Email delivery unavailable');
 }
});
test('batch 297 requires a callable binding and uncoerced configured addresses',async()=>{
 for(const env of [{EMAIL_FROM:1,EMAIL:{send:async()=>({messageId:'ok'})}},{EMAIL_FROM:'mail@example.invalid',EMAIL:{}},{EMAIL_FROM:'mail@example.invalid',EMAIL:{send:true}},{EMAIL_FROM:'mail@example.invalid',EMAIL_ALLOWED_SENDER:1,EMAIL:{send:async()=>({messageId:'ok'})}}])assert.equal(mailReady(env),false);
 const untrusted={toString:()=>assert.fail('must not coerce address')};assert.equal(emailSender(untrusted),null);
 await assert.rejects(sendEmail({EMAIL_FROM:'mail@example.invalid',EMAIL:{send:async()=>assert.fail('must not send')}},untrusted,'security_notice',variables,'fixture-key'),/Email delivery unavailable/);
});
test('batch 297 normalizes native transport addresses and reads the receipt once',async()=>{
 let message,reads=0;
 const env={EMAIL_FROM:'PrimeCare <mail@example.invalid>',EMAIL:{send:async value=>{message=value;return {get messageId(){reads++;return 'fixture-message-id';},private:'ignored'};}}};
 assert.equal(await sendEmail(env,'Fixture <recipient@example.invalid>','security_notice',variables,'fixture-key'),'fixture-message-id');
 assert.equal(message.from,'mail@example.invalid');assert.equal(message.to,'recipient@example.invalid');assert.equal(reads,1);
 assert.ok(message.html.includes('&lt;script&gt;'));assert.ok(!message.html.includes('<script>'));
});
test('batch 297 native binding errors never expose private provider details',async()=>{
 await assert.rejects(sendEmail({EMAIL_FROM:'mail@example.invalid',EMAIL:{send:async()=>{throw Error('private-provider-secret')}}},'recipient@example.invalid','security_notice',variables,'fixture-key'),error=>error.message==='Email delivery unavailable');
});
for(const [id,base] of Object.entries(templates))test('batch 298 '+id+' validates bounded content and canonical variables before rendering',()=>{
 const values=Object.fromEntries(base.required.map(key=>[key,'Fixture <&>']));
 assert.ok(renderEmail(id,values).html.includes('&lt;&amp;&gt;'));
 for(const value of [null,[],{...base,subject:'private\nsubject'},{...base,subject:'x'.repeat(201)},{...base,title:''},{...base,body:'x'.repeat(4001)},{...base,body:base.body+' {{private}}'},{...base,body:base.body+' {{bad_placeholder}}'}])assert.throws(()=>renderEmail(id,values,{[id]:value}));
 const withoutRules={...base,required:[],private:'private-extra'};
 assert.throws(()=>renderEmail(id,{}, {[id]:withoutRules}),/Missing template variables/);
 assert.ok(!JSON.stringify(renderEmail(id,values,{[id]:withoutRules})).includes('private-extra'));
 const content={...base,subject:'x'.repeat(200),title:'x'.repeat(200),body:base.required.map(k=>'{{'+k+'}}').join(' ')};
 assert.equal(renderEmail(id,values,{[id]:content}).subject.length,200);
});
test('batch 298 rejects unknown template IDs and malformed override maps',()=>{
 for(const id of ['unknown','__proto__','constructor'])assert.throws(()=>renderEmail(id,{}));
 for(const overrides of [null,[],true])assert.throws(()=>renderEmail('security_notice',variables,overrides));
});
