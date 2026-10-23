import {test} from 'node:test';
import assert from 'node:assert/strict';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import {TwilioExtensionConnectAdapter,createTwilioVoiceCallVerifier} from '../packages/shared/src/communications/twilio-connect.mjs';
import {TwilioExtensionConnectService} from '../cloudflare/workers/src/business-tasks/twilio-connect.ts';
import {twilioVoiceIdentity} from '../packages/shared/src/communications/twilio-voice.mjs';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
const accountSid='AC'+'a'.repeat(32),callSid='CA'+'b'.repeat(32),authToken='c'.repeat(32),webhookUrl='https://fixture.invalid/voice/connect';
const caller={extension:'100001',tenantId:'tenant-a',userId:'alice',published:true,active:true,userActive:true,tenantActive:true};
const target={...caller,extension:'100002',userId:'bob'};
const from='client:'+await twilioVoiceIdentity(caller);
const input={callSid,from,callerExtension:caller.extension,targetExtension:target.extension};
function fixture(){
 let denied=false,lookups=0,checks=0;
 const rows=[{...caller},{...target}],call={sid:callSid,accountSid,from,direction:'inbound',status:'in-progress'};
 const policy={async assert(actor,action,state){checks++;assert.deepEqual(actor,{id:'alice',tenantId:'tenant-a'});assert.equal(action,'voice.call.connect');assert.equal(state.userId,'bob');if(denied)throw Error('private');},async assignee(){throw Error('unused');}};
 const directory={async lookup(value){lookups++;return rows.filter(r=>r.extension===value);}};
 const store={run(){throw Error('unused');},read(){throw Error('unused');},inbox(){throw Error('unused');}};
 const service=new TwilioExtensionConnectService(store,policy,directory,{async fetch(){return {...call};}},accountSid);
 return {service,rows,call,deny(){denied=true;},get checks(){return checks;},get lookups(){return lookups;},directory};
}
function request(params={},signature){
 const values={AccountSid:accountSid,CallSid:callSid,From:from,Direction:'inbound',CallerExtension:caller.extension,TargetExtension:target.extension,...params};
 const body=new URLSearchParams();for(const [key,value] of Object.entries(values))for(const item of Array.isArray(value)?value:[value])body.append(key,item);
 return new Request(webhookUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(authToken,webhookUrl,values)},body});
}
const adapter=service=>new TwilioExtensionConnectAdapter({accountSid,authToken,webhookUrl,maxWebhookBytes:4096,sharedNumber:'+15550001000',service});
test('inherited service resolves both current destinations twice and repeats permission check',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);assert.deepEqual(await f.service.connect(input),{identity:await twilioVoiceIdentity(target)});assert.equal(f.lookups,4);assert.equal(f.checks,2);
});
test('canonical Call resource rejects spoofed identity, account, direction, status and SID',async()=>{
 for(const change of [{from:'client:spoofed'},{accountSid:'AC'+'d'.repeat(32)},{direction:'outbound-api'},{status:'completed'},{sid:'CA'+'d'.repeat(32)}]){const f=fixture();Object.assign(f.call,change);await assert.rejects(f.service.connect(input),/^Error: Voice unavailable$/);assert.equal(f.lookups,0);}
});
test('caller extension cannot impersonate another user and target cannot cross tenants',async()=>{
 for(const change of [{tenantId:'tenant-b'},{published:false},{active:false},{userActive:false},{tenantActive:false}]){const f=fixture();Object.assign(f.rows[1],change);await assert.rejects(f.service.connect(input));}
 const f=fixture();f.call.from='client:'+await twilioVoiceIdentity(target);await assert.rejects(f.service.connect({...input,from:f.call.from}));
 await assert.rejects(f.service.connect({...input,targetExtension:caller.extension}));
});
test('current denial, duplicate rows and directory revocation prevent connection',async()=>{
 const denied=fixture();denied.deny();await assert.rejects(denied.service.connect(input));
 const duplicate=fixture();duplicate.rows.push({...caller});await assert.rejects(duplicate.service.connect(input));
 const revoked=fixture();const lookup=revoked.directory.lookup.bind(revoked.directory);let count=0;revoked.directory.lookup=async value=>{if(++count===3)revoked.rows[1].published=false;return lookup(value);};await assert.rejects(revoked.service.connect(input));
});
test('signed adapter emits only the authorized SDK identity and fixed caller number',async()=>{
 const response=await adapter(fixture().service).respond(request({To:'+19005559999',tenantId:'tenant-b',identity:'attacker'}));const xml=await response.text();assert.equal(response.status,200);assert.match(xml,new RegExp('<Identity>'+await twilioVoiceIdentity(target)+'</Identity>'));assert.doesNotMatch(xml,/<Number|<Sip|record=|19005559999|tenant-b|attacker/);assert.equal(response.headers.get('cache-control'),'no-store');
});
test('invalid signatures and repeated critical fields never reach connection service',async()=>{
 let calls=0;const handler=adapter({async connect(){calls++;return {identity:await twilioVoiceIdentity(target)};}});
 for(const req of [request({},'invalid'),request({CallerExtension:['100001','100002']}),request({TargetExtension:'+15550009999'}),request({From:['spoof',from]}),request({CallSid:'bad'})])assert.equal((await handler.respond(req)).status,403);assert.equal(calls,0);
});
test('private provider and policy failures are generic unavailable responses',async()=>{
 const response=await adapter({async connect(){throw Error('secret');}}).respond(request());assert.equal(response.status,503);assert.doesNotMatch(await response.text(),/secret/);
});
test('official SDK verifier fetches only the canonical account Call resource',async()=>{
 const requests=[];const verifier=createTwilioVoiceCallVerifier({accountSid,apiKeySid:'SK'+'e'.repeat(32),apiKeySecret:'f'.repeat(32),httpClient:{async request(options){requests.push(options);return {statusCode:200,body:JSON.stringify({sid:callSid,account_sid:accountSid,from,direction:'inbound',status:'in-progress',private_note:'hidden'}),headers:{}};}}});
 assert.deepEqual(await verifier.fetch(callSid),{sid:callSid,accountSid,from,direction:'inbound',status:'in-progress'});assert.equal(requests.length,1);assert.equal(requests[0].method,'get');assert.equal(requests[0].uri,`https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Calls/${callSid}.json`);await assert.rejects(verifier.fetch('../Accounts/other'));assert.equal(requests.length,1);
});
