import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {privilegedActor} from '../auth-projection';
import {GrowthFailure,fail,canonical,type Actor} from '../../../../packages/shared/src/growth/contract';
import {businessRoles,globalManager} from '../../../../packages/shared/src/business-plans/policy.mjs';
import {BusinessPlanRepository} from './repository';
export async function businessPlans(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||path!=='/growth/cycles')return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  if(!['GET','POST'].includes(request.method))fail(405,'method_not_allowed');const token=tokenFrom(request);if(!token)fail(401,'unauthorized');if(request.headers.has('x-tenant-id'))fail(400);
  const url=new URL(request.url);if([...url.searchParams.keys()].some(k=>!['tenant','id'].includes(k)))fail(400);const mutation=request.method==='POST';let body:any={};if(mutation){if(!request.headers.get('content-type')?.startsWith('application/json'))fail(415);try{body=await parseBody(request);}catch(e){return bodyFailure(e,'Invalid business-plan request',safe);}}
  const key=request.headers.get('idempotency-key');if(mutation&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   await db.query('BEGIN');try{
    const a=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id LEFT JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND (u.tenant_id IS NULL OR LOWER(t.status)='active') FOR SHARE OF u,s",[await sha256(token!)])).rows);if(!a)fail(401,'unauthorized');if(!businessRoles.includes(a!.roles))fail(403,'forbidden');const actor=a as Actor,scope=url.searchParams.get('tenant')||actor.tenant_id||(globalManager(actor)&&!mutation?(await db.query("SELECT id::text FROM tenants WHERE LOWER(status)='active' ORDER BY name LIMIT 1")).rows[0]?.id:null);if(!scope)fail(400,'Select an organization first.');if(scope!==actor.tenant_id&&!globalManager(actor))fail(403,'forbidden');if(!(await db.query("SELECT id FROM tenants WHERE id::text=$1 AND LOWER(status)='active'",[scope])).rows.length)fail(404,'not_found');
    const repo=new BusinessPlanRepository(db,actor,scope);
    if(!mutation){const result=await repo.list(url.searchParams.get('id')||undefined);await db.query('COMMIT');return json(result,200,safe);}
    const fingerprint=await sha256(canonical({body,scope}));await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[actor.id+':business-plan:'+key]);
    const old=(await db.query('SELECT fingerprint,response FROM business_plan_requests WHERE actor_id=$1 AND key=$2',[actor.id,key])).rows[0];if(old){if(old.fingerprint!==fingerprint)fail(409,'conflict');await db.query('COMMIT');return json(old.response,200,safe);}
    const rate=(await db.query("SELECT COUNT(*)::int AS n FROM business_plan_requests WHERE actor_id=$1 AND created_at>NOW()-INTERVAL '1 minute'",[actor.id])).rows[0];if(rate.n>=60)fail(429,'rate_limited');
    const result=await repo.execute(body);await db.query('INSERT INTO business_plan_requests(actor_id,key,fingerprint,response) VALUES($1,$2,$3,$4)',[actor.id,key,fingerprint,JSON.stringify(result)]);await db.query('COMMIT');return json(result,200,safe);
   }catch(e){await db.query('ROLLBACK');throw e;}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);const code=(error as {code?:string}).code;if(code==='23505')return json({error:'conflict'},409,safe);if(code)return json({error:'Business planning service unavailable. No success is assumed; refresh to confirm.'},503,safe);if(error instanceof Error)return json({error:error.message},error.message==='forbidden'?403:error.message==='not_found'?404:400,safe);return json({error:'unavailable'},503,safe);}
}
