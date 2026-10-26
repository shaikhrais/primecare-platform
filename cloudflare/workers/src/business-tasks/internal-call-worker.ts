import {Pool} from 'pg';
import {callEventsTarget,type CallEventsNamespace} from './internal-call-events-hub.ts';
export {InternalCallEventsHub} from './internal-call-events-hub.ts';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {PostgresInternalCallContext,PostgresInternalCallContextPolicy,PostgresInternalCallContextStore} from './internal-call-context.ts';
export {PostgresInternalCallEndpointPolicy} from './internal-call-endpoint-policy.ts';
import {InternalCallApplication} from './internal-call-application.ts';
import {InternalCallReadinessAdapter} from './internal-call-readiness.ts';
import {InternalCallHttpAdapter} from './internal-call-http.ts';
import {CloudflareTurnProvider} from '../../../../packages/shared/src/communications/cloudflare-turn.mjs';
import {nativePostgresOptions} from './native-postgres.ts';
import {internalCallDatabaseOptions,measuredCallDatabase,type InternalCallDatabaseBinding} from './internal-call-database.ts';
import {sha256} from '../session-token.ts';
import definition from '../../../../tools/governance-production/internal-call-contracts-registration.json' with {type:'json'};
import preparation from '../../../../tools/governance-production/internal-call-preparation-registration.json' with {type:'json'};
import config from './internal-call-deployment.json' with {type:'json'};
type Limit={limit(input:{key:string}):Promise<{success:boolean}>};
export type InternalCallEnvironment={CALL_EVENTS:CallEventsNamespace;CALL_EVENTS_LIMIT:Limit;CALL_DATABASE:InternalCallDatabaseBinding;DB_URL:string;INTERNAL_CALL_SOURCE:string;INTERNAL_CALL_ORIGIN:string;INTERNAL_CALL_GATEWAY_ORIGIN:string;TURN_KEY_ID:string;TURN_KEY_TOKEN:string;INTERNAL_CALL_LIMIT:Limit;CALL_RELAY_LIMIT:Limit};
/** Real request-owned native host. No client role, tenant override, fake policy
 * or synthetic provider is installed in this composition. */
