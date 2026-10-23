import {test} from 'node:test';
import assert from 'node:assert/strict';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import {TwilioVoiceExtensionAdapter,twilioVoiceIdentity} from '../packages/shared/src/communications/twilio-voice.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
const config={accountSid:'AC'+'a'.repeat(32),authToken:'b'.repeat(32),sharedNumber:'+15550001000',numberVerified:true,incomingUrl:'https://fixture.invalid/voice?stage=incoming',gatherUrl:'https://fixture.invalid/voice?stage=extension',maxWebhookBytes:4096};
const target={extension:'100001',tenantId:'tenant-a',userId:'user-a',published:true,active:true,tenantActive:true,userActive:true};
function fixture(lookup=async()=>[target]){const calls=[];return {calls,adapter:new TwilioVoiceExtensionAdapter({...config,directory:{async lookup(...args){calls.push(args);return lookup(...args);}}})};}
function request({stage='gather',params={},url,signature,body,headers={},declared=false}={}){
 const address=url??(stage==='gather'?config.gatherUrl:config.incomingUrl);
 const values={AccountSid:config.accountSid,CallSid:'CA'+'c'.repeat(32),To:config.sharedNumber,Direction:'inbound',...(stage==='gather'?{Digits:'100001'}:{}),...params};
 const form=new URLSearchParams();for(const [key,value] of Object.entries(values))for(const item of Array.isArray(value)?value:[value])form.append(key,item);
 const raw=body??form.toString();return new Request(address,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,address,values),...(declared?{'content-length':String(new TextEncoder().encode(raw).length)}:{}),...headers},body:raw});
}
test('Twilio adapter inherits binary bounds and rejects incomplete or unverified configuration',()=>{
 assert.ok(fixture().adapter instanceof BoundedBinaryAdapterBase);
 for(const change of [{accountSid:'bad'},{authToken:''},{sharedNumber:'123'},{numberVerified:false},{incomingUrl:'http://fixture.invalid/'},{gatherUrl:config.incomingUrl},{gatherUrl:'https://other.invalid/'},{directory:{}},{maxWebhookBytes:0}])assert.throws(()=>new TwilioVoiceExtensionAdapter({...config,directory:{lookup:async()=>[]},...change}));
});
test('valid initial webhook renders a finite DTMF gather using the official SDK',async()=>{
 const f=fixture(),response=await f.adapter.respond(request({stage:'incoming',declared:true})),xml=await response.text();
 assert.equal(response.status,200);assert.match(xml,/<Gather[^>]*input="dtmf"/);assert.match(xml,/numDigits="6"/);assert.match(xml,/actionOnEmptyResult="true"/);assert.match(xml,/stage=extension/);assert.match(xml,/<Hangup\/>/);assert.doesNotMatch(xml,/<Dial/);assert.deepEqual(f.calls,[]);assert.equal(response.headers.get('cache-control'),'no-store');
});
test('valid extension resolves twice and dials only its tenant-derived SDK client',async()=>{
 const f=fixture(),response=await f.adapter.respond(request()),xml=await response.text();
 assert.equal(response.status,200);assert.match(xml,new RegExp('<Identity>'+await twilioVoiceIdentity(target)+'</Identity>'));
 assert.match(xml,/callerId="\+15550001000"/);assert.match(xml,/answerOnBridge="true"/);assert.doesNotMatch(xml,/<Number|record=|tenant-a|user-a/);assert.deepEqual(f.calls,[['100001',2],['100001',2]]);
});
test('same user in another tenant and different identifier boundaries produce distinct identities',async()=>{
 assert.notEqual(await twilioVoiceIdentity(target),await twilioVoiceIdentity({...target,tenantId:'tenant-b'}));
 assert.notEqual(await twilioVoiceIdentity({tenantId:'ab',userId:'c'}),await twilioVoiceIdentity({tenantId:'a',userId:'bc'}));
 for(const scope of [{tenantId:'',userId:'x'},{tenantId:'x',userId:'a\u0000'},{tenantId:'x',userId:'\ud800'}])await assert.rejects(twilioVoiceIdentity(scope));
});
test('invalid signatures, tampered fields and another configured URL never query the directory',async()=>{
 const f=fixture();for(const input of [request({signature:'invalid'}),request({signature:getExpectedTwilioSignature(config.authToken,config.incomingUrl,{})}),request({params:{To:'+15550009999'}}),request({params:{AccountSid:'AC'+'d'.repeat(32)}}),request({params:{Direction:'outbound-api'}}),request({params:{CallSid:'bad'}}),request({url:config.gatherUrl+'&forged=1'})])assert.ok([403,404].includes((await f.adapter.respond(input)).status));assert.deepEqual(f.calls,[]);
});
test('all future form parameters, including duplicate values, participate in signature validation',async()=>{
 const f=fixture();assert.equal((await f.adapter.respond(request({params:{FutureField:['one','two']}}))).status,200);
 const signed=request({params:{FutureField:'one'}}),body=(await signed.text()).replace('FutureField=one','FutureField=two');
 assert.equal((await f.adapter.respond(new Request(signed.url,{method:'POST',headers:signed.headers,body}))).status,403);
});
test('duplicate critical fields cannot select an account, number or extension',async()=>{
 const f=fixture();for(const params of [{Digits:['100001','100002']},{AccountSid:[config.accountSid,config.accountSid]},{To:[config.sharedNumber,config.sharedNumber]}]){const response=await f.adapter.respond(request({params}));assert.doesNotMatch(await response.text(),/<Dial/);}assert.deepEqual(f.calls,[]);
});
test('unknown, duplicate, unpublished, inactive and revoked destinations share a generic response',async()=>{
 let expected;
 for(const rows of [[],[target,target],[{...target,published:false}],[{...target,active:false}],[{...target,tenantActive:false}],[{...target,userActive:false}],[{...target,extension:'100002'}]]){
  const response=await fixture(async()=>rows).adapter.respond(request()),body=await response.text();assert.equal(response.status,200);assert.doesNotMatch(body,/<Dial/);expected??=body;assert.equal(body,expected);
 }
});
test('empty, partial, injected and overlong extension input hangs up without lookup',async()=>{
 const f=fixture();for(const Digits of ['', '1','000000','100001#','100001<script>','1000010']){const response=await f.adapter.respond(request({params:{Digits}}));assert.doesNotMatch(await response.text(),/<Dial|<Gather/);}assert.deepEqual(f.calls,[]);
});
test('current directory revocation or reassignment between lookups never redirects the caller',async()=>{
 for(const second of [[],[{...target,userId:'another'}],[{...target,tenantId:'other'}],[{...target,published:false}]]){
  let calls=0;const f=fixture(async()=>++calls===1?[{...target}]:second);assert.doesNotMatch(await (await f.adapter.respond(request())).text(),/<Dial/);
 }
});
test('directory mutation across suspension cannot rewrite the original approved scope',async()=>{
 const row={...target};let calls=0;
 const f=fixture(async()=>{if(++calls===1)return [row];row.tenantId='other';return [row];});
 assert.doesNotMatch(await (await f.adapter.respond(request())).text(),/<Dial/);
});
test('directory failures remain generic unavailable without exposing provider data',async()=>{
 const response=await fixture(async()=>{throw Error('PRIVATE DIRECTORY');}).adapter.respond(request());assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
});
test('missing signatures, wrong methods and content types cancel unread bodies',async()=>{
 for(const change of [{method:'PUT'},{headers:{'content-type':'application/json'}},{headers:{'x-twilio-signature':''}}]){
  let cancelled=0;const raw=new ReadableStream({pull(){assert.fail('Rejected body read');},cancel(){cancelled++;}},{highWaterMark:0});
  const r=new Request(config.incomingUrl,{method:change.method??'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':'present',...change.headers},body:raw,duplex:'half'});
  assert.ok((await fixture().adapter.respond(r)).status>=400);assert.equal(cancelled,1);assert.equal(raw.locked,false);
 }
});
test('oversized and lying bodies reject before lookup and release the body',async()=>{
 const f=fixture();for(const headers of [{'content-length':'999999'},{'content-length':'1'},{'content-length':'invalid'}])assert.equal((await f.adapter.respond(request({headers}))).status,400);
 assert.deepEqual(f.calls,[]);
});
test('malformed percent encoding, UTF-8, and excessive fields are generic input failures',async()=>{
 const f=fixture();for(const body of ['x=%ZZ','x=%FF',new Uint8Array([255]),'x=1&'.repeat(129)]){const response=await f.adapter.respond(request({body}));assert.equal(response.status,400);}assert.deepEqual(f.calls,[]);
});
test('provider TypeError while reading is retryable, not an input rejection',async()=>{
 const raw=new ReadableStream({pull(c){c.error(new TypeError('PRIVATE NETWORK'));}}),r=new Request(config.incomingUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':'present'},body:raw,duplex:'half'});
 const response=await fixture().adapter.respond(r);assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});assert.equal(raw.locked,false);
});
test('forwarded host headers never replace the configured signed public URL',async()=>{
 const response=await fixture().adapter.respond(request({headers:{'x-forwarded-host':'attacker.invalid','x-forwarded-proto':'http'}}));assert.equal(response.status,200);assert.match(await response.text(),/<Dial/);
});
test('provider fields cannot choose tenant, user, arbitrary SDK client or telephone destination',async()=>{
 const response=await fixture().adapter.respond(request({params:{TenantId:'other',UserId:'other',Client:'forged',PhoneNumber:'+15550009999'}})),body=await response.text();
 assert.match(body,new RegExp('<Identity>'+await twilioVoiceIdentity(target)+'</Identity>'));assert.doesNotMatch(body,/forged|other|15550009999|<Number/);
});
test('configured reception handles no input, zero, invalid and unknown extensions without guessing tenant',async()=>{
 const reception={...target,extension:'100099',tenantId:'platform-tenant',userId:'receptionist'};const lookups=[];
 const adapter=new TwilioVoiceExtensionAdapter({...config,receptionExtension:reception.extension,directory:{async lookup(value){lookups.push(value);return value===target.extension?[target]:value===reception.extension?[reception]:[];}}});
 const prompt=await(await adapter.respond(request({stage:'incoming'}))).text();assert.match(prompt,/If you know/);assert.match(prompt,/reception/);
 for(const Digits of ['', '0','123','999999']){const result=await adapter.respond(request({params:{Digits,TenantId:'attacker',ReceptionExtension:'999998'}}));assert.equal(result.status,200);assert.match(await result.text(),new RegExp('<Identity>'+await twilioVoiceIdentity(reception)+'</Identity>'));}
 assert.match(await(await adapter.respond(request({params:{Digits:target.extension}}))).text(),new RegExp('<Identity>'+await twilioVoiceIdentity(target)+'</Identity>'));
 const duplicated=await adapter.respond(request({params:{Digits:['0','100001']}}));assert.doesNotMatch(await duplicated.text(),/<Dial/);
 assert.ok(!lookups.includes('999998'));
});
test('reception must be uniquely published and current; no external-number fallback',async()=>{
 for(const rows of [[],[{...target,extension:'100099',published:false}],[{...target,extension:'100099'},{...target,extension:'100099'}]]){
  const adapter=new TwilioVoiceExtensionAdapter({...config,receptionExtension:'100099',directory:{async lookup(){return rows;}}});assert.doesNotMatch(await(await adapter.respond(request({params:{Digits:'0'}}))).text(),/<Dial/);
 }
 assert.throws(()=>new TwilioVoiceExtensionAdapter({...config,receptionExtension:'+15550009999',directory:{lookup:async()=>[]}}));
 let count=0;const adapter=new TwilioVoiceExtensionAdapter({...config,receptionExtension:'100099',directory:{async lookup(){return ++count===1?[{...target,extension:'100099'}]:[];}}});assert.doesNotMatch(await(await adapter.respond(request({params:{Digits:'0'}}))).text(),/<Dial/);
});
