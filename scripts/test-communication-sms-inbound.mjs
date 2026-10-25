import {test} from 'node:test';
import assert from 'node:assert/strict';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import {TwilioSmsInboundAdapter} from '../packages/shared/src/communications/twilio-sms-inbound.mjs';
import {PostgresSmsInboundStore} from '../cloudflare/workers/src/business-tasks/sms-inbound.ts';
import {TwilioSignedFormAdapter} from '../packages/shared/src/communications/twilio-webhook.mjs';

const options={accountSid:'AC'+'a'.repeat(32),authToken:'b'.repeat(32),messagingServiceSid:'MG'+'c'.repeat(32),sender:'+15550001000',webhookUrl:'https://fixture.invalid/inbound',maxWebhookBytes:16384};
function request(params={},signature){
 const p={AccountSid:options.accountSid,MessageSid:'SM'+'d'.repeat(32),From:'+15550002000',To:options.sender,Body:'Can I book a visit?',NumMedia:'0',...params};
 const form=new URLSearchParams();for(const [k,v] of Object.entries(p))for(const x of Array.isArray(v)?v:[v])form.append(k,x);
 return new Request(options.webhookUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(options.authToken,options.webhookUrl,p)},body:form});
}
function fixture(accept=async()=> 'recorded'){
 const events=[];const adapter=new TwilioSmsInboundAdapter({...options,store:{async accept(e){events.push(e);return accept(e);}}});return {adapter,events};
}
test('signed SMS persists a frozen provider event then returns empty TwiML',async()=>{
 const f=fixture();assert.ok(f.adapter instanceof TwilioSignedFormAdapter);
 const response=await f.adapter.respond(request({tenantId:'forged',actorId:'forged',roles:'admin',MessagingServiceSid:options.messagingServiceSid}));
 assert.equal(response.status,200);assert.equal(await response.text(),'<Response/>');assert.equal(response.headers.get('cache-control'),'no-store');assert.match(response.headers.get('content-type'),/^text\/xml/);
 assert.deepEqual(f.events,[{provider:'twilio',channel:'sms',accountSid:options.accountSid,messageSid:'SM'+'d'.repeat(32),messagingServiceSid:options.messagingServiceSid,from:'+15550002000',to:options.sender,text:'Can I book a visit?',mediaCount:0,control:null}]);assert.ok(Object.isFrozen(f.events[0]));
});
test('no acknowledgement before durable acceptance',async()=>{
 let release,entered;const gate=new Promise(r=>release=r),started=new Promise(r=>entered=r);let settled=false;
 const f=fixture(async()=>{entered();await gate;return 'recorded';});
 const pending=f.adapter.respond(request()).then(r=>{settled=true;return r;});await started;assert.equal(settled,false);release();assert.equal((await pending).status,200);
});
test('forged signatures, foreign account and tampered signed form never persist',async()=>{
 const f=fixture();assert.equal((await f.adapter.respond(request({},'forged'))).status,403);
 assert.equal((await f.adapter.respond(request({AccountSid:'AC'+'f'.repeat(32)}))).status,403);
 const original=request();const body=(await original.text()).replace('book','cancel');
 assert.equal((await f.adapter.respond(new Request(original.url,{method:'POST',headers:original.headers,body}))).status,403);assert.equal(f.events.length,0);
});
test('duplicate critical parameters and malformed channel inputs fail before storage',async()=>{
 const f=fixture();for(const p of [{MessageSid:['SM'+'d'.repeat(32),'SM'+'d'.repeat(32)]},{Body:['a','b']},{From:['+15550002000','+15550002000']},{To:'+15550009999'},{From:'whatsapp:+15550002000'},{From:'bad'},{MessagingServiceSid:'MG'+'f'.repeat(32)},{MessagingServiceSid:[options.messagingServiceSid,options.messagingServiceSid]},{MessageSid:'bad'},{Body:''},{Body:'x'.repeat(1601)},{Body:'bad\u0000text'},{NumMedia:'11'},{NumMedia:'01'},{NumMedia:['0','0']},{OptOutType:'UNKNOWN'},{OptOutType:['STOP','START']}])assert.equal((await f.adapter.respond(request(p))).status,400,JSON.stringify(p));assert.equal(f.events.length,0);
});
test('provider opt-out metadata and standalone keywords cannot enter ordinary AI input',async()=>{
 for(const [p,expected]of [[{Body:'stop'},'STOP'],[{Body:'  unsubscribe  '},'STOP'],[{Body:'Please stop by tomorrow'},null],[{Body:'help'},'HELP'],[{Body:'unstop'},'START'],[{Body:'Arrêt',OptOutType:'STOP'},'STOP']]){
  const f=fixture(async()=> 'quarantined');assert.equal((await f.adapter.respond(request(p))).status,200);assert.equal(f.events[0].control,expected);
 }
});
test('MMS is retained for quarantine without fetching or copying untrusted media URLs',async()=>{
 const f=fixture(async()=> 'quarantined');assert.equal((await f.adapter.respond(request({Body:'',NumMedia:'1',MediaUrl0:'http://169.254.169.254/private',MediaContentType0:'image/jpeg'}))).status,200);
 assert.equal(f.events[0].mediaCount,1);assert.equal(Object.hasOwn(f.events[0],'MediaUrl0'),false);
});
test('durable duplicate and quarantine acknowledge; storage failure and unknown result return generic 503',async()=>{
 for(const disposition of ['recorded','duplicate','quarantined'])assert.equal((await fixture(async()=>disposition).adapter.respond(request())).status,200);
 for(const accept of [async()=>undefined,async()=>{throw Error('PRIVATE DATABASE DETAILS');}]){
  const response=await fixture(accept).adapter.respond(request());assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
 }
});
const event={provider:'twilio',channel:'sms',accountSid:options.accountSid,messageSid:'SM'+'d'.repeat(32),messagingServiceSid:options.messagingServiceSid,from:'+15550002000',to:options.sender,text:'Hello',mediaCount:0,control:null};
test('repository parameterizes data, persists stable hashes and recognizes duplicates',async()=>{
 const calls=[];const store=new PostgresSmsInboundStore({async query(sql,values){calls.push({sql,values});return {rows:[{duplicate_count:calls.length-1,disposition:'pending'}]};}});
 assert.equal(await store.accept(event),'recorded');assert.equal(await store.accept(Object.fromEntries(Object.entries(event).reverse())),'duplicate');
 assert.equal(calls[0].values[2],calls[1].values[2]);assert.match(calls[0].values[2],/^[a-f0-9]{64}$/);assert.equal(calls[0].values[4],'pending');assert.ok(calls[0].sql.includes('WHERE inbox.fingerprint=EXCLUDED.fingerprint'));assert.equal(calls[0].sql.includes('Hello'),false);
});
test('control and media repository records are quarantined from AI queue',async()=>{
 for(const [change,disposition]of [[{control:'STOP'},'control'],[{control:'START'},'control'],[{control:'HELP'},'control'],[{mediaCount:1},'quarantined']]){
  const store=new PostgresSmsInboundStore({async query(sql,values){assert.equal(values[4],disposition);return {rows:[{duplicate_count:0,disposition}]};}});assert.equal(await store.accept({...event,...change}),'quarantined');
 }
});
test('repository denies invalid inputs, caller-added identity, payload conflicts and malformed receipts',async()=>{
 let writes=0;const store=new PostgresSmsInboundStore({async query(){writes++;return {rows:[]};}});
 for(const e of [{...event,tenantId:'forged'},{...event,control:'invalid'},{...event,mediaCount:-1},{...event,from:'bad'},{...event,text:''}])await assert.rejects(store.accept(e),/Invalid SMS/);assert.equal(writes,0);
 await assert.rejects(store.accept(event),/persistence conflict/);
 for(const row of [{duplicate_count:-1,disposition:'pending'},{duplicate_count:0,disposition:'sent'}])await assert.rejects(new PostgresSmsInboundStore({async query(){return {rows:[row]};}}).accept(event),/persistence conflict/);
});
