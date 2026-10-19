import {growthReports} from './reports';
import {publicEnquiry} from './enquiries';
import {canManageIntake} from '../../../../packages/shared/src/growth/intake';
import {leadFilters} from '../../../../packages/shared/src/growth/contacts';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {privilegedActor} from '../auth-projection';
import {requiredRow,optionalRow} from '../database-results';
import {GrowthFailure,GrowthPolicy,fail,uuid,canonical,type Actor} from '../../../../packages/shared/src/growth/contract';
import {GrowthRepository} from './repository';
import {GrowthCommands} from './commands';
export async function growth(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!(path==='/growth'||path.startsWith('/growth/')))return null;
 const reportsResponse=await growthReports(request,env,path,headers);if(reportsResponse)return reportsResponse;
 const publicResponse=await publicEnquiry(request,env,path,headers);if(publicResponse)return publicResponse;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const token=tokenFrom(request);if(!token)fail(401,'unauthorized');
  const url=new URL(request.url),match=/^\/growth(?:\/(plan|leads|campaigns|tasks|team|calls|appointments|contacts|duplicates|briefs|reviews|task-actions|intake-links|onboarding|handoffs|finance|capacity)(?:\/([0-9a-f-]+))?)?$/.exec(path);
  if(!match)fail(404,'not_found');const entity=match![1],id=match![2];if(id&&!uuid(id))fail(400);
  const method=request.method,read=method==='GET'&&!entity;
  if(!(read||method==='PUT'&&(entity==='plan'&&!id||['team','briefs','capacity'].includes(entity)&&!!id)||method==='POST'&&['reviews','task-actions'].includes(entity)&&!!id||method==='POST'&&['leads','campaigns','tasks','calls','appointments','duplicates','intake-links','onboarding','handoffs','finance'].includes(entity)&&!id||method==='PATCH'&&['leads','campaigns','tasks','appointments','contacts','intake-links','onboarding'].includes(entity)&&!!id))fail(405,'method_not_allowed');
  if(request.headers.has('x-tenant-id')||!read&&url.searchParams.size>0)fail(400);
  const filters=read?leadFilters(url.searchParams):{};
  const offsetText=url.searchParams.get('offset')??'0';if(!/^\d{1,7}$/.test(offsetText))fail(400);const offset=Number(offsetText);
  let body:Record<string,unknown>={};if(!read){try{body=await parseBody(request);}catch(error){return bodyFailure(error,'invalid_request',safe);}}else if(request.body)fail(400);
  const key=request.headers.get('idempotency-key');if(!read&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active'"+(lock?' FOR SHARE OF u,s,t':' LIMIT 1'),[await sha256(token!)])).rows);
   const authority=(a:ReturnType<typeof privilegedActor>)=>{if(!a)fail(401,'unauthorized');GrowthPolicy.read(a as Actor);return a as Actor;};
   let actor=authority(await session());
   if(!read){const rate=requiredRow((await db.query("INSERT INTO growth_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN growth_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE growth_rate.attempts+1 END,window_start=CASE WHEN growth_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE growth_rate.window_start END RETURNING attempts",[actor.id])).rows).attempts;if(typeof rate!=='number'||rate<1||!Number.isSafeInteger(rate))throw Error('Invalid rate');if(rate>90){safe.set('retry-after','60');fail(429,'rate_limited');}}
   await db.query(read?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');let committed=false;
   try{
    actor=authority(await session(!read));const repo=new GrowthRepository(db,actor);
    if(read)return json(await repo.dashboard(offset,filters),200,safe);
    GrowthPolicy.command(actor,method,entity);
    if(entity==='intake-links'&&!canManageIntake(actor))fail(403,'forbidden');
    GrowthPolicy.privilegedOperation(actor,method,entity,body);
    const fingerprint=await sha256(canonical({path,method,body,tenant:actor.tenant_id}));
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[actor.id+':'+key]);
    const previous=optionalRow((await db.query('SELECT request_hash,response,status FROM growth_requests WHERE actor_id=$1 AND idempotency_key=$2',[actor.id,key])).rows);
    if(previous){if(previous.request_hash!==fingerprint)fail(409,'conflict');if(![200,201].includes(previous.status as number)||!previous.response||typeof previous.response!=='object'||Array.isArray(previous.response))throw Error('Invalid replay');return json(previous.response,previous.status as number,safe);}
    const result=await new GrowthCommands(repo).execute(entity,id,method,body),status=method==='POST'?201:200;
    await db.query('INSERT INTO growth_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,$5)',[actor.id,key,fingerprint,JSON.stringify(result),status]);
    await db.query('COMMIT');committed=true;return json(result,status,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);if((error as {code?:string}).code==='23505')return json({error:'conflict'},409,safe);return json({error:'unavailable'},503,safe);}
}
