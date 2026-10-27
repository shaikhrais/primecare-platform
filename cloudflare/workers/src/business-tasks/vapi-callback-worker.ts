import {CallAuditedWorker} from './call-audit-worker-base.ts';
import {DurableObject} from 'cloudflare:workers';
import pg from 'pg';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
import {createPostgresVapiVerifiedRuntime,vapiReceptionScope,type VerifiedRuntimeEnvironment} from './vapi-verified-runtime.ts';
import {createPostgresVapiCallbackHost} from './vapi-callback-host.ts';
import {createPostgresNativeVapiCallbackApprovalHost} from './reception-callback.ts';
import {nativePostgresOptions} from './native-postgres.ts';
import config from './voice-contact-deployment.json' with {type:'json'};
import contracts from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
type Env=VerifiedRuntimeEnvironment&{DB_URL:string;VAPI_TOOLS_ORIGIN:string;VAPI_GATEWAY_ORIGIN:string;VAPI_CALLBACK_SOURCE:string;VAPI_TOOLS_SERVICE_SECRET:string;CALLBACK_REQUESTS:DurableObjectNamespace;VAPI_TOOL_LIMIT:{limit(value:{key:string}):Promise<{success:boolean}>}};
const taskPath='/v1/vapi/voice/tasks';
const approvalPaths=contracts.operations.filter(o=>['task.preview','task.approve'].includes(o.key)).map(o=>o.path);
const response=(env:Env,error:string,status:number)=>Response.json({error},{status,headers:{'cache-control':'no-store','x-content-type-options':'nosniff','x-primecare-vapi-callback-source':env.VAPI_CALLBACK_SOURCE??'unconfigured'}});
/** Private per-call transaction journal. Persistent claims are never cleared by
 * a timer: uncertain executions remain non-repeatable through accepted retries. */
export class CallbackRequests extends DurableObject<Env>{
 async fetch(request:Request){
  const pool=new pg.Pool(nativePostgresOptions(this.env.DB_URL));pool.on('error',()=>{});
  try{
   const runtime=createPostgresVapiVerifiedRuntime(pool,this.env);
   return await createPostgresVapiCallbackHost({pool,identities:runtime.identities,durableStorage:this.ctx.storage,secret:this.env.VAPI_TOOLS_SERVICE_SECRET,...vapiReceptionScope,calls:runtime.calls,admit:async()=>(await this.env.VAPI_TOOL_LIMIT.limit({key:'callback-task'})).success===true}).respond(request);
  }finally{await pool.end();}
 }
}
/** Registered provider tool and separate native app approval host. Authenticated
 * provider requests cannot reach native approval; app sessions cannot grant OTP.
 */
export class VapiCallbackWorker extends BaseWorker<Env>{
 protected async handle(request:Request,env:Env){
  const url=new URL(request.url),native=approvalPaths.includes(url.pathname),provider=url.pathname===taskPath;
  const deny=async(error:string,status:number)=>{try{await request.body?.cancel();}catch{}return response(env,error,status);};
  if(!native&&!provider||provider&&url.origin!==env.VAPI_TOOLS_ORIGIN||native&&![env.VAPI_TOOLS_ORIGIN,env.VAPI_GATEWAY_ORIGIN].includes(url.origin))return deny('not_found',404);
  if(url.search||url.hash)return deny('invalid_request',400);
  if(request.method!=='POST')return deny('method_not_allowed',405);
  if(!/^[a-f0-9]{40}$/.test(env.VAPI_CALLBACK_SOURCE??''))return deny('unavailable',503);
  if(provider){
   if(!await createVapiToolCredentialVerifier({secret:env.VAPI_TOOLS_SERVICE_SECRET})(request))return deny('unauthorized',401);
   if((await env.VAPI_TOOL_LIMIT.limit({key:'callback-provider'})).success!==true)return deny('rate_limited',429);
   const id=request.headers.get('x-primecare-vapi-call-id');if(!/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(id??''))return deny('invalid_call_reference',400);
   const r=await env.CALLBACK_REQUESTS.get(env.CALLBACK_REQUESTS.idFromName(id!)).fetch(request);const h=new Headers(r.headers);h.set('x-primecare-vapi-callback-source',env.VAPI_CALLBACK_SOURCE);return new Response(r.body,{status:r.status,headers:h});
  }
  const origin=request.headers.get('origin');if(origin!==null&&!config.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')return deny('forbidden',403);
  if(!/^Bearer [^\s]+$/.test(request.headers.get('authorization')??''))return deny('unauthorized',401);
  if((await env.VAPI_TOOL_LIMIT.limit({key:'callback-native'})).success!==true)return deny('rate_limited',429);
  const pool=new pg.Pool(nativePostgresOptions(env.DB_URL));pool.on('error',()=>{});
  try{
   const {identities}=createPostgresVapiVerifiedRuntime(pool,env);
   const result=await createPostgresNativeVapiCallbackApprovalHost({pool,identities,origin:url.origin,appOrigins:config.appOrigins,maxRequestBytes:2048}).respond(request);
   result.headers.set('x-primecare-vapi-callback-source',env.VAPI_CALLBACK_SOURCE);return result;
  }finally{await pool.end();}
 }
 protected override onError(_error:unknown,request:Request,env:Env){void request.body?.cancel().catch(()=>{});return response(env,'callback_unavailable',503);}
}
export default workerHandler(new CallAuditedWorker(new VapiCallbackWorker(),'VAPI_TOOLS_SERVICE_SECRET','business_tool_backend',['/v1/vapi/voice/tasks']));
