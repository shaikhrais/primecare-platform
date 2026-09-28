import type {Client} from 'pg';
import bcrypt from 'bcryptjs';

export function validatePasswordChange(value:unknown):{currentPassword:string;newPassword:string}|null {
 if(!value || typeof value!=='object' || Array.isArray(value))return null;
 const data=value as Record<string,unknown>;
 if(Object.keys(data).some(k=>!['currentPassword','newPassword'].includes(k)) ||
   typeof data.currentPassword!=='string' || !data.currentPassword ||
   new TextEncoder().encode(data.currentPassword).length>72 ||
   typeof data.newPassword!=='string' || data.newPassword.length<12 ||
   new TextEncoder().encode(data.newPassword).length>72 || data.currentPassword===data.newPassword)return null;
 return {currentPassword:data.currentPassword,newPassword:data.newPassword};
}

/** Caller owns transaction and has locked the active user/session records. */
export async function changePassword(db:Client,user:{id:string;password_hash:string},input:{currentPassword:string;newPassword:string}) {
 if(typeof user.password_hash!=='string' || !await bcrypt.compare(input.currentPassword,user.password_hash))
   return {status:401,body:{error:'Invalid credentials'}};
 await db.query('UPDATE users SET password_hash=$1,updated_at=NOW() WHERE id=$2',[await bcrypt.hash(input.newPassword,12),user.id]);
 await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[user.id]);
 await db.query("INSERT INTO auth_password_audit(user_id,action) VALUES($1,'password_changed')",[user.id]);
 return {status:200,body:{status:'password_changed',reauthenticationRequired:true}};
}
