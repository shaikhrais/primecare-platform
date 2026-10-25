// Actual workerd, official signed callbacks and TwiML. Synthetic account/provider
// and booking request only; no production endpoint or phone call is contacted.
import assert from 'node:assert/strict';import {builtinModules} from 'node:module';import {build} from 'esbuild';import {Miniflare} from 'miniflare';import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
const origin='https://fixture.invalid',accountSid='AC'+'a'.repeat(32),callSid='CA'+'b'.repeat(32),authToken='d'.repeat(32),sharedNumber='+15550001000';
const bundle=await build({stdin:{contents:`
import {fixture,args,callSid} from './scripts/fixtures/business-phone-call.mjs';
import {TwilioPhoneAuthorizationAdapter,TwilioSpokenConfirmationAdapter} from './packages/shared/src/communications/twilio-phone-authorization.mjs';
const f=fixture();let pending;
const options={accountSid:'${accountSid}',authToken:'${authToken}',sharedNumber:'${sharedNumber}',maxWebhookBytes:4096,startUrl:'${origin}/auth',checkUrl:'${origin}/check',readbackUrl:'${origin}/readback',decisionUrl:'${origin}/decision',receptionUrl:'${origin}/reception',resumeUrl:'${origin}/resume',calls:f.authPorts.calls};
const auth=new TwilioPhoneAuthorizationAdapter({...options,authorization:f.authorization});
const confirmation=new TwilioSpokenConfirmationAdapter({...options,confirmations:f.confirmations,pendingIntent:async()=>pending.intentId});
export default {async fetch(request){
 const path=new URL(request.url).pathname;
 if(path==='/fixture-propose'){pending=await f.tasks.propose(callSid,'appointment.booking.request',args());return Response.json(pending);}
 if(path==='/fixture-execute'){try{return Response.json(await f.tasks.execute(callSid,pending.intentId));}catch{return new Response(null,{status:409});}}
 if(path==='/fixture-probe')return Response.json({writes:f.writes,sends:f.sends,proof:f.proofs.get(callSid)});
 return (path==='/auth'||path==='/check'?auth:confirmation).respond(request);
}};
`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',mainFields:['module','main'],external:['node:*',...new Set(builtinModules.map(x=>x.replace(/^node:/,'')))],banner:{js:'import {createRequire} from "node:module";const require=createRequire("/worker.js");'},write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat']});
function signed(path,changes={},signature){const url=origin+path,p={AccountSid:accountSid,CallSid:callSid,Direction:'inbound',To:sharedNumber,...changes};return runtime.dispatchFetch(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(authToken,url,p)},body:new URLSearchParams(p).toString()});}
try{
 assert.equal((await signed('/auth',{Digits:'4277'},'bad')).status,403);
 assert.match(await(await signed('/auth',{Digits:'4277'})).text(),/numDigits="6"/);
 assert.match(await(await signed('/check',{Digits:'123456'})).text(),/resume/);
 const proposal=await(await runtime.dispatchFetch(origin+'/fixture-propose')).json();assert.equal(proposal.requiresConfirmation,true);
 assert.equal((await runtime.dispatchFetch(origin+'/fixture-execute')).status,409);
 const xml=await(await signed('/readback')).text();assert.ok(xml.indexOf('</Say>')<xml.indexOf('<Gather'));
 const probe=await(await runtime.dispatchFetch(origin+'/fixture-probe')).json(),path='/decision?challenge='+probe.proof.challengeId;assert.equal(probe.writes,0);
 assert.equal((await signed(path,{SpeechResult:'confirm appointment'},'bad')).status,403);
 assert.match(await(await signed(path,{SpeechResult:'confirm appointment'})).text(),/resume/);
 assert.equal((await(await runtime.dispatchFetch(origin+'/fixture-execute')).json()).status,'completed');
 assert.equal((await runtime.dispatchFetch(origin+'/fixture-execute')).status,409);
 assert.equal((await(await runtime.dispatchFetch(origin+'/fixture-probe')).json()).writes,1);
 console.log('WORKERD_PHONE_CALL_PASS 12');
}finally{await runtime.dispose();}
