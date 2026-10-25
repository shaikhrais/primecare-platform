import {ScopedServiceBase,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {VoiceTokenDirectory} from './twilio-token.ts';
import type {VoiceCallVerifier} from './twilio-connect.ts';
import type {VerifiedVoiceIdentity} from './voice-tasks.ts';
export type VoiceOtpContact={phone:string;version:number};
export type VoiceOtpRow={callSid:string;state:string;nativeSessionHash:string;userId:string;tenantId:string;phone:string;contactVersion:number;verificationSid:string;grantId:string;expiresAt:number};
export interface VoiceOtpRepository {
 issue(callSid:string,pairingHash:string,expiresAt:number):Promise<void>;
 begin(input:{callSid:string;pairingHash:string;nativeSessionHash:string;actor:Actor;contact:VoiceOtpContact}):Promise<boolean>;
 sent(callSid:string,verificationSid:string):Promise<void>;
 unknown(callSid:string):Promise<void>;
 read(callSid:string):Promise<VoiceOtpRow|null>;
 claimCheck(callSid:string):Promise<boolean>;
 checked(callSid:string,approved:boolean,grantId:string,expiresAt:number):Promise<void>;
}
export type VoiceOtpPorts={sessions:Pick<VoiceTokenDirectory,'currentSession'>;calls:VoiceCallVerifier;contacts:{current(actor:Actor):Promise<VoiceOtpContact|null>};provider(contact:VoiceOtpContact):{start():Promise<{verificationSid:string;status:'pending'}>;check(sid:string,code:string):Promise<{approved:boolean}>}};
const sid=(prefix:string,v:unknown)=>typeof v==='string'&&v.length===34&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(v);
async function pairingHash(callSid:string,pin:string){const digest=await crypto.subtle.digest('SHA-256',new TextEncoder().encode('primecare-call-pairing-v1:'+callSid+':'+pin));return Array.from(new Uint8Array(digest),b=>b.toString(16).padStart(2,'0')).join('');}
function pairingPin(){let value;const bytes=new Uint32Array(1);do{crypto.getRandomValues(bytes);value=bytes[0];}while(value>=4200000000);return String(value%100000000).padStart(8,'0');}
/** App-linked call step-up. issue() is for the signed provider flow BEFORE AI
 * streaming; start/check are native authenticated app operations, never AI tools.
 */
export class VoiceOtpService extends ScopedServiceBase {
 readonly repository:VoiceOtpRepository;readonly ports:VoiceOtpPorts;readonly config:Readonly<{accountSid:string;sharedNumber:string}>;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:VoiceOtpRepository,ports:VoiceOtpPorts,config:{accountSid:string;sharedNumber:string}){
  super(store,policy);if(!sid('AC',config.accountSid)||typeof config.sharedNumber!=='string'||config.sharedNumber.trim()!==config.sharedNumber||!/^\+[1-9][0-9]{1,14}$/.test(config.sharedNumber)||typeof ports?.sessions?.currentSession!=='function'||typeof ports?.calls?.fetch!=='function'||typeof ports?.contacts?.current!=='function'||typeof ports?.provider!=='function'||['issue','begin','sent','unknown','read','claimCheck','checked'].some(k=>typeof (repository as any)?.[k]!=='function'))throw Error('Call OTP ports required');
  this.repository=repository;this.ports=ports;this.config=Object.freeze({...config});
 }
 async #live(callSid:string,contact?:VoiceOtpContact){
  if(!sid('CA',callSid))throw Error('Call verification unavailable');const call=await this.ports.calls.fetch(callSid);
  if(!call||call.sid!==callSid||call.accountSid!==this.config.accountSid||call.direction!=='inbound'||call.to!==this.config.sharedNumber||!['ringing','in-progress'].includes(call.status))throw Error('Call verification unavailable');
  // A provider-read number is a matching constraint, never authentication.
  // Do not reverse-lookup users or infer a tenant from caller ID. The current
  // native session selects the account, including accounts sharing a number.
  // Hidden, SIP/client and differently formatted numbers need reception rather
  // than guessing a country code or accepting a model-supplied replacement.
  if(contact&&call.from!==contact.phone)throw Error('Call verification unavailable');
 }
 async #session(hash:string){
  if(typeof hash!=='string'||hash.length!==64||! /^[a-f0-9]{64}$/.test(hash))throw Error('Current app session required');
  const row=await this.ports.sessions.currentSession(hash);
  if(!row||row.id!==hash||row.active!==true||!row.userId||!row.tenantId||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())throw Error('Current app session required');
  return Object.freeze({actor:Object.freeze({id:row.userId,tenantId:row.tenantId}),expiresAt:row.expiresAt});
 }
 async #contact(actor:Actor){const row=await this.ports.contacts.current(actor);if(!row||typeof row.phone!=='string'||row.phone.trim()!==row.phone||!/^\+[1-9][0-9]{1,14}$/.test(row.phone)||!Number.isSafeInteger(row.version)||row.version<1)throw Error('Verified account contact required');return Object.freeze({phone:row.phone,version:row.version});}
 async #authorize(actor:Actor,callSid:string,action:string){await this.checkAccess(actor,action,{id:'voice-auth:'+callSid,tenantId:actor.tenantId,kind:'voice_auth',version:1,userId:actor.id},['voice_auth']);}
 /** Returns a pairing secret only to an authenticated provider handler. The host
  * must deliver it privately to the current caller, never to logs or the LLM.
  * Once issued, a lost response requires restarting this flow with a new call.
  */
 async issue(callSid:string){await this.#live(callSid);const pin=pairingPin(),expiresAt=Date.now()+120000;await this.repository.issue(callSid,await pairingHash(callSid,pin),expiresAt);return {pairingCode:pin,expiresAt};}
 async start(nativeSessionHash:string,callSid:string,pin:string){
  if(typeof pin!=='string'||pin.length!==8||! /^[0-9]{8}$/.test(pin))throw Error('Call verification unavailable');
  const session=await this.#session(nativeSessionHash),contact=await this.#contact(session.actor);await this.#live(callSid,contact);await this.#authorize(session.actor,callSid,'voice.otp.start');
  let claimed=false;try{claimed=await this.repository.begin({callSid,pairingHash:await pairingHash(callSid,pin),nativeSessionHash,actor:session.actor,contact});}catch{throw Error('Call verification unavailable');}
  if(!claimed)throw Error('Pairing unavailable');
  try{
   // Claim is durable before the provider send. No send retries after ambiguity.
   await this.#bound(nativeSessionHash,callSid,'voice.otp.start','sending');
   const result=await this.ports.provider(contact).start();if(!sid('VE',result.verificationSid)||result.status!=='pending')throw Error('Receipt invalid');
   await this.repository.sent(callSid,result.verificationSid);return {verificationRequested:true};
  }catch{try{await this.repository.unknown(callSid);}catch{}throw Error('Verification send outcome unknown; do not resend automatically');}
 }
 async #bound(hash:string,callSid:string,action:string,state:string){
  const session=await this.#session(hash),row=await this.repository.read(callSid);
  if(!row||row.callSid!==callSid||row.state!==state||row.nativeSessionHash!==hash||row.userId!==session.actor.id||row.tenantId!==session.actor.tenantId||row.expiresAt<=Date.now())throw Error('Call verification unavailable');
  const snapshot=Object.freeze({...row}),contact=await this.#contact(session.actor);
  if(contact.phone!==snapshot.phone||contact.version!==snapshot.contactVersion)throw Error('Account contact changed');
  await this.#live(callSid,contact);await this.#authorize(session.actor,callSid,action);
  const latest=await this.#session(hash),latestContact=await this.#contact(latest.actor);
  if(latest.actor.id!==session.actor.id||latest.actor.tenantId!==session.actor.tenantId||latestContact.phone!==snapshot.phone||latestContact.version!==snapshot.contactVersion||snapshot.expiresAt<=Date.now())throw Error('Call verification unavailable');
  return {session:latest,row:snapshot,contact:latestContact};
 }
 async check(nativeSessionHash:string,callSid:string,code:string){
  if(typeof code!=='string'||code.length!==6||! /^[0-9]{6}$/.test(code))throw Error('Verification unavailable');
  const initial=await this.#bound(nativeSessionHash,callSid,'voice.otp.check','pending');
  if(!await this.repository.claimCheck(callSid))throw Error('Verification attempts unavailable');
  try{
   await this.#bound(nativeSessionHash,callSid,'voice.otp.check','checking');
   const result=await this.ports.provider(initial.contact).check(initial.row.verificationSid,code);
   const current=await this.#bound(nativeSessionHash,callSid,'voice.otp.check','checking');
   if(typeof result.approved!=='boolean')throw Error('Invalid receipt');
   await this.repository.checked(callSid,result.approved,crypto.randomUUID(),Math.min(initial.session.expiresAt,current.session.expiresAt,Date.now()+300000));
   return {verified:result.approved};
  }catch{try{await this.repository.unknown(callSid);}catch{}throw Error('Verification unavailable');}
 }
 /** Signed provider polling only; no account data or pairing secret is returned. */
 async pending(callSid:string){try{await this.#live(callSid);const row=await this.repository.read(callSid);return !!row&&row.callSid===callSid&&row.expiresAt>Date.now()&&['issued','sending','pending','checking'].includes(row.state);}catch{return false;}}
 /** Native session/contact/permission/call are rechecked on every tool boundary. */
 async current(callSid:string):Promise<VerifiedVoiceIdentity|null>{
  try{const row=await this.repository.read(callSid);if(!row||row.state!=='verified')return null;const bound=await this.#bound(row.nativeSessionHash,callSid,'voice.otp.use','verified');return {actor:bound.session.actor,sessionId:bound.row.grantId,authentication:'otp',active:true,expiresAt:Math.min(bound.row.expiresAt,bound.session.expiresAt)};}catch{return null;}
 }
}

/** SQL ports use the existing pool without retaining a connection during provider
 * I/O. Pairing + per-contact send quota are committed before any SMS attempt.
 */
export class PostgresVoiceOtpRepository implements VoiceOtpRepository {
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function'||typeof pool?.connect!=='function')throw Error('Voice OTP database required');this.pool=pool;}
 async issue(callSid:string,hash:string,expiresAt:number){const r=await this.pool.query("INSERT INTO communication_voice_otp(call_sid,pairing_hash,expires_at) VALUES($1,$2,$3) ON CONFLICT(call_sid) DO NOTHING RETURNING call_sid",[callSid,hash,expiresAt]);if(r.rows.length!==1)throw Error('Pairing already issued');}
 async begin(input:Parameters<VoiceOtpRepository['begin']>[0]){
  const db=await this.pool.connect();try{
   await db.query('BEGIN');
   const r=await db.query(`UPDATE communication_voice_otp SET pairing_attempts=pairing_attempts+1,
    state=CASE WHEN pairing_hash=$2 THEN 'sending' ELSE state END,
    native_session_hash=CASE WHEN pairing_hash=$2 THEN $3 ELSE native_session_hash END,
    user_id=CASE WHEN pairing_hash=$2 THEN $4 ELSE user_id END,tenant_id=CASE WHEN pairing_hash=$2 THEN $5 ELSE tenant_id END,
    phone=CASE WHEN pairing_hash=$2 THEN $6 ELSE phone END,contact_version=CASE WHEN pairing_hash=$2 THEN $7 ELSE contact_version END
    WHERE call_sid=$1 AND state='issued' AND pairing_attempts<5 AND expires_at>EXTRACT(EPOCH FROM now())*1000 RETURNING pairing_hash=$2 AS matched`,[input.callSid,input.pairingHash,input.nativeSessionHash,input.actor.id,input.actor.tenantId,input.contact.phone,input.contact.version]);
   if(r.rows.length!==1||r.rows[0].matched!==true){await db.query('COMMIT');return false;}
   const quota=(await db.query(`INSERT INTO communication_voice_otp_limits(phone,window_start,sends) VALUES($1,now(),1)
    ON CONFLICT(phone) DO UPDATE SET sends=CASE WHEN communication_voice_otp_limits.window_start<now()-INTERVAL '10 minutes' THEN 1 ELSE communication_voice_otp_limits.sends+1 END,
    window_start=CASE WHEN communication_voice_otp_limits.window_start<now()-INTERVAL '10 minutes' THEN now() ELSE communication_voice_otp_limits.window_start END RETURNING sends`,[input.contact.phone])).rows;
   if(quota.length!==1||quota[0].sends>3)throw Error('Verification send quota');
   await db.query('COMMIT');return true;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 async sent(callSid:string,verificationSid:string){const r=await this.pool.query("UPDATE communication_voice_otp SET state='pending',verification_sid=$2 WHERE call_sid=$1 AND state='sending' AND expires_at>EXTRACT(EPOCH FROM now())*1000 RETURNING call_sid",[callSid,verificationSid]);if(r.rows.length!==1)throw Error('Verification receipt conflict');}
 async unknown(callSid:string){await this.pool.query("UPDATE communication_voice_otp SET state='unknown',grant_id=NULL WHERE call_sid=$1 AND state IN ('sending','pending','checking','verified')",[callSid]);}
 async read(callSid:string){const rows=(await this.pool.query(`SELECT call_sid AS "callSid",state,native_session_hash AS "nativeSessionHash",user_id AS "userId",tenant_id AS "tenantId",phone,contact_version::float8 AS "contactVersion",verification_sid AS "verificationSid",grant_id AS "grantId",expires_at::float8 AS "expiresAt" FROM communication_voice_otp WHERE call_sid=$1`,[callSid])).rows;return rows.length===1?rows[0]:null;}
 async claimCheck(callSid:string){const r=await this.pool.query("UPDATE communication_voice_otp SET state='checking',check_attempts=check_attempts+1 WHERE call_sid=$1 AND state='pending' AND check_attempts<5 AND expires_at>EXTRACT(EPOCH FROM now())*1000 RETURNING call_sid",[callSid]);return r.rows.length===1;}
 async checked(callSid:string,approved:boolean,grantId:string,expiresAt:number){const r=await this.pool.query("UPDATE communication_voice_otp SET state=CASE WHEN $2 THEN 'verified' ELSE 'pending' END,grant_id=CASE WHEN $2 THEN $3 ELSE NULL END,expires_at=CASE WHEN $2 THEN $4 ELSE expires_at END WHERE call_sid=$1 AND state='checking' AND expires_at>EXTRACT(EPOCH FROM now())*1000 RETURNING call_sid",[callSid,approved,grantId,expiresAt]);if(r.rows.length!==1)throw Error('Verification result conflict');}
}
/** Read current verified records only. This change provides no contact-enrolment
 * writer and does not mark any real phone as verified.
 */
export class PostgresVoiceOtpContactDirectory {
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function')throw Error('Contact database required');this.pool=pool;}
 async current(actor:Actor){const rows=(await this.pool.query(`SELECT c.phone,c.version::float8 AS version FROM communication_voice_verified_contacts c
  JOIN users u ON u.id::text=c.user_id AND u.tenant_id::text=c.tenant_id JOIN tenants t ON t.id=u.tenant_id
  WHERE c.user_id=$1 AND c.tenant_id=$2 AND c.revoked_at IS NULL AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[actor.id,actor.tenantId])).rows;return rows.length===1?rows[0]:null;}
}
