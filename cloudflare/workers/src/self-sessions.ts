import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {authRateLimit} from './auth-rate-limit';

/** Personal session controls. No caller-supplied user identity is accepted. */
export async function selfSessions(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  if(path!=='/user/sessions')return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(!['GET','DELETE'].includes(request.method)){safe.set('allow','GET, DELETE');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,mutating=request.method==='DELETE';
  const keys=mutating?[]:['limit','offset'];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||
    !/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return json({error:'Invalid query or body'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;
  if(!token)return json({error:'No session'},401,safe);
  if(env.WORKSPACE_SOURCE_LIMIT&&!(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('self-sessions:'+(request.headers.get('cf-connecting-ip')??'unknown'))})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
  const hash=await sha256(token);
  return withDb(env,async db=>{
    const actorSql="SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active'";
    if(mutating){
      const actor=(await db.query(actorSql+' LIMIT 1',[hash])).rows[0];
      if(!actor)return json({error:'Invalid session'},401,safe);
      const retry=await authRateLimit(db,await sha256('manageAccount:'+String(actor.id)),'manageAccount');
      if(retry!==null){safe.set('retry-after',String(retry));return json({error:'Too many requests'},429,safe);}
    }
    await db.query(mutating?'BEGIN':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
    let committed=false;
    try {
      // Exclusive user lock serializes with login's shared user lock and other
      // account changes. Recheck the bearer after acquiring this lock.
      const actor=(await db.query(actorSql+(mutating?' FOR UPDATE OF u':' LIMIT 1'),[hash])).rows[0];
      if(!actor)return json({error:'Invalid session'},401,safe);
      if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
      if(mutating){
        if(!(await db.query('SELECT 1 FROM auth_sessions WHERE token_hash=$1 AND user_id=$2 AND expires_at>NOW()',[hash,actor.id])).rows.length)return json({error:'Invalid session'},401,safe);
        const count=Number((await db.query('WITH revoked AS (DELETE FROM auth_sessions WHERE user_id=$1 RETURNING 1) SELECT COUNT(*)::int AS count FROM revoked',[actor.id])).rows[0].count);
        await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$1,$2,$3,$4)',
          [actor.id,actor.tenant_id,JSON.stringify({sessionCount:count}),JSON.stringify({sessionCount:0,action:'sessions_revoked',initiatedBy:'self'})]);
        await db.query('COMMIT');committed=true;
        safe.set('set-cookie','session_token=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0');
        return json({revokedSessions:count,status:'signed_out_all_devices'},200,safe);
      }
      const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1 AND expires_at>NOW()',[actor.id])).rows[0].count);
      const rows=(await db.query('SELECT created_at,expires_at,(token_hash=$2) AS current FROM auth_sessions WHERE user_id=$1 AND expires_at>NOW() ORDER BY created_at DESC,expires_at DESC,token_hash LIMIT $3 OFFSET $4',[actor.id,hash,Number(limit),Number(offset)])).rows;
      return json({sessions:rows.map(s=>({created_at:s.created_at,expires_at:s.expires_at,current:s.current})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(offset)+Number(limit)<total}},200,safe);
    }finally{if(!committed)await db.query('ROLLBACK');}
  });
}
