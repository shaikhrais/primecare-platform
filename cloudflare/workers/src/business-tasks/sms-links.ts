import {assertActor,required,type Actor,type AccessPolicy,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import type {MessagingLink,MessagingLinkPolicy} from '../../../../packages/shared/src/communications/messaging-ai.ts';
import type {InboundSmsEvent} from '../../../../packages/shared/src/communications/twilio-sms-inbound.mjs';
import type {SmsRecipientPolicy} from './sms.ts';
import {PostgresSmsInboundStore} from './sms-inbound.ts';

type Sql={query(sql:string,values?:unknown[]):Promise<{rows:any[]}>};
type Client=Sql&{release():void};
type Pool=Sql&{connect():Promise<Client>};
type Config={accountSid:string;messagingServiceSid:string;sharedNumber:string};
type NativeContext={actor:Actor;sessionHash:string};
/** Construct policy on the owned native client, never recursively acquire the
 * same pool while a transaction/row lock is held. No default grants are supplied.
 */
type PolicyFactory=(client:Sql)=>AccessPolicy;
const denied=()=>Error('Messaging link unavailable');
const phone=(v:unknown)=>typeof v==='string'&&/^\+[1-9][0-9]{1,14}$/.test(v);
const uuid=(v:unknown)=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(v);
function configSnapshot(c:Config):Readonly<Config>{
 if(typeof c?.accountSid!=='string'||typeof c?.messagingServiceSid!=='string'||!/^AC[a-fA-F0-9]{32}$/.test(c.accountSid)||!/^MG[a-fA-F0-9]{32}$/.test(c.messagingServiceSid)||!phone(c.sharedNumber))throw denied();
 return Object.freeze({accountSid:c.accountSid,messagingServiceSid:c.messagingServiceSid,sharedNumber:c.sharedNumber});
}
const lockKey=(c:Pick<Config,'accountSid'|'sharedNumber'>,address:string)=>JSON.stringify(['sms-consent',c.accountSid,c.sharedNumber,address]);
async function lock(db:Sql,c:Pick<Config,'accountSid'|'sharedNumber'>,address:string){await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[lockKey(c,address)]);}
async function freshSession(db:Sql,context:NativeContext){
 assertActor(context.actor);if(!/^[a-f0-9]{64}$/.test(context.sessionHash))throw denied();
 const rows=(await db.query(`SELECT s.token_hash FROM auth_sessions s JOIN users u ON u.id::text=s.user_id::text JOIN tenants t ON t.id::text=u.tenant_id::text
  WHERE s.token_hash=$1 AND u.id::text=$2 AND u.tenant_id::text=$3 AND LOWER(u.status)='active' AND LOWER(t.status)='active'
  AND s.expires_at>clock_timestamp() AND s.created_at<=clock_timestamp() AND s.created_at>clock_timestamp()-INTERVAL '5 minutes'
  FOR SHARE OF s,u,t`,[context.sessionHash,context.actor.id,context.actor.tenantId])).rows;
 if(rows.length!==1)throw denied();
}
function sameLink(a:MessagingLink,b:MessagingLink){
 const keys=['id','version','actorId','tenantId','conversationId','provider','channel','address'] as const;
 return !!b&&Object.keys(b).length===keys.length&&keys.every(k=>a[k]===b[k]);
}
function contextSnapshot(context:NativeContext):NativeContext{
 assertActor(context?.actor);if(typeof context.sessionHash!=='string'||!/^[a-f0-9]{64}$/.test(context.sessionHash))throw denied();
 return {actor:Object.freeze({id:context.actor.id,tenantId:context.actor.tenantId}),sessionHash:context.sessionHash};
}
/** Storage/policy adapter for the existing shared AI reply service. Binding is a
 * trusted native-host operation: phone comes only from independent verified
 * contact enrollment, never the model, SMS body or request phone parameters.
 * No HTTP endpoint, grant, default policy or contact enrollment is created here.
 */
