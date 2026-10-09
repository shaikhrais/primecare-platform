import {confirmedAudit} from './audit-confirmation';
import type {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {accountId} from './account-read-projection';

export function confirmedPasswordUpdate(rows:Record<string,unknown>[],id:string,hash:string) {
 if(rows.length!==1 || accountId(rows[0].id)!==id || rows[0].password_hash!==hash)throw Error('Invalid password update');
}

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
 const id=accountId(user.id),hash=await bcrypt.hash(input.newPassword,12);
 confirmedPasswordUpdate((await db.query('UPDATE users SET password_hash=$1,updated_at=NOW() WHERE id=$2 RETURNING id,password_hash',[hash,id])).rows,id,hash);
 await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[user.id]);
 confirmedAudit((await db.query("INSERT INTO auth_password_audit(user_id,action) VALUES($1,'password_changed') RETURNING id,user_id,action,created_at",[id])).rows,{user_id:id,action:'password_changed'});
 await db.query('DELETE FROM auth_password_resets WHERE user_id=$1',[user.id]);
 return {status:200,body:{status:'password_changed',reauthenticationRequired:true}};
}
