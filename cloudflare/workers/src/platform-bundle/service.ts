import {readHistory} from './history';
import {readAttention} from './attention';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {privilegedActor} from '../auth-projection';
import {optionalRow,requiredRow} from '../database-results';
import {bundleAccess,type BundleActor,registry} from '../../../../packages/shared/src/platform-bundle/contract';
import {GrowthFailure,fail,canonical,keys,text,uuid} from '../../../../packages/shared/src/growth/contract';
import {launchState} from './launch';
import {uploadDocument,reviewDocument} from './documents';
import {supportCommand} from './support';
import {routeCommand} from './routing';
import {readBundle} from './read';
const identifier=/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/;
export async function platformBundle(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!path.startsWith('/platform/bundle'))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const attention=path==='/platform/bundle/attention';
  const match=attention?[]:/^\/platform\/bundle(?:\/tenants\/([^/]+)(?:\/(launch|documents|tickets|history)(?:\/([^/]+)(?:\/(download|review))?)?)?|\/enquiries(?:\/([^/]+))?)?$/.exec(path);if(!match)fail(404,'not_found');
  const tenant=match![1],entity=match![2]??(path.includes('/enquiries')?'enquiries':undefined),id=match![3]??match![5],sub=match![4];
  if(tenant&&!identifier.test(tenant)||id&&!uuid(id))fail(400);const read=request.method==='GET',download=entity==='documents'&&sub==='download'&&!!id,history=entity==='history'&&!id;
  if(!(read&&(!entity||download||history)||request.method==='POST'&&!!entity&&entity!=='history'&&(!sub||sub==='review')&&(entity!=='launch'||!id)&&(entity!=='documents'||!id||sub==='review')&&(entity!=='tickets'||!sub)&&(entity!=='enquiries'||!sub)))fail(405,'method_not_allowed');
  const url=new URL(request.url);if(request.headers.has('x-tenant-id')||(!read||download)&&url.search)fail(400);
  let offset=0,list='tickets',search='',kind='all',ticketId:string|null=null;if(read&&!download){for(const key of url.searchParams.keys())if(!(history?['offset','kind','ticketId']:attention?['offset','kind','search']:['offset','list','search']).includes(key)||url.searchParams.getAll(key).length!==1)fail(400);const raw=url.searchParams.get('offset')??'0';if(!/^(0|[1-9]\d{0,5})$/.test(raw)||Number(raw)>100000)fail(400);offset=Number(raw);kind=url.searchParams.get('kind')??'all';if(attention&&!registry.attentionKinds.includes(kind))fail(400);if(history){if(!registry.historyKinds.includes(kind))fail(400);ticketId=url.searchParams.get('ticketId');if(['messages','deadlines'].includes(kind)?!ticketId||!uuid(ticketId):ticketId!==null)fail(400);}list=url.searchParams.get('list')??'tickets';search=(url.searchParams.get('search')??'').trim();if(!['tickets','routes'].includes(list)||!text(search,100,true))fail(400);}
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)fail(401,'unauthorized');
  let body:Record<string,unknown>={};if(!read){try{body=await parseBody(request,entity==='documents'&&!id?2_850_000:50_000);}catch(error){return bodyFailure(error,'invalid_request',safe);}}else if(request.body)fail(400);
  const key=request.headers.get('idempotency-key');if(!read&&(!key||!/^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active'"+(lock?' FOR SHARE OF u,s':' LIMIT 1'),[await sha256(token!)])).rows);
   const authorize=(a:ReturnType<typeof privilegedActor>)=>{if(!a)fail(401,'unauthorized');const access=bundleAccess(a!.roles);if(!access)fail(403,'forbidden');if(tenant&&access==='own'&&tenant!==a!.tenant_id)fail(404,'not_found');return a! as BundleActor;};
   let actor=authorize(await session());
   const bucket=actor.id+':'+(read?'read':'write');const r=requiredRow((await db.query("INSERT INTO platform_bundle_rate(bucket,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(bucket) DO UPDATE SET attempts=CASE WHEN platform_bundle_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE platform_bundle_rate.attempts+1 END,window_start=CASE WHEN platform_bundle_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE platform_bundle_rate.window_start END RETURNING attempts",[bucket])).rows);if(typeof r.attempts!=='number')throw Error('Invalid rate');if(r.attempts>(read?120:30)){safe.set('retry-after','60');fail(429,'rate_limited');}
   await db.query(read?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');let committed=false;
   try{
    actor=authorize(await session(!read));const global=bundleAccess(actor.roles)==='global';
    if(tenant){const exists=optionalRow((await db.query('SELECT id FROM tenants WHERE id::text=$1'+(!read?' FOR UPDATE':''),[tenant])).rows);if(!exists)fail(404,'not_found');}
    if(download){const doc=optionalRow((await db.query('SELECT filename,media_type,content FROM platform_documents WHERE id=$1 AND tenant_id::text=$2',[id,tenant])).rows);if(!doc)fail(404,'not_found');safe.set('content-type',String(doc.media_type));safe.set('content-disposition','attachment; filename="'+String(doc.filename).replace(/[^A-Za-z0-9_. -]/g,'_')+'"');safe.set('content-security-policy',"default-src 'none'; sandbox");return new Response(Uint8Array.from(doc.content as Uint8Array).buffer,{status:200,headers:safe});}
    if(read&&history)return json(await readHistory(db,tenant!,global,kind,ticketId,offset),200,safe);
    if(read&&attention)return json(await readAttention(db,actor,global,offset,search,kind),200,safe);
    if(read)return json(await readBundle(db,actor,global,tenant??null,list,offset,search),200,safe);
    // Apply current authority before replay; a cached response never grants cross-tenant access.
    if(entity==='documents'&&sub==='review'&&!global||entity==='launch'&&['approve','request_changes'].includes(String(body.action))&&!global||entity==='enquiries'&&!id&&!global)fail(403,'forbidden');
    const hash=await sha256(canonical({path,body}));await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['platform-bundle:'+actor.id+':'+key]);
    const replay=optionalRow((await db.query('SELECT request_hash,response,status FROM platform_bundle_requests WHERE actor_id=$1 AND idempotency_key=$2',[actor.id,key])).rows);if(replay){if(replay.request_hash!==hash)fail(409,'conflict');return json(replay.response,Number(replay.status),safe);}
    const ticketBefore=entity==='tickets'&&id?optionalRow((await db.query('SELECT status,priority,owner_id,version,cycle_start,response_due,resolution_due,first_response_at,resolved_at FROM platform_support_tickets WHERE id=$1 AND tenant_id::text=$2',[id,tenant])).rows):null;
    let result:{id:string;version:number}|{tenantId:string;version:number};
    if(entity==='documents')result=sub==='review'?await reviewDocument(db,tenant!,id!,actor.id,body):await uploadDocument(db,tenant!,actor.id,body);
    else if(entity==='tickets')result=await supportCommand(db,actor,global,tenant!,id,body);
    else if(entity==='enquiries')result=await routeCommand(db,actor,global,id,body);
    else{
     keys(body,['version','action','evidence','confirmed']);if(!Number.isSafeInteger(body.version)||Number(body.version)<0||!['training','submit','approve','request_changes'].includes(String(body.action))||!text(body.evidence,1000)||typeof body.confirmed!=='boolean')fail(400);
     const state=await launchState(db,tenant!,global);if(body.version!==state.version)fail(409,'conflict');
     if(body.action==='training')await db.query("INSERT INTO platform_launch(tenant_id,training_evidence) VALUES($1,$2) ON CONFLICT(tenant_id) DO UPDATE SET training_evidence=$2,state='draft',approved_by=NULL,approved_fingerprint=NULL,version=platform_launch.version+1,updated_at=NOW()",[tenant,body.evidence]);
     else{
      if(body.action==='submit'&&!state.canSubmit||body.action==='approve'&&(!state.canApprove||body.confirmed!==true)||body.action==='request_changes'&&!state.canRequestChanges)fail(409,'conflict');
      if(body.action==='submit')await db.query("UPDATE platform_launch SET state='submitted',submitted_by=$1,approved_by=NULL,approved_fingerprint=NULL,version=version+1,updated_at=NOW() WHERE tenant_id::text=$2",[actor.id,tenant]);
      else if(body.action==='request_changes')await db.query("UPDATE platform_launch SET state='draft',approved_by=NULL,approved_fingerprint=NULL,version=version+1,updated_at=NOW() WHERE tenant_id::text=$1",[tenant]);
      else await db.query("UPDATE platform_launch SET state='approved',approved_by=$1,approved_fingerprint=$2,version=version+1,updated_at=NOW() WHERE tenant_id::text=$3",[actor.id,state.fingerprint,tenant]);
     }
     result={tenantId:tenant!,version:state.version+1};
    }
    // Only evidence and record identifiers enter the audit; never file bytes or enquiry contacts.
    const target='id' in result?result.id:result.tenantId;
    let auditTenant=tenant??null;if(entity==='enquiries')auditTenant=optionalRow((await db.query('SELECT tenant_id FROM platform_routed_enquiries WHERE id=$1',[target])).rows)?.tenant_id as string??null;
    const ticketAfter=entity==='tickets'?requiredRow((await db.query('SELECT status,priority,owner_id,version,cycle_start,response_due,resolution_due,first_response_at,resolved_at FROM platform_support_tickets WHERE id=$1 AND tenant_id::text=$2',[target,tenant])).rows):null;
    const action=entity==='launch'?'launch_'+body.action:entity+'_'+(sub??body.action??'created');
    await db.query('INSERT INTO platform_bundle_audit(actor_id,tenant_id,target_id,action,evidence,state) VALUES($1,$2,$3,$4,$5,$6)',[actor.id,auditTenant,target,action,body.evidence??(entity==='tickets'?body.message:'')??'',JSON.stringify(entity==='tickets'?{previous:ticketBefore,current:ticketAfter}:result)]);
    const status=!id&&entity!=='launch'?201:200;await db.query('INSERT INTO platform_bundle_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,$5)',[actor.id,key,hash,JSON.stringify(result),status]);await db.query('COMMIT');committed=true;return json(result,status,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);if((error as {code?:string}).code==='23505')return json({error:'conflict'},409,safe);return json({error:'unavailable'},503,safe);}
}