export class PostgresSmsMessagingRepository implements MessagingLinkPolicy {
 readonly pool:Pool;readonly config:Readonly<Config>;readonly policyFor:PolicyFactory;
 constructor(pool:Pool,config:Config,policyFor:PolicyFactory){
  if(typeof pool?.connect!=='function'||typeof pool?.query!=='function'||typeof policyFor!=='function')throw denied();
  this.pool=pool;this.config=configSnapshot(config);this.policyFor=policyFor;
 }
 private policy(db:Sql){const p=this.policyFor(db);if(typeof p?.assert!=='function'||typeof p.assignee!=='function')throw denied();return p;}
 private async conversation(db:Sql,actor:Actor,id:string):Promise<RecordState>{
  const rows=(await db.query(`SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2 AND state->>'kind'='conversation' AND state->'members' ? $3 FOR SHARE`,[actor.tenantId,id,actor.id])).rows;
  if(rows.length!==1)throw denied();return rows[0].state;
 }
 async bind(context:NativeContext,input:{id:string;conversationId:string;consent:true}):Promise<MessagingLink>{
  context=contextSnapshot(context);
  if(!input||Object.keys(input).sort().join(',')!=='consent,conversationId,id'||!uuid(input.id)||input.consent!==true)throw denied();
  required(input.conversationId);input={...input};const actor=context.actor,c=this.config,db=await this.pool.connect();
  try{
   await db.query('BEGIN');await freshSession(db,context);
   const conversation=await this.conversation(db,actor,input.conversationId);await this.policy(db).assert(actor,'messaging.link.bind',conversation);
   const contacts=(await db.query(`SELECT phone,version::float8 AS version FROM communication_voice_verified_contacts WHERE tenant_id=$1 AND user_id=$2 AND revoked_at IS NULL FOR SHARE`,[actor.tenantId,actor.id])).rows;
   if(contacts.length!==1||!phone(contacts[0].phone)||!Number.isSafeInteger(contacts[0].version))throw denied();
   const contact=contacts[0];await lock(db,c,contact.phone);
   const consent=(await db.query(`INSERT INTO communication_sms_consent(account_sid,shared_number,phone,blocked,version) VALUES($1,$2,$3,false,1)
    ON CONFLICT(account_sid,shared_number,phone) DO UPDATE SET phone=EXCLUDED.phone RETURNING blocked,version::float8 AS version`,[c.accountSid,c.sharedNumber,contact.phone])).rows[0];
   if(!consent||consent.blocked||!Number.isSafeInteger(consent.version))throw denied();
   const existing=(await db.query('SELECT * FROM communication_sms_links WHERE id=$1 FOR UPDATE',[input.id])).rows;
   if(existing.length){
    const e=existing[0];if(existing.length!==1||e.revoked_at!==null||e.tenant_id!==actor.tenantId||e.user_id!==actor.id||e.conversation_id!==input.conversationId||e.account_sid!==c.accountSid||e.messaging_service_sid!==c.messagingServiceSid||e.shared_number!==c.sharedNumber||e.phone!==contact.phone||Number(e.contact_version)!==contact.version||Number(e.consent_version)!==consent.version)throw denied();
   }else{
    const active=(await db.query('SELECT id,tenant_id,user_id FROM communication_sms_links WHERE account_sid=$1 AND shared_number=$2 AND phone=$3 AND revoked_at IS NULL FOR UPDATE',[c.accountSid,c.sharedNumber,contact.phone])).rows;
    if(active.some(e=>e.tenant_id!==actor.tenantId||e.user_id!==actor.id))throw denied();
    await db.query('UPDATE communication_sms_links SET revoked_at=clock_timestamp(),version=version+1 WHERE account_sid=$1 AND shared_number=$2 AND phone=$3 AND revoked_at IS NULL',[c.accountSid,c.sharedNumber,contact.phone]);
    await db.query(`INSERT INTO communication_sms_links(id,tenant_id,user_id,conversation_id,account_sid,messaging_service_sid,shared_number,phone,contact_version,consent_version)
     VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)`,[input.id,actor.tenantId,actor.id,input.conversationId,c.accountSid,c.messagingServiceSid,c.sharedNumber,contact.phone,contact.version,consent.version]);
   }
   const result=await this.current(db,actor,input.conversationId,'messaging.link.bind');await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 private async current(db:Sql,actor:Actor,conversationId:string,action:string):Promise<MessagingLink>{
  assertActor(actor);required(conversationId);const c=this.config;
  const rows=(await db.query(`SELECT l.id,l.version::float8 AS version,l.phone,w.state
   FROM communication_sms_links l JOIN communication_sms_consent s ON s.account_sid=l.account_sid AND s.shared_number=l.shared_number AND s.phone=l.phone
   JOIN communication_voice_verified_contacts v ON v.tenant_id=l.tenant_id AND v.user_id=l.user_id AND v.phone=l.phone AND v.version=l.contact_version AND v.revoked_at IS NULL
   JOIN users u ON u.id::text=l.user_id AND u.tenant_id::text=l.tenant_id AND LOWER(u.status)='active'
   JOIN tenants t ON t.id::text=l.tenant_id AND LOWER(t.status)='active'
   JOIN business_work_aggregates w ON w.tenant_id=l.tenant_id AND w.id=l.conversation_id AND w.state->>'kind'='conversation' AND w.state->'members' ? l.user_id
   WHERE l.tenant_id=$1 AND l.user_id=$2 AND l.conversation_id=$3 AND l.account_sid=$4 AND l.messaging_service_sid=$5 AND l.shared_number=$6
   AND l.revoked_at IS NULL AND NOT s.blocked AND s.version=l.consent_version LIMIT 2 FOR SHARE OF l,s,v,u,t,w`,[actor.tenantId,actor.id,conversationId,c.accountSid,c.messagingServiceSid,c.sharedNumber])).rows;
  if(rows.length!==1||!uuid(rows[0].id)||!Number.isSafeInteger(rows[0].version)||!phone(rows[0].phone))throw denied();
  await this.policy(db).assert(actor,action,rows[0].state);
  return Object.freeze({id:rows[0].id,version:rows[0].version,actorId:actor.id,tenantId:actor.tenantId,conversationId,provider:'twilio',channel:'sms',address:rows[0].phone});
 }
 async resolve(actor:Actor,conversationId:string):Promise<MessagingLink>{
  assertActor(actor);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});required(conversationId);
  const db=await this.pool.connect();try{return await this.current(db,actor,conversationId,'messaging.link.use');}finally{db.release();}
 }
 async revoke(context:NativeContext,id:string){
  context=contextSnapshot(context);if(!uuid(id))throw denied();const db=await this.pool.connect(),c=this.config;
  try{
   await db.query('BEGIN');await freshSession(db,context);
   const rows=(await db.query('SELECT phone,conversation_id FROM communication_sms_links WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND account_sid=$4 AND messaging_service_sid=$5 AND shared_number=$6',[id,context.actor.tenantId,context.actor.id,c.accountSid,c.messagingServiceSid,c.sharedNumber])).rows;
   if(rows.length!==1)throw denied();await lock(db,c,rows[0].phone);
   await this.policy(db).assert(context.actor,'messaging.link.revoke',await this.conversation(db,context.actor,rows[0].conversation_id));
   await db.query('UPDATE communication_sms_links SET revoked_at=clock_timestamp(),version=version+1 WHERE id=$1 AND revoked_at IS NULL',[id]);await db.query('COMMIT');
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 /** Serialize submission with committed STOP/re-link/revoke. Provider acceptance
  * is still uncertain on failure and an already submitted SMS cannot be recalled.
  * Work must be the bounded, no-retry provider send only; never acquire this pool.
  */
 async guardSend<T>(expected:MessagingLink,work:()=>Promise<T>):Promise<T>{
  expected=structuredClone(expected);if(expected.channel!=='sms'||expected.provider!=='twilio'||!phone(expected.address)||typeof work!=='function')throw denied();
  const actor=Object.freeze({id:expected.actorId,tenantId:expected.tenantId});assertActor(actor);const db=await this.pool.connect();
  try{
   await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");await db.query("SET LOCAL idle_in_transaction_session_timeout='15s'");await lock(db,this.config,expected.address);
   if(!sameLink(await this.current(db,actor,expected.conversationId,'messaging.link.send'),expected))throw denied();
   // A policy port may await an external authority. Prove the guarded native
   // transaction is still alive after that await before submitting anything.
   await db.query('SELECT 1');
   const result=await work();await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
}
/** Shared signed-inbox validation/deduplication stays in the existing base. STOP
 * and link revocation commit atomically before acknowledgement. START removes
 * provider blocking only; it cannot recreate/revive a link or an old reply.
 */
export class PostgresSmsConsentInboxStore extends PostgresSmsInboundStore {
 readonly database:Pool;
 constructor(pool:Pool){super(pool);if(typeof pool.connect!=='function')throw denied();this.database=pool;}
 override async accept(event:InboundSmsEvent):Promise<'recorded'|'duplicate'|'quarantined'>{
  const e=structuredClone(event);if(!e||!/^AC[a-fA-F0-9]{32}$/.test(e.accountSid)||!phone(e.from)||!phone(e.to))throw denied();
  const db=await this.database.connect();try{
   await db.query('BEGIN');await lock(db,{accountSid:e.accountSid,sharedNumber:e.to},e.from);
   const result=await new PostgresSmsInboundStore(db).accept(e);
   if(result!=='duplicate'&&(e.control==='STOP'||e.control==='START')){
    await db.query(`INSERT INTO communication_sms_consent(account_sid,shared_number,phone,blocked,version) VALUES($1,$2,$3,$4,1)
     ON CONFLICT(account_sid,shared_number,phone) DO UPDATE SET blocked=EXCLUDED.blocked,
      version=CASE WHEN communication_sms_consent.blocked IS DISTINCT FROM EXCLUDED.blocked THEN communication_sms_consent.version+1 ELSE communication_sms_consent.version END,
      updated_at=clock_timestamp()`,[e.accountSid,e.to,e.from,e.control==='STOP']);
    if(e.control==='STOP')await db.query('UPDATE communication_sms_links SET revoked_at=clock_timestamp(),version=version+1 WHERE account_sid=$1 AND shared_number=$2 AND phone=$3 AND revoked_at IS NULL',[e.accountSid,e.to,e.from]);
   }
   await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
}
/** Capture expected from the durable AI turn/outbox binding, never an HTTP body.
 * Existing country/consent/quota rules remain mandatory alongside link checks.
 */
export function linkBoundSmsRecipientPolicy(repository:PostgresSmsMessagingRepository,expected:MessagingLink,base:SmsRecipientPolicy):SmsRecipientPolicy{
 expected=structuredClone(expected);if(typeof base?.recipient!=='function')throw denied();
 return {async recipient(actor,to){
  assertActor(actor);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  if(actor.id!==expected.actorId||actor.tenantId!==expected.tenantId||to!==expected.address)throw denied();
  await base.recipient(actor,to);if(!sameLink(await repository.resolve(actor,expected.conversationId),expected))throw denied();
 }};
}
export function linkBoundSmsTransport<T>(repository:PostgresSmsMessagingRepository,expected:MessagingLink,base:{send(input:{to:string;text:string}):Promise<T>}){
 expected=structuredClone(expected);if(typeof base?.send!=='function')throw denied();
 return {async send(input:{to:string;text:string}):Promise<T>{
  if(!input||Object.keys(input).sort().join(',')!=='text,to'||input.to!==expected.address)throw denied();
  const message={to:input.to,text:input.text};return repository.guardSend(expected,()=>base.send(message));
 }};
}
