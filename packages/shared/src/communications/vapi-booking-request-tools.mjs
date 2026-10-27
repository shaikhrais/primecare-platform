import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import catalogue from '../vapi-booking-request-tools.json' with {type:'json'};
import contracts from '../../../../tools/governance-production/vapi-booking-request-contracts.json' with {type:'json'};
const id=v=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
const text=v=>typeof v==='string'&&!!v.trim()&&v.length<=100&&!/[\u0000-\u001f\u007f]/.test(v);
const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(v);
const instant=v=>typeof v==='string'&&Number.isFinite(Date.parse(v));
const time=v=>typeof v==='string'&&/^([01]\d|2[0-3]):[0-5]\d$/.test(v);
const fail=code=>{throw Object.assign(Error(code),{code});};
const same=(a,b)=>['id','service_type','preferred_date','preferred_time','status','created_at','updated_at'].every(k=>a[k]===b[k]);
const empty={type:'object',additionalProperties:false,properties:{},required:[]};
const createSchema={type:'object',additionalProperties:false,properties:{preferredDate:{type:'string',pattern:'^\\d{4}-\\d{2}-\\d{2}$'},preferredTime:{type:'string',pattern:'^([01]\\d|2[0-3]):[0-5]\\d$'}},required:['preferredDate','preferredTime']};
/** Existing native owner API adapter. The host supplies its current session,
 * approved service/time zone, target request and independent confirmation port. */
