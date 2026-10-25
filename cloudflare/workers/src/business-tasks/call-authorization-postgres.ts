import type {CallAccount,PhoneCallGrant,PhoneCallGrantRepository} from './call-authorization.ts';
import type {SpokenConfirmation,SpokenConfirmationRepository} from './voice-spoken-confirmations.ts';
type Sql={query(sql:string,params?:unknown[]):Promise<{rows:any[]}>};
type Pool=Sql&{connect():Promise<Sql&{release():void}>};
const now="FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000)";
const authSelect=`SELECT call_sid AS "callSid",state,account_reference AS reference,directory_version::float8 AS "directoryVersion",tenant_id,user_id,phone,contact_version::float8 AS "contactVersion",verification_sid AS "verificationSid",session_id AS "sessionId",expires_at::float8 AS "expiresAt" FROM communication_phone_authorizations`;
/** Read-only account selection by the caller's public account extension.
 * Rechecks active native user/tenant, directory version and enrolled contact.
 * A selection grants nothing until the separate OTP check succeeds. */
export class PostgresPhoneCallAccountDirectory {
 readonly pool:Sql;
 constructor(pool:Sql){this.pool=pool;if(typeof pool?.query!=='function')throw Error('Account directory required');}
 async resolve(reference:string):Promise<CallAccount|null>{
  if(typeof reference!=='string'||!/^[1-9][0-9]{3}$/.test(reference))return null;
  const rows=(await this.pool.query(`SELECT e.extension,e.version::float8 AS directory_version,e.user_id,e.tenant_id,c.phone,c.version::float8 AS contact_version
   FROM communication_voice_extensions e JOIN users u ON u.id::text=e.user_id AND u.tenant_id::text=e.tenant_id
   JOIN tenants t ON t.id::text=e.tenant_id JOIN communication_voice_verified_contacts c ON c.tenant_id=e.tenant_id AND c.user_id=e.user_id AND c.revoked_at IS NULL
   WHERE e.extension=$1 AND e.active AND LOWER(u.status)='active' AND LOWER(t.status)='active'
   AND NOT EXISTS (SELECT 1 FROM communication_voice_verified_contacts other
    JOIN users ou ON ou.id::text=other.user_id AND ou.tenant_id::text=other.tenant_id JOIN tenants ot ON ot.id::text=other.tenant_id
    WHERE other.phone=c.phone AND other.revoked_at IS NULL AND LOWER(ou.status)='active' AND LOWER(ot.status)='active'
    AND (other.user_id<>c.user_id OR other.tenant_id<>c.tenant_id)) LIMIT 2`,[reference])).rows;
  if(rows.length!==1)return null;const r=rows[0];return {actor:{id:r.user_id,tenantId:r.tenant_id},reference:r.extension,directoryVersion:r.directory_version,phone:r.phone,contactVersion:r.contact_version};
 }
}
export class PostgresPhoneCallGrantRepository implements PhoneCallGrantRepository {
 readonly pool:Pool;
 constructor(pool:Pool){this.pool=pool;if(typeof pool?.query!=='function'||typeof pool?.connect!=='function')throw Error('Call grant database required');}
 async begin(row:PhoneCallGrant){
  row=structuredClone(row);const db=await this.pool.connect();try{
   await db.query('BEGIN');
   // One immutable candidate per canonical call across every tenant. The same
   // contact quota is shared with existing app-paired OTP, not a new bypass.
   await db.query(`INSERT INTO communication_phone_authorizations(call_sid,state,account_reference,directory_version,tenant_id,user_id,phone,contact_version,expires_at) VALUES($1,'sending',$2,$3,$4,$5,$6,$7,$8)`,[row.callSid,row.reference,row.directoryVersion,row.actor.tenantId,row.actor.id,row.phone,row.contactVersion,row.expiresAt]);
   const rows=(await db.query(`INSERT INTO communication_voice_otp_limits(phone,window_start,sends) VALUES($1,clock_timestamp(),1)
    ON CONFLICT(phone) DO UPDATE SET sends=CASE WHEN communication_voice_otp_limits.window_start<clock_timestamp()-INTERVAL '10 minutes' THEN 1 ELSE communication_voice_otp_limits.sends+1 END,
    window_start=CASE WHEN communication_voice_otp_limits.window_start<clock_timestamp()-INTERVAL '10 minutes' THEN clock_timestamp() ELSE communication_voice_otp_limits.window_start END RETURNING sends`,[row.phone])).rows;
   if(rows.length!==1||rows[0].sends>3)throw Error('Verification quota');await db.query('COMMIT');
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 async read(callSid:string):Promise<PhoneCallGrant|null>{const rows=(await this.pool.query(authSelect+' WHERE call_sid=$1',[callSid])).rows;if(rows.length!==1)return null;const {tenant_id,user_id,...row}=rows[0];return {...row,actor:{id:user_id,tenantId:tenant_id}} as PhoneCallGrant;}
 private async change(sql:string,params:unknown[]){if((await this.pool.query(sql,params)).rows.length!==1)throw Error('Call grant conflict');}
 async sent(callSid:string,verificationSid:string){await this.change(`UPDATE communication_phone_authorizations SET state='pending',verification_sid=$2 WHERE call_sid=$1 AND state='sending' AND expires_at>${now} RETURNING call_sid`,[callSid,verificationSid]);}
 async claimCheck(callSid:string){return (await this.pool.query(`UPDATE communication_phone_authorizations SET state='checking',check_attempts=check_attempts+1 WHERE call_sid=$1 AND state='pending' AND check_attempts<5 AND expires_at>${now} RETURNING call_sid`,[callSid])).rows.length===1;}
 async checked(callSid:string,approved:boolean,sessionId:string,expiresAt:number){await this.change(`UPDATE communication_phone_authorizations SET state=CASE WHEN $2 THEN 'verified' ELSE 'pending' END,session_id=CASE WHEN $2 THEN $3 ELSE NULL END,expires_at=CASE WHEN $2 THEN LEAST($4,${now}+300000) ELSE expires_at END WHERE call_sid=$1 AND state='checking' AND expires_at>${now} RETURNING call_sid`,[callSid,approved,sessionId,expiresAt]);}
 async unknown(callSid:string){await this.pool.query("UPDATE communication_phone_authorizations SET state='unknown',session_id=NULL WHERE call_sid=$1 AND state IN ('sending','pending','checking','verified')",[callSid]);}
}
const proofSelect=`SELECT call_sid AS "callSid",challenge_id::text AS "challengeId",intent_id AS "intentId",digest,session_id AS "sessionId",user_id AS "userId",tenant_id AS "tenantId",state,method,created_at::float8 AS "createdAt",expires_at::float8 AS "expiresAt",approved_at::float8 AS "approvedAt" FROM communication_spoken_confirmations`;
const exactWhere=`call_sid=$1 AND challenge_id=$2 AND intent_id=$3 AND digest=$4 AND session_id=$5 AND user_id=$6 AND tenant_id=$7 AND expires_at>${now}`;
const values=(p:SpokenConfirmation)=>[p.callSid,p.challengeId,p.intentId,p.digest,p.sessionId,p.userId,p.tenantId];
export class PostgresSpokenConfirmationRepository implements SpokenConfirmationRepository {
 readonly pool:Sql;
 constructor(pool:Sql){this.pool=pool;if(typeof pool?.query!=='function')throw Error('Spoken confirmation database required');}
 async prepare(p:SpokenConfirmation){
  const result=await this.pool.query(`INSERT INTO communication_spoken_confirmations(call_sid,challenge_id,intent_id,digest,session_id,user_id,tenant_id,state,created_at,expires_at)
   SELECT $1,$2,$3,$4,$5,$6,$7,'prepared',$8,$9 FROM communication_voice_tasks t WHERE t.id=$3 AND t.digest=$4 AND t.status='proposed' AND (t.intent->>'expiresAt')::bigint>${now}
   ON CONFLICT(call_sid) DO UPDATE SET challenge_id=EXCLUDED.challenge_id,intent_id=EXCLUDED.intent_id,digest=EXCLUDED.digest,session_id=EXCLUDED.session_id,user_id=EXCLUDED.user_id,tenant_id=EXCLUDED.tenant_id,state='prepared',method=NULL,approved_at=NULL,created_at=EXCLUDED.created_at,expires_at=EXCLUDED.expires_at
   WHERE communication_spoken_confirmations.expires_at<=${now} OR communication_spoken_confirmations.state IN ('declined','consumed') RETURNING call_sid`,[...values(p),p.createdAt,p.expiresAt]);
  if(result.rows.length!==1)throw Error('Readback already pending');
 }
 async read(callSid:string):Promise<SpokenConfirmation|null>{const rows=(await this.pool.query(proofSelect+' WHERE call_sid=$1',[callSid])).rows;return rows.length===1?rows[0]:null;}
 async decide(p:SpokenConfirmation,method:'signed-speech'|'dtmf'|null){return (await this.pool.query(`UPDATE communication_spoken_confirmations SET state=CASE WHEN $8::text IS NULL THEN 'declined' ELSE 'approved' END,method=$8,approved_at=CASE WHEN $8::text IS NULL THEN NULL ELSE ${now} END WHERE ${exactWhere} AND state='prepared' RETURNING call_sid`,[...values(p),method])).rows.length===1;}
 async consume(p:SpokenConfirmation){return (await this.pool.query(`UPDATE communication_spoken_confirmations SET state='consumed' WHERE ${exactWhere} AND state='approved' AND approved_at<=${now} AND approved_at>=${now}-60000 RETURNING call_sid`,values(p))).rows.length===1;}
}