export class InternalCallWorker extends BaseWorker<InternalCallEnvironment> {
 readonly execution?:{waitUntil(work:Promise<unknown>):void};
 constructor(execution?:{waitUntil(work:Promise<unknown>):void}){super();this.execution=execution;}
 protected async handle(request:Request,env:InternalCallEnvironment){
  const url=new URL(request.url),op=[...definition.operations,...preparation.operations].find(o=>o.path===url.pathname),headers={'cache-control':'no-store','x-content-type-options':'nosniff','x-primecare-calls-source':/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')?env.INTERNAL_CALL_SOURCE:'unconfigured'};
  const fail=(status:number,error:string)=>Response.json({error},{status,headers});
  if(url.pathname==='/v1/calls/events'){
   if(![env.INTERNAL_CALL_ORIGIN,env.INTERNAL_CALL_GATEWAY_ORIGIN].includes(url.origin))return fail(404,'not_found');
   if(request.method!=='GET')return new Response(null,{status:405,headers:{allow:'GET'}});
   if(!config.appOrigins.includes(request.headers.get('origin')??''))return fail(403,'forbidden');
   const userId=url.searchParams.get('userId'),ip=request.headers.get('cf-connecting-ip');
   if(!userId||!/^[A-Za-z0-9][A-Za-z0-9_:.-]{0,199}$/.test(userId)||!ip)return fail(400,'invalid_request');
   if(!/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')||!env.CALL_EVENTS||typeof env.CALL_EVENTS_LIMIT?.limit!=='function')return fail(503,'unavailable');
   if((await env.CALL_EVENTS_LIMIT.limit({key:'events:'+await sha256(ip)})).success!==true)return fail(429,'rate_limited');
   return (await callEventsTarget(env.CALL_EVENTS,userId)).fetch(request);
  }
  if(!op||![env.INTERNAL_CALL_ORIGIN,env.INTERNAL_CALL_GATEWAY_ORIGIN].includes(url.origin))return fail(404,'not_found');
  if(request.method!==op.method)return new Response(null,{status:405,headers:{...headers,allow:op.method}});
  const origin=request.headers.get('origin');if(origin!==null&&!config.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')return fail(403,'forbidden');
  if(!/^Bearer [^\s]{1,8192}$/.test(request.headers.get('authorization')??''))return fail(401,'unauthorized');
  if(!/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')||typeof env.INTERNAL_CALL_LIMIT?.limit!=='function'||typeof env.CALL_RELAY_LIMIT?.limit!=='function')return fail(503,'unavailable');
  const ip=request.headers.get('cf-connecting-ip');if(!ip||ip.length>64)return fail(503,'unavailable');
  for(const key of ['source:'+await sha256(ip),'session:'+await sha256(request.headers.get('authorization')!)])if((await env.INTERNAL_CALL_LIMIT.limit({key})).success!==true)return fail(429,'rate_limited');
  const options=internalCallDatabaseOptions(env.CALL_DATABASE),directPool=new Pool(nativePostgresOptions(env.DB_URL)),fastPool=new Pool(options);directPool.on('error',()=>{});fastPool.on('error',()=>{});const metrics=new Map<string,{count:number;milliseconds:number;max:number}>(),pool=measuredCallDatabase(fastPool,metrics),transactions=measuredCallDatabase(directPool,metrics);let turn:CloudflareTurnProvider|undefined,preparationTurn:CloudflareTurnProvider|undefined;
  try{
   // Credentials are initialized lazily for media issuance, so directory/read
   // and explicit boundary denials remain observable while relay is unavailable.
   const context=new PostgresInternalCallContext(pool,request),policy=new PostgresInternalCallContextPolicy(pool,context),store=new PostgresInternalCallContextStore({query:pool.query,connect:transactions.connect},context);
   const app=new InternalCallApplication(pool,{admit:async(actor,callId)=>(await env.CALL_RELAY_LIMIT.limit({key:actor.tenantId+':'+actor.id+':'+callId})).success===true,preparationProvider:{issue:async()=>{preparationTurn??=new CloudflareTurnProvider({keyId:env.TURN_KEY_ID,apiToken:env.TURN_KEY_TOKEN,ttlSeconds:1800,fetch:(resource,init)=>fetch(resource,init)});return preparationTurn.issue();}},provider:{issue:async()=>{turn??=new CloudflareTurnProvider({keyId:env.TURN_KEY_ID,apiToken:env.TURN_KEY_TOKEN,ttlSeconds:1800,fetch:(resource,init)=>fetch(resource,init)});return turn.issue();}}},policy,transactions,store);
   const adapter=new InternalCallHttpAdapter({origin:url.origin,appOrigins:config.appOrigins,application:app,readiness:req=>new InternalCallReadinessAdapter(context,app,url.origin,config.appOrigins).respond(req),current:(req,key)=>context.current(req,key),committed:async(actor,key,input,result)=>{
    if(!env.CALL_EVENTS||!this.execution||!(key==='call.dial'||key==='call.prepare.signal'||key==='call.command'&&['accept','decline','end','expire','signal'].includes(input.action))||typeof result.id!=='string')return;
    const state=await app.core.calls.read(actor,result.id),signal=key==='call.prepare.signal'||key==='call.command'&&input.action==='signal',members=signal?state.members.filter((userId:string)=>userId!==actor.id):state.members;
    this.execution.waitUntil(Promise.all(members.map(async(userId:string)=>(await callEventsTarget(env.CALL_EVENTS,userId)).fetch(new Request('https://internal.invalid/invalidate',{method:'POST',body:JSON.stringify({kind:signal?'signal':'changed'})})))).catch(()=>{}));
   }});
   const response=await adapter.respond(request);
   for(const [key,value]of Object.entries(headers))response.headers.set(key,value);if(response.ok)response.headers.set('server-timing',[...metrics].map(([key,value])=>key+';dur='+Math.round(value.milliseconds)+';desc="'+value.count+' queries; max '+Math.round(value.max)+'ms"').join(','));return response;
  }finally{turn?.close();preparationTurn?.close();await Promise.all([fastPool.end(),directPool.end()]);}
 }
 protected override onError(error:unknown,_request:Request,env:InternalCallEnvironment){const health=(error as {communicationHealth?:string})?.communicationHealth;return Response.json({error:'unavailable'},{status:503,headers:{'cache-control':'no-store','x-content-type-options':'nosniff','x-primecare-calls-source':/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')?env.INTERNAL_CALL_SOURCE:'unconfigured','x-primecare-calls-health':typeof health==='string'&&/^call_database_[a-z_]{1,32}$/.test(health)?health:error instanceof TypeError?'runtime_type':'worker_failure'}});}
}
export default {...workerHandler(new InternalCallWorker()),fetch:(request:Request,env:InternalCallEnvironment,execution:{waitUntil(work:Promise<unknown>):void})=>workerHandler(new InternalCallWorker(execution)).fetch(request,env)};
