import {NativeVoiceTaskHttpAdapter,type NativeVoiceTaskHttpOptions} from '../../../../packages/shared/src/communications/voice-native-http.mjs';
import {ScopedServiceBase,assertActor,type Actor,type AtomicStore,type AccessPolicy,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import {validateCallbackRequest,type CallbackRequest} from './voice-reception-tasks.ts';
import {voiceTaskIntentDigest,VoiceTaskService,PostgresVoiceTaskRepository,type VoiceTaskIntent} from './voice-tasks.ts';
import {PostgresVoiceTaskConfirmationService} from './voice-confirmations.ts';
import {ReceptionCallbackTask} from './voice-reception-tasks.ts';
import {PostgresAtomicStore} from './store.ts';
type Sql={query(sql:string,values?:unknown[]):Promise<{rows:any[]}>};
type Pool=Sql&{connect():Promise<Sql&{release():void}>};
export type CallbackReceipt={intentId:string;status:'requested';reason:CallbackRequest['reason'];windowStartsAt:string;windowEndsAt:string};
type Authorize=(intent:VoiceTaskIntent)=>Promise<void>;
export interface CallbackRequestRepository {
 save(actor:Actor,input:CallbackRequest,intentId:string,authorize:Authorize):Promise<CallbackReceipt>;
 read(actor:Actor,intentId:string,authorize:Authorize):Promise<CallbackReceipt>;
}
const uuid=(v:string)=>/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(v);
const same=(a:CallbackRequest,b:CallbackRequest)=>a.reason===b.reason&&a.windowStartsAt===b.windowStartsAt&&a.windowEndsAt===b.windowEndsAt;
const unavailable=()=>Error('Callback request unavailable');
/** Typed business port. The outer task service must consume independent approval
 * and claim the task first; the repository independently verifies those facts.
 * No URL, phone, assignee, actor or tenant is accepted in model arguments. */
export class ReceptionCallbackRequestService extends ScopedServiceBase {
 readonly repository:CallbackRequestRepository;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:CallbackRequestRepository){super(store,policy);if(typeof repository?.save!=='function'||typeof repository?.read!=='function')throw unavailable();this.repository=repository;}
 private authorization(actor:Actor):Authorize{return async intent=>{if(intent.actor.id!==actor.id||intent.actor.tenantId!==actor.tenantId||intent.taskId!=='reception.callback.request'||intent.taskVersion!==1)throw unavailable();await this.checkAccess(actor,'voice.task.execute',{id:intent.id,tenantId:actor.tenantId,kind:'voice_task',version:1,ownerId:actor.id,taskId:intent.taskId,args:structuredClone(intent.args)},['voice_task']);};}
 async requestCallback(actor:Actor,input:CallbackRequest,idempotencyKey:string):Promise<void>{
  assertActor(actor);const owner={id:actor.id,tenantId:actor.tenantId},request=validateCallbackRequest(input);
  const id=typeof idempotencyKey==='string'&&idempotencyKey.startsWith('voice-task:')?idempotencyKey.slice(11):'';if(!uuid(id))throw unavailable();
  const authorize=this.authorization(owner),saved=await this.repository.save(owner,request,id,authorize);
  const readback=await this.repository.read(owner,id,authorize);
  if(saved.intentId!==id||readback.intentId!==id||saved.status!=='requested'||readback.status!=='requested'||!same(saved,request)||!same(readback,request))throw Error('Callback save outcome requires reconciliation');
 }
 async read(actor:Actor,intentId:string):Promise<CallbackReceipt>{assertActor(actor);if(!uuid(intentId))throw unavailable();const owner={id:actor.id,tenantId:actor.tenantId};return this.repository.read(owner,intentId,this.authorization(owner));}
}
/** Native PostgreSQL persistence. Approval, task, user, tenant and contact rows
 * are locked through the write. The request row itself is append-only here.
 * Current registered permission/call policy remains mandatory via authorize(). */
