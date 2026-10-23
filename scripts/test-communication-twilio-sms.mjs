import {test} from 'node:test';
import assert from 'node:assert/strict';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import {TwilioSmsTransport,TwilioSmsStatusAdapter,smsDeliveryProjection} from '../packages/shared/src/communications/twilio-sms.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import {createTwilioSmsClient} from '../packages/shared/src/communications/twilio-sms-client.mjs';
const config={accountSid:'AC'+'a'.repeat(32),authToken:'b'.repeat(32),messagingServiceSid:'MG'+'c'.repeat(32),sender:'+15550001000',webhookUrl:'https://fixture.invalid/sms-status',maxWebhookBytes:4096};
const sid='SM'+'d'.repeat(32),recipient='+15550002000';
function request({params={},signature,body,headers={},url=config.webhookUrl}={}){
 const values={AccountSid:config.accountSid,MessageSid:sid,MessageStatus:'delivered',MessagingServiceSid:config.messagingServiceSid,From:config.sender,To:recipient,...params};
 const encoded=new URLSearchParams();for(const [key,value]of Object.entries(values))for(const item of Array.isArray(value)?value:[value])encoded.append(key,item);
 return new Request(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,url,values),...headers},body:body??encoded.toString()});
}
function fixture(record=async()=> 'recorded'){
 const events=[];return {events,adapter:new TwilioSmsStatusAdapter({...config,store:{async record(event){events.push(event);return record(event);}}})};
}
test('callback inherits bounds, validates signature and records before acknowledging',async()=>{
 const f=fixture();assert.ok(f.adapter instanceof BoundedBinaryAdapterBase);
 const response=await f.adapter.respond(request({params:{TenantId:'forged',UserId:'forged',ErrorMessage:'PRIVATE CARRIER'}}));
 assert.equal(response.status,204);assert.equal(await response.text(),'');assert.equal(response.headers.get('cache-control'),'no-store');
 assert.deepEqual(f.events,[{accountSid:config.accountSid,messageSid:sid,messagingServiceSid:config.messagingServiceSid,from:config.sender,to:recipient,status:'delivered',errorCode:null}]);
});
test('invalid signatures and foreign account or URL never reach persistence',async()=>{
 const f=fixture();for(const input of [request({signature:'wrong'}),request({params:{AccountSid:'AC'+'e'.repeat(32)}}),request({url:config.webhookUrl+'?forged=1'})])assert.ok((await f.adapter.respond(input)).status>=400);
 assert.equal(f.events.length,0);
});
test('duplicate critical fields, wrong sender/service, non-SMS status and malformed codes fail closed',async()=>{
 const f=fixture();for(const params of [{MessageSid:[sid,sid]},{MessageStatus:['sent','delivered']},{MessagingServiceSid:['MG'+'c'.repeat(32),'MG'+'c'.repeat(32)]},{From:'+15550009999'},{MessagingServiceSid:'MG'+'e'.repeat(32)},{MessageStatus:'read'},{To:'not-phone'},{ErrorCode:['30003','30005']},{ErrorCode:'bad'}])assert.equal((await f.adapter.respond(request({params}))).status,400);
 assert.equal(f.events.length,0);
});
test('failure codes persist without copying private carrier descriptions',async()=>{
 const f=fixture();assert.equal((await f.adapter.respond(request({params:{MessageStatus:'undelivered',ErrorCode:'30003',ErrorMessage:'PRIVATE'}}))).status,204);
 assert.equal(f.events[0].errorCode,'30003');assert.ok(!Object.hasOwn(f.events[0],'ErrorMessage'));
});
test('store duplicates and durably quarantined early callbacks acknowledge; failed writes retry',async()=>{
 for(const value of ['duplicate','quarantined'])assert.equal((await fixture(async()=>value).adapter.respond(request())).status,204);
 for(const action of [async()=>undefined,async()=>{throw Error('PRIVATE DATABASE');}]){
  const response=await fixture(action).adapter.respond(request());assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
 }
});
test('future duplicate fields are signed and tampering does not persist',async()=>{
 const f=fixture();assert.equal((await f.adapter.respond(request({params:{Future:['one','two']}}))).status,204);
 const signed=request({params:{Future:'one'}}),body=(await signed.text()).replace('Future=one','Future=two');
 assert.equal((await f.adapter.respond(new Request(signed.url,{method:'POST',headers:signed.headers,body}))).status,403);
 assert.equal(f.events.length,1);
});
test('malformed form input, excessive fields, oversized or lying lengths fail before persistence',async()=>{
 const f=fixture();for(const opts of [{body:'x=%ZZ'},{body:new Uint8Array([255])},{body:'x=1&'.repeat(129)},{headers:{'content-length':'1'}},{headers:{'content-length':'99999'}},{headers:{'content-length':'invalid'}}])assert.equal((await f.adapter.respond(request(opts))).status,400);
 assert.equal(f.events.length,0);
});
test('wrong method/type and missing signature cancel unread bodies',async()=>{
 for(const change of [{method:'PUT'},{type:'application/json'},{signature:''}]){
  let cancelled=false;const stream=new ReadableStream({pull(){assert.fail('Rejected body read');},cancel(){cancelled=true;}},{highWaterMark:0});
  const response=await fixture().adapter.respond(new Request(config.webhookUrl,{method:change.method??'POST',headers:{'content-type':change.type??'application/x-www-form-urlencoded','x-twilio-signature':change.signature??'present'},body:stream,duplex:'half'}));
  assert.ok(response.status>=400);assert.ok(cancelled);assert.equal(stream.locked,false);
 }
});
test('delivery projection ignores duplicates and late lower-state callbacks',()=>{
 for(const list of [['delivered','queued','sent','delivered'],['sent','delivered'],['delivered']])assert.deepEqual(smsDeliveryProjection(list),{status:'delivered',delivered:true});
 assert.deepEqual(smsDeliveryProjection(['sent','queued']),{status:'sent',delivered:false});
 assert.deepEqual(smsDeliveryProjection([]),{status:'unknown',delivered:false});
 assert.deepEqual(smsDeliveryProjection(['failed','delivered']),{status:'reconciliation_required',delivered:false});
 assert.throws(()=>smsDeliveryProjection(['read']));
});
function transport(create){return new TwilioSmsTransport({client:{messages:{create}},...config,statusCallback:config.webhookUrl,maxTextBytes:6400});}
const receipt=()=>({sid,accountSid:config.accountSid,messagingServiceSid:config.messagingServiceSid,from:config.sender,to:recipient,status:'queued'});
test('outbound transport uses fixed sender, service and callback without claiming delivery',async()=>{
 let sent;const result=await transport(async args=>{sent=args;return receipt();}).send({to:recipient,text:'Fixture notification'});
 assert.deepEqual(sent,{to:recipient,body:'Fixture notification',from:config.sender,messagingServiceSid:config.messagingServiceSid,statusCallback:config.webhookUrl});
 assert.deepEqual(result,{messageSid:sid,status:'queued'});
});
test('untrusted sender, tenant, callback and malformed inputs cannot be passed through',async()=>{
 let calls=0;const sender=transport(async()=>{calls++;return receipt();});
 for(const message of [{to:recipient,text:'x',from:'+15550009999'},{to:recipient,text:'x',tenantId:'forged'},{to:recipient,text:'x',statusCallback:'https://attacker.invalid'},{to:'bad',text:'x'},{to:recipient,text:' '},{to:recipient,text:'x'.repeat(6401)},{to:recipient,text:'x'.repeat(1601)}])await assert.rejects(sender.send(message),/Invalid SMS/);
 assert.equal(calls,0);
});
test('ambiguous sends and malformed receipts are never automatically retried',async()=>{
 let calls=0;await assert.rejects(transport(async()=>{calls++;throw Object.assign(Error('PRIVATE'),{status:429});}).send({to:recipient,text:'x'}),/^Error: SMS acceptance unknown$/);assert.equal(calls,1);
 for(const change of [{sid:'bad'},{accountSid:'AC'+'e'.repeat(32)},{messagingServiceSid:'MG'+'e'.repeat(32)},{to:'+15550009999'},{from:'+15550009999'},{status:'read'}])await assert.rejects(transport(async()=>({...receipt(),...change})).send({to:recipient,text:'x'}),/SMS acceptance unknown/);
});
test('official SDK composition submits one server-authenticated request with delivery callback',async()=>{
 const requests=[];
 const client=createTwilioSmsClient({accountSid:config.accountSid,apiKeySid:'SK'+'e'.repeat(32),apiKeySecret:'f'.repeat(32),httpClient:{async request(options){requests.push(options);return {statusCode:201,body:JSON.stringify({sid,account_sid:config.accountSid,messaging_service_sid:config.messagingServiceSid,from:config.sender,to:recipient,status:'queued'})};}}});
 const sender=new TwilioSmsTransport({client,...config,statusCallback:config.webhookUrl,maxTextBytes:6400});
 assert.deepEqual(await sender.send({to:recipient,text:'Fixture'}),{messageSid:sid,status:'queued'});
 assert.equal(requests.length,1);const [request]=requests;
 assert.equal(request.method,'post');assert.equal(request.uri,'https://api.twilio.com/2010-04-01/Accounts/'+config.accountSid+'/Messages.json');
 assert.equal(request.username,'SK'+'e'.repeat(32));assert.equal(request.data.StatusCallback,config.webhookUrl);assert.equal(request.data.MessagingServiceSid,config.messagingServiceSid);assert.equal(request.data.From,config.sender);
 assert.deepEqual(Object.keys(client),['messages']);assert.doesNotMatch(JSON.stringify(client),/ffffffff/);
});
test('official SDK HTTP 429 and timeout do not cause automatic duplicate submissions',async()=>{
 for(const failure of ['429','timeout']){
  let calls=0;const client=createTwilioSmsClient({accountSid:config.accountSid,apiKeySid:'SK'+'e'.repeat(32),apiKeySecret:'f'.repeat(32),httpClient:{async request(){calls++;if(failure==='timeout')throw Error('PRIVATE TIMEOUT');return {statusCode:429,body:JSON.stringify({code:20429,message:'PRIVATE RATE LIMIT'})};}}});
  await assert.rejects(new TwilioSmsTransport({client,...config,statusCallback:config.webhookUrl,maxTextBytes:6400}).send({to:recipient,text:'Fixture'}),/^Error: SMS acceptance unknown$/);assert.equal(calls,1);
 }
});
