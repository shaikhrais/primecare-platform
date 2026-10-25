import {Pool} from 'pg';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {PostgresCommunicationSession} from './session.ts';
import {PostgresRegisteredCommunicationEndpointPolicy} from './endpoint-policy.ts';
import {InternalCallApplication} from './internal-call-application.ts';
import {InternalCallHttpAdapter} from './internal-call-http.ts';
import {CloudflareTurnProvider} from '../../../../packages/shared/src/communications/cloudflare-turn.mjs';
import {nativePostgresOptions} from './native-postgres.ts';
import {sha256} from '../session-token.ts';
import definition from '../../../../tools/governance-production/internal-call-contracts-registration.json' with {type:'json'};
import config from './internal-call-deployment.json' with {type:'json'};
import type {Actor} from '../../../../packages/shared/src/communications/service-base.ts';
type Limit={limit(input:{key:string}):Promise<{success:boolean}>};
export type InternalCallEnvironment={DB_URL:string;INTERNAL_CALL_SOURCE:string;INTERNAL_CALL_ORIGIN:string;INTERNAL_CALL_GATEWAY_ORIGIN:string;TURN_KEY_ID:string;TURN_KEY_TOKEN:string;INTERNAL_CALL_LIMIT:Limit;CALL_RELAY_LIMIT:Limit};
export class PostgresInternalCallEndpointPolicy extends PostgresRegisteredCommunicationEndpointPolicy {
 async authorize(actor:Actor,key:string,request:Request){const op=definition.operations.find(o=>o.key===key);if(!op||op.path!==new URL(request.url).pathname||request.method!==op.method)throw Error('Forbidden');return this.authorizeRegistered(actor,null,op.method,op.path,'INTERNAL_'+key.replaceAll('.','_').toUpperCase());}
}
/** Real request-owned native host. No client role, tenant override, fake policy
 * or synthetic provider is installed in this composition. */
export class InternalCallWorker extends BaseWorker<InternalCallEnvironment> {
 protected async handle(request:Request,env:InternalCallEnvironment){
  const url=new URL(request.url),op=definition.operations.find(o=>o.path===url.pathname),headers={'cache-control':'no-store','x-content-type-options':'nosniff','x-primecare-calls-source':/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')?env.INTERNAL_CALL_SOURCE:'unconfigured'};
  const fail=(status:number,error:string)=>Response.json({error},{status,headers});
  if(!op||![env.INTERNAL_CALL_ORIGIN,env.INTERNAL_CALL_GATEWAY_ORIGIN].includes(url.origin))return fail(404,'not_found');
  if(request.method!==op.method)return new Response(null,{status:405,headers:{...headers,allow:op.method}});
  const origin=request.headers.get('origin');if(origin!==null&&!config.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')return fail(403,'forbidden');
  if(!/^Bearer [^\s]{1,8192}$/.test(request.headers.get('authorization')??''))return fail(401,'unauthorized');
  if(!/^[a-f0-9]{40}$/.test(env.INTERNAL_CALL_SOURCE??'')||typeof env.INTERNAL_CALL_LIMIT?.limit!=='function'||typeof env.CALL_RELAY_LIMIT?.limit!=='function')return fail(503,'unavailable');
  const ip=request.headers.get('cf-connecting-ip');if(!ip||ip.length>64)return fail(503,'unavailable');
  for(const key of ['source:'+await sha256(ip),'session:'+await sha256(request.headers.get('authorization')!)])if((await env.INTERNAL_CALL_LIMIT.limit({key})).success!==true)return fail(429,'rate_limited');
  const pool=new Pool(nativePostgresOptions(env.DB_URL));pool.on('error',()=>{});let turn:CloudflareTurnProvider|undefined;
  try{
   // Credentials are initialized lazily for media issuance, so directory/read
   // and explicit boundary denials remain observable while relay is unavailable.
   const app=new InternalCallApplication(pool,{admit:async(actor,callId)=>(await env.CALL_RELAY_LIMIT.limit({key:actor.tenantId+':'+actor.id+':'+callId})).success===true,provider:{issue:async()=>{turn??=new CloudflareTurnProvider({keyId:env.TURN_KEY_ID,apiToken:env.TURN_KEY_TOKEN,ttlSeconds:1800});return turn.issue();}}});
   const sessions=new PostgresCommunicationSession(pool),permissions=new PostgresInternalCallEndpointPolicy(pool);
   const adapter=new InternalCallHttpAdapter({origin:url.origin,appOrigins:config.appOrigins,application:app,authenticate:req=>sessions.authenticate(req),authorize:(actor,key,req)=>permissions.authorize(actor,key,req)});
   const response=await adapter.respond(request);for(const [key,value]of Object.entries(headers))response.headers.set(key,value);return response;
  }finally{turn?.close();await pool.end();}
 }
 protected override onError(){return Response.json({error:'unavailable'},{status:503,headers:{'cache-control':'no-store','x-content-type-options':'nosniff'}});}
}
export default workerHandler(new InternalCallWorker());
