import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl,twilioSid,twilioFailure} from './twilio-webhook.mjs';
const headers={'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'};
const xml=response=>new Response(response.toString(),{headers});
function urls(values){const list=values.map(twilioPublicUrl);if(new Set(list).size!==list.length||new Set(list.map(v=>new URL(v).origin)).size!==1||list.some(v=>new URL(v).search))throw Error('Private call URLs required');return list;}
/** Shared signed-provider lifecycle. No model arguments choose a destination,
 * identity, phone, account SID or confirmation decision. All redirects are fixed.
 */
export class TwilioPrivateCallAdapterBase extends TwilioSignedFormAdapter {
 constructor(options,webhookUrls){
  super({...options,webhookUrls});
  if(typeof options.calls?.fetch!=='function'||!/^\+[1-9][0-9]{1,14}$/.test(options.sharedNumber))throw Error('Private call ports required');
  const [receptionUrl,resumeUrl]=urls([options.receptionUrl,options.resumeUrl]);
  this.privateConfig=Object.freeze({accountSid:options.accountSid,sharedNumber:options.sharedNumber,receptionUrl,resumeUrl});this.calls=options.calls;
 }
 async live(params){
  if(!twilioSid('CA',params.CallSid)||params.Direction!=='inbound'||params.To!==this.privateConfig.sharedNumber)throw Error('Call unavailable');
  const call=await this.calls.fetch(params.CallSid),c=this.privateConfig;
  if(call?.sid!==params.CallSid||call.accountSid!==c.accountSid||call.to!==c.sharedNumber||call.direction!=='inbound'||call.status!=='in-progress')throw Error('Call unavailable');
 }
 redirect(url){const r=new VoiceResponse();r.redirect({method:'POST'},url);return xml(r);}
 reception(){return this.redirect(this.privateConfig.receptionUrl);}
}
/** Dedicated Gather pauses the AI stream. Six-digit OTP goes straight from the
 * signed keypad callback to Verify; it is not sent to the AI or persisted/logged.
 * Four-digit account extension selects only a candidate; OTP authenticates it. */
export class TwilioPhoneAuthorizationAdapter extends TwilioPrivateCallAdapterBase {
 constructor(options){
  const [startUrl,checkUrl]=urls([options.startUrl,options.checkUrl,options.receptionUrl,options.resumeUrl]);super(options,[startUrl,checkUrl]);
  if(typeof options.authorization?.start!=='function'||typeof options.authorization?.check!=='function')throw Error('Call authorization service required');
  this.startUrl=startUrl;this.checkUrl=checkUrl;this.authorization=options.authorization;
 }
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;const p=checked.params;
  try{
   await this.live(p);
   if(request.url===this.startUrl){
    if(p.Digits===undefined){const r=new VoiceResponse();r.gather({input:'dtmf',numDigits:4,timeout:10,action:this.startUrl,method:'POST'}).say('Enter your four digit PrimeCare account extension.');r.redirect({method:'POST'},this.privateConfig.receptionUrl);return xml(r);}
    if(typeof p.Digits!=='string'||!/^[1-9][0-9]{3}$/.test(p.Digits)||p.SpeechResult!==undefined)return twilioFailure(400);
    const result=await this.authorization.start(p.CallSid,p.Digits);if(result?.verificationRequested!==true)throw Error('Authorization unavailable');
    const r=new VoiceResponse();r.gather({input:'dtmf',numDigits:6,timeout:30,action:this.checkUrl,method:'POST'}).say('Enter the six digit verification code sent to your registered phone. Do not say the code aloud.');r.redirect({method:'POST'},this.privateConfig.receptionUrl);return xml(r);
   }
   if(typeof p.Digits!=='string'||!/^[0-9]{6}$/.test(p.Digits)||p.SpeechResult!==undefined)return twilioFailure(400);
   const result=await this.authorization.check(p.CallSid,p.Digits);
   return result?.verified===true?this.redirect(this.privateConfig.resumeUrl):this.reception();
  }catch{return this.reception();}
 }
}
/** Readback is outside the LLM. The server resolves the pending intent for this
 * canonical call. Its random challenge appears in the signed action URL, so an
 * old signed 'confirm appointment' callback cannot approve a later proposal. */
export class TwilioSpokenConfirmationAdapter extends TwilioPrivateCallAdapterBase {
 constructor(options){
  const [readbackUrl,decisionUrl]=urls([options.readbackUrl,options.decisionUrl,options.receptionUrl,options.resumeUrl]);super(options,[readbackUrl]);
  if(typeof options.confirmations?.prepare!=='function'||typeof options.confirmations?.accept!=='function'||typeof options.pendingIntent!=='function')throw Error('Spoken confirmation ports required');
  this.options=Object.freeze({...options});this.readbackUrl=readbackUrl;this.decisionUrl=decisionUrl;
 }
 async respond(request){
  let checked,challenge;
  if(request.url===this.readbackUrl)checked=await this.validate(request);
  else{
   const url=new URL(request.url),expected=new URL(this.decisionUrl);challenge=url.searchParams.get('challenge');
   if(url.origin!==expected.origin||url.pathname!==expected.pathname||url.hash||url.username||url.password||[...url.searchParams].length!==1||!/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(challenge??'')||url.search!=='?challenge='+challenge)return twilioFailure(404);
   // The URL is tightly constrained before invoking the inherited signature
   // validator. No provider body is inspected before signature verification.
   const signed=new TwilioSignedFormAdapter({accountSid:this.options.accountSid,authToken:this.options.authToken,webhookUrl:request.url,maxWebhookBytes:this.maxBytes});checked=await signed.validate(request);
  }
  if(checked.response)return checked.response;const p=checked.params;
  try{
   await this.live(p);
   if(challenge===undefined){
    const intentId=await this.options.pendingIntent(p.CallSid),proof=await this.options.confirmations.prepare(p.CallSid,intentId);
    if(typeof proof.summary!=='string'||!proof.summary.trim()||proof.summary.length>1000||/[\u0000-\u001f\u007f]/.test(proof.summary)||! /^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(proof.challengeId)||!Number.isSafeInteger(proof.expiresAt)||proof.expiresAt<=Date.now())throw Error('Readback unavailable');
    const r=new VoiceResponse();r.say(proof.summary);
    // No Gather is open during the exact summary, preventing early barge-in
    // from becoming approval of details that have not yet been read aloud.
    r.gather({input:'speech dtmf',numDigits:1,language:'en-US',speechTimeout:'auto',timeout:10,actionOnEmptyResult:true,action:this.decisionUrl+'?challenge='+proof.challengeId,method:'POST'}).say('To submit this appointment request, say confirm appointment or press 1. Otherwise say cancel or press 2.');
    r.redirect({method:'POST'},this.privateConfig.receptionUrl);return xml(r);
   }
   if(p.SpeechResult!==undefined&&typeof p.SpeechResult!=='string'||p.Digits!==undefined&&typeof p.Digits!=='string')return twilioFailure(400);
   const result=await this.options.confirmations.accept(p.CallSid,challenge,{...(p.SpeechResult===undefined?{}:{speech:p.SpeechResult}),...(p.Digits===undefined?{}:{digits:p.Digits})});
   return result?.approved===true?this.redirect(this.privateConfig.resumeUrl):this.reception();
  }catch{return this.reception();}
 }
}