export class VapiBookingRequestToolClient extends BoundedBinaryAdapterBase {
 #send;#scope;#initial;#agent;#context;
 constructor({agentKey,fetch:send,currentScope,bookingRequests}){
  super(262144);if(!Object.hasOwn(catalogue.roles,agentKey)||typeof send!=='function'||typeof currentScope!=='function'||contracts.operations.length!==3||!['POST /v1/client/booking-requests','GET /v1/client/booking-requests/{requestId}','POST /v1/client/booking-requests/{requestId}/cancel'].every(k=>contracts.operations.some(o=>o.method+' '+o.path===k)))fail('booking_request_configuration_required');
  this.#send=send;this.#scope=currentScope;this.#initial=currentScope();this.#agent=agentKey;if(typeof this.#initial!=='string'||!this.#initial)fail('native_context_required');
  if(bookingRequests!==undefined){const c=bookingRequests;if(!c||typeof c.timeZone!=='string'||c.serviceType!==undefined&&!text(c.serviceType)||c.requestId!==undefined&&!id(c.requestId)||c.confirm!==undefined&&typeof c.confirm!=='function')fail('booking_request_configuration_required');try{new Intl.DateTimeFormat('en',{timeZone:c.timeZone}).format();}catch{fail('booking_request_configuration_required');}this.#context=Object.freeze({...c});}
 }
 #current(){if(this.#scope()!==this.#initial)fail('native_context_changed');}
 #available(action){return !!this.#context&&(action==='create'?!!this.#context.serviceType&&typeof this.#context.confirm==='function':!!this.#context.requestId&&(action==='status'||typeof this.#context.confirm==='function'));}
 functionDefinitions(){return catalogue.roles[this.#agent].filter(a=>this.#available(a)).map(a=>({type:'function',function:{name:catalogue.tools[a].name,description:catalogue.tools[a].description,parameters:structuredClone(a==='create'?createSchema:empty)}}));}
 async #request(method,path,body,key){
  this.#current();const send=this.#send,response=await send('https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/client/booking-requests'+path,{method,redirect:'manual',signal:AbortSignal.timeout(15000),headers:{accept:'application/json',...(body?{'content-type':'application/json'}:{}),...(key?{'idempotency-key':key}:{})},...(body?{body:JSON.stringify(body)}:{})});try{this.#current();}catch(error){await response.body?.cancel();throw error;}
  if(!response.ok){await response.body?.cancel();fail([401,403].includes(response.status)?'native_api_denied':response.status===409?'native_api_conflict':'booking_request_api_unavailable');}
  const b=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(response.body)));this.#current();const r=b?.request;if(!b||Object.hasOwn(b,'error'))fail('invalid_booking_request_response');
  if(!r||!id(r.id)||!text(r.service_type)||!instant(r.preferred_date)||r.preferred_time!==null&&!time(r.preferred_time)||!text(r.status)||!instant(r.created_at)||!instant(r.updated_at))fail('invalid_booking_request_response');
  return {id:r.id,service_type:r.service_type,preferred_date:new Date(r.preferred_date).toISOString(),preferred_time:r.preferred_time,status:r.status,created_at:new Date(r.created_at).toISOString(),updated_at:new Date(r.updated_at).toISOString()};
 }
 async #read(requestId=this.#context.requestId){const row=await this.#request('GET','/'+encodeURIComponent(requestId));if(row.id!==requestId)fail('booking_request_readback_mismatch');return row;}
 #project(row){return {requestId:row.id,status:row.status,serviceType:row.service_type,preferredDate:row.preferred_date.slice(0,10),preferredTime:row.preferred_time,timeZone:this.#context.timeZone,appointmentConfirmed:false,appointmentCancelled:false};}
 async executeFunction(name,input={},operationId){
  const action=catalogue.roles[this.#agent].find(a=>catalogue.tools[a].name===name);
  if(!action||!this.#available(action)||!input||typeof input!=='object'||Array.isArray(input)||Object.keys(input).sort().join(',')!==(action==='create'?'preferredDate,preferredTime':''))fail('invalid_booking_request_input');
  if(action==='status')return {saved:false,...this.#project(await this.#read())};
  if(!uuid(operationId))fail('stable_operation_id_required');let body,before;
  if(action==='create'){
   const date=input.preferredDate,clock=input.preferredTime;if(typeof date!=='string'||!/^\d{4}-\d{2}-\d{2}$/.test(date)||!instant(date+'T00:00:00.000Z')||new Date(date+'T00:00:00.000Z').toISOString().slice(0,10)!==date||!time(clock))fail('invalid_booking_request_input');
   const parts=new Intl.DateTimeFormat('en-CA',{timeZone:this.#context.timeZone,year:'numeric',month:'2-digit',day:'2-digit',hour:'2-digit',minute:'2-digit',hourCycle:'h23'}).formatToParts(new Date()),v=k=>parts.find(p=>p.type===k).value,today=v('year')+'-'+v('month')+'-'+v('day');if(date<today||date===today&&clock<=v('hour')+':'+v('minute'))fail('future_booking_preference_required');
   body={service_type:this.#context.serviceType.trim(),preferred_date:date+'T00:00:00.000Z',preferred_time:clock};
  }else{before=await this.#read();if(before.status!=='pending')return {saved:false,alreadyTerminal:true,...this.#project(before)};}
  const decision=Object.freeze({kind:'booking_request_'+action,timeZone:this.#context.timeZone,...(body?{request:Object.freeze(structuredClone(body))}:{request:Object.freeze(structuredClone(before))})});
  if(await this.#context.confirm(decision)!==true)fail('independent_confirmation_required');this.#current();
  if(before&&!same(before,await this.#read()))fail('native_api_conflict');
  const key='voice_booking_request_'+action+'_'+operationId.replaceAll('-','');
  try{
   const receipt=await this.#request('POST',action==='create'?'':'/'+encodeURIComponent(this.#context.requestId)+'/cancel',body,key);
   if(receipt.status!==(action==='create'?'pending':'cancelled')||action==='cancel'&&receipt.id!==this.#context.requestId)fail('booking_request_readback_mismatch');
   if(body&&(receipt.service_type!==body.service_type||receipt.preferred_date!==body.preferred_date||receipt.preferred_time!==body.preferred_time))fail('booking_request_readback_mismatch');
   if(!same(receipt,await this.#read(receipt.id)))fail('booking_request_readback_mismatch');this.#current();return {saved:true,...this.#project(receipt)};
  }catch(error){if(['native_api_denied','native_api_conflict'].includes(error?.code))throw error;fail('tool_result_unknown_check_status');}
 }
}
