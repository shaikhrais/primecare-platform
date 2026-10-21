import {sealMfaSeed,openMfaSeed,generateMfaSeed} from './mfa-secret.mjs';
import {matchTotp} from './totp.mjs';
const keyId='mfa-v1';
const encode=new TextEncoder();
export async function digest(value) {return [...new Uint8Array(await crypto.subtle.digest('SHA-256',encode.encode(value)))].map(x=>x.toString(16).padStart(2,'0')).join('');}
function token(){return btoa(String.fromCharCode(...crypto.getRandomValues(new Uint8Array(32)))).replaceAll('+','-').replaceAll('/','_').replaceAll('=','');}
function key(env){if(typeof env.MFA_ENCRYPTION_KEY!=='string'||!/^[a-f0-9]{64}$/.test(env.MFA_ENCRYPTION_KEY))throw Error('MFA unavailable');return Uint8Array.from(env.MFA_ENCRYPTION_KEY.match(/../g),x=>parseInt(x,16));}
function identity(user){if(typeof user.id!=='string'||!user.id||typeof user.tenant_id!=='string'||!user.tenant_id)throw Error('Invalid MFA identity');return {userId:user.id,tenantId:user.tenant_id,keyId};}
function base32(bytes){const alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';let result='',bits=0,value=0;for(const byte of bytes){value=(value<<8)|byte;bits+=8;while(bits>=5){bits-=5;result+=alphabet[(value>>>bits)&31];}}if(bits)result+=alphabet[(value<<(5-bits))&31];return result;}
async function audit(db,user,action){const id=crypto.randomUUID();const r=await db.query('INSERT INTO auth_mfa_audit(id,user_id,tenant_id,action) VALUES($1,$2,$3,$4) RETURNING id',[id,user.id,user.tenant_id,action]);if(r.rows.length!==1||r.rows[0].id!==id)throw Error('MFA audit unavailable');}
const denied={status:401,body:{error:'MFA verification failed'}};
/** Called only after password validation. All authority remains inside this transaction. */
export async function beginMfa(db,env,checked){
 const encryptionKey=key(env); // fail before writes when server key is absent
 await db.query('BEGIN');
 try {
  const result=await db.query("SELECT id::text AS id,tenant_id::text AS tenant_id,roles,status,password_hash FROM users WHERE id::text=$1 FOR UPDATE",[String(checked.id)]);
  const user=result.rows[0];
  if(result.rows.length!==1||!user||user.password_hash!==checked.password_hash||user.roles!=='code_admin'||!['active','mfa_pending'].includes(user.status)) {await db.query('ROLLBACK');return denied;}
  const context=identity(user);
  let credential=(await db.query('SELECT envelope,enabled,last_counter FROM auth_mfa_credentials WHERE user_id=$1 FOR UPDATE',[user.id])).rows[0];
  if(!credential){const envelope=await sealMfaSeed(generateMfaSeed(),encryptionKey,context);const r=await db.query('INSERT INTO auth_mfa_credentials(user_id,tenant_id,envelope) VALUES($1,$2,$3) RETURNING envelope,enabled,last_counter',[user.id,user.tenant_id,JSON.stringify(envelope)]);if(r.rows.length!==1)throw Error('MFA enrollment unavailable');credential=r.rows[0];}
  const seed=await openMfaSeed(credential.envelope,encryptionKey,context);
  const challenge=token(),purpose=credential.enabled?'verify':'enroll';
  // Only one password-verified challenge per user. New login invalidates old setup.
  await db.query('DELETE FROM auth_mfa_challenges WHERE user_id=$1 OR expires_at<=NOW()',[user.id]);
  const hash=await digest(challenge);
  const stored=await db.query("INSERT INTO auth_mfa_challenges(token_hash,user_id,tenant_id,role,password_version,purpose,expires_at) VALUES($1,$2,$3,$4,$5,$6,NOW()+INTERVAL '5 minutes') RETURNING token_hash",[hash,user.id,user.tenant_id,user.roles,await digest(user.password_hash),purpose]);
  if(stored.rows.length!==1||stored.rows[0].token_hash!==hash)throw Error('MFA challenge unavailable');
  if(purpose==='enroll')await audit(db,user,'mfa_enrollment_started');
  await db.query('COMMIT');
  return {status:200,body:{status:'mfa_required',challenge,purpose,...(purpose==='enroll'?{setupKey:base32(seed)}:{})}};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
export function validMfaRequest(body){return body&&typeof body==='object'&&!Array.isArray(body)&&Object.keys(body).sort().join(',')==='challenge,code'&&typeof body.challenge==='string'&&body.challenge.length===43&&/^[A-Za-z0-9_-]+$/.test(body.challenge)&&typeof body.code==='string'&&body.code.length===6&&/^[0-9]+$/.test(body.code);}
export async function finishMfa(db,env,body){
 if(!validMfaRequest(body))return {status:400,body:{error:'Invalid MFA request'}};
 const encryptionKey=key(env),hash=await digest(body.challenge);
 // Read identity without locking, then lock user before challenge to match login's lock order.
 const lookup=await db.query('SELECT user_id FROM auth_mfa_challenges WHERE token_hash=$1',[hash]);
 if(lookup.rows.length!==1)return denied;
 await db.query('BEGIN');
 try {
  const users=await db.query("SELECT id::text AS id,tenant_id::text AS tenant_id,roles,status,password_hash FROM users WHERE id::text=$1 FOR UPDATE",[lookup.rows[0].user_id]);
  const user=users.rows[0];
  const found=await db.query('SELECT *,expires_at>NOW() AS fresh FROM auth_mfa_challenges WHERE token_hash=$1 FOR UPDATE',[hash]);
  const challenge=found.rows[0];
  if(users.rows.length!==1||found.rows.length!==1||!challenge?.fresh||challenge.attempts>=5||!user||!['active','mfa_pending'].includes(user.status)||user.roles!==challenge.role||user.roles!=='code_admin'||user.tenant_id!==challenge.tenant_id||await digest(user.password_hash)!==challenge.password_version){await db.query('ROLLBACK');return denied;}
  const records=await db.query('SELECT tenant_id,envelope,enabled,last_counter FROM auth_mfa_credentials WHERE user_id=$1 FOR UPDATE',[user.id]);
  const credential=records.rows[0];
  if(records.rows.length!==1||credential.tenant_id!==user.tenant_id||credential.enabled!==(challenge.purpose==='verify')){await db.query('ROLLBACK');return denied;}
  const seed=await openMfaSeed(credential.envelope,encryptionKey,identity(user));
  const counter=await matchTotp(seed,body.code,{seconds:Math.floor(Date.now()/1000),lastAcceptedCounter:Number(credential.last_counter)});
  if(counter===null){const attempted=await db.query('UPDATE auth_mfa_challenges SET attempts=attempts+1 WHERE token_hash=$1 AND attempts<5 RETURNING attempts',[hash]);if(attempted.rows.length!==1)throw Error('Invalid MFA attempt result');await audit(db,user,'mfa_verification_failed');await db.query('COMMIT');return denied;}
  const consumed=await db.query('UPDATE auth_mfa_credentials SET enabled=true,enabled_at=COALESCE(enabled_at,NOW()),last_counter=$2 WHERE user_id=$1 AND last_counter<$2 RETURNING user_id',[user.id,counter]);
  if(consumed.rows.length!==1||consumed.rows[0].user_id!==user.id)throw Error('MFA replay rejected');
  const removed=await db.query('DELETE FROM auth_mfa_challenges WHERE token_hash=$1 RETURNING token_hash',[hash]);
  if(removed.rows.length!==1||removed.rows[0].token_hash!==hash)throw Error('Invalid MFA challenge consumption');
  if(user.status==='mfa_pending'){const active=await db.query("UPDATE users SET status='active',updated_at=NOW() WHERE id::text=$1 AND status='mfa_pending' RETURNING id::text AS id",[user.id]);if(active.rows.length!==1||active.rows[0].id!==user.id)throw Error('MFA activation failed');}
  await audit(db,user,credential.enabled?'mfa_verified':'mfa_enrolled');
  const session=token(),sessionHash=await digest(session);
  const stored=await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) SELECT $1,id,NOW()+INTERVAL '12 hours' FROM users WHERE id::text=$2 AND status='active' RETURNING token_hash",[sessionHash,user.id]);
  if(stored.rows.length!==1||stored.rows[0].token_hash!==sessionHash)throw Error('MFA session unavailable');
  await db.query('COMMIT');return {status:200,body:{token:session,userId:user.id,role:user.roles,status:'authenticated'}};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
