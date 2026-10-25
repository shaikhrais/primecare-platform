import {test} from 'node:test';import assert from 'node:assert/strict';
import {fixture,actor,args,callSid,accountSid,sharedNumber} from './fixtures/business-phone-call.mjs';
import {PhoneCallOperationCore} from '../cloudflare/workers/src/business-tasks/phone-call-core.ts';
import {CallAuthorizationServiceBase} from '../cloudflare/workers/src/business-tasks/call-authorization.ts';
import {VoiceTaskConfirmationServiceBase} from '../cloudflare/workers/src/business-tasks/voice-confirmations.ts';
import {TwilioPhoneAuthorizationAdapter,TwilioSpokenConfirmationAdapter,TwilioPrivateCallAdapterBase} from '../packages/shared/src/communications/twilio-phone-authorization.mjs';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
const base='https://fixture.invalid',config={accountSid,authToken:'d'.repeat(32),sharedNumber,maxWebhookBytes:4096,receptionUrl:base+'/reception',resumeUrl:base+'/resume',startUrl:base+'/auth',checkUrl:base+'/check',readbackUrl:base+'/readback',decisionUrl:base+'/decision'};
function request(url,changes={},signature){const p={AccountSid:accountSid,CallSid:callSid,Direction:'inbound',To:sharedNumber,...changes};return new Request(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,url,p)},body:new URLSearchParams(p)});}
async function verified(f){await f.authorization.start(callSid,'4277');assert.deepEqual(await f.authorization.check(callSid,'123456'),{verified:true});}
test('inherited phone-only services verify OTP and execute one exact spoken-confirmed booking',async()=>{
 const f=fixture();assert.equal(typeof PhoneCallOperationCore,'function');assert.ok(f.authorization instanceof CallAuthorizationServiceBase);assert.ok(f.confirmations instanceof VoiceTaskConfirmationServiceBase);
 assert.equal(await f.authorization.current(callSid),null);await verified(f);assert.deepEqual((await f.authorization.current(callSid)).actor,actor);
 const p=await f.tasks.propose(callSid,'appointment.booking.request',args());await assert.rejects(f.tasks.execute(callSid,p.intentId));assert.equal(f.writes,0);
 const proof=await f.confirmations.prepare(callSid,p.intentId);assert.equal(proof.summary,p.summary);
 assert.deepEqual(await f.confirmations.accept(callSid,proof.challengeId,{speech:'Confirm appointment.'}),{approved:true});
 const outcomes=await Promise.allSettled([f.tasks.execute(callSid,p.intentId),f.tasks.execute(callSid,p.intentId)]);assert.equal(outcomes.filter(r=>r.status==='fulfilled').length,1);assert.equal(f.writes,1);
});
test('caller ID, account selection and speech cannot bypass OTP; send replay never resends',async()=>{
 const f=fixture();await assert.rejects(f.tasks.propose(callSid,'appointment.booking.request',args()));await f.authorization.start(callSid,'4277');
 assert.equal(await f.authorization.current(callSid),null);await assert.rejects(f.authorization.start(callSid,'4277'));assert.equal(f.sends,1);
 await assert.rejects(f.authorization.check(callSid,'yes'));assert.equal(f.checks,0);
 for(let i=0;i<5;i++)assert.deepEqual(await f.authorization.check(callSid,'999999'),{verified:false});
 await assert.rejects(f.authorization.check(callSid,'123456'));assert.equal(f.checks,5);assert.equal(await f.authorization.current(callSid),null);
});
test('call mismatch, missing account and denied permission never send OTP',async()=>{
 for(const mutate of [f=>f.call.accountSid='AC'+'e'.repeat(32),f=>f.call.to='+15550009999',f=>f.call.direction='outbound-api',f=>f.call.status='completed',f=>f.account.reference='9999',f=>f.deny()]){
  const f=fixture();mutate(f);await assert.rejects(f.authorization.start(callSid,'4277'));assert.equal(f.sends,0);
 }
});
test('contact/account revocation and call ending invalidate grants and block booking',async()=>{
 for(const mutate of [f=>f.account.contactVersion++,f=>f.account.directoryVersion++,f=>f.account.actor.tenantId='other',f=>f.call.status='completed',f=>f.deny()]){
  const f=fixture();await verified(f);mutate(f);assert.equal(await f.authorization.current(callSid),null);await assert.rejects(f.tasks.propose(callSid,'appointment.booking.request',args()));assert.equal(f.writes,0);
 }
});
test('uncertain OTP submission stays terminal without resend and code is absent from stored data',async()=>{
 const f=fixture();f.failProvider();await assert.rejects(f.authorization.start(callSid,'4277'));await assert.rejects(f.authorization.start(callSid,'4277'));assert.equal(f.sends,1);assert.equal(await f.authorization.current(callSid),null);
 const g=fixture();await verified(g);assert.ok(!JSON.stringify([...g.grants]).includes('123456'));
});
test('bare yes, negation, cancellation, silence and mixed inputs do not confirm',async()=>{
 for(const input of [{speech:'yes'},{speech:'do not confirm appointment'},{speech:'cancel'},{},{speech:'confirm appointment',digits:'1'},{digits:'2'}]){
  const f=fixture();await verified(f);const p=await f.tasks.propose(callSid,'appointment.booking.request',args()),c=await f.confirmations.prepare(callSid,p.intentId);
  assert.deepEqual(await f.confirmations.accept(callSid,c.challengeId,input),{approved:false});await assert.rejects(f.confirmations.accept(callSid,c.challengeId,{digits:'1'}));await assert.rejects(f.tasks.execute(callSid,p.intentId));assert.equal(f.writes,0);
 }
});
test('changed proposal/session, expired proof and callback replay cannot execute',async()=>{
 for(const mutate of [(f,p,c)=>f.intents.get(p.intentId).digest='e'.repeat(64),(f,p,c)=>f.grants.get(callSid).sessionId='replacement',(f,p,c)=>f.proofs.get(callSid).expiresAt=Date.now()-1]){
  const f=fixture();await verified(f);const p=await f.tasks.propose(callSid,'appointment.booking.request',args()),c=await f.confirmations.prepare(callSid,p.intentId);mutate(f,p,c);
  await assert.rejects(f.confirmations.accept(callSid,c.challengeId,{speech:'confirm appointment'}));assert.equal(f.writes,0);
 }
 const f=fixture();await verified(f);const p=await f.tasks.propose(callSid,'appointment.booking.request',args()),c=await f.confirmations.prepare(callSid,p.intentId);
 await f.confirmations.accept(callSid,c.challengeId,{digits:'1'});await assert.rejects(f.confirmations.accept(callSid,c.challengeId,{digits:'1'}));
});
test('signed phone adapter gathers account then isolates keypad OTP from AI',async()=>{
 const f=fixture(),a=new TwilioPhoneAuthorizationAdapter({...config,calls:f.authPorts.calls,authorization:f.authorization});assert.ok(a instanceof TwilioPrivateCallAdapterBase);
 const initial=await(await a.respond(request(config.startUrl))).text();assert.match(initial,/numDigits="4"/);
 const prompt=await(await a.respond(request(config.startUrl,{Digits:'4277'}))).text();assert.match(prompt,/numDigits="6"/);assert.doesNotMatch(prompt,/123456|alice|tenant-a|ConversationRelay/);
 const done=await(await a.respond(request(config.checkUrl,{Digits:'123456'}))).text();assert.match(done,/fixture.invalid\/resume/);assert.equal((await f.authorization.current(callSid)).authentication,'otp');
});
test('forged callbacks never send SMS or approve; signed speech is bound to challenge URL',async()=>{
 const f=fixture(),a=new TwilioPhoneAuthorizationAdapter({...config,calls:f.authPorts.calls,authorization:f.authorization});assert.equal((await a.respond(request(config.startUrl,{Digits:'4277'},'bad'))).status,403);assert.equal(f.sends,0);
 await verified(f);const p=await f.tasks.propose(callSid,'appointment.booking.request',args());
 const s=new TwilioSpokenConfirmationAdapter({...config,calls:f.authPorts.calls,confirmations:f.confirmations,pendingIntent:async()=>p.intentId});
 const xml=await(await s.respond(request(config.readbackUrl))).text();assert.ok(xml.indexOf('</Say>')<xml.indexOf('<Gather'));assert.match(xml,/confirm appointment/);assert.equal(f.writes,0);
 const challenge=f.proofs.get(callSid).challengeId,url=config.decisionUrl+'?challenge='+challenge;
 assert.equal((await s.respond(request(url,{SpeechResult:'confirm appointment'},'bad'))).status,403);
 const changed=config.decisionUrl+'?challenge='+crypto.randomUUID(),signed=request(url,{SpeechResult:'confirm appointment'});const replay=new Request(changed,{method:'POST',headers:signed.headers,body:await signed.text()});assert.equal((await s.respond(replay)).status,403);
 const result=await(await s.respond(request(url,{SpeechResult:'confirm appointment'}))).text();assert.match(result,/resume/);await f.tasks.execute(callSid,p.intentId);assert.equal(f.writes,1);
 const repeated=await(await s.respond(request(url,{SpeechResult:'confirm appointment'}))).text();assert.match(repeated,/reception/);assert.equal(f.writes,1);
});
