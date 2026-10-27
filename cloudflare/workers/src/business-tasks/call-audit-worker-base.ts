import pg from 'pg';
import {BaseWorker} from '../core/base-worker.ts';
import {nativePostgresOptions} from './native-postgres.ts';
import {PostgresCallAudit,uuid,safeWord,type AuditPayload} from './call-audit.ts';
import {canonicalSnapshot,type AuditEnv} from './call-audit-provider.ts';
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
const now=()=>new Date().toISOString();
const reply=()=>Response.json({error:'Audit service unavailable; action was not started. Do not retry automatically.'},{status:503,headers:{'cache-control':'no-store'}});
/** Inherited boundary used by verification/client-read and business task hosts.
 * Persist start before delegation. A missing completion always remains visible.
 * Unknown callers are recorded without fabricating an account or tenant.
 */
export class CallAuditedWorker<E extends AuditEnv> extends BaseWorker<E>{
 constructor(readonly delegate:{fetch(r:Request,e:E):Promise<Response>},readonly secretName:keyof E,readonly source:string,readonly paths:readonly string[],readonly ports:{openPool?:(env:E)=>any;ledger?:(pool:any)=>Pick<PostgresCallAudit,'append'>;snapshot?:typeof canonicalSnapshot}={}){super();}
 protected async handle(request:Request,env:E):Promise<Response>{
  if(!this.paths.includes(new URL(request.url).pathname))return this.delegate.fetch(request,env);
  const traceId=crypto.randomUUID(),started=Date.now(),pool=this.ports.openPool?this.ports.openPool(env):new pg.Pool(nativePostgresOptions(env.DB_URL));pool.on?.('error',()=>{});
  const ledger=this.ports.ledger?this.ports.ledger(pool):new PostgresCallAudit(pool);let stream='unbound:'+traceId,reason='unclassified_failure';
  let meta:Partial<AuditPayload>={traceId};
  const write=async(phase:string,extra:Partial<AuditPayload>={})=>ledger.append(stream,traceId+':'+phase,{kind:'tool_attempt',source:this.source,at:now(),...meta,phase,...extra} as AuditPayload);
  try{
   // Credential denial does not parse model data or store its claimed identity.
   const authenticated=await createVapiToolCredentialVerifier({secret:String(env[this.secretName])})(request);
   if(authenticated&&request.method==='POST'){
    try{
     const clone=request.clone();if(Number(clone.headers.get('content-length')??0)>131072)throw Error();
     const reader=clone.body?.getReader();let n=0,s='';if(reader){const decode=new TextDecoder();try{while(true){const r=await reader.read();if(r.done)break;n+=r.value.length;if(n>131072)throw Error();s+=decode.decode(r.value,{stream:true});}}finally{await reader.cancel();}}
     const body=JSON.parse(s),tool=body.message?.toolCallList?.[0];
     const id=body.message?.call?.id??request.headers.get('x-primecare-vapi-call-id');
     meta={...meta,suppliedCallId:uuid(id)?id:undefined,toolCallId:safeWord(tool?.id??body.requestId),toolName:safeWord(tool?.function?.name??body.taskId)};
     let args=tool?.function?.arguments;if(typeof args==='string')try{args=JSON.parse(args);}catch{}
     const action=args?.action??body.action;meta.action=['request','check','propose','execute'].includes(action)?action:undefined;
     if(uuid(id)){
      try{
       const snapshot=await (this.ports.snapshot??canonicalSnapshot)(id,env);stream=id;
       meta={...meta,callId:id,callSid:snapshot.callSid,assistantId:snapshot.assistantId};
       await ledger.append(id,'snapshot:'+traceId,snapshot);
       if(typeof snapshot.from==='string'&&snapshot.direction==='inbound'){
        const matches=(await pool.query("SELECT count(*)::int AS count FROM public.communication_voice_verified_contacts c JOIN public.users u ON u.id::text=c.user_id AND u.tenant_id::text=c.tenant_id JOIN public.tenants t ON t.id=u.tenant_id WHERE c.phone=$1 AND c.revoked_at IS NULL AND lower(u.status)='active' AND lower(t.status)='active'",[snapshot.from])).rows[0].count;
        reason=matches===0?'no_verified_account_phone':matches>1?'ambiguous_verified_account_phone':'verified_phone_present';
       }
      }catch(e){reason=['call_scope_mismatch','call_provider_mismatch','provider_read_failed'].includes((e as Error).message)?(e as Error).message:'canonical_readback_failed';}
     }else reason='invalid_call_reference';
    }catch{reason='invalid_or_oversized_request';}
   }else reason=authenticated?'invalid_method':'provider_credential_denied';
   await write('started',{outcome:'pending',reason});
  }catch{await pool.end();return reply();}
  try{
   const response=await this.delegate.fetch(request,env),headers=new Headers(response.headers);
   const internal=headers.get('x-primecare-audit-reason');headers.delete('x-primecare-audit-reason');
   let outcome=response.ok?'responded':'denied',flags:Partial<AuditPayload>={};
   // JSON receipts are projected; private client results and SMS digits never leave memory.
   try{
    const raw=await response.clone().text();if(raw.length<1048576){const body=JSON.parse(raw),entry=body.results?.[0];
     if(body.error||entry?.error)outcome='denied';
     let result=entry?.result??body;if(typeof result==='string')try{result=JSON.parse(result);}catch{result={};}
     for(const key of ['verified','codeRequested'] as const)if(typeof result?.[key]==='boolean')flags[key]=result[key];
     if(uuid(result?.id??result?.intentId))flags.resultId=result.id??result.intentId;
    }
   }catch{}
   await write('finished',{outcome,reason:safeWord(internal)??(outcome==='denied'?reason:'response_received'),httpStatus:response.status,durationMs:Date.now()-started,...flags});
   headers.set('x-primecare-audit-id',traceId);
   return new Response(response.body,{status:response.status,statusText:response.statusText,headers});
  }catch{
   // Do not promise that a delegated side effect was rolled back. Start is durable.
   try{await write('unknown',{outcome:'unknown',reason:'execution_or_audit_completion_failed',durationMs:Date.now()-started});}catch{}
   return Response.json({error:'Outcome unknown; do not retry automatically.'},{status:503,headers:{'cache-control':'no-store','x-primecare-audit-id':traceId}});
  }finally{await pool.end();}
 }
}
