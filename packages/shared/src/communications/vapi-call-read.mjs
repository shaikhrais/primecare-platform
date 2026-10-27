import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
const uuid=value=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(value);
const sid=(prefix,value)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-f0-9]{32}$','i').test(value);
export class VapiCallReadError extends Error{constructor(code){super('Vapi call verification unavailable');this.code=code;}}
/** Read-only provider port. No call creation, updates, credentials or tools API.
 * Raw call responses can contain transcripts, tokens and recording URLs. Only
 * lifecycle and routing projections leave this inherited bounded adapter.
 * Field source: official @vapi-ai/server-sdk 3.0.0 Call/TwilioTransport.
 */
export class VapiCallReadClient extends BoundedBinaryAdapterBase{
 #key;#fetch;
 constructor({apiKey,fetch:request=globalThis.fetch}){
  super(524288);if(typeof apiKey!=='string'||apiKey.length<16||apiKey.length>512||/\s/.test(apiKey)||typeof request!=='function')throw new VapiCallReadError('configuration_required');this.#key=apiKey;this.#fetch=request;
 }
 async fetch(id){
  if(!uuid(id))throw new VapiCallReadError('invalid_resource');
  try{
   const send=this.#fetch;const response=await send('https://api.vapi.ai/call/'+id,{method:'GET',redirect:'manual',signal:AbortSignal.timeout(10000),headers:{authorization:'Bearer '+this.#key,accept:'application/json'}});
   if(!response.ok){await response.body?.cancel();throw new VapiCallReadError(response.status===404?'resource_not_found':[401,403].includes(response.status)?'authentication_denied':'provider_unavailable');}
   const row=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(response.body)));
   if(!row||row.id!==id||!uuid(row.orgId)||!uuid(row.assistantId)||!uuid(row.phoneNumberId)||!['inboundPhoneCall','outboundPhoneCall','webCall','vapi.websocketCall'].includes(row.type)||!['scheduled','queued','ringing','in-progress','forwarding','ended','not-found','deletion-failed'].includes(row.status))throw new VapiCallReadError('invalid_provider_response');
   const transport=row.transport;
   if(row.phoneCallProvider!==undefined&&!['twilio','vonage','vapi','telnyx'].includes(row.phoneCallProvider)||row.phoneCallProviderId!==undefined&&!sid('CA',row.phoneCallProviderId)||transport!==undefined&&(!transport||typeof transport!=='object'||Array.isArray(transport))||transport?.callSid!==undefined&&!sid('CA',transport.callSid)||transport?.accountSid!==undefined&&!sid('AC',transport.accountSid))throw new VapiCallReadError('invalid_provider_response');
   if(transport?.provider!==undefined&&!['twilio','vonage','vapi.websocket','vapi.sip','telnyx','daily'].includes(transport.provider)||transport?.conversationType!==undefined&&!['voice','chat'].includes(transport.conversationType)||[row.startedAt,row.endedAt].some(value=>value!==undefined&&value!==null&&(typeof value!=='string'||value.length>40||!Number.isFinite(Date.parse(value)))))throw new VapiCallReadError('invalid_provider_response');
   return Object.freeze({id:row.id,orgId:row.orgId,assistantId:row.assistantId,phoneNumberId:row.phoneNumberId,type:row.type,status:row.status,provider:row.phoneCallProvider??null,callSid:row.phoneCallProviderId??transport?.callSid??null,transportProvider:transport?.provider??null,transportCallSid:transport?.callSid??null,transportAccountSid:transport?.accountSid??null,conversationType:transport?.conversationType??null,startedAt:typeof row.startedAt==='string'?row.startedAt:null,ended:row.endedAt!==undefined&&row.endedAt!==null});
  }catch(error){if(error instanceof VapiCallReadError)throw error;throw new VapiCallReadError('provider_unavailable');}
 }
}
/** Composition port, not user authentication. Re-read Vapi around an independent
 * Twilio lookup; no caller/model-supplied account, number or Twilio SID is used.
 * Every invocation rechecks providers. No positive result is cached. OTP/passkey,
 * native session, tenant policy and exact task approval are still mandatory.
 */
export function createVapiCanonicalCallDirectory({vapi,twilio,orgId,assistantId,phoneNumberId,accountSid,sharedNumber,ownerTest}){
 if(typeof vapi?.fetch!=='function'||typeof twilio?.fetch!=='function'||[orgId,assistantId,phoneNumberId].some(id=>!uuid(id))||!sid('AC',accountSid)||typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{6,14}$/.test(sharedNumber))throw new VapiCallReadError('configuration_required');
 if(ownerTest!==undefined&&(!uuid(ownerTest.callId)||typeof ownerTest.customerPhone!=='string'||!/^\+[1-9][0-9]{6,14}$/.test(ownerTest.customerPhone)||!Number.isSafeInteger(ownerTest.expiresAt)))throw new VapiCallReadError('configuration_required');
 const ownerCall=id=>ownerTest?.callId===id&&ownerTest.expiresAt>Date.now();
 const readVapi=vapi.fetch.bind(vapi),readTwilio=twilio.fetch.bind(twilio);
 const active=(row,id)=>{
  const started=Date.parse(row?.startedAt);
  return row?.id===id&&row.orgId===orgId&&row.assistantId===assistantId&&row.phoneNumberId===phoneNumberId&&(row.type==='inboundPhoneCall'||ownerCall(id)&&row.type==='outboundPhoneCall')&&row.status==='in-progress'&&(row.provider===null||row.provider==='twilio')&&row.transportProvider==='twilio'&&row.conversationType==='voice'&&sid('CA',row.callSid)&&row.transportCallSid===row.callSid&&row.transportAccountSid===accountSid&&!row.ended&&Number.isFinite(started)&&started<=Date.now()+5000&&started+600000>Date.now();
 };
 return Object.freeze({async current(id){
  if(!uuid(id))return null;
  try{
   const first=await readVapi(id);if(!active(first,id))return null;
   const call=await readTwilio(first.callSid);
   if(!call||call.sid!==first.callSid||call.accountSid!==accountSid||!(first.type==='inboundPhoneCall'?call.to===sharedNumber&&call.direction==='inbound':ownerCall(id)&&call.from===sharedNumber&&call.to===ownerTest.customerPhone&&call.direction==='outbound-api')||call.status!=='in-progress')return null;
   const latest=await readVapi(id);
   if(!active(latest,id)||latest.callSid!==first.callSid||latest.startedAt!==first.startedAt||latest.type!==first.type)return null;
   return Object.freeze({vapiCallId:id,callSid:first.callSid,orgId,assistantId,phoneNumberId,active:true,expiresAt:Math.min(Date.now()+10000,Date.parse(latest.startedAt)+600000)});
  }catch{return null;}
 }});
}
