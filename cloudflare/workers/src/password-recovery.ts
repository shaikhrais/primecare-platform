import type {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {sendEmail,mailReady,type MailEnv} from './email';
import {authRateLimit} from './auth-rate-limit';
export const recoveryMessage='If an active account matches, recovery instructions will be emailed. Check your inbox and spam folder.';
export async function recoveryHash(value:string) {
 const digest=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(value));
 return [...new Uint8Array(digest)].map(byte=>byte.toString(16).padStart(2,'0')).join('');
}
export function validateRecovery(value:Record<string,unknown>,reset=false) {
 const allowed=reset?['email','code','newPassword']:['email'];
 const email=typeof value.email==='string'?value.email.trim().toLowerCase():'';
 if(Object.keys(value).some(k=>!allowed.includes(k)) || email.length>254 || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))return null;
 if(!reset)return {email,code:'',newPassword:''};
 const code=typeof value.code==='string'?value.code.trim().toUpperCase():'';
 const newPassword=typeof value.newPassword==='string'?value.newPassword:'';
 if(!/^[A-F0-9]{12}$/.test(code) || newPassword.length<12 || new TextEncoder().encode(newPassword).length>72)return null;
 return {email,code,newPassword};
}
export async function recoverPassword(db:Client,env:MailEnv,email:string) {
 if(!mailReady(env))return {status:503,body:{error:'Password recovery email is temporarily unavailable. Contact your IT team.'}};
 const retry=await authRateLimit(db,await recoveryHash('forgot:'+email),'forgotPassword');
 if(retry!==null)return {status:429,body:{error:'Too many recovery requests. Please try again later.'}};
 const user=(await db.query("SELECT id,email FROM users WHERE LOWER(email)=$1 AND LOWER(status)='active' LIMIT 2",[email])).rows;
 if(user.length!==1)return {status:200,body:{message:recoveryMessage}};
 const code=[...crypto.getRandomValues(new Uint8Array(6))].map(b=>b.toString(16).padStart(2,'0')).join('').toUpperCase();
 const hash=await recoveryHash(email+':'+code);
 await db.query("INSERT INTO auth_password_resets(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '15 minutes')",[hash,user[0].id]);
 try {await sendEmail(env,email,'password_reset',{code},'password-reset-'+hash);}
 catch {await db.query('DELETE FROM auth_password_resets WHERE token_hash=$1',[hash]);return {status:503,body:{error:'Password recovery email is temporarily unavailable. Please try again later.'}};}
 return {status:200,body:{message:recoveryMessage}};
}
export async function resetPassword(db:Client,input:{email:string;code:string;newPassword:string}) {
 const retry=await authRateLimit(db,await recoveryHash('reset:'+input.email),'resetPassword');
 if(retry!==null)return {status:429,body:{error:'Too many attempts. Please try again later.'}};
 const passwordHash=await bcrypt.hash(input.newPassword,12);
 await db.query('BEGIN');
 try {
  // Lock user first (same order as password/account changes), then consume code.
  const users=(await db.query("SELECT id FROM users WHERE LOWER(email)=$1 AND LOWER(status)='active' FOR UPDATE",[input.email])).rows;
  const consumed=users.length===1?(await db.query('DELETE FROM auth_password_resets WHERE token_hash=$1 AND user_id=$2 AND expires_at>NOW() RETURNING user_id',[await recoveryHash(input.email+':'+input.code),users[0].id])).rows:[];
  if(consumed.length!==1){await db.query('ROLLBACK');return {status:400,body:{error:'Invalid or expired reset code. Request a new code.'}};}
  const id=users[0].id;
  await db.query('UPDATE users SET password_hash=$1,updated_at=NOW() WHERE id=$2',[passwordHash,id]);
  await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[id]);
  await db.query('DELETE FROM auth_password_resets WHERE user_id=$1',[id]);
  await db.query("INSERT INTO auth_password_audit(user_id,action) VALUES($1,'password_changed')",[id]);
  await db.query('COMMIT');return {status:200,body:{status:'password_reset',reauthenticationRequired:true}};
 } catch(error){await db.query('ROLLBACK');throw error;}
}
