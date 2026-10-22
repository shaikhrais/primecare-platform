import bcrypt from 'bcryptjs';
import policy from '../../../../packages/shared/src/auth-elevation.json' with {type:'json'};
import {digest} from './mfa.mjs';
import {lockedUser,sessionLookup,sessionCurrent,proofRate,freshFactor,failedProof} from './mfa-lifecycle.mjs';
const denied=(status=401)=>({status,body:{error:'Privileged access denied'}});
const invalid=()=>({status:400,body:{error:'Invalid privileged access request'}});
const id=value=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(value);
const text=(value,min,max)=>typeof value==='string'&&value===value.trim()&&[...value].length>=min&&[...value].length<=max&&!/[\u0000-\u001f\u007f]/.test(value);
const password=value=>typeof value==='string'&&value.length>0&&new TextEncoder().encode(value).length<=72;
const exact=(body,keys)=>body&&typeof body==='object'&&!Array.isArray(body)&&Object.keys(body).sort().join(',')===[...keys].sort().join(',');
const scope=value=>Array.isArray(value)&&value.length===1&&value[0]===policy.action;
const seconds=value=>Number.isInteger(value)&&value>=1&&value<=policy.maximumSeconds;
const one=result=>{if(!Array.isArray(result.rows)||result.rows.length!==1)throw Error('Privileged persistence failed');return result.rows[0];};
const stamp=value=>{if(!(value instanceof Date)||!Number.isFinite(value.getTime()))throw Error('Invalid privileged expiry');return value.toISOString();};
function valid(body,operation){
 switch(operation){
  case 'elevate':return exact(body,['password','code','reason','scope','seconds'])&&password(body.password)&&typeof body.code==='string'&&/^[0-9]{6}$/.test(body.code)&&text(body.reason,10,500)&&scope(body.scope)&&seconds(body.seconds);
  case 'revokeElevation':return exact(body,['elevationId'])&&id(body.elevationId);
  case 'requestSupport':return exact(body,['elevationId','tenantId','ticket','reason','scope','seconds'])&&id(body.elevationId)&&id(body.tenantId)&&text(body.ticket,1,100)&&text(body.reason,10,500)&&scope(body.scope)&&seconds(body.seconds);
  case 'listSupport':return exact(body,[]);
  case 'approveSupport':case 'revokeSupport':return exact(body,['requestId','password'])&&id(body.requestId)&&password(body.password);
  case 'summary':return exact(body,['requestId'])&&id(body.requestId);
  default:return false;
 }
}
async function audit(db,actor,action,{elevationId=null,requestId=null,targetTenantId=null}={}){
 const value=crypto.randomUUID();
 if(one(await db.query('INSERT INTO auth_privileged_access_audit(id,actor_user_id,actor_tenant_id,target_tenant_id,elevation_id,support_request_id,action) VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING id',[value,actor.id,actor.tenant_id,targetTenantId,elevationId,requestId,action])).id!==value)throw Error('Privileged audit failed');
}
async function readRate(db,userId){
 const result=one(await db.query(`INSERT INTO auth_rate_limits(subject_hash,attempts,reset_at) VALUES($1,1,NOW()+INTERVAL '1 minute')
  ON CONFLICT(subject_hash) DO UPDATE SET attempts=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN 1 ELSE LEAST(auth_rate_limits.attempts+1,61) END,
  reset_at=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN NOW()+INTERVAL '1 minute' ELSE auth_rate_limits.reset_at END RETURNING attempts`,[await digest('privileged-read:'+userId)]));
 if(!Number.isInteger(result.attempts)||result.attempts<1||result.attempts>61)throw Error('Invalid privileged rate result');return result.attempts<=60;
}
async function elevation(db,elevationId){
 const rows=(await db.query(`SELECT e.*,e.expires_at>NOW() AND e.revoked_at IS NULL AND EXISTS
  (SELECT 1 FROM users u JOIN auth_sessions s ON s.user_id::text=u.id::text JOIN tenants t ON t.id::text=u.tenant_id::text
   WHERE t.status='active' AND u.id::text=e.user_id AND u.tenant_id::text=e.tenant_id AND u.status='active' AND u.roles='code_admin'
   AND s.token_hash=e.session_hash AND s.expires_at>NOW()) AS live
  FROM auth_privilege_elevations e WHERE e.id=$1 FOR UPDATE OF e`,[elevationId])).rows;
 if(rows.length>1)throw Error('Ambiguous elevation');return rows[0]??null;
}
const owns=(e,actor,sessionHash)=>e&&e.user_id===actor.id&&e.tenant_id===actor.tenant_id&&e.session_hash===sessionHash&&scope(e.scopes);
async function support(db,requestId){
 const lookup=(await db.query('SELECT elevation_id FROM auth_tenant_support_requests WHERE id=$1',[requestId])).rows;
 if(lookup.length!==1)return null;
 const elevated=await elevation(db,lookup[0].elevation_id);
 const rows=(await db.query('SELECT *,expires_at>NOW() AS fresh FROM auth_tenant_support_requests WHERE id=$1 FOR UPDATE',[requestId])).rows;
 if(rows.length!==1||!elevated||rows[0].elevation_id!==elevated.id)return null;
 const request=rows[0];
 if(request.requester_user_id!==elevated.user_id||request.requester_tenant_id!==elevated.tenant_id||request.requester_session_hash!==elevated.session_hash||!scope(request.scopes))throw Error('Inconsistent support binding');
 return {request,elevated};
}
function project(request){
 if(!id(request.id)||!id(request.requester_user_id)||!id(request.target_tenant_id)||!text(request.ticket,1,100)||!text(request.reason,10,500)||!scope(request.scopes)||!['pending','approved','revoked'].includes(request.state))throw Error('Invalid support projection');
 return {requestId:request.id,requesterId:request.requester_user_id,tenantId:request.target_tenant_id,ticket:request.ticket,reason:request.reason,scope:request.scopes,expiresAt:stamp(request.expires_at),state:request.state};
}
async function targetActive(db,tenantId){return (await db.query("SELECT id::text AS id FROM tenants WHERE id::text=$1 AND status='active'",[tenantId])).rows.length===1;}

