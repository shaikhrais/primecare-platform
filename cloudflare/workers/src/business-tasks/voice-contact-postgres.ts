import type {Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {ContactEnrollmentRepository,ContactEnrollmentRow,ContactEnrollmentSession} from './voice-contact.ts';
const fields='id,user_id AS "userId",tenant_id AS "tenantId",session_hash AS "sessionHash",request_id AS "requestId",phone,state,verification_sid AS "verificationSid",expires_at::float8 AS "expiresAt"';
const denied=()=>Error('Contact enrollment unavailable');
async function current(db:any,actor:Actor,hash:string){
 const rows=(await db.query(`SELECT s.token_hash FROM public.auth_sessions s JOIN public.users u ON u.id::text=s.user_id::text JOIN public.tenants t ON t.id::text=u.tenant_id::text
 WHERE s.token_hash=$1 AND u.id::text=$2 AND u.tenant_id::text=$3 AND LOWER(u.status)='active' AND LOWER(t.status)='active' AND s.expires_at>clock_timestamp() AND s.created_at<=clock_timestamp() AND s.created_at>clock_timestamp()-INTERVAL '5 minutes' FOR SHARE OF s,u,t`,[hash,actor.id,actor.tenantId])).rows;
 if(rows.length!==1)throw denied();
}
/** Native session context only; no session is read from an enrollment request body. */
export class PostgresVoiceContactSessions{
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function')throw Error('Native session database required');this.pool=pool;}
 async currentSession(hash:string):Promise<ContactEnrollmentSession|null>{
  const rows=(await this.pool.query(`SELECT s.token_hash AS id,u.id::text AS "userId",u.tenant_id::text AS "tenantId",EXTRACT(EPOCH FROM s.created_at)*1000 AS "createdAt",EXTRACT(EPOCH FROM s.expires_at)*1000 AS "expiresAt" FROM public.auth_sessions s JOIN public.users u ON u.id::text=s.user_id::text JOIN public.tenants t ON t.id::text=u.tenant_id::text WHERE s.token_hash=$1 AND s.expires_at>clock_timestamp() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[hash])).rows;
  if(rows.length!==1)return null;const row=rows[0],createdAt=Number(row.createdAt),expiresAt=Number(row.expiresAt);
  // PostgreSQL timestamps have microseconds; clamp only to whole epoch milliseconds.
  if(!Number.isFinite(createdAt)||!Number.isFinite(expiresAt))throw denied();return {id:row.id,userId:row.userId,tenantId:row.tenantId,createdAt:Math.floor(createdAt),expiresAt:Math.floor(expiresAt),active:true};
 }
}
/** Durable quotas and first-time-only write. No OTP code or password is persisted. */
export class PostgresVoiceContactRepository implements ContactEnrollmentRepository{
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function'||typeof pool?.connect!=='function')throw Error('Contact database required');this.pool=pool;}
 async status(actor:Actor){const rows=(await this.pool.query('SELECT revoked_at IS NULL AS verified FROM public.communication_voice_verified_contacts WHERE tenant_id=$1 AND user_id=$2',[actor.tenantId,actor.id])).rows;if(rows.length>1)throw denied();return {exists:rows.length===1,verified:rows.length===1&&rows[0].verified===true};}
 async claim(input:Parameters<ContactEnrollmentRepository['claim']>[0]){
  const db=await this.pool.connect();try{
   await db.query('BEGIN');await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[JSON.stringify(['voice-contact',input.actor.tenantId,input.actor.id])]);await current(db,input.actor,input.sessionHash);
   if((await db.query('SELECT 1 FROM public.communication_voice_verified_contacts WHERE tenant_id=$1 AND user_id=$2',[input.actor.tenantId,input.actor.id])).rows.length)throw denied();
   const values=[input.actor.tenantId,input.actor.id],existing=(await db.query('SELECT '+fields+' FROM public.communication_voice_contact_challenges WHERE tenant_id=$1 AND user_id=$2 AND request_id=$3',[...values,input.requestId])).rows;
   if(existing.length){const row=existing[0];if(existing.length!==1||row.phone!==input.phone||row.sessionHash!==input.sessionHash||row.expiresAt<=Date.now()||row.state!=='pending')throw denied();await db.query('COMMIT');return {row,created:false};}
   // One explicit enrollment send per user in ten minutes. Do not resend after an
   // uncertain send or reused provider SID; provider code lifetime can exceed UI TTL.
   if((await db.query("SELECT 1 FROM public.communication_voice_contact_challenges WHERE tenant_id=$1 AND user_id=$2 AND created_at>clock_timestamp()-INTERVAL '10 minutes' LIMIT 1",values)).rows.length)throw denied();
   await db.query("DELETE FROM public.communication_voice_contact_challenges WHERE tenant_id=$1 AND user_id=$2 AND expires_at<EXTRACT(EPOCH FROM clock_timestamp()-INTERVAL '1 day')*1000",values);
   const quota=(await db.query(`INSERT INTO public.communication_voice_otp_limits(phone,window_start,sends) VALUES($1,now(),1) ON CONFLICT(phone) DO UPDATE SET sends=CASE WHEN communication_voice_otp_limits.window_start<now()-INTERVAL '10 minutes' THEN 1 ELSE communication_voice_otp_limits.sends+1 END,window_start=CASE WHEN communication_voice_otp_limits.window_start<now()-INTERVAL '10 minutes' THEN now() ELSE communication_voice_otp_limits.window_start END RETURNING sends`,[input.phone])).rows;
   if(quota.length!==1||quota[0].sends>3)throw denied();
   const row=(await db.query('INSERT INTO public.communication_voice_contact_challenges(id,tenant_id,user_id,session_hash,request_id,phone,state,expires_at) VALUES($1,$2,$3,$4,$5,$6,\'sending\',$7) RETURNING '+fields,[crypto.randomUUID(),...values,input.sessionHash,input.requestId,input.phone,input.expiresAt])).rows;
   if(row.length!==1)throw denied();await db.query('COMMIT');return {row:row[0],created:true};
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 async sent(actor:Actor,id:string,sid:string){const r=await this.pool.query("UPDATE public.communication_voice_contact_challenges SET state='pending',verification_sid=$4,updated_at=now() WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND state='sending' AND expires_at>EXTRACT(EPOCH FROM clock_timestamp())*1000 RETURNING id",[id,actor.tenantId,actor.id,sid]);if(r.rows.length!==1)throw denied();}
 async read(actor:Actor,id:string):Promise<ContactEnrollmentRow|null>{const rows=(await this.pool.query('SELECT '+fields+' FROM public.communication_voice_contact_challenges WHERE id=$1 AND tenant_id=$2 AND user_id=$3',[id,actor.tenantId,actor.id])).rows;if(rows.length>1)throw denied();return rows[0]??null;}
 async claimCheck(actor:Actor,id:string,hash:string){return (await this.pool.query("UPDATE public.communication_voice_contact_challenges SET state='checking',check_attempts=check_attempts+1,updated_at=now() WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND session_hash=$4 AND state='pending' AND check_attempts<5 AND expires_at>EXTRACT(EPOCH FROM clock_timestamp())*1000 RETURNING id",[id,actor.tenantId,actor.id,hash])).rows.length===1;}
 async finish(actor:Actor,id:string,hash:string,approved:boolean){
  const db=await this.pool.connect();try{
   await db.query('BEGIN');await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[JSON.stringify(['voice-contact',actor.tenantId,actor.id])]);await current(db,actor,hash);
   const rows=(await db.query("SELECT "+fields+" FROM public.communication_voice_contact_challenges WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND session_hash=$4 AND state='checking' AND expires_at>EXTRACT(EPOCH FROM clock_timestamp())*1000 FOR UPDATE",[id,actor.tenantId,actor.id,hash])).rows;if(rows.length!==1)throw denied();
   if(approved){const saved=await db.query('INSERT INTO public.communication_voice_verified_contacts(tenant_id,user_id,phone,version,verified_at) VALUES($1,$2,$3,1,now()) ON CONFLICT(tenant_id,user_id) DO NOTHING RETURNING user_id',[actor.tenantId,actor.id,rows[0].phone]);if(saved.rows.length!==1)throw denied();}
   const saved=await db.query("UPDATE public.communication_voice_contact_challenges SET state=$4,updated_at=now() WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND state='checking' RETURNING id",[id,actor.tenantId,actor.id,approved?'verified':'pending']);if(saved.rows.length!==1)throw denied();await db.query('COMMIT');
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 async unknown(actor:Actor,id:string){await this.pool.query("UPDATE public.communication_voice_contact_challenges SET state='unknown',updated_at=now() WHERE id=$1 AND tenant_id=$2 AND user_id=$3 AND state IN ('sending','pending','checking')",[id,actor.tenantId,actor.id]);}
}
