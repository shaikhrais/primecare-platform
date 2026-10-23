import {ScopedServiceBase,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {VoiceTaskTrust,VoiceTaskRepository,VerifiedVoiceIdentity} from './voice-tasks.ts';
type IdentityBroker={current(callSid:string):Promise<VerifiedVoiceIdentity|null>};
/** Authenticated app confirmation boundary. Never expose approve() as an AI tool.
 * Provider authentication/OTP verification remains an independently trusted broker.
 * Native request identity is supplied by the host, never by model JSON.
 */
export class PostgresVoiceTaskConfirmationService extends ScopedServiceBase implements VoiceTaskTrust {
 readonly pool:any;readonly identities:IdentityBroker;readonly intents:VoiceTaskRepository;
 constructor(store:AtomicStore,policy:AccessPolicy,pool:any,identities:IdentityBroker,intents:VoiceTaskRepository){
  super(store,policy);if(typeof pool?.query!=='function'||typeof identities?.current!=='function'||typeof intents?.read!=='function')throw Error('Confirmation ports required');
  this.pool=pool;this.identities=identities;this.intents=intents;
 }
 async current(callSid:string){
  if(!/^CA[a-fA-F0-9]{32}$/.test(callSid))return null;
  const row=await this.identities.current(callSid);
  if(!row||row.active!==true||!['otp','passkey'].includes(row.authentication)||typeof row.sessionId!=='string'||! /^[A-Za-z0-9_-]{1,200}$/.test(row.sessionId)||typeof row.actor?.id!=='string'||!row.actor.id||typeof row.actor?.tenantId!=='string'||!row.actor.tenantId||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())return null;
  return Object.freeze({...row,actor:Object.freeze({id:row.actor.id,tenantId:row.actor.tenantId})});
 }
 async #proposal(actor:Actor,intentId:string){
  if(!/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(intentId))throw Error('Confirmation unavailable');
  const found=await this.intents.read(intentId);if(!found)throw Error('Confirmation unavailable');const row=structuredClone(found);
  if(row.status!=='proposed'||row.expiresAt<=Date.now()||row.actor.id!==actor.id||row.actor.tenantId!==actor.tenantId)throw Error('Confirmation unavailable');
  const current=await this.current(row.callSid);
  if(!current||current.actor.id!==actor.id||current.actor.tenantId!==actor.tenantId||current.sessionId!==row.sessionId)throw Error('Confirmation unavailable');
  await this.checkAccess(actor,'voice.task.confirm',{id:row.id,tenantId:row.actor.tenantId,kind:'voice_task',version:1,ownerId:row.actor.id,taskId:row.taskId},['voice_task']);
  return row;
 }
 /** Read-back for the authenticated app. No task executes during preview. */
 async preview(actor:Actor,intentId:string){
  const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  const row=await this.#proposal(owner,intentId);
  return Object.freeze({intentId:row.id,summary:row.summary,digest:row.digest,expiresAt:row.expiresAt});
 }
 /** Called only after an explicit app confirmation of the displayed digest.
  * Host must enforce native session auth/CSRF and must not register this as a tool.
  */
 async approve(actor:Actor,intentId:string,displayedDigest:string){
  const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  if(!/^[a-f0-9]{64}$/.test(displayedDigest))throw Error('Confirmation unavailable');
  const row=await this.#proposal(owner,intentId);if(row.digest!==displayedDigest)throw Error('Proposal changed');
  const approvedAt=Date.now();
  const result=await this.pool.query(`INSERT INTO communication_voice_confirmations(intent_id,digest,call_sid,session_id,user_id,tenant_id,approved_at,expires_at)
   SELECT $1,$2,$3,$4,$5,$6,$7,$8 FROM communication_voice_tasks t WHERE t.id=$1 AND t.digest=$2 AND t.status='proposed' AND (t.intent->>'expiresAt')::bigint>$7
   ON CONFLICT(intent_id) DO UPDATE SET intent_id=EXCLUDED.intent_id
   WHERE communication_voice_confirmations.consumed_at IS NULL AND communication_voice_confirmations.digest=EXCLUDED.digest AND communication_voice_confirmations.call_sid=EXCLUDED.call_sid
   AND communication_voice_confirmations.session_id=EXCLUDED.session_id AND communication_voice_confirmations.user_id=EXCLUDED.user_id AND communication_voice_confirmations.tenant_id=EXCLUDED.tenant_id
   AND communication_voice_confirmations.expires_at>$7 RETURNING intent_id,expires_at`,[row.id,row.digest,row.callSid,row.sessionId,owner.id,owner.tenantId,approvedAt,Math.min(row.expiresAt,approvedAt+60000)]);
  if(result.rows.length!==1)throw Error('Confirmation expired or consumed');
  return Object.freeze({approved:true,expiresAt:Number(result.rows[0].expires_at)});
 }
 async consumeConfirmation(input:Parameters<VoiceTaskTrust['consumeConfirmation']>[0]){
  const request=structuredClone(input),row=await this.#proposal(request.actor,request.intentId);
  if(row.callSid!==request.callSid||row.sessionId!==request.sessionId||row.digest!==request.digest)return null;
  const now=Date.now();
  const result=await this.pool.query(`UPDATE communication_voice_confirmations c SET consumed_at=$7
   FROM communication_voice_tasks t WHERE c.intent_id=$1 AND c.digest=$2 AND c.call_sid=$3 AND c.session_id=$4 AND c.user_id=$5 AND c.tenant_id=$6
   AND c.consumed_at IS NULL AND c.approved_at<=$7 AND c.expires_at>$7 AND c.approved_at>=$7-60000
   AND t.id=c.intent_id AND t.digest=c.digest AND t.status='proposed' AND (t.intent->>'expiresAt')::bigint>$7
   RETURNING c.approved_at`,[request.intentId,request.digest,request.callSid,request.sessionId,request.actor.id,request.actor.tenantId,now]);
  if(result.rows.length!==1)return null;
  return Object.freeze({approved:true,method:'app' as const,approvedAt:Number(result.rows[0].approved_at)});
 }
}
