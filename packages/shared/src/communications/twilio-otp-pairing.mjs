import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl,twilioSid,twilioFailure} from './twilio-webhook.mjs';
/** Pair outside the AI stream. Native app handles pairing + OTP entry; no OTP is
 * spoken to the agent. All continuation URLs are fixed registered host endpoints.
 */
export class TwilioOtpPairingAdapter extends TwilioSignedFormAdapter {
 constructor({accountSid,authToken,sharedNumber,pairingUrl,waitUrl,agentUrl,receptionUrl,maxWebhookBytes,service}){
  super({accountSid,authToken,webhookUrls:[pairingUrl,waitUrl],maxWebhookBytes});
  const urls=[pairingUrl,waitUrl,agentUrl,receptionUrl].map(twilioPublicUrl);
  if(typeof sharedNumber!=='string'||sharedNumber.trim()!==sharedNumber||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||new Set(urls).size!==4||new Set(urls.map(v=>new URL(v).origin)).size!==1||['issue','current','pending'].some(k=>typeof service?.[k]!=='function'))throw Error('Call pairing configuration required');
  this.config=Object.freeze({sharedNumber,pairingUrl,waitUrl,agentUrl,receptionUrl});this.service=service;
 }
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;const p=checked.params,c=this.config;
  if(!twilioSid('CA',p.CallSid)||p.To!==c.sharedNumber||p.Direction!=='inbound')return twilioFailure(403);
  const response=new VoiceResponse();
  try{
   if(request.url===c.pairingUrl){
    const result=await this.service.issue(p.CallSid);
    if(typeof result?.pairingCode!=='string'||result.pairingCode.length!==8||! /^[0-9]{8}$/.test(result.pairingCode)||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<=Date.now())throw Error('Pairing unavailable');
    response.say('To use account tasks, sign in to your PrimeCare app. Enter this call pairing code: '+result.pairingCode.split('').join(' ')+'. Then enter the verification code in the app. Do not read either code to the AI assistant.');
   }else if(await this.service.current(p.CallSid)){
    response.redirect({method:'POST'},c.agentUrl);return this.xml(response);
   }else if(!await this.service.pending(p.CallSid)){
    response.say('Account verification is unavailable. Connecting you to reception.');response.redirect({method:'POST'},c.receptionUrl);return this.xml(response);
   }
   response.pause({length:10});response.redirect({method:'POST'},c.waitUrl);return this.xml(response);
  }catch{response.say('Account verification is unavailable. Connecting you to reception.');response.redirect({method:'POST'},c.receptionUrl);return this.xml(response);}
 }
 xml(response){return new Response(response.toString(),{headers:{'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});}
}