/** All capability authority is derived from the current verified database session.
 * IDs are references, never bearer credentials. There is no clinical handler.
 */
export async function privilegedAccess(db,env,sessionToken,body,operation,tenantHint=null){
 if(!valid(body,operation))return invalid();
 const userId=await sessionLookup(db,sessionToken);if(!userId)return denied();
 const proving=['elevate','approveSupport','revokeSupport'].includes(operation);
 if(!(proving?await proofRate(db,userId):await readRate(db,userId)))return denied(429);
 await db.query('BEGIN');
 try{
  const actor=await lockedUser(db,userId);
  if(!actor||actor.status!=='active'||!await sessionCurrent(db,sessionToken,actor)){await db.query('ROLLBACK');return denied();}
  if(!await targetActive(db,actor.tenant_id)){await db.query('ROLLBACK');return denied(403);}
  if(tenantHint!==null&&tenantHint!==actor.tenant_id){await db.query('ROLLBACK');return denied(403);}
  const allowed=operation==='listSupport'||operation==='approveSupport'?actor.roles==='tenant_admin':operation==='revokeSupport'?['code_admin','tenant_admin'].includes(actor.roles):actor.roles==='code_admin';
  if(!allowed){await db.query('ROLLBACK');return denied(403);}
  const sessionHash=await digest(sessionToken);
  let response;
  if(operation==='elevate'){
   if(!await freshFactor(db,env,actor,body.password,body.code)){
    await failedProof(db,actor);await audit(db,actor,'proof_failed');await db.query('COMMIT');return denied();
   }
   const elevationId=crypto.randomUUID();
   const stored=one(await db.query("INSERT INTO auth_privilege_elevations(id,user_id,tenant_id,session_hash,reason,scopes,expires_at) VALUES($1,$2,$3,$4,$5,$6::jsonb,NOW()+$7*INTERVAL '1 second') RETURNING id,expires_at",[elevationId,actor.id,actor.tenant_id,sessionHash,body.reason,JSON.stringify(body.scope),body.seconds]));
   if(stored.id!==elevationId)throw Error('Elevation mismatch');await audit(db,actor,'elevation_issued',{elevationId});
   response={status:'elevated',elevationId,expiresAt:stamp(stored.expires_at),scope:body.scope};
  }else if(operation==='revokeElevation'){
   const elevated=await elevation(db,body.elevationId);
   if(!owns(elevated,actor,sessionHash)){await db.query('ROLLBACK');return denied(403);}
   if(elevated.revoked_at===null){one(await db.query('UPDATE auth_privilege_elevations SET revoked_at=NOW() WHERE id=$1 AND revoked_at IS NULL RETURNING id',[elevated.id]));await audit(db,actor,'elevation_revoked',{elevationId:elevated.id});}
   response={status:'revoked'};
  }else if(operation==='requestSupport'){
   const elevated=await elevation(db,body.elevationId);
   if(!owns(elevated,actor,sessionHash)||elevated.live!==true||!await targetActive(db,body.tenantId)){await db.query('ROLLBACK');return denied(403);}
   const requestId=crypto.randomUUID();
   const request=one(await db.query("INSERT INTO auth_tenant_support_requests(id,elevation_id,requester_user_id,requester_tenant_id,requester_session_hash,target_tenant_id,ticket,reason,scopes,expires_at) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9::jsonb,LEAST($10,NOW()+$11*INTERVAL '1 second')) RETURNING *",[requestId,elevated.id,actor.id,actor.tenant_id,sessionHash,body.tenantId,body.ticket,body.reason,JSON.stringify(body.scope),elevated.expires_at,body.seconds]));
   if(request.id!==requestId)throw Error('Support request mismatch');await audit(db,actor,'support_requested',{elevationId:elevated.id,requestId,targetTenantId:body.tenantId});response=project(request);
  }else if(operation==='listSupport'){
   const rows=(await db.query(`SELECT r.* FROM auth_tenant_support_requests r JOIN auth_privilege_elevations e ON e.id=r.elevation_id
    WHERE r.target_tenant_id=$1 AND r.state IN ('pending','approved') AND r.expires_at>NOW() AND e.expires_at>NOW() AND e.revoked_at IS NULL
    ORDER BY r.created_at DESC,r.id LIMIT 50`,[actor.tenant_id])).rows;
   if(rows.length>50)throw Error('Unbounded support result');response={requests:rows.map(project)};
  }else{
   const record=await support(db,body.requestId);
   if(!record){await db.query('ROLLBACK');return denied(403);}
   const {request,elevated}=record;
   const owner=owns(elevated,actor,sessionHash)&&request.requester_user_id===actor.id;
   const approver=actor.roles==='tenant_admin'&&actor.tenant_id===request.target_tenant_id&&actor.id!==request.requester_user_id;
   if(operation==='summary'){
    const approval=(await db.query("SELECT id::text AS id FROM users WHERE id::text=$1 AND tenant_id::text=$2 AND roles='tenant_admin' AND status='active'",[request.approved_by,request.target_tenant_id])).rows;
    if(!owner||elevated.live!==true||request.fresh!==true||request.state!=='approved'||approval.length!==1||!await targetActive(db,request.target_tenant_id)){await db.query('ROLLBACK');return denied(403);}
    const counts=one(await db.query(`SELECT
     (SELECT COUNT(*)::int FROM users WHERE tenant_id::text=$1 AND status='active') AS accounts,
     (SELECT COUNT(*)::int FROM auth_sessions s JOIN users u ON u.id::text=s.user_id::text WHERE u.tenant_id::text=$1 AND u.status='active' AND s.expires_at>NOW()) AS sessions,
     (SELECT COUNT(*)::int FROM auth_mfa_credentials c JOIN users u ON u.id::text=c.user_id WHERE u.tenant_id::text=$1 AND c.tenant_id=$1 AND u.status='active' AND c.enabled=true) AS factors`,[request.target_tenant_id]));
    if(!Object.values(counts).every(value=>Number.isInteger(value)&&value>=0))throw Error('Invalid support counts');
    await audit(db,actor,'security_summary_read',{elevationId:elevated.id,requestId:request.id,targetTenantId:request.target_tenant_id});
    response={tenantId:request.target_tenant_id,activeAccounts:counts.accounts,activeSessions:counts.sessions,enrolledAuthenticators:counts.factors};
   }else{
    if(operation==='approveSupport'?!approver:!approver&&!owner){await db.query('ROLLBACK');return denied(403);}
    if(!await bcrypt.compare(body.password,actor.password_hash)){await audit(db,actor,'proof_failed');await db.query('COMMIT');return denied();}
    if(operation==='approveSupport'){
     if(elevated.live!==true||request.fresh!==true||request.state==='revoked'||!await targetActive(db,request.target_tenant_id)){await db.query('ROLLBACK');return denied(403);}
     if(request.state==='pending'){
      one(await db.query("UPDATE auth_tenant_support_requests SET state='approved',approved_by=$2,approved_at=NOW() WHERE id=$1 AND state='pending' RETURNING id",[request.id,actor.id]));
      await audit(db,actor,'support_approved',{elevationId:elevated.id,requestId:request.id,targetTenantId:request.target_tenant_id});
     }
     response={status:'approved',requestId:request.id,expiresAt:stamp(request.expires_at)};
    }else{
     if(request.state!=='revoked'){
      one(await db.query("UPDATE auth_tenant_support_requests SET state='revoked',revoked_by=$2,revoked_at=NOW() WHERE id=$1 AND state<>'revoked' RETURNING id",[request.id,actor.id]));
      await audit(db,actor,'support_revoked',{elevationId:elevated.id,requestId:request.id,targetTenantId:request.target_tenant_id});
     }
     response={status:'revoked'};
    }
   }
  }
  await db.query('COMMIT');return {status:200,body:response};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
