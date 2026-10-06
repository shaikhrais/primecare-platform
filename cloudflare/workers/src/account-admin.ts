import type {Client} from 'pg';
import policy from './account-policy.json';
const exactCount=(value:unknown)=>{if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid account count');return value;};
type Actor={id:string;roles:string;tenant_id:string};
type Operation='sessions_read'|'sessions_revoke'|'audit_read'|'account_read'|'creation_audit_read';
export type AdminInput={operation:Operation;userId:string;limit:number;offset:number;includeExpired:boolean};
type Parsed={input:AdminInput}|{status:number;error:string;allow?:string}|null;
const identifier=(id:string)=>/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(id);

/** Exact route/method/query validation; no body or tenant override is accepted. */
export function parseAccountAdminRequest(request:Request,path:string):Parsed {
  const sessions=/^\/admin\/users\/([^/]+)\/sessions$/.exec(path),audit=path==='/admin/users/audit',creationAudit=path==='/admin/users/creation-audit';
  const detail=!audit&&!creationAudit&&!sessions?/^\/admin\/users\/([^/]+)$/.exec(path):null;
  if(!sessions&&!audit&&!creationAudit&&!detail)return null;
  const readOnly=audit||creationAudit||!!detail;
  const allow=readOnly?'GET':'GET, DELETE';
  if(!(readOnly?request.method==='GET':['GET','DELETE'].includes(request.method)))return {status:405,error:'Method not allowed',allow};
  const operation:Operation=audit?'audit_read':creationAudit?'creation_audit_read':detail?'account_read':request.method==='DELETE'?'sessions_revoke':'sessions_read';
  const params=new URL(request.url).searchParams;
  const keys=operation==='sessions_revoke'||detail?[]:audit||creationAudit?['limit','offset','userId']:['limit','offset','includeExpired'];
  if([...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||request.body!==null)return {status:400,error:'Invalid query or body'};
  const userId=sessions?.[1]??detail?.[1]??params.get('userId')??'';
  if((sessions||detail||params.has('userId'))&&!identifier(userId))return {status:400,error:'Invalid user identifier'};
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0',expired=params.get('includeExpired')??'false';
  if(!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000||!['true','false'].includes(expired))return {status:400,error:'Invalid query'};
  return {input:{operation,userId,limit:Number(limit),offset:Number(offset),includeExpired:expired==='true'}};
}
const pagination=(input:AdminInput,total:number)=>({limit:input.limit,offset:input.offset,total,hasMore:input.offset+input.limit<total});
const safeState=(raw:unknown)=>{
  const state=(raw&&typeof raw==='object'?raw:{}) as Record<string,unknown>;
  return {role:typeof state.role==='string'&&policy.ceo.includes(state.role)?state.role:null,
    status:state.status==='active'||state.status==='inactive'?state.status:null,
    sessionCount:typeof state.sessionCount==='number'&&Number.isSafeInteger(state.sessionCount)&&state.sessionCount>=0?state.sessionCount:null};
};

/** Runs inside the caller's transaction. Revocation locks the target user,
 * deletes sessions and appends audit together; any failed audit must roll back. */
export async function accountAdministration(db:Client,actor:Actor,input:AdminInput):Promise<{status:number;body:unknown}> {
  if(actor.roles!=='ceo'||!actor.tenant_id)return {status:403,body:{error:'Forbidden'}};
  if(input.operation==='account_read') {
    const user=(await db.query('SELECT id,email,roles,status,updated_at FROM users WHERE id::text=$1 AND tenant_id::text=$2',[input.userId,String(actor.tenant_id)])).rows[0];
    if(!user)return {status:404,body:{error:'Account not found'}};
    // Explicit projection also protects against unexpected fields from adapters.
    return {status:200,body:{user:{id:String(user.id),email:user.email,roles:user.roles,status:user.status,updated_at:user.updated_at,
      canModify:String(user.id).toLowerCase()!==String(actor.id).toLowerCase()},assignableRoles:policy.ceo}};
  }
  if(input.operation==='creation_audit_read') {
    const values=[String(actor.tenant_id),input.userId];
    const filter="tenant_id::text=$1 AND action='account_created' AND ($2='' OR target_user_id::text=$2)";
    const total=exactCount((await db.query('SELECT COUNT(*)::int AS count FROM auth_account_audit WHERE '+filter,values)).rows[0].count);
    const events=(await db.query(`SELECT id,actor_user_id::text AS "actorUserId",target_user_id::text AS "targetUserId",created_at
      FROM auth_account_audit WHERE ${filter} ORDER BY created_at DESC,id DESC LIMIT $3 OFFSET $4`,[...values,input.limit,input.offset])).rows;
    return {status:200,body:{events:events.map(e=>({id:String(e.id),actorUserId:String(e.actorUserId),targetUserId:String(e.targetUserId),created_at:e.created_at,action:'account_created'})),pagination:pagination(input,total)}};
  }
  if(input.operation==='audit_read') {
    const values=[String(actor.tenant_id),input.userId];
    const filter="tenant_id::text=$1 AND ($2='' OR target_user_id::text=$2)";
    const total=exactCount((await db.query('SELECT COUNT(*)::int AS count FROM auth_management_audit WHERE '+filter,values)).rows[0].count);
    const rows=(await db.query(`SELECT id,actor_user_id::text AS "actorUserId",target_user_id::text AS "targetUserId",created_at,
      CASE WHEN new_state->>'action'='sessions_revoked' THEN 'sessions_revoked' ELSE 'account_updated' END AS action,
      jsonb_build_object('role',previous_state->'role','status',previous_state->'status','sessionCount',previous_state->'sessionCount') AS previous,
      jsonb_build_object('role',new_state->'role','status',new_state->'status','sessionCount',new_state->'sessionCount') AS current
      FROM auth_management_audit WHERE ${filter} ORDER BY created_at DESC,id DESC LIMIT $3 OFFSET $4`,[...values,input.limit,input.offset])).rows;
    return {status:200,body:{events:rows.map(r=>({id:String(r.id),actorUserId:String(r.actorUserId),targetUserId:String(r.targetUserId),
      created_at:r.created_at,action:r.action,previous:safeState(r.previous),current:safeState(r.current)})),pagination:pagination(input,total)}};
  }
  if(input.operation==='sessions_revoke'&&input.userId.toLowerCase()===String(actor.id).toLowerCase())return {status:403,body:{error:'Self revocation is not allowed'}};
  const target=(await db.query('SELECT id FROM users WHERE id::text=$1 AND tenant_id::text=$2'+(input.operation==='sessions_revoke'?' FOR UPDATE':''),[input.userId,String(actor.tenant_id)])).rows[0];
  if(!target)return {status:404,body:{error:'Account not found'}};
  if(input.operation==='sessions_revoke') {
    if(String(target.id).toLowerCase()===String(actor.id).toLowerCase())return {status:403,body:{error:'Self revocation is not allowed'}};
    const deleted=exactCount((await db.query('WITH revoked AS (DELETE FROM auth_sessions WHERE user_id=$1 RETURNING 1) SELECT COUNT(*)::int AS count FROM revoked',[target.id])).rows[0].count);
    await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)',
      [actor.id,target.id,actor.tenant_id,JSON.stringify({sessionCount:deleted}),JSON.stringify({sessionCount:0,action:'sessions_revoked'})]);
    return {status:200,body:{userId:String(target.id),revokedSessions:deleted}};
  }
  const filter='user_id=$1'+(input.includeExpired?'':' AND expires_at>NOW()');
  const total=exactCount((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE '+filter,[target.id])).rows[0].count);
  const sessions=(await db.query('SELECT created_at,expires_at FROM auth_sessions WHERE '+filter+' ORDER BY created_at DESC,expires_at DESC,token_hash LIMIT $2 OFFSET $3',[target.id,input.limit,input.offset])).rows;
  return {status:200,body:{userId:String(target.id),sessions:sessions.map(s=>({created_at:s.created_at,expires_at:s.expires_at})),pagination:pagination(input,total)}};
}
