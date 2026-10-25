import {ScopedServiceBase,assertActor,type Actor,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {PostgresCommunicationAccessPolicy} from './access-policy.ts';
import {InternalAppCallCore} from './internal-call-core.ts';
import type {AppCallRelayPorts} from './internal-call-media.ts';
type Pool=ConstructorParameters<typeof InternalAppCallCore>[0]['pool'];
/** Additional directory/self-publication scope only. Conversation policy is
 * inherited unchanged; no new role, cross-tenant or model permissions. */
export class PostgresInternalCallPolicy extends PostgresCommunicationAccessPolicy {
 override async assert(actor:Actor,action:string,state:any){
  if(!['internal.call.directory','internal.call.extension'].includes(action))return super.assert(actor,action,state);
  assertActor(actor);const a={id:actor.id,tenantId:actor.tenantId},s=structuredClone(state);
  if(!s||s.tenantId!==a.tenantId||s.userId!==a.id||s.kind!==(action==='internal.call.directory'?'call_directory':'voice_destination'))throw Error('Forbidden');
  await this.inspect(async db=>{await this.active(db,a);});
 }
}
const unavailable=()=>Error('Call unavailable');
const limits={maxMembers:2,maxMessages:100,ringMilliseconds:45000,maxSignalBytes:16384};
export class InternalCallApplication extends ScopedServiceBase {
 readonly core:InternalAppCallCore;readonly pool:Pool;
 constructor(pool:Pool,relay:AppCallRelayPorts,policy:AccessPolicy=new PostgresInternalCallPolicy(pool)){
  const core=new InternalAppCallCore({pool,limits,policy,relay});super(core.calls.store,policy);this.core=core;this.pool=pool;
 }
 private async directoryAccess(actor:Actor,action='internal.call.directory'){
  await this.checkAccess(actor,action,{id:'call-directory:'+actor.id,tenantId:actor.tenantId,kind:action==='internal.call.directory'?'call_directory':'voice_destination',version:1,userId:actor.id},[action==='internal.call.directory'?'call_directory':'voice_destination']);
 }
 async directory(actor:Actor,after?:string){
  await this.directoryAccess(actor);if(after!==undefined&&!/^[1-9][0-9]{3}$/.test(after))throw unavailable();
  const self=(await this.core.directory.destinations(actor,2));if(self.length>1)throw unavailable();
  const rows=(await this.pool.query(`SELECT e.extension,e.user_id AS "userId",e.version::float8 AS version,e.published FROM communication_voice_extensions e
   JOIN users u ON u.id::text=e.user_id AND u.tenant_id::text=e.tenant_id JOIN tenants t ON t.id::text=e.tenant_id
   WHERE e.tenant_id=$1 AND e.user_id<>$2 AND e.active AND e.published AND LOWER(u.status)='active' AND LOWER(t.status)='active' AND ($3::text IS NULL OR e.extension>$3) ORDER BY e.extension LIMIT 101`,[actor.tenantId,actor.id,after??null])).rows;
  return {userId:actor.id,self:self.length?this.entry(self[0]):null,items:rows.slice(0,100).map((r:any)=>this.entry(r)),nextAfter:rows.length>100?rows[99].extension:null};
 }
 private entry(row:any){return {extension:row.extension,userId:row.userId,version:row.version,published:row.published};}
 async extension(actor:Actor,published:boolean){
  if(typeof published!=='boolean')throw unavailable();await this.directoryAccess(actor,'internal.call.extension');
  const check=async(row:any)=>{if(row.userId!==actor.id||row.tenantId!==actor.tenantId||row.active!==true||row.userActive!==true||row.tenantActive!==true)throw unavailable();await this.directoryAccess(actor,'internal.call.extension');};
  let row=await this.core.directory.assign(actor,actor.id,check);
  if(row.published!==published)row=await this.core.directory.publish(actor,actor.id,row.version,published,check);
  return this.entry(row);
 }
 private view(state:any,actor:Actor){
  if(!state.id.startsWith('internal-call:')||state.members.length!==2||!state.members.includes(actor.id))throw unavailable();
  return {id:state.id,kind:'conversation',version:state.version,members:state.members,calls:state.calls.filter((c:any)=>[c.callerId,c.recipientId].includes(actor.id)).slice(-20).map((c:any)=>({id:c.id,callerId:c.callerId,recipientId:c.recipientId,status:c.status,expiresAt:c.expiresAt,signals:c.status==='accepted'?(c.signals??[]):[],...(c.offered===undefined?{}:{offered:c.offered}),...(c.answered===undefined?{}:{answered:c.answered})}))};
 }
 async read(actor:Actor,id:string){if(typeof id!=='string'||!id.startsWith('internal-call:'))throw unavailable();return this.view(await this.sweep(actor,id),actor);}
 async inbox(actor:Actor){
  await this.policy.assert(actor,'conversation.inbox',null);
  const rows=(await this.pool.query(`SELECT w.id FROM business_work_aggregates w WHERE w.tenant_id=$1 AND w.id LIKE 'internal-call:%' AND w.state->>'kind'='conversation' AND w.state->'members' ? $2 AND NOT EXISTS(SELECT 1 FROM jsonb_array_elements_text(w.state->'members') member WHERE NOT EXISTS(SELECT 1 FROM users u JOIN tenants t ON t.id=u.tenant_id WHERE u.id::text=member.value AND u.tenant_id::text=w.tenant_id AND LOWER(u.status)='active' AND LOWER(t.status)='active')) ORDER BY CASE WHEN EXISTS(SELECT 1 FROM jsonb_array_elements(w.state->'calls') c WHERE (c->>'status'='ringing' AND (c->>'expiresAt')::bigint>$3) OR (c->>'status'='accepted' AND LEAST(COALESCE((c->'lastSeen'->>(c->>'callerId'))::bigint,(c->>'expiresAt')::bigint),COALESCE((c->'lastSeen'->>(c->>'recipientId'))::bigint,(c->>'expiresAt')::bigint))>$3::bigint-90000::bigint)) THEN 0 ELSE 1 END,COALESCE((SELECT MAX((c->>'expiresAt')::bigint) FROM jsonb_array_elements(w.state->'calls') c),0) DESC,w.id LIMIT 25`,[actor.tenantId,actor.id,Date.now()])).rows;const items=[];
  for(const r of rows)items.push(this.view(await this.sweep(actor,r.id),actor));
  return {items};
 }
 async dial(actor:Actor,extension:string,requestId:string){
  const rows=await this.core.directory.lookup(extension,2);if(rows.length!==1||rows[0].tenantId!==actor.tenantId||!rows[0].userId)throw unavailable();
  const db=await this.pool.connect();try{
   await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");await db.query("SET LOCAL idle_in_transaction_session_timeout='60s'");
   for(const userId of [...new Set([actor.id,rows[0].userId])].sort())await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[JSON.stringify(['internal-call-busy',actor.tenantId,userId])]);
   const result=await this.dialLocked(actor,extension,requestId,rows[0].userId,rows[0].version);await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 private async dialLocked(actor:Actor,extension:string,requestId:string,lockedUserId:string,lockedVersion:number){
  if(typeof extension!=='string'||!/^[1-9][0-9]{3}$/.test(extension)||typeof requestId!=='string'||!/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(requestId))throw unavailable();
  const targets=await this.core.directory.lookup(extension,2);if(targets.length!==1||targets[0].tenantId!==actor.tenantId||targets[0].userId!==lockedUserId||targets[0].version!==lockedVersion||targets[0].userId===actor.id||targets[0].published!==true||!targets[0].userId)throw unavailable();
  const target=targets[0].userId,hash=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify([actor.tenantId,actor.id,requestId]))),id='internal-call:'+Array.from(new Uint8Array(hash),b=>b.toString(16).padStart(2,'0')).join('');
  await this.core.calls.create(actor,id,'create',[actor.id,target].sort(),'general');
  const state=await this.sweep(actor,id),callId='call:'+requestId,old=state.calls.find((c:any)=>c.id===callId);
  if(old){if(old.callerId!==actor.id||old.recipientId!==target)throw unavailable();return this.view(state,actor);}
  const busy=(await this.pool.query(`SELECT id FROM business_work_aggregates w WHERE tenant_id=$1 AND id LIKE 'internal-call:%' AND (state->'members' ? $2 OR state->'members' ? $3) AND EXISTS(SELECT 1 FROM jsonb_array_elements(state->'calls') c WHERE (c->>'status'='ringing' AND (c->>'expiresAt')::bigint>$4) OR (c->>'status'='accepted' AND LEAST(COALESCE((c->'lastSeen'->>(c->>'callerId'))::bigint,(c->>'expiresAt')::bigint),COALESCE((c->'lastSeen'->>(c->>'recipientId'))::bigint,(c->>'expiresAt')::bigint))>$4::bigint-90000::bigint)) LIMIT 1`,[actor.tenantId,actor.id,target,Date.now()])).rows;
  if(busy.length)throw Error('Call conflict');
  await this.core.execute(actor,{action:'dial',id,key:requestId,version:state.version,callId,extension});return this.read(actor,id);
 }
 private async sweep(actor:Actor,id:string){
  const state=await this.core.calls.read(actor,id),now=Date.now();
  const expired=state.calls.find((c:any)=>[c.callerId,c.recipientId].includes(actor.id)&&(c.status==='ringing'&&c.expiresAt<=now||c.status==='accepted'&&Math.min(c.lastSeen?.[c.callerId]??c.expiresAt,c.lastSeen?.[c.recipientId]??c.expiresAt)<now-90000));
  if(!expired)return state;
  try{await this.core.calls.call(actor,id,'sweep:'+expired.id+':'+expired.status,state.version,expired.status==='ringing'?'expire':'end',expired.id);}catch(error){if(!(error instanceof Error)||!['Version conflict','Call conflict'].includes(error.message))throw error;}
  return this.core.calls.read(actor,id);
 }
 private async heartbeat(actor:Actor,id:string,callId:string){
  if(typeof id!=='string'||!id.startsWith('internal-call:'))throw unavailable();
  // Presence is an operational lease, not a semantic call command. Updating it
  // under PostgreSQL's row lock must not invalidate an offer/answer version.
  const state=await this.core.calls.read(actor,id);await this.core.calls.authorize(actor,'conversation.call',state);
  const now=Date.now();
  const rows=(await this.pool.query(`UPDATE business_work_aggregates w SET state=jsonb_set(w.state,'{calls}',(SELECT jsonb_agg(CASE WHEN c->>'id'=$4 THEN jsonb_set(c,'{lastSeen}',(CASE WHEN jsonb_typeof(c->'lastSeen')='object' THEN c->'lastSeen' ELSE jsonb_build_object(c->>'callerId',$5::bigint,c->>'recipientId',$5::bigint) END)||jsonb_build_object($3::text,GREATEST(COALESCE((c->'lastSeen'->>$3)::bigint,$5::bigint),$5::bigint))) ELSE c END ORDER BY n) FROM jsonb_array_elements(w.state->'calls') WITH ORDINALITY a(c,n))) WHERE w.tenant_id=$1 AND w.id=$2 AND w.state->>'kind'='conversation' AND w.state->'members' ? $3 AND EXISTS(SELECT 1 FROM users u JOIN tenants t ON t.id=u.tenant_id WHERE u.id::text=$3 AND u.tenant_id::text=$1 AND LOWER(u.status)='active' AND LOWER(t.status)='active') AND EXISTS(SELECT 1 FROM jsonb_array_elements(w.state->'calls') c WHERE c->>'id'=$4 AND c->>'status'='accepted' AND (c->>'callerId'=$3 OR c->>'recipientId'=$3) AND LEAST(COALESCE((c->'lastSeen'->>(c->>'callerId'))::bigint,(c->>'expiresAt')::bigint),COALESCE((c->'lastSeen'->>(c->>'recipientId'))::bigint,(c->>'expiresAt')::bigint))>=$5::bigint-90000::bigint) RETURNING (state->>'version')::text AS version`,[actor.tenantId,id,actor.id,callId,now])).rows;
  if(rows.length!==1||!Number.isSafeInteger(Number(rows[0].version)))throw Error('Call not accepted');
  return {id,version:Number(rows[0].version)};
 }
 async command(actor:Actor,input:any){
  if(input.action==='inbox')return this.inbox(actor);if(input.action==='read')return this.read(actor,input.id);if(input.action==='heartbeat')return this.heartbeat(actor,input.id,input.callId);await this.read(actor,input.id);
  const result=await this.core.execute(actor,input);
  if(input.action==='accept')return this.heartbeat(actor,input.id,input.callId);
  return result;
 }
 async media(actor:Actor,id:string,callId:string){await this.read(actor,id);if(!this.core.media)throw unavailable();return this.core.media.configuration(actor,id,callId);}
}
