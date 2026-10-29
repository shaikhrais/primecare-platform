import {pswPersonal} from '../psw-personal/service';
import {pswWorkspace} from '../psw-workspace/service';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {privilegedActor} from '../auth-projection';
import {requiredRow,optionalRow} from '../database-results';
import {careRole,clearanceBody,caseBody,actionBody,staffingBody,identifier,registry,GrowthFailure,fail,uuid,canonical,type Actor} from '../../../../packages/shared/src/care/contract';
import {CareRepository} from './repository';
import {CareCommands,authorizeCareCommand} from './commands';
import {authorizeStaffing,staffingCommand} from './staffing';
import {scheduleBody,timeBody} from '../../../../packages/shared/src/care/scheduling';
import {scheduleCommand} from './schedules';
import {authorizeTime,timeCommand} from './time-records';
import {handoverBody,followupBody} from '../../../../packages/shared/src/care/workflows';
import {authorizeHandover,handoverCommand} from './handovers';
import {authorizeFollowup,followupCommand} from './followups';
import {operational} from '../../../../packages/shared/src/care/contract';

export async function careDelivery(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!(path==='/care'||path.startsWith('/care/')))return null;
 const personalResponse=await pswPersonal(request,env,path,headers);if(personalResponse)return personalResponse;
 const workspaceResponse=await pswWorkspace(request,env,path,headers);if(workspaceResponse)return workspaceResponse;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');safe.set('referrer-policy','no-referrer');
 try{
  const match=/^\/care(?:\/(clearances|cases|staffing|schedules|time-records|handovers|followups)(?:\/([0-9a-f-]+)\/actions)?)?$/.exec(path);if(!match)fail(404,'not_found');const kind=match[2]?'actions':match[1],id=match[2];if(id&&match[1]!=='cases')fail(404,'not_found');if(id&&!uuid(id))fail(400);
  const read=request.method==='GET'&&!kind;if(!(read||request.method==='POST'&&!!kind))fail(405,'method_not_allowed');
  if(request.headers.has('x-tenant-id'))fail(400);const params=new URL(request.url).searchParams;
  if(!read&&params.size||read&&([...params.keys()].some(k=>!['offset','case','view','staffingOffset','staff','seriesOffset','timeOffset','handoverOffset','followupOffset','followupView','followupOwner','workloadOffset','workloadQuery','rosterQuery','visitQuery','visitOffset','sourceQuery','sourceOffset'].includes(k)||params.getAll(k).length!==1)||request.body))fail(400);
  const staffingOffset=params.get('staffingOffset')??'0',staff=params.get('staff');if(!/^\d{1,7}$/.test(staffingOffset)||Number(staffingOffset)>registry.maxOffset||staff!==null&&!identifier(staff))fail(400);
  const seriesOffset=params.get('seriesOffset')??'0',timeOffset=params.get('timeOffset')??'0';if([seriesOffset,timeOffset].some(v=>!/^\d{1,7}$/.test(v)||Number(v)>registry.maxOffset))fail(400);
  const handoverOffset=params.get('handoverOffset')??'0',followupOffset=params.get('followupOffset')??'0',followupView=params.get('followupView')??'all';if([handoverOffset,followupOffset].some(v=>!/^\d{1,7}$/.test(v)||Number(v)>registry.maxOffset)||!registry.followupPolicy.filters.includes(followupView))fail(400);
  const followupOwner=params.get('followupOwner')??undefined,workloadOffset=params.get('workloadOffset')??'0',rawWorkloadQuery=params.get('workloadQuery')??'',workloadQuery=rawWorkloadQuery.trim();
  if(followupOwner!==undefined&&!identifier(followupOwner)||!/^\d{1,7}$/.test(workloadOffset)||Number(workloadOffset)>registry.maxOffset||rawWorkloadQuery.length>registry.workloadPolicy.queryMaxLength||/[\u0000-\u001f\u007f]/.test(rawWorkloadQuery))fail(400);
  const rawRosterQuery=params.get('rosterQuery')??'',rosterQuery=rawRosterQuery.trim();if(rawRosterQuery.length>100||/[\u0000-\u001f\u007f]/.test(rawRosterQuery))fail(400);
  const rawVisitQuery=params.get('visitQuery')??'',visitQuery=rawVisitQuery.trim(),visitOffset=params.get('visitOffset')??'0';if(rawVisitQuery.length>registry.visitPickerPolicy.queryMaxLength||/[\u0000-\u001f\u007f]/.test(rawVisitQuery)||!/^\d{1,7}$/.test(visitOffset)||Number(visitOffset)>registry.maxOffset)fail(400);
  const rawSourceQuery=params.get('sourceQuery')??'',sourceQuery=rawSourceQuery.trim(),sourceOffset=params.get('sourceOffset')??'0';if(rawSourceQuery.length>registry.scheduleSourcePolicy.queryMaxLength||/[\u0000-\u001f\u007f]/.test(rawSourceQuery)||!/^\d{1,7}$/.test(sourceOffset)||Number(sourceOffset)>registry.maxOffset)fail(400);
  const view=params.get('view')??'all';if(!registry.taskPolicy.filters.includes(view))fail(400);
  const offsetText=params.get('offset')??'0',selected=params.get('case');if(!/^\d{1,7}$/.test(offsetText)||Number(offsetText)>registry.maxOffset||selected&&!uuid(selected))fail(400);
  const token=tokenFrom(request);if(!token)fail(401,'unauthorized');
  let raw:Record<string,unknown>={};if(!read){try{raw=await parseBody(request);}catch(e){return bodyFailure(e,'invalid_request',safe);}}
  const key=request.headers.get('idempotency-key');if(!read&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active'"+(lock?' FOR SHARE OF u,s,t':' LIMIT 1'),[await sha256(token!)])).rows);
   const check=(a:ReturnType<typeof privilegedActor>)=>{if(!a)fail(401,'unauthorized');if(!careRole(a.roles)||!a.tenant_id)fail(403,'forbidden');return a as Actor;};let actor=check(await session());
   const rate=requiredRow((await db.query("INSERT INTO care_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN care_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE care_rate.attempts+1 END,window_start=CASE WHEN care_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE care_rate.window_start END RETURNING attempts",[actor.id])).rows).attempts;
   if(typeof rate!=='number')throw Error('Invalid rate');if(rate>120){safe.set('retry-after','60');fail(429,'rate_limited');}
   await db.query(read?'BEGIN ISOLATION LEVEL REPEATABLE READ':'BEGIN');let committed=false;
   try{
    actor=check(await session(true));const repo=new CareRepository(db,actor);
    if(read){const result=await repo.snapshot(Number(offsetText),selected??undefined,view,Number(staffingOffset),staff??undefined,Number(seriesOffset),Number(timeOffset),Number(handoverOffset),Number(followupOffset),followupView,followupOwner,Number(workloadOffset),workloadQuery,rosterQuery,Number(visitOffset),visitQuery,Number(sourceOffset),sourceQuery);await db.query('COMMIT');committed=true;return json(result,200,safe);}
    const v=kind==='handovers'?handoverBody(raw):kind==='followups'?followupBody(raw):kind==='schedules'?scheduleBody(raw):kind==='time-records'?timeBody(raw):kind==='staffing'?staffingBody(raw):kind==='clearances'?clearanceBody(raw):kind==='cases'?caseBody(raw):actionBody(raw);
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['care-request:'+actor.id+':'+key]);
    if(kind==='schedules'&&!operational(actor))fail(403,'forbidden');
    const context=kind==='handovers'?await authorizeHandover(repo,v):kind==='followups'?await authorizeFollowup(repo,v):kind==='schedules'?null:kind==='time-records'?await authorizeTime(repo,v):kind==='staffing'?await authorizeStaffing(repo,v):await authorizeCareCommand(repo,kind!,id,v);
    const hash=await sha256(canonical({path,body:raw,tenant:actor.tenant_id})),previous=optionalRow((await db.query('SELECT fingerprint,response,status FROM care_requests WHERE actor_id::text=$1 AND idempotency_key=$2',[actor.id,key])).rows);
    if(previous){if(previous.fingerprint!==hash)fail(409,'conflict');await db.query('COMMIT');committed=true;return json(previous.response,Number(previous.status),safe);}
    const commands=new CareCommands(repo),result=kind==='handovers'?await handoverCommand(repo,context,v):kind==='followups'?await followupCommand(repo,context,v):kind==='schedules'?await scheduleCommand(repo,v):kind==='time-records'?await timeCommand(repo,context,v):kind==='staffing'?await staffingCommand(repo,v,context):kind==='clearances'?await commands.verify(v):kind==='cases'?await commands.create(v):await commands.action(context,v),status=kind==='cases'?201:200;
    await db.query('INSERT INTO care_requests(actor_id,idempotency_key,fingerprint,response,status) VALUES($1,$2,$3,$4,$5)',[actor.id,key,hash,JSON.stringify(result),status]);
    await db.query('COMMIT');committed=true;return json(result,status,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(e){return json({error:e instanceof GrowthFailure?e.code:'unavailable'},e instanceof GrowthFailure?e.status:503,safe);}
}
