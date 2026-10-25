import {PostgresCommunicationSession} from './session.ts';
import {nativeCallPermissionQuery} from './internal-call-endpoint-policy.ts';
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
const literal=(s:string)=>"'"+s.replaceAll("'","''")+"'";
const permission=(method:string,path:string,code:string)=>{
 const q=nativeCallPermissionQuery({id:'template',tenantId:'template'},method,path,code);
 const values=['i.id','i.tenant_id','NULL::text',literal(method),literal(path),literal(code)];
 return q.text.replace(/\$(\d+)\b/g,(_m,n)=>values[Number(n)-1]);
};
export const callEventsAuthorizationQuery=`WITH identity AS MATERIALIZED (
 SELECT u.id::text AS id,u.tenant_id::text AS tenant_id FROM public.auth_sessions s JOIN public.users u ON u.id=s.user_id
 WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 2)
 SELECT i.* FROM identity i WHERE (SELECT count(*) FROM identity)=1
 AND (SELECT count(*) FROM "${pin.schema}"."${pin.manifestTable}")=1
 AND EXISTS(SELECT 1 FROM "${pin.schema}"."${pin.manifestTable}" WHERE manifest_sha256=${literal(pin.manifestSha256)})
 AND EXISTS(${permission('POST','/v1/calls/command','INTERNAL_CALL_COMMAND')})
 AND EXISTS(${permission('GET','/v1/calls/events','INTERNAL_CALL_EVENTS')})`;
/** A connection retains an identity reference, never a cached grant. Each frame
 * release, heartbeat and authentication checks current native authority. */
export class PostgresCallEventsSession extends PostgresCommunicationSession {
 async currentHash(hash:string,selectedUserId:string){
  if(!/^[a-f0-9]{64}$/.test(hash))throw Error('Forbidden');
  const {rows}=await this.database.query(callEventsAuthorizationQuery,[hash]);
  const actor=this.actorFromRows(rows,new Request('https://internal.invalid/'));
  if(actor.id!==selectedUserId)throw Error('Forbidden');return actor;
 }
}
