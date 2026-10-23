import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl,twilioSid,twilioFailure} from './twilio-webhook.mjs';
function identity(value){
 if(value?.active!==true||!['otp','passkey'].includes(value.authentication)||!Number.isSafeInteger(value.expiresAt)||value.expiresAt<=Date.now()||[value.sessionId,value.actor?.id,value.actor?.tenantId].some(v=>typeof v!=='string'||!v.trim()||v.length>200||/[\u0000-\u001f\u007f]/.test(v)))throw Error('Verification unavailable');
 return Object.freeze({actor:Object.freeze({id:value.actor.id,tenantId:value.actor.tenantId}),sessionId:value.sessionId,authentication:value.authentication,active:true,expiresAt:value.expiresAt});
}
/** Signed, bounded TwiML startup after private app OTP verification.
 * No WebSocket upgrade, LLM, task execution, route mount or permission grant.
 * Socket host must independently validate the handshake and bind setup.callSid
 * to the canonical Call and current broker before sending/accepting model data. */
export class TwilioVerifiedAgentAdapter extends TwilioSignedFormAdapter {
 #config;#calls;#identities;#authorize;
 constructor({accountSid,authToken,sharedNumber,agentUrl,completeUrl,receptionUrl,socketUrl,greeting,maxWebhookBytes,calls,identities,authorize}){
  super({accountSid,authToken,webhookUrls:[agentUrl,completeUrl],maxWebhookBytes});
  const urls=[agentUrl,completeUrl,receptionUrl].map(twilioPublicUrl),socket=new URL(socketUrl),origin=new URL(agentUrl);
  if(typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||sharedNumber.trim()!==sharedNumber||new Set(urls).size!==3||new Set(urls.map(v=>new URL(v).origin)).size!==1||urls.some(v=>new URL(v).search)||socket.protocol!=='wss:'||socket.host!==origin.host||socket.username||socket.password||socket.hash||socket.search||socket.href!==socketUrl||urls.some(v=>new URL(v).pathname===socket.pathname)||typeof greeting!=='string'||!greeting.trim()||greeting.length>500||/[\u0000-\u001f\u007f]/.test(greeting)||typeof calls?.fetch!=='function'||typeof identities?.current!=='function'||typeof authorize!=='function')throw Error('Voice agent configuration required');
  this.#config=Object.freeze({accountSid,sharedNumber,agentUrl,completeUrl,receptionUrl,socketUrl,greeting});this.#calls=calls;this.#identities=identities;this.#authorize=authorize;
 }
 async #call(callSid){
  const row=await this.#calls.fetch(callSid),c=this.#config;
  if(row?.sid!==callSid||row.accountSid!==c.accountSid||row.to!==c.sharedNumber||row.direction!=='inbound'||typeof row.status!=='string')throw Error('Call unavailable');
  return row.status;
 }
 #xml(response){return new Response(response.toString(),{headers:{'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});}
 #reception(){const response=new VoiceResponse();response.redirect({method:'POST'},this.#config.receptionUrl);return this.#xml(response);}
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;const p=checked.params,c=this.#config;
  if(!twilioSid('CA',p.CallSid)||p.Direction!=='inbound'||request.url===c.agentUrl&&p.To!==c.sharedNumber)return twilioFailure(403);
  let status;try{status=await this.#call(p.CallSid);}catch{return twilioFailure(503);}
  if(status!=='in-progress'){const response=new VoiceResponse();response.hangup();return this.#xml(response);}
  // Never use model-produced HandoffData to choose a destination or restart AI.
  if(request.url===c.completeUrl)return this.#reception();
  try{
   const before=identity(await this.#identities.current(p.CallSid));
   if(await this.#authorize(before,p.CallSid)!==true)return this.#reception();
   if(await this.#call(p.CallSid)!=='in-progress')return this.#reception();
   const after=identity(await this.#identities.current(p.CallSid));
   if(after.actor.id!==before.actor.id||after.actor.tenantId!==before.actor.tenantId||after.sessionId!==before.sessionId||after.authentication!==before.authentication)return this.#reception();
   const response=new VoiceResponse();response.say(c.greeting);response.connect({action:c.completeUrl,method:'POST'}).conversationRelay({url:c.socketUrl});
   return this.#xml(response);
  }catch{return this.#reception();}
 }
}
