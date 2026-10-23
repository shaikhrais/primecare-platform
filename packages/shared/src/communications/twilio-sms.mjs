import {TwilioSignedFormAdapter,twilioSid,twilioPublicUrl,twilioFailure} from './twilio-webhook.mjs';
const statuses=new Set(['accepted','scheduled','queued','sending','sent','delivered','undelivered','failed','canceled']);
const e164=value=>typeof value==='string'&&/^\+[1-9][0-9]{1,14}$/.test(value);
/** Provider port only. A scoped outbox must claim once before invoking send.
 * SDK client must disable automatic retries; ambiguous acceptance must not resend.
 */
export class TwilioSmsTransport{
 #client;#account;#service;#sender;#callback;#max;
 constructor({client,accountSid,messagingServiceSid,sender,statusCallback,maxTextBytes}){
  if(typeof client?.messages?.create!=='function'||!twilioSid('AC',accountSid)||!twilioSid('MG',messagingServiceSid)||!e164(sender)||!Number.isSafeInteger(maxTextBytes)||maxTextBytes<1||maxTextBytes>6400)throw Error('SMS transport configuration required');
  this.#client=client;this.#account=accountSid;this.#service=messagingServiceSid;this.#sender=sender;this.#callback=twilioPublicUrl(statusCallback);this.#max=maxTextBytes;
 }
 async send(message){
  if(!message||typeof message!=='object'||Object.keys(message).some(key=>!['to','text'].includes(key))||!e164(message.to)||typeof message.text!=='string'||message.text.length>1600||!message.text.trim()||new TextEncoder().encode(message.text).length>this.#max||/[\u0000\u000b\u000c]/.test(message.text))throw Error('Invalid SMS');
  const to=message.to,body=message.text;
  try{
   const result=await this.#client.messages.create({to,body,from:this.#sender,messagingServiceSid:this.#service,statusCallback:this.#callback});
   if(!twilioSid('SM',result?.sid)||result.accountSid!==this.#account||result.messagingServiceSid!==this.#service||result.to!==to||result.from!==null&&result.from!==this.#sender||!statuses.has(result.status))throw Error('receipt');
   return {messageSid:result.sid,status:result.status};
  }catch{throw Error('SMS acceptance unknown');}
 }
}
/** All observations are preserved; terminal contradictions require reconciliation.
 * A delayed queued/sent event cannot overwrite a delivery result. No SMS read proof.
 */
export function smsDeliveryProjection(observations){
 if(!Array.isArray(observations)||observations.some(value=>!statuses.has(value)))throw Error('Invalid SMS status');
 const seen=new Set(observations),terminal=['delivered','undelivered','failed','canceled'].filter(value=>seen.has(value));
 if(terminal.length>1)return {status:'reconciliation_required',delivered:false};
 if(terminal.length===1)return {status:terminal[0],delivered:terminal[0]==='delivered'};
 for(const status of ['sent','sending','queued','scheduled','accepted'])if(seen.has(status))return {status,delivered:false};
 return {status:'unknown',delivered:false};
}
/** Thin receiver: record atomically before 204. Store must resolve provider SID to
 * a unique durable outbox mapping, dedupe observations, and quarantine early or
 * unmatched callbacks. Never infer tenant from From/To or untrusted custom fields.
 */
export class TwilioSmsStatusAdapter extends TwilioSignedFormAdapter{
 #store;#service;#sender;
 constructor(options){
  super(options);
  if(typeof options?.store?.record!=='function'||!twilioSid('MG',options.messagingServiceSid)||!e164(options.sender))throw Error('SMS callback configuration required');
  this.#store=options.store;this.#service=options.messagingServiceSid;this.#sender=options.sender;
 }
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;
  const p=checked.params;
  if(!twilioSid('SM',p.MessageSid)||typeof p.MessageStatus!=='string'||!statuses.has(p.MessageStatus)||p.MessagingServiceSid!==undefined&&p.MessagingServiceSid!==this.#service||p.From!==this.#sender||!e164(p.To)||p.ErrorCode!==undefined&&p.ErrorCode!==''&&(typeof p.ErrorCode!=='string'||!/^\d{1,8}$/.test(p.ErrorCode)))return twilioFailure(400);
  try{
   const disposition=await this.#store.record(Object.freeze({accountSid:p.AccountSid,messageSid:p.MessageSid,messagingServiceSid:this.#service,from:p.From,to:p.To,status:p.MessageStatus,errorCode:p.ErrorCode||null}));
   if(!['recorded','duplicate','quarantined'].includes(disposition))throw Error('durability');
   return new Response(null,{status:204,headers:{'cache-control':'no-store','x-content-type-options':'nosniff'}});
  }catch{return twilioFailure(503);}
 }
}
