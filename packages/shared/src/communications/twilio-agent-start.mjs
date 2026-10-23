import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl,twilioSid,twilioFailure} from './twilio-webhook.mjs';
export function verifiedAgentIdentity(value){
 if(value?.active!==true||!['otp','passkey'].includes(value.authentication)||!Number.isSafeInteger(value.expiresAt)||value.expiresAt<=Date.now()||[value.sessionId,value.actor?.id,value.actor?.tenantId].some(v=>typeof v!=='string'||!v.trim()||v.length>200||/[\u0000-\u001f\u007f]/.test(v)))throw Error('Verification unavailable');
 return Object.freeze({actor:Object.freeze({id:value.actor.id,tenantId:value.actor.tenantId}),sessionId:value.sessionId,authentication:value.authentication,active:true,expiresAt:value.expiresAt});
}
export const sameAgentIdentity=(a,b)=>a.actor.id===b.actor.id&&a.actor.tenantId===b.actor.tenantId&&a.sessionId===b.sessionId&&a.authentication===b.authentication;
/** Shared canonical Call + broker guard for startup and socket lifecycles. */
export function createVerifiedAgentCallGuard({accountSid,sharedNumber,calls,identities,authorize}){
 if(!twilioSid('AC',accountSid)||typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||typeof calls?.fetch!=='function'||typeof identities?.current!=='function'||typeof authorize!=='function')throw Error('Voice verification ports required');
 const status=async callSid=>{if(!twilioSid('CA',callSid))throw Error('Call unavailable');const row=await calls.fetch(callSid);if(row?.sid!==callSid||row.accountSid!==accountSid||row.to!==sharedNumber||row.direction!=='inbound'||typeof row.status!=='string')throw Error('Call unavailable');return row.status;};
 return Object.freeze({status,async current(callSid){const before=verifiedAgentIdentity(await identities.current(callSid));if(await status(callSid)!=='in-progress'||await authorize(before,callSid)!==true)throw Error('Call unavailable');const after=verifiedAgentIdentity(await identities.current(callSid));if(!sameAgentIdentity(before,after))throw Error('Call unavailable');return after;}});
}
/** Signed, bounded TwiML startup after private app OTP verification.
 * No WebSocket upgrade, LLM, task execution, route mount or permission grant.
 * Socket host must independently validate the handshake and bind setup.callSid
 * to the canonical Call and current broker before sending/accepting model data. */
export class TwilioVerifiedAgentAdapter extends TwilioSignedFormAdapter {
 #config;#guard;
 constructor({accountSid,authToken,sharedNumber,agentUrl,completeUrl,receptionUrl,socketUrl,greeting,maxWebhookBytes,calls,identities,authorize}){
  super({accountSid,authToken,webhookUrls:[agentUrl,completeUrl],maxWebhookBytes});
  const urls=[agentUrl,completeUrl,receptionUrl].map(twilioPublicUrl),socket=new URL(socketUrl),origin=new URL(agentUrl);
  if(typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||sharedNumber.trim()!==sharedNumber||new Set(urls).size!==3||new Set(urls.map(v=>new URL(v).origin)).size!==1||urls.some(v=>new URL(v).search)||socket.protocol!=='wss:'||socket.host!==origin.host||socket.username||socket.password||socket.hash||socket.search||socket.href!==socketUrl||urls.some(v=>new URL(v).pathname===socket.pathname)||typeof greeting!=='string'||!greeting.trim()||greeting.length>500||/[\u0000-\u001f\u007f]/.test(greeting)||typeof calls?.fetch!=='function'||typeof identities?.current!=='function'||typeof authorize!=='function')throw Error('Voice agent configuration required');
  this.#config=Object.freeze({accountSid,sharedNumber,agentUrl,completeUrl,receptionUrl,socketUrl,greeting});this.#guard=createVerifiedAgentCallGuard({accountSid,sharedNumber,calls,identities,authorize});
 }
 #xml(response){return new Response(response.toString(),{headers:{'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});}
 #reception(){const response=new VoiceResponse();response.redirect({method:'POST'},this.#config.receptionUrl);return this.#xml(response);}
 async respond(request){
  const checked=await this.validate(request);if(checked.response)return checked.response;const p=checked.params,c=this.#config;
  if(!twilioSid('CA',p.CallSid)||p.Direction!=='inbound'||request.url===c.agentUrl&&p.To!==c.sharedNumber)return twilioFailure(403);
  let status;try{status=await this.#guard.status(p.CallSid);}catch{return twilioFailure(503);}
  if(status!=='in-progress'){const response=new VoiceResponse();response.hangup();return this.#xml(response);}
  // Never use model-produced HandoffData to choose a destination or restart AI.
  if(request.url===c.completeUrl)return this.#reception();
  try{
   await this.#guard.current(p.CallSid);
   const response=new VoiceResponse();response.say(c.greeting);response.connect({action:c.completeUrl,method:'POST'}).conversationRelay({url:c.socketUrl});
   return this.#xml(response);
  }catch{return this.#reception();}
 }
}