export class PostgresCallbackRequestRepository implements CallbackRequestRepository {
 readonly pool:Pool;constructor(pool:Pool){if(typeof pool?.connect!=='function')throw unavailable();this.pool=pool;}
 private async context(db:Sql,actor:Actor,id:string,writing:boolean){
  const rows=(await db.query(`SELECT t.intent,t.status,c.contact_version FROM communication_voice_tasks t
   JOIN LATERAL (SELECT v.version AS contact_version FROM communication_voice_verified_contacts v
    JOIN users u ON u.id::text=v.user_id AND u.tenant_id::text=v.tenant_id JOIN tenants n ON n.id=u.tenant_id
    WHERE v.user_id=$2 AND v.tenant_id=$3 AND v.revoked_at IS NULL AND LOWER(u.status)='active' AND LOWER(n.status)='active'
    FOR SHARE OF v,u,n) c ON TRUE
   JOIN communication_voice_confirmations p ON p.intent_id=t.id AND p.digest=t.digest
    AND p.user_id=$2 AND p.tenant_id=$3 AND p.call_sid=t.intent->>'callSid' AND p.session_id=t.intent->>'sessionId'
   WHERE t.id=$1 AND t.intent->'actor'->>'id'=$2 AND t.intent->'actor'->>'tenantId'=$3
    AND p.consumed_at IS NOT NULL AND p.approved_at<=p.consumed_at AND p.consumed_at<p.expires_at AND p.consumed_at<=FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000)
    ${writing?"AND t.status='executing' AND (t.intent->>'expiresAt')::bigint>FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000) AND p.expires_at>FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000) AND p.approved_at>=FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000)-60000":''}
   FOR SHARE OF t,p`,[id,actor.id,actor.tenantId])).rows;
  if(rows.length!==1)throw unavailable();const row=rows[0],intent=row.intent as VoiceTaskIntent;
  if(intent.id!==id||intent.actor.id!==actor.id||intent.actor.tenantId!==actor.tenantId||intent.taskId!=='reception.callback.request'||intent.taskVersion!==1||!Number.isSafeInteger(Number(row.contact_version))||Number(row.contact_version)<1||await voiceTaskIntentDigest(intent)!==intent.digest)throw unavailable();
  return {intent:{...intent,status:row.status} as VoiceTaskIntent,contactVersion:Number(row.contact_version)};
 }
 private receipt(row:any):CallbackReceipt{
  const start=new Date(row.window_starts_at),end=new Date(row.window_ends_at);
  if(!uuid(row.intent_id)||row.status!=='requested'||!['general','appointment_help'].includes(row.reason)||!Number.isFinite(start.getTime())||!Number.isFinite(end.getTime())||start>=end)throw unavailable();
  return {intentId:row.intent_id,status:'requested',reason:row.reason,windowStartsAt:start.toISOString(),windowEndsAt:end.toISOString()};
 }
 async save(actor:Actor,input:CallbackRequest,intentId:string,authorize:Authorize):Promise<CallbackReceipt>{
  assertActor(actor);if(!uuid(intentId))throw unavailable();const request=validateCallbackRequest(input),db=await this.pool.connect();
  try{await db.query('BEGIN');await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['callback:'+intentId]);
   const context=await this.context(db,actor,intentId,true);if(!same(validateCallbackRequest(context.intent.args),request))throw unavailable();await authorize(context.intent);
   await this.context(db,actor,intentId,true);validateCallbackRequest(request);
   await db.query(`INSERT INTO communication_callback_requests(intent_id,tenant_id,user_id,contact_version,reason,window_starts_at,window_ends_at)
    VALUES($1,$2,$3,$4,$5,$6,$7) ON CONFLICT(intent_id) DO NOTHING`,[intentId,actor.tenantId,actor.id,context.contactVersion,request.reason,request.windowStartsAt,request.windowEndsAt]);
   const rows=(await db.query('SELECT * FROM communication_callback_requests WHERE intent_id=$1 AND tenant_id=$2 AND user_id=$3',[intentId,actor.tenantId,actor.id])).rows;
   if(rows.length!==1||Number(rows[0].contact_version)!==context.contactVersion)throw unavailable();const receipt=this.receipt(rows[0]);if(!same(receipt,request))throw unavailable();
   await authorize(context.intent);await this.context(db,actor,intentId,true);validateCallbackRequest(request);await db.query('COMMIT');return receipt;
  }catch(e){await db.query('ROLLBACK');throw e;}finally{db.release();}
 }
 async read(actor:Actor,intentId:string,authorize:Authorize):Promise<CallbackReceipt>{
  assertActor(actor);if(!uuid(intentId))throw unavailable();const db=await this.pool.connect();
  try{await db.query('BEGIN');const context=await this.context(db,actor,intentId,false);await authorize(context.intent);
   const rows=(await db.query('SELECT * FROM communication_callback_requests WHERE intent_id=$1 AND tenant_id=$2 AND user_id=$3',[intentId,actor.tenantId,actor.id])).rows;
   if(rows.length!==1||Number(rows[0].contact_version)!==context.contactVersion)throw unavailable();const receipt=this.receipt(rows[0]);await db.query('ROLLBACK');return receipt;
  }catch(e){await db.query('ROLLBACK');throw e;}finally{db.release();}
 }
}
/** Callback-only composition: real persistence and app approval, without
 * enabling unfinished booking or rescheduling ports. Host identity and current
 * policy are mandatory. Construction mounts no endpoint and sends no traffic. */
export function createPostgresReceptionCallbackServices(options:{pool:Pool;policy:AccessPolicy;identities:ConstructorParameters<typeof PostgresVoiceTaskConfirmationService>[3]}){
 const store=new PostgresAtomicStore(options.pool,'business_sms'),intents=new PostgresVoiceTaskRepository(options.pool);
 const callbacks=new ReceptionCallbackRequestService(store,options.policy,new PostgresCallbackRequestRepository(options.pool));
 const confirmations=new PostgresVoiceTaskConfirmationService(store,options.policy,options.pool,options.identities,intents);
 const tasks=new VoiceTaskService(store,options.policy,intents,confirmations,[new ReceptionCallbackTask(callbacks.requestCallback.bind(callbacks))]);
 return Object.freeze({callbacks,confirmations,tasks});
}

/** Compose callback persistence with the two registered native app approval
 * handlers. The host must supply current native-session resolution and exact
 * endpoint authorization; provider authentication never grants app approval.
 * This factory does not mount routes or alter gateway/permission metadata. */
export function createPostgresReceptionCallbackHttpServices(options:Parameters<typeof createPostgresReceptionCallbackServices>[0] & {native:Omit<NativeVoiceTaskHttpOptions,'service'>}){
 const services=createPostgresReceptionCallbackServices(options);
 const approvals=new NativeVoiceTaskHttpAdapter({...options.native,service:services.confirmations});
 return Object.freeze({...services,approvals});
}
