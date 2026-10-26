import {Pool} from 'pg';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {BoundedBinaryAdapterBase} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {TwilioSignedFormAdapter,twilioFailure} from '../../../../packages/shared/src/communications/twilio-webhook.mjs';
import {TwilioCallFetch} from '../../../../packages/shared/src/communications/twilio-call-fetch.mjs';
import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {nativePostgresOptions} from './native-postgres.ts';
import {PostgresAtomicStore} from './store.ts';
import {ExternalCallService,type ExternalCallState} from './external-call-service.ts';
import {ExternalCallPolicy,ExternalCallSessions} from './external-call-policy.ts';
import {tokenFrom,sha256} from '../session-token.ts';
import config from './external-call-deployment.json' with {type:'json'};
import definition from '../../../../tools/governance-production/external-call-registration.json' with {type:'json'};
type Env={DB_URL:string;EXTERNAL_SOURCE:string;EXTERNAL_ORIGIN:string;EXTERNAL_GATEWAY_ORIGIN:string;TWILIO_ACCOUNT_SID:string;TWILIO_API_KEY_SID:string;TWILIO_API_KEY_SECRET:string;TWILIO_AUTH_TOKEN:string;TWILIO_APPLICATION_SID:string;EXTERNAL_LIMIT:{limit(o:{key:string}):Promise<{success:boolean}>}};
const jsonHeaders={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
export class ExternalCallWorker extends BaseWorker<Env>{
 readonly ports:{openPool?:(url:string)=>any;providerFetch?:typeof fetch};constructor(ports:{openPool?:(url:string)=>any;providerFetch?:typeof fetch}={}){super();this.ports=Object.freeze({...ports});}
 protected async handle(request:Request,env:Env){const url=new URL(request.url),op=definition.operations.find(o=>o.path===url.pathname),source={'x-primecare-external-source':env.EXTERNAL_SOURCE,'x-primecare-external-request':crypto.randomUUID()},began=Date.now();let phase='boundary';const record=(status:number,error?:unknown)=>{const e=error as {code?:string;message?:string}|undefined;const reasons:Record<string,string>={'Forbidden':'forbidden','Invalid input':'invalid_input','Call busy':'call_busy','Call unavailable':'call_unavailable','Version conflict':'version_conflict','Configuration required':'configuration','Idempotency conflict':'idempotency_conflict'};console.info(JSON.stringify({event:'external_call_request',reference:source['x-primecare-external-request'],operation:op?.key??'unknown',phase,status,elapsedMs:Date.now()-began,...(e?.code&&/^[A-Z0-9]{5}$/.test(e.code)?{sqlState:e.code}:{}),...(e?.message&&reasons[e.message]?{reason:reasons[e.message]}:{})}));};const fail=(status:number,error?:unknown)=>{record(status,error);return Response.json({error:status===401?'unauthorized':status===403?'forbidden':status===409?'call_busy':'unavailable'},{status,headers:{...jsonHeaders,...source}});};
  if(!op||![env.EXTERNAL_ORIGIN,env.EXTERNAL_GATEWAY_ORIGIN].includes(url.origin))return fail(404);if(request.method!==op.method||url.search||url.hash)return fail(400);
  const origin=request.headers.get('origin');if(origin!==null&&!config.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')return fail(403);
  const native=op.authentication==='native-session-csrf';if(native&&!tokenFrom(request))return fail(401);if(!/^[a-f0-9]{40}$/.test(env.EXTERNAL_SOURCE))return fail(503);
  const pool=this.ports.openPool?this.ports.openPool(env.DB_URL):new Pool(nativePostgresOptions(env.DB_URL));pool.on?.('error',()=>{});
  try{const sessions=new ExternalCallSessions(pool),policy=new ExternalCallPolicy(pool),provider=new TwilioCallFetch({accountSid:env.TWILIO_ACCOUNT_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,fetch:this.ports.providerFetch});const lookup=async(actor:{id:string;tenantId:string}):Promise<ExternalCallState|null>=>(await pool.query('SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2',[actor.tenantId,'external-call:'+actor.id])).rows[0]?.state??null;
   const service=new ExternalCallService(new PostgresAtomicStore(pool),policy,{current:h=>sessions.current(h),lookup,verify:s=>provider.call(s),terminate:async s=>{await provider.call(s,true);}},{accountSid:env.TWILIO_ACCOUNT_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,applicationSid:env.TWILIO_APPLICATION_SID,callerId:config.callerId});
   if(native){phase='session';const hash=await sha256(tokenFrom(request)!),actor=await sessions.current(hash);if((await env.EXTERNAL_LIMIT.limit({key:actor.tenantId+':'+actor.id})).success!==true)return fail(429);
    const boundary=async()=>{const now=await sessions.current(hash);if(now.id!==actor.id||now.tenantId!==actor.tenantId)throw Error('Forbidden');await policy.assert(actor,op.key,{id:'external-call:'+actor.id,kind:'external_call',version:0,tenantId:actor.tenantId,ownerId:actor.id});};await boundary();phase='input';
    if(request.headers.get('content-type')?.split(';')[0]!=='application/json'||request.headers.has('content-encoding'))return fail(415);let b:any;try{b=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await new BoundedBinaryAdapterBase(1024).readBoundedBody(request.body!)));}catch{return fail(400);}if(!b||typeof b!=='object'||Array.isArray(b))return fail(400);const keys=Object.keys(b).sort().join(',');let result;phase=op.key;
    if(op.key==='external.prepare'&&keys==='phone,requestId')result=await service.prepare(actor,hash,b);else if(op.key==='external.state'&&keys==='')result=await service.state(actor,hash);else if(op.key==='external.end'&&keys==='ticket'&&typeof b.ticket==='string')result=await service.end(actor,hash,b.ticket);else return fail(400);
    phase='recheck';await boundary();record(200);return Response.json(result,{headers:{...jsonHeaders,...source}});
   }
   phase='provider_signature';const checked=await new TwilioSignedFormAdapter({accountSid:env.TWILIO_ACCOUNT_SID,authToken:env.TWILIO_AUTH_TOKEN,webhookUrl:env.EXTERNAL_ORIGIN+op.path,maxWebhookBytes:16384}).validate(request);if(checked.response)return checked.response;const p=checked.params;
   if(typeof p.CallSid!=='string'||!/^CA[a-f0-9]{32}$/i.test(p.CallSid)||op.key==='external.connect'&&(typeof p.Ticket!=='string'||typeof p.From!=='string')||op.key==='external.complete'&&typeof p.DialCallStatus!=='string')return twilioFailure(403);
   const rows=op.key==='external.connect'?await pool.query("SELECT state FROM business_work_aggregates WHERE state->>'kind'='external_call' AND state->>'ticket'=$1 LIMIT 2",[p.Ticket]):await pool.query("SELECT state FROM business_work_aggregates WHERE state->>'kind'='external_call' AND state->>'callSid'=$1 LIMIT 2",[p.CallSid]);if(rows.rows.length!==1)return twilioFailure(403);const s=rows.rows[0].state,actor={id:s.ownerId,tenantId:s.tenantId};const response=new VoiceResponse();
   phase=op.key;if(op.key==='external.connect'){if(p.Direction!=='inbound')return twilioFailure(403);const target=await service.connect(actor,p.Ticket as string,p.CallSid,p.From as string);response.dial({callerId:target.callerId,answerOnBridge:true,timeout:30,timeLimit:3600,action:env.EXTERNAL_ORIGIN+'/v1/external-calls/complete',method:'POST'}).number(target.phone);response.hangup();}
   else{await service.complete(actor,p.CallSid,p.DialCallStatus as string);response.hangup();}
   record(200);return new Response(response.toString(),{headers:{...jsonHeaders,'content-type':'application/xml; charset=utf-8',...source}});
  }catch(error){const status=(error as any)?.status;return fail(status===401?401:(error as Error)?.message==='Not found'?404:(error as Error)?.message==='Forbidden'?403:['Call busy','Version conflict','Call unavailable','Idempotency conflict'].includes((error as Error)?.message)?409:(error as Error)?.message==='Invalid input'?400:503,error);}finally{await pool.end();}
 }
 protected override async onError(){return Response.json({error:'unavailable'},{status:503,headers:jsonHeaders});}
}
export default workerHandler(new ExternalCallWorker());
