import {accountUser} from './account-read-projection';
import type {Client} from 'pg';
import policy from './account-policy.json';
const exactCount=(value:unknown)=>{if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid account count');return value;};

/** Read authorized account fields only, with literal search and bounded paging. */
export async function listAccounts(db:Client,actor:{id:string;roles:string;tenant_id:string},url:URL):Promise<{status:number;body:unknown}> {
  if(actor.roles!=='ceo'||!actor.tenant_id)return {status:403,body:{error:'Forbidden'}};
  const params=url.searchParams,keys=['limit','offset','search','role','status'];
  if([...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1))return {status:400,body:{error:'Invalid query'}};
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0',search=params.get('search')??'',role=params.get('role')??'',status=params.get('status')??'';
  if(!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000||
    search.length>200||/[\u0000-\u001f]/.test(search)||role&&!policy.ceo.includes(role)||status&&!['active','inactive'].includes(status))
    return {status:400,body:{error:'Invalid query'}};
  // Placeholder parameters carry every user-controlled value. '%' and '_'
  // are escaped so searches cannot silently broaden to the whole tenant.
  const pattern='%'+search.replace(/[\\%_]/g,'\\$&')+'%';
  const filter="tenant_id::text=$1 AND ($2='' OR roles=$2) AND ($3='' OR LOWER(status)=$3) AND ($4='' OR email ILIKE $5 ESCAPE E'\\\\')";
  const values=[String(actor.tenant_id),role,status,search,pattern];
  const total=exactCount((await db.query('SELECT COUNT(*)::int AS count FROM users WHERE '+filter,values)).rows[0].count);
  const users=(await db.query('SELECT id,email,roles,status,updated_at FROM users WHERE '+filter+' ORDER BY LOWER(email),id LIMIT $6 OFFSET $7',
    [...values,Number(limit),Number(offset)])).rows;
  return {status:200,body:{users:users.map(u=>accountUser(u,actor.id)),
    assignableRoles:policy.ceo,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(offset)+Number(limit)<total}}};
}

export function validateAccountUpdate(value: unknown): {id:string;role:string;status:string} | null {
  if(!value || typeof value!=='object' || Array.isArray(value)) return null;
  const data=value as Record<string,unknown>;
  if(Object.keys(data).some(k=>!['id','role','status'].includes(k))) return null;
  if(typeof data.id!=='string' || !/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(data.id) ||
    typeof data.role!=='string' || !policy.ceo.includes(data.role) ||
    (data.status!=='active' && data.status!=='inactive')) return null;
  return {id:data.id,role:data.role,status:data.status};
}

/** Only the already-approved CEO authority is allowed to manage accounts. */
export async function manageAccount(db:Client, actor:{id:string;roles:string;tenant_id:string},
  input:{id:string;role:string;status:string}):Promise<{status:number;body:unknown}> {
  if(actor.roles!=='ceo' || !actor.tenant_id || input.id.toLowerCase()===actor.id.toLowerCase())
    return {status:403,body:{error:'Forbidden'}};
  const target=await db.query('SELECT id,roles,status FROM users WHERE id=$1 AND tenant_id=$2 FOR UPDATE',[input.id,actor.tenant_id]);
  if(!target.rows.length) return {status:404,body:{error:'Account not found'}};
  if(String(target.rows[0].id).toLowerCase()===actor.id.toLowerCase())
    return {status:403,body:{error:'Forbidden'}};
  const result=await db.query('UPDATE users SET roles=$1,status=$2,updated_at=NOW() WHERE id=$3 AND tenant_id=$4 RETURNING id,email,roles,status,tenant_id',
    [input.role,input.status,input.id,actor.tenant_id]);
  await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[input.id]);
  await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)',
    [actor.id,input.id,actor.tenant_id,JSON.stringify({role:target.rows[0].roles,status:target.rows[0].status}),JSON.stringify({role:input.role,status:input.status})]);
  return {status:200,body:{user:result.rows[0]}};
}
