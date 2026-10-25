import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
const uuid=value=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(value);
const exact=(value,keys)=>value&&typeof value==='object'&&!Array.isArray(value)&&Object.keys(value).sort().join(',')===[...keys].sort().join(',');
const json=(body,status=200)=>Response.json(body,{status,headers:{'cache-control':'no-store','x-content-type-options':'nosniff'}});
/** Internal API Request tool transport, deliberately not a mounted endpoint.
 * Host ports own registered endpoint policy, rate limits, Vapi service credential
 * validation, canonical provider-call verification and durable replay claims.
 * current() must independently verify the live provider call and canonical Twilio
 * call, returning the pinned scope below. Header/caller/model claims are not proof.
 * VoiceTaskService resolves OTP/passkey identity and consumes the configured trusted app or dedicated signed call confirmation.
 */
export class VapiApiRequestAdapter extends BoundedBinaryAdapterBase {
 #options;
 constructor({url,orgId,assistantId,phoneNumberId,authenticate,authorize,admit,calls,claims,tasks,taskIds}){
  super(16384);
  const endpoint=new URL(url);
  if(endpoint.protocol!=='https:'||endpoint.href!==url||endpoint.username||endpoint.password||endpoint.search||endpoint.hash||[orgId,assistantId,phoneNumberId].some(id=>!uuid(id))||[authenticate,authorize,admit,calls?.current,claims?.claim,tasks?.propose,tasks?.execute].some(fn=>typeof fn!=='function')||!Array.isArray(taskIds)||!taskIds.length||taskIds.length>20||taskIds.some(id=>typeof id!=='string'||!/^[a-z][a-z0-9_.]{1,79}$/.test(id))||new Set(taskIds).size!==taskIds.length)throw Error('Registered Vapi integration ports required');
  this.#options=Object.freeze({url,orgId,assistantId,phoneNumberId,authenticate,authorize,admit,calls:Object.freeze({current:calls.current.bind(calls)}),claims:Object.freeze({claim:claims.claim.bind(claims)}),tasks:Object.freeze({propose:tasks.propose.bind(tasks),execute:tasks.execute.bind(tasks)}),taskIds:Object.freeze([...taskIds])});
 }
 async #call(id){
  const o=this.#options,row=await o.calls.current(id);
  if(!row||row.vapiCallId!==id||row.orgId!==o.orgId||row.assistantId!==o.assistantId||row.phoneNumberId!==o.phoneNumberId||row.active!==true||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now()||typeof row.callSid!=='string'||!/^CA[a-f0-9]{32}$/i.test(row.callSid))throw Error('Verified call required');
  return Object.freeze({callSid:row.callSid,vapiCallId:id});
 }
 async respond(request){
  const o=this.#options;
  if(request.url!==o.url)return json({error:'Not found'},404);
  if(request.method!=='POST')return new Response(null,{status:405,headers:{allow:'POST','cache-control':'no-store'}});
  try{
   // No model input is inspected until provider authentication and endpoint
   // authorization/rate limiting have succeeded. Each port must explicitly allow.
   if(await o.authenticate(request)!==true)return json({error:'Unauthorized'},401);
   if(await o.authorize(request)!==true)return json({error:'Forbidden'},403);
   if(await o.admit(request)!==true)return json({error:'Too many requests'},429);
   const callId=request.headers.get('x-primecare-vapi-call-id');
   if(!uuid(callId)||!/^application\/json(?:\s*;|$)/i.test(request.headers.get('content-type')??'')||request.headers.has('content-encoding'))return json({error:'Invalid tool request'},400);
   let body;
   try{body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(request.body)));}catch{return json({error:'Invalid tool request'},400);}
   // Actor, tenant, session, approval, URLs and credentials are never accepted as
   // transport fields. Task-specific validators independently reject extra args.
   const propose=body?.action==='propose';
   if(!exact(body,propose?['action','taskId','args','requestId']:['action','intentId','requestId'])||!uuid(body.requestId)||(!propose&&(body.action!=='execute'||!uuid(body.intentId)))||propose&&(!o.taskIds.includes(body.taskId)||!body.args||typeof body.args!=='object'||Array.isArray(body.args)))return json({error:'Invalid tool request'},400);
   const call=await this.#call(callId);
   const bytes=new TextEncoder().encode(JSON.stringify(body));
   const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',bytes)),b=>b.toString(16).padStart(2,'0')).join('');
   // Durable atomic insert, scoped by provider call and requestId. Must reject
   // duplicates (including changed-body reuse); retain through maximum retry TTL.
   if(await o.claims.claim({vapiCallId:callId,requestId:body.requestId,digest})!==true)return json({error:'Request already attempted; check status in the app'},409);
   const current=await this.#call(callId);if(current.callSid!==call.callSid)throw Error('Call changed');
   if(propose){
    const result=await o.tasks.propose(call.callSid,body.taskId,body.args);
    if(!uuid(result?.intentId)||typeof result.summary!=='string'||!result.summary.trim()||result.summary.length>1000||/[\u0000-\u001f\u007f]/.test(result.summary)||result.requiresConfirmation!==true||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<=Date.now())throw Error('Invalid task proposal');
    // Digest and identity remain in the server/app approval flow, outside the AI.
    return json({status:'awaiting_confirmation',intentId:result.intentId,summary:result.summary,expiresAt:result.expiresAt,requiresConfirmation:true});
   }
   try{
    const result=await o.tasks.execute(call.callSid,body.intentId);
    if(result?.status!=='completed')throw Error('Invalid task receipt');
    // Completion means the registered task completed, not a confirmed booking.
    return json({status:'completed',intentId:body.intentId});
   }catch(error){if(error?.code==='VOICE_TASK_CONFIRMATION_REQUIRED')return json({status:'awaiting_confirmation',intentId:body.intentId,requiresConfirmation:true});throw error;}
  }catch{return json({error:'Task unavailable; check status in the app before trying again'},503);}
 }
}
