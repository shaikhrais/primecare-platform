import {Pool} from 'pg';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {tokenFrom,sha256} from '../session-token.ts';
import {NativeVoiceContactHttpAdapter,NativeVoiceHttpError} from '../../../../packages/shared/src/communications/voice-native-http.mjs';
import {TwilioVerifyFetchClient} from '../../../../packages/shared/src/communications/twilio-verify-fetch.mjs';
import {createTwilioContactEnrollmentClient} from '../../../../packages/shared/src/communications/twilio-verify.mjs';
import {VoiceContactEnrollmentService} from './voice-contact.ts';
import {PostgresVoiceContactRepository,PostgresVoiceContactSessions} from './voice-contact-postgres.ts';
import {PostgresVoiceContactAccessPolicy} from './voice-contact-native-policy.ts';
import {PostgresVoiceEndpointPolicy} from './endpoint-policy.ts';
import {PostgresAtomicStore} from './store.ts';
import definition from '../../../../tools/governance-production/voice-contact-contracts-registration.json' with {type:'json'};
import config from './voice-contact-deployment.json' with {type:'json'};
export type VoiceContactEnvironment={DB_URL:string;VOICE_CONTACT_ORIGIN:string;VOICE_GATEWAY_ORIGIN:string;VOICE_CONTACT_SOURCE:string;TWILIO_ACCOUNT_SID:string;TWILIO_API_KEY_SID:string;TWILIO_API_KEY_SECRET:string;TWILIO_VERIFY_SERVICE_SID:string;VOICE_CONTACT_LIMIT:{limit(options:{key:string}):Promise<{success:boolean}>}};
type NativePool={query(...args:any[]):Promise<any>;connect():Promise<any>;end():Promise<void>};
type Ports={openPool?(url:string):NativePool;providerFetch?:typeof fetch};
export function nativeContactPostgresOptions(value:string){
 const url=new URL(value);if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.port&&url.port!=='5432'||url.pathname!=='/postgres'||!url.username||!url.password)throw Error('Pinned native database required');
 return {host:url.hostname,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),max:2,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:5000,query_timeout:10000,idleTimeoutMillis:1000};
}
function openPool(value:string):NativePool{
 const pool=new Pool(nativeContactPostgresOptions(value));pool.on('error',()=>{});return pool;
}
/** Bounded operational category only; never expose error text, SQL, credentials,
 * phone numbers or code values. Used only on unavailable responses. */
export function nativeContactFailureCategory(error:unknown):string{
 const value=error as {code?:unknown;message?:unknown};
 if(typeof value?.code==='string'&&/^[0-9A-Z]{5}$/.test(value.code))return 'postgres_'+value.code;
 if(['ENOTFOUND','ECONNREFUSED','ECONNRESET','ETIMEDOUT','UNABLE_TO_VERIFY_LEAF_SIGNATURE','SELF_SIGNED_CERT_IN_CHAIN','ERR_TLS_CERT_ALTNAME_INVALID'].includes(String(value?.code)))return 'database_connection';
 const message=typeof value?.message==='string'?value.message:'';
 if(message.includes('Dynamic require of'))return 'runtime_module';
 if(message==='Pinned native database required')return 'database_configuration';
 if(message==='Verify transport configuration required')return 'verify_configuration';
 return 'host_unavailable';
}
const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
/** Native endpoint host only. Per-request pool, current PostgreSQL sessions,
 * exact permissions, durable quotas, official Verify SDK and bounded fetch. */
