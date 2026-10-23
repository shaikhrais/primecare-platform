import Twilio from 'twilio/lib/rest/Twilio.js';
import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioSid,twilioFailure,twilioPublicUrl} from './twilio-webhook.mjs';
/** Read-only official SDK verifier. It cannot place calls or administer an account. */
export function createTwilioVoiceCallVerifier({accountSid,apiKeySid,apiKeySecret,httpClient}){
 if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||typeof apiKeySecret!=='string'||!/^[a-fA-F0-9]{32}$/.test(apiKeySecret)||httpClient!==undefined&&typeof httpClient?.request!=='function')throw Error('Voice credentials required');
 const client=new Twilio(apiKeySid,apiKeySecret,{accountSid,autoRetry:false,maxRetries:0,timeout:10000,...(httpClient?{httpClient}:{})});
 return Object.freeze({async fetch(callSid){
  if(!twilioSid('CA',callSid))throw Error('Voice unavailable');
  try{const row=await client.calls(callSid).fetch();return Object.freeze({sid:row.sid,accountSid:row.accountSid,from:row.from,direction:row.direction,status:row.status});}catch{throw Error('Voice unavailable');}
 }});
}
/** Exact signed TwiML App webhook; extensions only, never a phone/SIP dialer. */
export class TwilioExtensionConnectAdapter extends TwilioSignedFormAdapter {
 constructor({accountSid,authToken,webhookUrl,maxWebhookBytes,sharedNumber,service,dialCompleteUrl}){
  super({accountSid,authToken,webhookUrl,maxWebhookBytes});
  if(typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||typeof service?.connect!=='function')throw Error('Voice connect configuration required');
  if(dialCompleteUrl!==undefined&&(new URL(twilioPublicUrl(dialCompleteUrl)).origin!==new URL(webhookUrl).origin||dialCompleteUrl===webhookUrl))throw Error('Voicemail callback URL required');
  Object.defineProperties(this,{dialCompleteUrl:{value:dialCompleteUrl},sharedNumber:{value:sharedNumber},service:{value:service}});
 }
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;
  const p=checked.params;
  if(!twilioSid('CA',p.CallSid)||typeof p.From!=='string'||!/^client:primecare_[a-f0-9]{64}$/.test(p.From)||p.Direction!=='inbound'||typeof p.CallerExtension!=='string'||! /^[1-9][0-9]{5}$/.test(p.CallerExtension)||typeof p.TargetExtension!=='string'||! /^[1-9][0-9]{5}$/.test(p.TargetExtension))return twilioFailure(403);
  try{
   const result=await this.service.connect({callSid:p.CallSid,from:p.From,callerExtension:p.CallerExtension,targetExtension:p.TargetExtension});
   if(typeof result?.identity!=='string'||!/^primecare_[a-f0-9]{64}$/.test(result.identity))throw Error('Voice unavailable');
   const response=new VoiceResponse();response.dial({callerId:this.sharedNumber,answerOnBridge:true,timeout:20,...(this.dialCompleteUrl?{action:this.dialCompleteUrl,method:'POST'}:{})}).client().identity(result.identity);response.hangup();
   return new Response(response.toString(),{headers:{'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});
  }catch{return twilioFailure(503);}
 }
}
