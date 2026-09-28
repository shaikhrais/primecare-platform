import type {Client} from 'pg';
import policy from './account-policy.json';

export function validateAccountUpdate(value: unknown): {id:string;role:string;status:string} | null {
  if(!value || typeof value!=='object' || Array.isArray(value)) return null;
  const data=value as Record<string,unknown>;
  if(Object.keys(data).some(k=>!['id','role','status'].includes(k))) return null;
  if(typeof data.id!=='string' || !/^[a-f0-9-]{36}$/i.test(data.id) ||
    typeof data.role!=='string' || !policy.ceo.includes(data.role) ||
    (data.status!=='active' && data.status!=='inactive')) return null;
  return {id:data.id,role:data.role,status:data.status};
}

/** Only the already-approved CEO authority is allowed to manage accounts. */
export async function manageAccount(db:Client, actor:{id:string;roles:string;tenant_id:string},
  input:{id:string;role:string;status:string}):Promise<{status:number;body:unknown}> {
  if(actor.roles!=='ceo' || !actor.tenant_id || input.id===actor.id)
    return {status:403,body:{error:'Forbidden'}};
  const target=await db.query('SELECT id,roles,status FROM users WHERE id=$1 AND tenant_id=$2 FOR UPDATE',[input.id,actor.tenant_id]);
  if(!target.rows.length) return {status:404,body:{error:'Account not found'}};
  const result=await db.query('UPDATE users SET roles=$1,status=$2 WHERE id=$3 AND tenant_id=$4 RETURNING id,email,roles,status,tenant_id',
    [input.role,input.status,input.id,actor.tenant_id]);
  await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[input.id]);
  await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)',
    [actor.id,input.id,actor.tenant_id,JSON.stringify({role:target.rows[0].roles,status:target.rows[0].status}),JSON.stringify({role:input.role,status:input.status})]);
  return {status:200,body:{user:result.rows[0]}};
}
