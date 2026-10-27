import {reconcileCalls} from './call-audit-reconciliation.ts';
import pg from 'pg';
import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import {nativePostgresOptions} from './native-postgres.ts';
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
import {PostgresCallAudit,uuid,safeWord,toolObservations,hash} from './call-audit.ts';
import {canonicalSnapshot,snapshotKey,providerJson,phoneId,orgId,type AuditEnv} from './call-audit-provider.ts';
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
import {registeredMetadataValue as val} from './endpoint-policy.ts';
export type CallAuditEnvironment=AuditEnv&{CALL_AUDIT_SECRET:string;CALL_AUDIT_ORIGIN:string;CALL_AUDIT_API_ID:string;CALL_AUDIT_SOURCE:string};
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const path='/v1/vapi/calls/audit';
export class CallAuditEventsWorker extends BaseWorker<CallAuditEnvironment>{
 protected async handle(request:Request,env:CallAuditEnvironment):Promise<Response>{
  const u=new URL(request.url);if(u.origin!==env.CALL_AUDIT_ORIGIN||u.pathname!==path||u.search)return new Response(null,{status:404,headers});
  if(request.method!=='POST')return new Response(null,{status:405,headers});
  if(!await createVapiToolCredentialVerifier({secret:env.CALL_AUDIT_SECRET})(request))return new Response(null,{status:401,headers});
  if(request.headers.get('content-type')?.split(';')[0]!=='application/json')return new Response(null,{status:415,headers});
  const reader=request.body?.getReader();if(!reader)return new Response(null,{status:400,headers});let size=0,text='';const decode=new TextDecoder();
  try{while(true){const chunk=await reader.read();if(chunk.done)break;size+=chunk.value.length;if(size>1048576)return new Response(null,{status:413,headers});text+=decode.decode(chunk.value,{stream:true});}}finally{await reader.cancel();}
  const body=JSON.parse(text),message=body?.message;
  if(!['status-update','end-of-call-report','conversation-update'].includes(message?.type)||!uuid(message?.call?.id))return new Response(null,{status:400,headers});
  const pool=new pg.Pool(nativePostgresOptions(env.DB_URL));pool.on('error',()=>{});
  try{
   const v=val,schema=pin.schema;if(!/^governance_[a-f0-9]+$/.test(schema))throw Error();
   const rows=(await pool.query(`SELECT ${v('a','id')} AS id,${v('a','permission_key')} AS permission FROM "${schema}".govt_api_endpoints a WHERE ${v('a','route_path')}=$1 AND ${v('a','http_method')}='POST' AND ${v('a','auth_required')}='1' AND EXISTS(SELECT 1 FROM "${schema}".govt_source_manifest WHERE manifest_sha256=$2)`,[path,pin.manifestSha256])).rows;
   if(rows.length!==1||rows[0].id!==env.CALL_AUDIT_API_ID||rows[0].permission!=='vapi.service.call_audit')throw Error();
   const ledger=new PostgresCallAudit(pool),id=message.call.id,snapshot=await canonicalSnapshot(id,env);
   await ledger.append(id,await snapshotKey(snapshot),snapshot);
   const stamp=typeof message.timestamp==='number'?new Date(message.timestamp).toISOString():typeof message.timestamp==='string'&&Number.isFinite(Date.parse(message.timestamp))?new Date(message.timestamp).toISOString():snapshot.at;
   if(message.type!=='conversation-update'){
    const payload={kind:'call_event',source:'vapi_authenticated_webhook',at:stamp,callId:id,phase:message.type,status:safeWord(message.status??snapshot.status),endedReason:safeWord(message.endedReason??snapshot.endedReason)};
    await ledger.append(id,'webhook:'+await hash(payload),payload);
   }
   for(const t of toolObservations(message)){
    // Provider tool observations do not prove backend execution. Dates use the
    // call start so repeated conversation snapshots have stable receipt keys.
    await ledger.append(id,'provider-tool:'+t.toolCallId+':'+t.phase,{kind:'tool_observation',source:'vapi_authenticated_webhook',at:String(snapshot.startedAt??snapshot.at),callId:id,...t,evidence:'provider_observed_only'});
   }
   return Response.json({accepted:true},{headers:{...headers,'x-primecare-call-audit-source':env.CALL_AUDIT_SOURCE}});
  }finally{await pool.end();}
 }
 override async scheduled(_controller:unknown,env:CallAuditEnvironment){await reconcileCalls(env);}
 protected override onError(){return Response.json({error:'audit_unavailable'},{status:503,headers});}
}
export default workerHandler(new CallAuditEventsWorker());
