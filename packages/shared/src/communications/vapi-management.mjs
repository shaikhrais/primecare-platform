import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
const uuid=value=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(value);
const fail=code=>new VapiManagementError(code);
export class VapiManagementError extends Error {
 constructor(code){super('Vapi management request unavailable');this.code=code;}
}
/** Server-only management port. Fixed provider origin, bounded private reads and
 * narrowly scoped synthetic chat tests; no phone routing, calls or SMS writes.
 * Raw provider objects (which can contain Twilio credentials) never escape.
 */
export class VapiManagementClient extends BoundedBinaryAdapterBase {
 #key;#fetch;
 constructor({apiKey,fetch:request=globalThis.fetch}){
  super(524288);
  if(typeof apiKey!=='string'||apiKey.length<16||apiKey.length>512||/\s/.test(apiKey)||typeof request!=='function')throw fail('configuration_required');
  this.#key=apiKey;this.#fetch=request;
 }
 async #request(path,body){
  try{
   const response=await this.#fetch('https://api.vapi.ai'+path,{method:body===undefined?'GET':'POST',redirect:'error',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body===undefined?{}:{'content-type':'application/json'})},...(body===undefined?{}:{body:JSON.stringify(body)})});
   if(!response.ok){try{await response.body?.cancel();}catch{}throw fail(response.status===402?'payment_required':[401,403].includes(response.status)?'authentication_denied':response.status===404?'resource_not_found':'provider_unavailable');}
   const bytes=await this.readBoundedBody(response.body);
   const data=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));
   if(!data||typeof data!=='object'||Array.isArray(data))throw fail('invalid_provider_response');
   return data;
  }catch(error){if(error instanceof VapiManagementError)throw error;throw fail('provider_unavailable');}
 }
 async assistant(id){
  if(!uuid(id))throw fail('invalid_resource');const row=await this.#request('/assistant/'+id);
  if(row.id!==id||!uuid(row.orgId)||typeof row.name!=='string'||typeof row.firstMessage!=='string'||!row.model||!Array.isArray(row.model.messages))throw fail('invalid_provider_response');
  const messages=row.model.messages;
  if(messages.length>100||messages.some(m=>!m||typeof m.role!=='string'||typeof m.content!=='string'))throw fail('invalid_provider_response');
  const prompt=messages.filter(m=>m.role==='system').map(m=>m.content).join('\n');
  if(prompt.length>65536||row.name.length>200||row.firstMessage.length>4000)throw fail('invalid_provider_response');
  const arrays=[row.model.tools,row.model.toolIds,row.model.functions];
  if(arrays.some(a=>a!==undefined&&!Array.isArray(a)))throw fail('invalid_provider_response');
  return Object.freeze({id:row.id,orgId:row.orgId,name:row.name,firstMessage:row.firstMessage,prompt,
   toolCount:arrays.reduce((count,a)=>count+(a?.length??0),0),serverConfigured:!!row.server?.url,
   recordingDisabled:row.artifactPlan?.recordingEnabled===false||row.artifactPlan?.recordingEnabled===undefined&&row.recordingEnabled===false,
   maxDurationSeconds:row.maxDurationSeconds});
 }
 async phoneNumber(id){
  if(!uuid(id))throw fail('invalid_resource');const row=await this.#request('/phone-number/'+id);
  if(row.id!==id||!uuid(row.orgId)||typeof row.number!=='string'||!/^\+[1-9][0-9]{6,14}$/.test(row.number)||typeof row.provider!=='string'||row.assistantId!==undefined&&row.assistantId!==null&&!uuid(row.assistantId))throw fail('invalid_provider_response');
  return Object.freeze({id:row.id,orgId:row.orgId,number:row.number,provider:row.provider,assistantId:row.assistantId??null,squadConfigured:!!row.squadId,workflowConfigured:!!row.workflowId,serverConfigured:!!row.server?.url});
 }
 async syntheticChat(id,input){
  if(!uuid(id)||typeof input!=='string'||input.length<1||input.length>2000)throw fail('invalid_test');
  // Re-read saved configuration before each test. A chat test must never invoke
  // a subsequently attached booking, transfer, SMS or custom function tool.
  const assistant=await this.assistant(id);
  if(assistant.toolCount!==0||assistant.serverConfigured)throw fail('test_scope_changed');
  const row=await this.#request('/chat',{assistantId:id,input});
  if(row.assistantId!==id||!Array.isArray(row.output)||!row.output.length||row.output.length>20||row.output.some(item=>item?.role!=='assistant'||typeof item.content!=='string'))throw fail('invalid_provider_response');
  const answer=row.output.map(item=>item.content).join('\n');
  if(!answer.trim()||answer.length>8000||answer.includes(this.#key))throw fail('invalid_provider_response');
  return Object.freeze({answer,scope:'synthetic_text_only',voiceVerified:false,businessActionsVerified:false});
 }
}
