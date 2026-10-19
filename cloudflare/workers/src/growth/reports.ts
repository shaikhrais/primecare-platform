import {marketingStatementOptions} from '../../../../packages/shared/src/growth/marketing';
import {canBusiness} from '../../../../packages/shared/src/growth/business';
import {marketingStatement} from './marketing-statement';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {configuredMail} from '../maintenance';
import {mailReady} from '../email';
import {privilegedActor} from '../auth-projection';
import {optionalRow,requiredRow} from '../database-results';
import {PdfReportRenderer,ReportDeliveryService} from '../reporting';
import {GrowthFailure,GrowthPolicy,fail,canonical,registry,uuid,type Actor} from '../../../../packages/shared/src/growth/contract';
import {canReport,reportOptions,deliveryResolution} from '../../../../packages/shared/src/growth/reporting';
import {GrowthRepository} from './repository';
import {performance} from './performance';
export async function growthReports(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 const statement=path==='/growth/marketing-statement'||path==='/growth/marketing-statement/pdf';
 if(env.SERVICE_NAME!=='governance'||!statement&&!(path==='/growth/performance'||path.startsWith('/growth/performance/')))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const resolve=/^\/growth\/performance\/deliveries\/([0-9a-f-]+)$/.exec(path);if(resolve&&!uuid(resolve[1]))fail(400);
  if(!statement&&!resolve&&!['/growth/performance','/growth/performance/pdf','/growth/performance/email'].includes(path))fail(404,'not_found');const email=path.endsWith('/email')||!!resolve,pdf=path.endsWith('/pdf');
  if(request.method!==(email?'POST':'GET'))fail(405,'method_not_allowed');if(request.headers.has('x-tenant-id'))fail(400);
  const token=tokenFrom(request);if(!token)fail(401,'unauthorized');const params=new URL(request.url).searchParams;
  if(email&&params.size||[...params.keys()].some(k=>params.getAll(k).length!==1)||!email&&request.body)fail(400);
  let input:Record<string,unknown>=Object.fromEntries(params);if(email){try{input=await parseBody(request);}catch(error){return bodyFailure(error,'invalid_request',safe);}}
  const options=resolve?{start:'',end:'',locale:'en' as const,to:undefined}:statement?marketingStatementOptions(input):reportOptions(input,email),resolution=resolve?deliveryResolution(input):null,key=request.headers.get('idempotency-key');if(email&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active'"+(lock?' FOR SHARE OF u,s,t':' LIMIT 1'),[await sha256(token!)])).rows);
   const check=(a:ReturnType<typeof privilegedActor>)=>{if(!a)fail(401,'unauthorized');GrowthPolicy.read(a as Actor);if(!(statement?canBusiness(a as Actor):canReport(a as Actor,email)))fail(403,'forbidden');return a as Actor;};let actor=check(await session());
   const rate=requiredRow((await db.query("INSERT INTO growth_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN growth_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE growth_rate.attempts+1 END,window_start=CASE WHEN growth_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE growth_rate.window_start END RETURNING attempts",[actor.id])).rows);if(typeof rate.attempts!=='number')throw Error('Invalid rate');if(rate.attempts>90){safe.set('retry-after','60');fail(429,'rate_limited');}
   await db.query(email?'BEGIN':'BEGIN ISOLATION LEVEL REPEATABLE READ');let committed=false;
   try{
    actor=check(await session(true));const repo=new GrowthRepository(db,actor);
    if(resolve){
     await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[actor.id+':'+key]);
     await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-report:'+actor.id]);
     const resolutionHash=await sha256(canonical({path,input,tenant:actor.tenant_id})),replay=optionalRow((await db.query('SELECT request_hash,response FROM growth_requests WHERE actor_id=$1 AND idempotency_key=$2',[actor.id,key])).rows);if(replay){if(replay.request_hash!==resolutionHash)fail(409,'conflict');return json(replay.response,200,safe);}
     const row=optionalRow((await db.query('SELECT state,version FROM growth_report_deliveries WHERE id=$1 AND actor_id=$2 AND tenant_id::text=$3 FOR UPDATE',[resolve[1],actor.id,actor.tenant_id])).rows);if(!row)fail(404,'not_found');if(row!.state!=='unknown'||row!.version!==resolution!.version)fail(409,'conflict');
     await db.query('UPDATE growth_report_deliveries SET state=$1,version=version+1,review_evidence=$2,updated_at=NOW() WHERE id=$3',[resolution!.decision,resolution!.evidence,resolve[1]]);await repo.audit('performance_email_review',resolve[1],resolution!.evidence);const result={id:resolve[1],version:resolution!.version+1,state:resolution!.decision};await db.query('INSERT INTO growth_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,200)',[actor.id,key,resolutionHash,JSON.stringify(result)]);await db.query('COMMIT');committed=true;return json(result,200,safe);
    }
    if(email){
     await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-report:'+actor.id]);const hash=await sha256(canonical(options)),previous=optionalRow((await db.query('SELECT request_hash,state FROM growth_report_deliveries WHERE actor_id=$1 AND tenant_id::text=$2 AND idempotency_key=$3',[actor.id,actor.tenant_id,key])).rows);
     if(previous){if(previous.request_hash!==hash)fail(409,'conflict');if(!['sending','accepted','unknown','not_sent'].includes(String(previous.state)))throw Error('Invalid delivery state');return json({state:previous.state},['accepted','not_sent'].includes(String(previous.state))?200:409,safe);}
     const pending=optionalRow((await db.query("SELECT state FROM growth_report_deliveries WHERE actor_id=$1 AND tenant_id::text=$2 AND request_hash=$3 AND state IN ('sending','unknown') LIMIT 1",[actor.id,actor.tenant_id,hash])).rows);if(pending)return json({state:pending.state},409,safe);
     const count=requiredRow((await db.query("SELECT COUNT(*)::int AS count FROM growth_report_deliveries WHERE actor_id=$1 AND tenant_id::text=$2 AND created_at>NOW()-INTERVAL '1 hour'",[actor.id,actor.tenant_id])).rows).count;if(typeof count!=='number')throw Error('Invalid quota');if(count>=registry.reportPolicy.emailHourlyLimit){safe.set('retry-after','3600');fail(429,'rate_limited');}
     const exists=requiredRow((await db.query("SELECT to_regclass('tenant_mail_configuration') IS NOT NULL AS exists")).rows).exists;const mail=exists?await configuredMail(db,env,actor.tenant_id):env;if(!mailReady(mail))fail(503,'unavailable');
     const report=await performance(repo,options),id=crypto.randomUUID();new PdfReportRenderer().render(report);
     await db.query("INSERT INTO growth_report_deliveries(id,tenant_id,actor_id,idempotency_key,request_hash,recipient,state) VALUES($1,$2,$3,$4,$5,$6,'sending')",[id,actor.tenant_id,actor.id,key,hash,options.to]);await repo.audit('performance_email_claimed',id);await db.query('COMMIT');committed=true;
     try{
      const messageId=await new ReportDeliveryService().send(mail,report,{options:{locale:options.locale,search:'',readiness:'all'},to:options.to!,subject:'',message:'',confirmed:true});
      const rows=(await db.query("UPDATE growth_report_deliveries SET state='accepted',message_id=$2,updated_at=NOW() WHERE id=$1 AND state='sending' RETURNING id",[id,messageId])).rows;if(rows.length!==1)throw Error('Acceptance audit failed');return json({state:'accepted'},202,safe);
     }catch{try{await db.query("UPDATE growth_report_deliveries SET state='unknown',updated_at=NOW() WHERE id=$1 AND state='sending'",[id]);}catch{}return json({state:'unknown'},503,safe);}
    }
    const result=statement?await marketingStatement(repo,options):await performance(repo,options),bytes=pdf?new PdfReportRenderer().render(result):null;await repo.audit(statement?(pdf?'marketing_statement_pdf':'marketing_statement_read'):(pdf?'performance_pdf':'performance_read'),statement?'growth_marketing_statement':'growth_performance');await db.query('COMMIT');committed=true;
    if(bytes){safe.set('content-type','application/pdf');safe.set('content-disposition',statement?'attachment; filename="marketing-statement-'+options.start.slice(0,7)+'.pdf"':'attachment; filename="growth-performance.pdf"');const buffer=new ArrayBuffer(bytes.byteLength);new Uint8Array(buffer).set(bytes);return new Response(buffer,{headers:safe});}return json(result,200,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){return json({error:error instanceof GrowthFailure?error.code:'unavailable'},error instanceof GrowthFailure?error.status:503,safe);}
}