export class VoiceContactEnrollmentWorker extends BaseWorker<VoiceContactEnvironment>{
 readonly ports:Readonly<Ports>;constructor(ports:Ports={}){super();this.ports=Object.freeze({...ports});}
 #response(env:VoiceContactEnvironment,response:Response){const h=new Headers(response.headers);h.set('x-primecare-voice-contact-source',/^[a-f0-9]{40}$/.test(env.VOICE_CONTACT_SOURCE??'')?env.VOICE_CONTACT_SOURCE:'unconfigured');return new Response(response.body,{status:response.status,headers:h});}
 protected async handle(request:Request,env:VoiceContactEnvironment):Promise<Response>{
  const deny=async(status:number,error:string,extra:HeadersInit={})=>{try{await request.body?.cancel();}catch{}return this.#response(env,Response.json({error},{status,headers:{...headers,...extra}}));};
  const url=new URL(request.url),op=definition.operations.find(o=>o.path===url.pathname);
  if(!op||![env.VOICE_CONTACT_ORIGIN,env.VOICE_GATEWAY_ORIGIN].includes(url.origin))return deny(404,'not_found');
  if(request.method!==op.method)return deny(405,'method_not_allowed',{allow:op.method});
  if(url.search||url.hash)return deny(400,'invalid_voice_request');
  const origin=request.headers.get('origin');if(origin!==null&&!config.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')return deny(403,'forbidden');
  if(!request.headers.has('authorization')||!tokenFrom(request))return deny(401,'unauthorized');
  if(!/^[a-f0-9]{40}$/.test(env.VOICE_CONTACT_SOURCE)||typeof env.VOICE_CONTACT_LIMIT?.limit!=='function')return deny(503,'voice_unavailable',{'x-primecare-native-health':'runtime_configuration'});
  const hash=await sha256(tokenFrom(request)!);
  const ip=request.headers.get('cf-connecting-ip');if(!ip||ip.length>64)return deny(503,'voice_unavailable',{'x-primecare-native-health':'missing_source_context'});
  for(const key of ['session:'+hash,'source:'+await sha256(ip)])if((await env.VOICE_CONTACT_LIMIT.limit({key})).success!==true)return deny(429,'rate_limited');
  const pool=(this.ports.openPool??openPool)(env.DB_URL);
  let runtimeFailure:string|undefined;
  try{
   const sessions=new PostgresVoiceContactSessions(pool),permissions=new PostgresVoiceEndpointPolicy(pool);
   const provider=new TwilioVerifyFetchClient({serviceSid:env.TWILIO_VERIFY_SERVICE_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,fetch:this.ports.providerFetch});
   const service=new VoiceContactEnrollmentService(new PostgresAtomicStore(pool,'business_sms'),new PostgresVoiceContactAccessPolicy(pool),new PostgresVoiceContactRepository(pool),{sessions,provider:phone=>createTwilioContactEnrollmentClient({accountSid:env.TWILIO_ACCOUNT_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,serviceSid:env.TWILIO_VERIFY_SERVICE_SID,purpose:'first-time-contact-enrollment',phone,httpClient:provider})});
   const adapter=new NativeVoiceContactHttpAdapter({origin:url.origin,appOrigins:config.appOrigins,maxRequestBytes:config.maxRequestBytes,service,authenticate:async req=>{
    const token=tokenFrom(req);if(!token)throw new NativeVoiceHttpError(401);let row;try{row=await sessions.currentSession(await sha256(token));}catch(error){runtimeFailure=nativeContactFailureCategory(error);throw error;}
    if(!row)throw new NativeVoiceHttpError(401);if(req.headers.has('x-tenant-id')&&req.headers.get('x-tenant-id')!==row.tenantId)throw new NativeVoiceHttpError(403);
    return {actor:{id:row.userId,tenantId:row.tenantId},sessionHash:row.id,expiresAt:row.expiresAt};
   },authorize:async(session,key,req)=>{try{await permissions.authorize(session,key,req);}catch{throw new NativeVoiceHttpError(403);}}});
   const response=await adapter.respond(request);if(response.status===503&&runtimeFailure)response.headers.set('x-primecare-native-health',runtimeFailure);return this.#response(env,response);
  }finally{await pool.end();}
 }
 protected override async onError(error:unknown,request:Request,env:VoiceContactEnvironment):Promise<Response>{try{await request.body?.cancel();}catch{}return this.#response(env,Response.json({error:'voice_unavailable'},{status:503,headers:{...headers,'x-primecare-native-health':nativeContactFailureCategory(error)}}));}
}
export default workerHandler(new VoiceContactEnrollmentWorker());
