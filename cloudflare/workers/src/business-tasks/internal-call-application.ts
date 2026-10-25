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
 async read(actor:Actor,id:string){if(typeof id!=='string'||!id.startsWith('internal-call:'))throw unavailable();await this.sweep(actor,id);return this.view(await this.core.calls.read(actor,id),actor);}
 async inbox(actor:Actor){
  await this.policy.assert(actor,'conversation.inbox',null);
  const rows=(await this.pool.query(`SELECT id FROM business_work_aggregates WHERE tenant_id=$1 AND id LIKE 'internal-call:%' AND state->>'kind'='conversation' AND state->'members' ? $2 ORDER BY id LIMIT 100`,[actor.tenantId,actor.id])).rows;const items=[];
  for(const r of rows){await this.sweep(actor,r.id);let state=await this.core.calls.read(actor,r.id);let changes=false;
   for(const c of state.calls)if(c.status==='ringing'&&c.expiresAt<=Date.now()&&[c.callerId,c.recipientId].includes(actor.id)){
    try{await this.core.calls.call(actor,r.id,'expire:'+c.id,state.version,'expire',c.id);changes=true;break;}catch(error){if(!(error instanceof Error)||error.message!=='Version conflict')throw error;}
   }
   if(changes)state=await this.core.calls.read(actor,r.id);items.push(this.view(state,actor));
  }
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
  const target=targets[0].userId,hash=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify([actor.tenantId,...[actor.id,target].sort()]))),id='internal-call:'+Array.from(new Uint8Array(hash),b=>b.toString(16).padStart(2,'0')).join('');
  await this.core.calls.create(actor,id,'create',[actor.id,target].sort(),'general');
  await this.sweep(actor,id);const state=await this.core.calls.read(actor,id),callId='call:'+requestId,old=state.calls.find((c:any)=>c.id===callId);
  if(old){if(old.callerId!==actor.id||old.recipientId!==target)throw unavailable();return this.view(state,actor);}
  const busy=(await this.pool.query(`SELECT id FROM business_work_aggregates w WHERE tenant_id=$1 AND id LIKE 'internal-call:%' AND (state->'members' ? $2 OR state->'members' ? $3) AND EXISTS(SELECT 1 FROM jsonb_array_elements(state->'calls') c WHERE (c->>'status'='ringing' AND (c->>'expiresAt')::bigint>$4) OR (c->>'status'='accepted' AND LEAST(COALESCE((c->'lastSeen'->>(c->>'callerId'))::bigint,(c->>'expiresAt')::bigint),COALESCE((c->'lastSeen'->>(c->>'recipientId'))::bigint,(c->>'expiresAt')::bigint))>$4-90000)) LIMIT 1`,[actor.tenantId,actor.id,target,Date.now()])).rows;
  if(busy.length)throw Error('Call conflict');
  await this.core.execute(actor,{action:'dial',id,key:requestId,version:state.version,callId,extension});return this.read(actor,id);
 }
 private async sweep(actor:Actor,id:string){
  const state=await this.core.calls.read(actor,id),now=Date.now();
  const expired=state.calls.find((c:any)=>[c.callerId,c.recipientId].includes(actor.id)&&(c.status==='ringing'&&c.expiresAt<=now||c.status==='accepted'&&Math.min(c.lastSeen?.[c.callerId]??c.expiresAt,c.lastSeen?.[c.recipientId]??c.expiresAt)<now-90000));
  if(expired)try{await this.core.calls.call(actor,id,'sweep:'+expired.id+':'+expired.status,state.version,expired.status==='ringing'?'expire':'end',expired.id);}catch(error){if(!(error instanceof Error)||!['Version conflict','Call conflict'].includes(error.message))throw error;}
 }
 private async heartbeat(actor:Actor,id:string,callId:string){
  const state=await this.core.calls.read(actor,id),call=state.calls.find((c:any)=>c.id===callId);
  if(!call||call.status!=='accepted'||![call.callerId,call.recipientId].includes(actor.id))throw Error('Call not accepted');
  const now=Date.now();if(Math.min(call.lastSeen?.[call.callerId]??call.expiresAt,call.lastSeen?.[call.recipientId]??call.expiresAt)<now-90000)throw Error('Call not accepted');
  return this.store.run({actor,id,key:'heartbeat:'+callId+':'+actor.id+':'+Math.floor(now/10000),expectedVersion:state.version,type:'conversation.call.heartbeat',payload:{callId}},s=>this.core.calls.authorize(actor,'conversation.call',s),async s=>{
   const c=s!.calls.find((x:any)=>x.id===callId);if(c.status!=='accepted')throw Error('Call not accepted');
   c.lastSeen??={[c.callerId]:now,[c.recipientId]:now};c.lastSeen[actor.id]=now;return {state:s!,event:'conversation.call.heartbeat'};
  });
 }
 async command(actor:Actor,input:any){
  if(input.action==='inbox')return this.inbox(actor);if(input.action==='read')return this.read(actor,input.id);await this.read(actor,input.id);
  if(input.action==='heartbeat')return this.heartbeat(actor,input.id,input.callId);
  const result=await this.core.execute(actor,input);
  if(input.action==='accept')return this.heartbeat(actor,input.id,input.callId);
  return result;
 }
 async media(actor:Actor,id:string,callId:string){await this.read(actor,id);if(!this.core.media)throw unavailable();return this.core.media.configuration(actor,id,callId);}
}
