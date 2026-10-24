import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
const uuid=value=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(value);
const fail=code=>new VapiManagementError(code);
export class VapiManagementError extends Error {
 constructor(code){super('Vapi management request unavailable');this.code=code;}
}
/** Server-only management port. Fixed provider origin, bounded private reads and
 * narrowly scoped synthetic chat tests and guarded receptionist assignment; no calls or SMS writes.
 * Raw provider objects (which can contain Twilio credentials) never escape.
 */
export class VapiManagementClient extends BoundedBinaryAdapterBase {
 #key;#fetch;
 constructor({apiKey,fetch:request=globalThis.fetch}){
  super(524288);
  if(typeof apiKey!=='string'||apiKey.length<16||apiKey.length>512||/\s/.test(apiKey)||typeof request!=='function')throw fail('configuration_required');
  this.#key=apiKey;this.#fetch=request;
 }
 async #request(path,body,method=body===undefined?'GET':'POST',allowList=false){
  try{
   const response=await this.#fetch('https://api.vapi.ai'+path,{method,redirect:'error',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body===undefined?{}:{'content-type':'application/json'})},...(body===undefined?{}:{body:JSON.stringify(body)})});
   if(!response.ok){try{await response.body?.cancel();}catch{}const error=fail(response.status===402?'payment_required':[401,403].includes(response.status)?'authentication_denied':response.status===404?'resource_not_found':'provider_unavailable');error.httpStatus=response.status;throw error;}
   const bytes=await this.readBoundedBody(response.body);
   const data=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));
   if(!data||typeof data!=='object'||Array.isArray(data)&&!allowList)throw fail('invalid_provider_response');
   return data;
  }catch(error){if(error instanceof VapiManagementError)throw error;throw fail('provider_unavailable');}
 }
 /** Read reusable tool inventory without exposing endpoint headers, credentials,
  * server URLs, static parameters or provider payloads. Inventory is not approval
  * to attach a tool: its backend, scope and behavior require separate verification. */
 async tools(){
  const rows=await this.#request('/tool',undefined,'GET',true);
  if(!Array.isArray(rows)||rows.length>200)throw fail('invalid_provider_response');
  return Object.freeze(rows.map(row=>{
   if(!row||!uuid(row.id)||!uuid(row.orgId)||typeof row.type!=='string'||row.type.length>80)throw fail('invalid_provider_response');
   const name=row.function?.name??row.name??row.type;
   if(typeof name!=='string'||name.length>200||name.includes(this.#key))throw fail('invalid_provider_response');
   const destination=row.url||row.server?.url;let endpointHost=null;
   if(destination){try{endpointHost=new URL(destination).hostname;}catch{throw fail('invalid_provider_response');}}
   return Object.freeze({id:row.id,orgId:row.orgId,type:row.type,name,endpointHost,method:typeof row.method==='string'?row.method:null,bodyFields:row.body?.properties&&typeof row.body.properties==='object'?Object.keys(row.body.properties).slice(0,100):[],endpointConfigured:!!(row.url||row.server?.url),credentialConfigured:!!(row.credentialId||row.server?.credentialId)});
  }));
 }
 /** Provision/reuse one named provider-only credential in the verified org.
  * Secret material is passed only to the trusted deployment callback, never
  * returned in receipts or logs. Existing mismatched/redacted credentials are
  * preserved; ambiguous creation/install failures are not retried automatically.
  * Schema: official @vapi-ai/server-sdk 3.0.0 CustomCredential/Bearer plan. */
 async installToolCredential(expectedAssistant,install){
  if(!expectedAssistant||!uuid(expectedAssistant.id)||typeof install!=='function')throw fail('configuration_required');
  const assistant=await this.assistant(expectedAssistant.id);
  if(assistant.orgId!==expectedAssistant.orgId||assistant.name!==expectedAssistant.name||assistant.prompt!==expectedAssistant.prompt||assistant.firstMessage!==expectedAssistant.firstMessage||assistant.toolCount!==0||assistant.serverConfigured)throw fail('test_scope_changed');
  const name='PrimeCare Tools API 16534';
  const rows=await this.#request('/credential',undefined,'GET',true);
  if(!Array.isArray(rows)||rows.length>200)throw fail('invalid_provider_response');
  const matches=rows.filter(row=>row?.name===name);
  if(matches.length>1)throw fail('test_scope_changed');
  let row=matches[0],secret,created=false;
  if(row){
   if(row.provider!=='custom-credential'||row.orgId!==assistant.orgId||!uuid(row.id)||row.authenticationPlan?.type!=='bearer'||row.authenticationPlan.headerName!=='Authorization'||row.authenticationPlan.bearerPrefixEnabled!==true)throw fail('test_scope_changed');
   secret=row.authenticationPlan.token;
  }else{
   const bytes=crypto.getRandomValues(new Uint8Array(32));
   secret=btoa(String.fromCharCode(...bytes)).replace(/\+/g,'-').replace(/\//g,'_').replace(/=+$/,'');
   row=await this.#request('/credential',{provider:'custom-credential',name,authenticationPlan:{type:'bearer',token:secret,headerName:'Authorization',bearerPrefixEnabled:true}});created=true;
  }
  const valid=value=>value?.provider==='custom-credential'&&value.name===name&&value.orgId===assistant.orgId&&uuid(value.id)&&value.authenticationPlan?.type==='bearer'&&value.authenticationPlan.headerName==='Authorization'&&value.authenticationPlan.bearerPrefixEnabled===true;
  if(!valid(row)||typeof secret!=='string'||! /^[A-Za-z0-9_-]{43,128}$/.test(secret)||secret===this.#key||row.authenticationPlan.token!==undefined&&row.authenticationPlan.token!==secret)throw fail('configuration_required');
  try{await install(Object.freeze({credentialId:row.id,secret}));}catch{throw fail('provider_unavailable');}
  const saved=await this.#request('/credential/'+row.id);
  if(!valid(saved)||saved.id!==row.id||saved.authenticationPlan.token!==undefined&&saved.authenticationPlan.token!==secret)throw fail('invalid_provider_response');
  return Object.freeze({credentialId:row.id,name,created,orgId:assistant.orgId});
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
 /** Only this bounded assistant setting can be changed. Recheck the exact saved
  * assistant scope, patch one field once, then perform independent API readback.
  * No provider CAS is assumed and no mutation is automatically retried. */
 async setReceptionDuration(id,expected){
  const row=await this.assistant(id);
  if(!expected||row.orgId!==expected.orgId||row.name!==expected.name||row.prompt!==expected.prompt||row.firstMessage!==expected.firstMessage||row.toolCount!==0||row.serverConfigured||!row.recordingDisabled)throw fail('test_scope_changed');
  await this.#request('/assistant/'+id,{maxDurationSeconds:600},'PATCH');
  const saved=await this.assistant(id);
  if(saved.orgId!==row.orgId||saved.maxDurationSeconds!==600||saved.name!==row.name||saved.prompt!==row.prompt||saved.firstMessage!==row.firstMessage||saved.toolCount!==0||saved.serverConfigured||!saved.recordingDisabled)throw fail('invalid_provider_response');
  return saved;
 }
 /** Assign only a caller-verified phone/assistant pair. Read both again before
  * writing; refuse changed org, routing, prompt, tools or webhook. PATCH only
  * assistantId once and independently read back. Provider offers no CAS: a
  * concurrent dashboard edit can still race; never retry an ambiguous write. */
 async assignReception(phoneId,expectedPhone,expectedAssistant){
  if(!expectedAssistant||!uuid(expectedAssistant.id)||!expectedPhone)throw fail('test_scope_changed');
  const assistant=await this.assistant(expectedAssistant.id);
  const phone=await this.phoneNumber(phoneId);
  const safeAssistant=row=>row.orgId===expectedAssistant.orgId&&row.name===expectedAssistant.name&&row.prompt===expectedAssistant.prompt&&row.firstMessage===expectedAssistant.firstMessage&&row.toolCount===0&&!row.serverConfigured&&row.recordingDisabled&&row.maxDurationSeconds===600;
  const safePhone=row=>row.orgId===assistant.orgId&&row.orgId===expectedPhone.orgId&&row.number===expectedPhone.number&&row.provider==='twilio'&&expectedPhone.provider==='twilio'&&!row.squadConfigured&&!row.workflowConfigured&&!row.serverConfigured;
  if(!safeAssistant(assistant)||!safePhone(phone)||phone.assistantId!==expectedPhone.assistantId)throw fail('test_scope_changed');
  if(phone.assistantId===assistant.id)return Object.freeze({changed:false,phone});
  await this.#request('/phone-number/'+phoneId,{assistantId:assistant.id},'PATCH');
  const saved=await this.phoneNumber(phoneId);
  const savedAssistant=await this.assistant(assistant.id);
  if(!safePhone(saved)||saved.assistantId!==assistant.id||!safeAssistant(savedAssistant))throw fail('invalid_provider_response');
  return Object.freeze({changed:true,phone:saved});
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
