import {TwilioSignedFormAdapter,twilioSid,twilioFailure} from './twilio-webhook.mjs';

const phone=value=>typeof value==='string'&&/^\+[1-9][0-9]{1,14}$/.test(value);
const encoder=new TextEncoder();
/** Signed provider boundary only. Persist before acknowledgement; never invoke an
 * LLM or infer a tenant/account from the sending phone number in this webhook.
 * MMS is durably quarantined until its bounded private-media pipeline is wired.
 */
export class TwilioSmsInboundAdapter extends TwilioSignedFormAdapter {
 #store;#sender;#service;
 constructor(options){
  super(options);
  if(typeof options?.store?.accept!=='function'||!phone(options.sender)||!twilioSid('MG',options.messagingServiceSid))throw Error('SMS inbound configuration required');
  this.#store=options.store;this.#sender=options.sender;this.#service=options.messagingServiceSid;
 }
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;
  const p=checked.params;
  if(!twilioSid('SM',p.MessageSid)||!phone(p.From)||p.To!==this.#sender||p.MessagingServiceSid!==undefined&&p.MessagingServiceSid!==this.#service||
   typeof p.Body!=='string'||p.Body.length>1600||encoder.encode(p.Body).length>6400||/[\u0000\u000b\u000c]/.test(p.Body)||
   typeof p.NumMedia!=='string'||! /^(?:[0-9]|10)$/.test(p.NumMedia)||!p.Body.trim()&&p.NumMedia==='0'||
   p.OptOutType!==undefined&&!['STOP','START','HELP'].includes(p.OptOutType))return twilioFailure(400);
  const keyword=p.Body.trim().toUpperCase();
  // Advanced Opt-Out is authoritative when present. A standalone STOP still
  // suppresses AI processing if provider Advanced Opt-Out is not configured.
  const control=p.OptOutType??(['STOP','STOPALL','UNSUBSCRIBE','CANCEL','END','QUIT','REVOKE','OPTOUT'].includes(keyword)?'STOP':
   ['START','UNSTOP'].includes(keyword)?'START':keyword==='HELP'?'HELP':null);
  const event=Object.freeze({provider:'twilio',channel:'sms',accountSid:p.AccountSid,messageSid:p.MessageSid,
   messagingServiceSid:this.#service,from:p.From,to:p.To,text:p.Body,mediaCount:Number(p.NumMedia),control});
  try{
   const result=await this.#store.accept(event);
   if(!['recorded','duplicate','quarantined'].includes(result))throw Error('durability');
   // Empty TwiML acknowledges receipt. Replies go through a separately claimed
   // outbox, after account linking, policy and current opt-out checks.
   return new Response('<Response/>',{status:200,headers:{'content-type':'text/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});
  }catch{return twilioFailure(503);}
 }
}
