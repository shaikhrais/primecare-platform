import {DurableObject} from 'cloudflare:workers';
import pg from 'pg';
import savedAgents from '../../../../packages/shared/src/vapi-agent-targets.json' with {type:'json'};
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {BoundedBinaryAdapterBase} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
import {VapiCallReadClient,createVapiCanonicalCallDirectory} from '../../../../packages/shared/src/communications/vapi-call-read.mjs';
import {TwilioVerifyFetchClient} from '../../../../packages/shared/src/communications/twilio-verify-fetch.mjs';
import {createTwilioVoiceOtpClient} from '../../../../packages/shared/src/communications/twilio-verify.mjs';
import {nativePostgresOptions} from './native-postgres.ts';
import {ownerTestGrant,pendingOwnerCandidate,enrollApprovedOwner} from './vapi-owner-test.ts';
import {PostgresAtomicStore} from './store.ts';
import {SpokenSmsVerificationService,type SpokenCandidate} from './vapi-spoken-verification.ts';
import {VapiVerifiedCallIdentityService,DurableVapiCallProofRepository,type CallPossessionProof} from './vapi-call-identity.ts';
import {VapiClientInformationService} from './vapi-client-information.ts';
import {registeredMetadataValue as metadataValue} from './endpoint-policy.ts';
import clientContract from '../../../../tools/governance-production/vapi-client-information-registration.json' with {type:'json'};
import contract from '../../../../tools/governance-production/vapi-verification-registration.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
type Env={VAPI_CLIENT_READ_API_ID?:string;VAPI_CLIENT_READ_CONTRACT_SHA?:string;OWNER_TEST_CALL_ID?:string;OWNER_TEST_EXPIRES_AT?:string;OWNER_TEST_EMAIL?:string;OWNER_TEST_PHONE?:string;DB_URL:string;VAPI_PRIVATE_API_KEY:string;VAPI_VERIFY_SECRET:string;VAPI_VERIFY_OWNER:string;VAPI_VERIFY_ORIGIN:string;VAPI_VERIFY_API_ID:string;VAPI_VERIFY_CONTRACT_SHA:string;TWILIO_ACCOUNT_SID:string;TWILIO_API_KEY_SID:string;TWILIO_API_KEY_SECRET:string;TWILIO_VERIFY_SERVICE_SID:string;VERIFICATIONS:DurableObjectNamespace;VERIFY_LIMIT:{limit(value:{key:string}):Promise<{success:boolean}>}};
const orgId='9e1d8550-4b84-4472-a782-67557fe73944',assistantId='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',number='+12897994277';
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const digest=async(text:string)=>Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(text))),x=>x.toString(16).padStart(2,'0')).join('');
const same=(a:SpokenCandidate|undefined,b:SpokenCandidate|undefined)=>!!a&&!!b&&a.callId===b.callId&&a.callSid===b.callSid&&a.phone===b.phone&&a.version===b.version&&a.actor?.id===b.actor?.id&&a.actor?.tenantId===b.actor?.tenantId;
const authHeaders=(env:Env)=>({authorization:'Basic '+btoa(env.TWILIO_API_KEY_SID+':'+env.TWILIO_API_KEY_SECRET),accept:'application/json'});
async function twilioCall(env:Env,id:string){
 if(!/^CA[a-f0-9]{32}$/i.test(id))throw Error();const r=await fetch('https://api.twilio.com/2010-04-01/Accounts/'+env.TWILIO_ACCOUNT_SID+'/Calls/'+id+'.json',{redirect:'manual',headers:authHeaders(env),signal:AbortSignal.timeout(10000)});
 if(!r.ok){await r.body?.cancel();throw Error();}const row=JSON.parse(new TextDecoder().decode(await new BoundedBinaryAdapterBase(65536).readBoundedBody(r.body!)));return {sid:row.sid,accountSid:row.account_sid,from:row.from,to:row.to,direction:row.direction,status:row.status};
}
/** Private phone-keyed durable repository; codes are held by Twilio, never stored here. */
export class SpokenVerification extends DurableObject<Env> {
 /** Private namespace RPC. No public Worker route or model-callable action.
  * Read-only: does not send SMS, approve codes or refresh a proof's expiry. */
 async possession(candidate:SpokenCandidate):Promise<CallPossessionProof|null>{
  const row=await this.ctx.storage.get<any>('challenge');
  const proof=row?.proof;
  if(row?.state!=='verified'||!same(row.candidate,candidate)||!proof||row.expiresAt<=Date.now()||proof.expiresAt!==row.expiresAt||typeof proof.id!=='string'||!Number.isSafeInteger(proof.verifiedAt)||proof.verifiedAt>Date.now()||proof.expiresAt-proof.verifiedAt>120000)return null;
  return {id:proof.id,verifiedAt:proof.verifiedAt,expiresAt:proof.expiresAt};
 }
 async fetch(request:Request):Promise<Response>{return this.ctx.blockConcurrencyWhile(async()=>{try{
  const {candidate,input}=await request.json() as {candidate:SpokenCandidate;input:{action:'request'|'check';requestId:string;code?:string}};
  let row=await this.ctx.storage.get<any>('challenge');const now=Date.now();
  const bound=row&&same(row.candidate,candidate);
  if(input.action==='request'){
   if(row&&row.quotaUntil>now){if(bound&&row.state==='pending'&&row.expiresAt>now)return Response.json({verified:false,codeRequested:true});throw Error('Send unavailable');}
   row={candidate,state:'sending',expiresAt:now+120000,quotaUntil:now+600000,attempts:0,receipts:{}};await this.ctx.storage.put('challenge',row);await this.ctx.storage.setAlarm(row.quotaUntil);
   try{const receipt=await this.client(candidate.phone).start();row.sid=receipt.verificationSid;row.state='pending';await this.ctx.storage.put('challenge',row);return Response.json({verified:false,codeRequested:true});}catch{row.state='unknown';await this.ctx.storage.put('challenge',row);throw Error('Send outcome unknown');}
  }
  if(!bound||row.expiresAt<=now)throw Error('Challenge unavailable');
  if(Object.hasOwn(row.receipts,input.requestId))return Response.json(row.receipts[input.requestId]);
  if(row.state!=='pending'||row.attempts>=5||typeof input.code!=='string'||!/^\d{6}$/.test(input.code))throw Error('Check unavailable');
  row.state='checking';row.attempts++;await this.ctx.storage.put('challenge',row);
  try{const result=await this.client(candidate.phone).check(row.sid,input.code);if(Date.now()>=row.expiresAt)throw Error();const receipt={verified:result.approved};row.state=result.approved?'verified':row.attempts>=5?'locked':'pending';if(result.approved)row.proof={id:crypto.randomUUID(),verifiedAt:Date.now(),expiresAt:row.expiresAt};row.receipts[input.requestId]=receipt;await this.ctx.storage.put('challenge',row);return Response.json(receipt);}catch{row.state='unknown';await this.ctx.storage.put('challenge',row);throw Error('Check outcome unknown');}
 }catch{return Response.json({error:'verification_unavailable'},{status:503});}});}
 private client(phone:string){return createTwilioVoiceOtpClient({accountSid:this.env.TWILIO_ACCOUNT_SID,apiKeySid:this.env.TWILIO_API_KEY_SID,apiKeySecret:this.env.TWILIO_API_KEY_SECRET,serviceSid:this.env.TWILIO_VERIFY_SERVICE_SID,contact:{phone,verified:true},httpClient:new TwilioVerifyFetchClient({serviceSid:this.env.TWILIO_VERIFY_SERVICE_SID,apiKeySid:this.env.TWILIO_API_KEY_SID,apiKeySecret:this.env.TWILIO_API_KEY_SECRET})});}
 async alarm(){await this.ctx.storage.deleteAll();}
}
export class SpokenVerificationWorker extends BaseWorker<Env>{
 protected async handle(request:Request,env:Env):Promise<Response>{
  const deny=async(status:number)=>{try{await request.body?.cancel();}catch{}return Response.json({error:'verification_unavailable'},{status,headers});};
  const url=new URL(request.url),clientRead=url.pathname===clientContract.operations[0].path;if(url.origin!==env.VAPI_VERIFY_ORIGIN||!clientRead&&url.pathname!==contract.operations[0].path)return deny(404);if(request.method!=='POST')return deny(405);if(url.search||url.hash)return deny(400);
  if(!await createVapiToolCredentialVerifier({secret:env.VAPI_VERIFY_SECRET})(request))return deny(401);
  if(env.VAPI_VERIFY_CONTRACT_SHA!==pin.vapiVerificationRegistrationWriter.definitionSha256||clientRead&&env.VAPI_CLIENT_READ_CONTRACT_SHA!==pin.vapiClientInformationRegistrationWriter.definitionSha256||!(await env.VERIFY_LIMIT.limit({key:'spoken-verification'})).success)return deny(503);
  if(request.headers.get('content-type')?.split(';')[0].trim()!=='application/json')return deny(415);
  const body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await new BoundedBinaryAdapterBase(131072).readBoundedBody(request.body!))),message=body?.message,list=message?.toolCallList;
  if(message?.type!=='tool-calls'||!Array.isArray(list)||list.length!==1||list[0]?.type!=='function'||list[0]?.function?.name!==(clientRead?'primecare_client_information':'primecare_phone_verification')||typeof list[0]?.id!=='string')return deny(400);
  const tool=list[0],callId=message.call?.id;let args=tool.function.arguments;if(typeof args==='string'){if(args.length>1024)return deny(400);args=JSON.parse(args);}
  const pool=new pg.Pool(nativePostgresOptions(env.DB_URL));
  try{
   const ownerTest=ownerTestGrant(env);
   const directory=createVapiCanonicalCallDirectory({vapi:new VapiCallReadClient({apiKey:env.VAPI_PRIVATE_API_KEY}),twilio:{fetch:(id:string)=>twilioCall(env,id)},orgId,assistantId,assistantIds:[assistantId,...Object.values(savedAgents)],phoneNumberId:phoneId,accountSid:env.TWILIO_ACCOUNT_SID,sharedNumber:number,ownerTest});
   const candidate=async(id:string):Promise<SpokenCandidate|null>=>{const call=await directory.current(id);if(!call)return null;const raw=await twilioCall(env,call.callSid);if(raw.sid!==call.callSid||raw.accountSid!==env.TWILIO_ACCOUNT_SID||raw.status!=='in-progress'||!(raw.direction==='inbound'&&raw.to===number||ownerTest?.callId===id&&raw.direction==='outbound-api'&&raw.from===number&&raw.to===ownerTest.customerPhone))return null;
    const contactPhone=raw.direction==='inbound'?raw.from:raw.to;if(!/^\+[1-9][0-9]{6,14}$/.test(contactPhone??''))return null;
    const rows=(await pool.query(`SELECT u.email,u.roles,c.user_id,c.tenant_id,c.version::float8 AS version FROM public.communication_voice_verified_contacts c JOIN public.users u ON u.id::text=c.user_id AND u.tenant_id::text=c.tenant_id JOIN public.tenants t ON t.id=u.tenant_id WHERE c.phone=$1 AND c.revoked_at IS NULL AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[contactPhone])).rows;
    if(rows.length===0)return pendingOwnerCandidate(pool,ownerTest,id,contactPhone,call.callSid);if(rows.length!==1||ownerTest?.callId===id&&(rows[0].email.toLowerCase()!==ownerTest.email||rows[0].roles!=='code_admin'))return null;return {actor:{id:rows[0].user_id,tenantId:rows[0].tenant_id},phone:contactPhone,version:rows[0].version,callSid:call.callSid,callId:id};};
   const registered=async(read:boolean)=>{
    const schema=pin.schema;if(!/^[a-z0-9_]+$/.test(schema))throw Error();const op=read?clientContract.operations[0]:contract.operations[0];
    const v=metadataValue,rows=(await pool.query(`SELECT ${v('a','id')} AS id,${v('a','permission_key')} AS permission,${v('a','auth_required')} AS auth FROM "${schema}".govt_api_endpoints a WHERE ${v('a','http_method')}='POST' AND ${v('a','route_path')}=$1 AND ${v('a','service_name')}='governance' AND EXISTS(SELECT 1 FROM "${schema}".govt_source_manifest WHERE manifest_sha256=$2) LIMIT 2`,[op.path,pin.manifestSha256])).rows;
    if(rows.length!==1||rows[0].id!==(read?env.VAPI_CLIENT_READ_API_ID:env.VAPI_VERIFY_API_ID)||rows[0].permission!==op.permission||rows[0].auth!=='1')throw Error();
   };
   const policy={async assert(actor:any,action:string,state:any){if(action!=='voice.sms.spoken.verify'||state?.ownerId!==actor.id||state.tenantId!==actor.tenantId)throw Error();await registered(false);},async assignee(){throw Error();}};
   if(clientRead){
    const proofs=new DurableVapiCallProofRepository(env.VERIFICATIONS),identities=new VapiVerifiedCallIdentityService(new PostgresAtomicStore(pool,'business_sms'),policy,{current:candidate,proof:c=>proofs.read(c)});
    const readPolicy={async assert(actor:any,action:string,state:any){if(action!=='voice.client.read'||state?.kind!=='voice_client_information'||state.ownerId!==actor.id||state.tenantId!==actor.tenantId)throw Error();await registered(true);},async assignee(){throw Error();}};
    const service=new VapiClientInformationService(new PostgresAtomicStore(pool,'business_sms'),readPolicy,pool,identities);
    const result=await service.read(callId,args);return Response.json({results:[{toolCallId:tool.id,result:JSON.stringify(result)}]},{headers});
   }
   const service=new SpokenSmsVerificationService(new PostgresAtomicStore(pool,'business_sms'),policy,{current:candidate,run:async(c,input)=>{const key=await digest(c.phone);const response=await env.VERIFICATIONS.get(env.VERIFICATIONS.idFromName(key)).fetch('https://private-verification/action',{method:'POST',body:JSON.stringify({candidate:c,input})});if(!response.ok)throw Error();return response.json();}});
   const result=await service.execute(callId,tool.id,args);if(result.verified&&ownerTest?.callId===callId){const current=await candidate(callId);if(!current)throw Error();await enrollApprovedOwner(pool,ownerTest,current,true);if(!await candidate(callId))throw Error();}return Response.json({results:[{toolCallId:tool.id,result:JSON.stringify(result)}]},{headers});
  }catch{return Response.json({results:[{toolCallId:tool.id,error:clientRead?'Client information unavailable. Current account verification is required; no records were changed.':'Verification unavailable. Do not resend automatically; use reception or the account verification screen.'}]},{headers});}finally{await pool.end();}
 }
 protected override onError(){return Response.json({error:'verification_unavailable'},{status:503,headers});}
}
export default workerHandler(new SpokenVerificationWorker());
