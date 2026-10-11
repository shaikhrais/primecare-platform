import registry from './report-registry.json';
import workspaceRegistry from './workspace-registry.json';
import {visiblePages,overview,type Actor} from './workspace';
import {privilegedActor} from './auth-projection';
import {requiredRow} from './database-results';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {emailSender,mailReady,type MailEnv} from './email';
import type {Client} from 'pg';
import {configuredMail} from './maintenance';

export type Locale='en'|'fr'|'es';
export type ReportRequest={locale:Locale;search:string;readiness:'all'|'created'|'ready'};
export type ReportResult={id:string;title:string;columns:{key:string;label:string}[];rows:Record<string,string|number>[];generatedAt:string;scope:string;classification:string;locale:Locale;source:string};
export class ReportFailure extends Error {constructor(readonly status:number, message:string){super(message);}}
const fail=(status:number,message:string):never=>{throw new ReportFailure(status,message);};
const labels=(locale:Locale)=>registry.resources[locale];
const exactText=(v:unknown,max:number)=>typeof v==='string'&&v.length<=max&&!/[\u0000-\u001f\u007f]/.test(v);
export function parseReportRequest(value:Record<string,unknown>):ReportRequest {
 if(Object.keys(value).some(k=>!['locale','search','readiness'].includes(k)))fail(400,'Unknown report option');
 const locale=value.locale??'en',search=value.search??'',readiness=value.readiness??'all';
 if(!['en','fr','es'].includes(locale as string)||!exactText(search,100)||!['all','created','ready'].includes(readiness as string))fail(400,'Invalid report options');
 return {locale:locale as Locale,search:search as string,readiness:readiness as ReportRequest['readiness']};
}
export class ReportPolicy {
 definition(actor:Actor,id:string,action:'view'|'export'|'email') {
  const definition=registry.definitions.find(d=>d.report_id===id);
  if(!definition)fail(404,'Report not found');
  if(!actor.tenant_id||!definition!.grants.some(g=>g.role===actor.roles&&g[action]===1))fail(403,'Forbidden');
  return definition!;
 }
 catalog(actor:Actor,locale:Locale) {return registry.definitions.filter(d=>d.grants.some(g=>g.role===actor.roles&&g.view===1)).map(d=>({id:d.report_id,title:d.report_id==='page_readiness'?labels(locale).pages:d.report_id==='platform_administration'?labels(locale).platform:labels(locale).organization,classification:d.classification,supportsFilters:d.report_id==='page_readiness',canExport:d.grants.some(g=>g.role===actor.roles&&g.export===1),canEmail:d.grants.some(g=>g.role===actor.roles&&g.email===1)}));}
}
export abstract class AdminReportDefinition {
 constructor(readonly id:string){}
 abstract rows(db:Client,actor:Actor,request:ReportRequest):Promise<Pick<ReportResult,'columns'|'rows'|'scope'|'source'>>;
}
export class PageReadinessReport extends AdminReportDefinition {
 constructor(){super('page_readiness');}
 async rows(_db:Client,actor:Actor,request:ReportRequest) {
  const l=labels(request.locale);
  // Even inventory administrators receive only their directly authorized pages here.
  const pages=visiblePages(actor.roles).filter(p=>`${p.name} ${p.code} ${p.route}`.toLowerCase().includes(request.search.toLowerCase())&&(request.readiness==='all'||(request.readiness==='ready')===p.productionReady));
  return {scope:'authorized_pages',source:'governance.db',columns:[{key:'page',label:l.page},{key:'role',label:l.role},{key:'status',label:l.status},{key:'blockers',label:l.blockers}],rows:pages.map(p=>({page:p.name,role:p.role,status:p.productionReady?l.ready:l.created,blockers:p.blockers.join('; ')}))};
 }
}
export class OrganizationSummaryReport extends AdminReportDefinition {
 constructor(){super('organization_summary');}
 async rows(db:Client,actor:Actor,request:ReportRequest) {
  if(request.search||request.readiness!=='all')fail(400,'Filters are not supported by this report');
  // Defense in depth: report grants cannot silently widen existing organization authority.
  const permission=(workspaceRegistry.permissions as Record<string,{organization:boolean}>)[actor.roles];
  if(permission?.organization!==true)fail(403,'Forbidden');
  const data=await overview(db,actor),l=labels(request.locale);
  const rows:Record<string,string|number>[]=[{metric:l.activeAccounts,value:data.activeAccounts},{metric:l.activeSessions,value:data.activeSessions},...data.accountRoles.map(r=>({metric:r.role,value:r.count})),...data.metrics.map(m=>({metric:m.code,value:m.available?m.count!:l.unavailable}))];
  return {scope:'organization',source:'PostgreSQL tenant-scoped aggregates',columns:[{key:'metric',label:l.metric},{key:'value',label:l.value}],rows};
 }
}
export class PlatformAdministrationReport extends AdminReportDefinition {
 constructor(){super('platform_administration');}
 async rows(db:Client,actor:Actor,request:ReportRequest){
  if(actor.roles!=='platform_admin')fail(403,'Forbidden');
  if(request.search||request.readiness!=='all')fail(400,'Filters are not supported by this report');
  const rows=(await db.query(`SELECT t.slug AS tenant,t.name,COUNT(DISTINCT u.id)::int AS accounts,COUNT(DISTINCT m.id)::int AS masters FROM tenants t LEFT JOIN users u ON u.tenant_id::text=t.id::text AND u.roles<>'platform_admin' AND LOWER(u.status)='active' LEFT JOIN platform_master_records m ON m.tenant_id::text=t.id::text GROUP BY t.id,t.slug,t.name ORDER BY t.slug LIMIT 1000`)).rows;
  const l=labels(request.locale);
  return {scope:'platform_tenant_metadata',source:'PostgreSQL platform tenant metadata',columns:[{key:'tenant',label:l.scope},{key:'name',label:l.page},{key:'accounts',label:l.activeAccounts},{key:'masters',label:l.count}],rows};
 }
}
export class ReportService {
 readonly policy=new ReportPolicy();
 readonly definitions:readonly AdminReportDefinition[]=[new PageReadinessReport(),new OrganizationSummaryReport(),new PlatformAdministrationReport()];
 async run(db:Client,actor:Actor,id:string,request:ReportRequest,action:'view'|'export'|'email'='view'):Promise<ReportResult> {
  const definition=this.policy.definition(actor,id,action),handler=this.definitions.find(d=>d.id===id)!;
  const data=await handler.rows(db,actor,request);
  if(data.rows.length>1000)fail(413,'Report row limit exceeded');
  return {id,title:id==='page_readiness'?labels(request.locale).pages:id==='platform_administration'?labels(request.locale).platform:labels(request.locale).organization,...data,generatedAt:new Date().toISOString(),classification:definition.classification,locale:request.locale};
 }
}
export abstract class ReportRenderer {abstract render(result:ReportResult):Uint8Array;}
/** Bounded print-ready report: repeated headings, wrapped cells, page numbers, WinAnsi accents.
 * All input is server-generated. No remote URLs, HTML or uploaded PDFs are accepted. */
export class PdfReportRenderer extends ReportRenderer {
 render(result:ReportResult):Uint8Array {
  const latin=(s:string)=>[...s].map(c=>{const n=c.codePointAt(0)!;return n>=32&&n<=255?c:({'’':"'",'‘':"'",'–':'-','—':'-','…':'...'}[c]??'?');}).join('');
  const literal=(s:string)=>latin(s).replace(/[\\()]/g,'\\$&');
  const width=Math.floor(100/result.columns.length);
  const wrap=(s:string)=>{const words=latin(s).split(/\s+/),out:string[]=[];let line='';for(let word of words){while(word.length>width){if(line){out.push(line);line='';}out.push(word.slice(0,width));word=word.slice(width);}if(line.length+word.length+1>width){out.push(line);line='';}line+=(line?' ':'')+word;}if(line||!out.length)out.push(line);return out;};
  const lines:string[]=[];
  for(const row of result.rows){const cells=result.columns.map(c=>wrap(String(row[c.key]??''))),height=Math.max(...cells.map(c=>c.length));for(let i=0;i<height;i++)lines.push(cells.map(c=>(c[i]??'').padEnd(width,' ')).join(' | '));lines.push('');}
  if(!lines.length)lines.push(labels(result.locale).empty);
  const pages:string[][]=[];for(let i=0;i<lines.length;i+=46)pages.push(lines.slice(i,i+46));
  if(pages.length>100)fail(413,'Report page limit exceeded');
  const objects:string[]=['','', '<< /Type /Font /Subtype /Type1 /BaseFont /Courier /Encoding /WinAnsiEncoding >>'];
  const kids:number[]=[];
  pages.forEach((page,i)=>{const pageId=objects.length+1,streamId=pageId+1;kids.push(pageId);objects.push(`<< /Type /Page /Parent 2 0 R /MediaBox [0 0 842 595] /Resources << /Font << /F1 3 0 R >> >> /Contents ${streamId} 0 R >>`);
   const header=[`PrimeCare - ${result.title}`,`${labels(result.locale).generated}: ${result.generatedAt} | ${labels(result.locale).scope}: ${result.scope} | ${result.classification}`,result.columns.map(c=>c.label.padEnd(width,' ')).join(' | '),''];
   const stream=`BT /F1 8 Tf 30 563 Td 10 TL\n${[...header,...page,`${i+1} / ${pages.length}`].map(s=>`(${literal(s)}) Tj T*`).join('\n')}\nET`;
   objects.push(`<< /Length ${stream.length} >>\nstream\n${stream}\nendstream`);
  });
  objects[0]='<< /Type /Catalog /Pages 2 0 R >>';objects[1]=`<< /Type /Pages /Kids [${kids.map(n=>`${n} 0 R`).join(' ')}] /Count ${kids.length} >>`;
  let pdf='%PDF-1.4\n',offsets=[0];objects.forEach((o,i)=>{offsets.push(pdf.length);pdf+=`${i+1} 0 obj\n${o}\nendobj\n`;});const xref=pdf.length;pdf+=`xref\n0 ${objects.length+1}\n0000000000 65535 f \n${offsets.slice(1).map(n=>String(n).padStart(10,'0')+' 00000 n \n').join('')}trailer\n<< /Size ${objects.length+1} /Root 1 0 R >>\nstartxref\n${xref}\n%%EOF\n`;
  return Uint8Array.from([...pdf].map(c=>c.charCodeAt(0)));
 }
}
export type ReportEmailRequest={options:ReportRequest;to:string;subject:string;message:string;confirmed:true};
export function parseReportEmail(value:unknown):ReportEmailRequest {
 if(!value||typeof value!=='object'||Array.isArray(value))fail(400,'Invalid email request');
 const v=value as Record<string,unknown>;
 if(Object.keys(v).some(k=>!['to','subject','message','confirmed','locale','search','readiness'].includes(k)))fail(400,'Unknown email field');
 const to=typeof v.to==='string'?v.to.trim():'';
 if(!emailSender(to)||/[<>]/.test(to)||v.confirmed!==true||!exactText(v.subject??'',150)||!exactText(v.message??'',1000))fail(400,'Invalid recipient or confirmation');
 return {options:parseReportRequest(Object.fromEntries(['locale','search','readiness'].filter(k=>k in v).map(k=>[k,v[k]]))),to,subject:(v.subject as string)??'',message:(v.message as string)??'',confirmed:true};
}
const escape=(s:string)=>s.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
export class ReportDeliveryService {
 async send(env:MailEnv,report:ReportResult,request:ReportEmailRequest) {
  if(!mailReady(env))fail(503,'Email delivery unavailable');
  const bytes=new PdfReportRenderer().render(report);
  if(bytes.byteLength>3*1024*1024)fail(413,'PDF attachment too large');
  const text=request.message||report.title;
  const result=await env.EMAIL!.send({from:emailSender(env.EMAIL_FROM)!.email,to:request.to,subject:request.subject||report.title,text,html:`<p>${escape(text)}</p>`,attachments:[{content:bytes,filename:`${report.id}.pdf`,type:'application/pdf',disposition:'attachment'}]});
  if(!result||!exactText(result.messageId,200)||!result.messageId.trim())throw Error('Invalid mail acceptance');
  return result.messageId;
 }
}
async function emailBody(request:Request):Promise<unknown> {
 if(request.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')fail(400,'JSON required');
 const reader=request.body?.getReader();if(!reader)fail(400,'JSON required');
 const chunks:Uint8Array[]=[];let size=0;
 try{while(true){const {done,value}=await reader!.read();if(done)break;size+=value.length;if(size>8192){await reader!.cancel();fail(413,'Request too large');}chunks.push(value);}}finally{reader!.releaseLock();}
 const bytes=new Uint8Array(size);let at=0;for(const c of chunks){bytes.set(c,at);at+=c.length;}
 try{return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{return fail(400,'Invalid JSON');}
}
const service=new ReportService();
export async function reporting(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
 if(env.SERVICE_NAME!=='governance'||!(path==='/reports'||path.startsWith('/reports/')))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try {
  const match=/^\/reports(?:\/([a-z_]+)(?:\/(pdf|email))?)?$/.exec(path);if(!match)fail(404,'Report route not found');
  const id=match![1],action=match![2],method=action==='email'?'POST':'GET';
  if(request.method!==method){safe.set('allow',method);fail(405,'Method not allowed');}
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)fail(401,'No session');
  const params=new URL(request.url).searchParams;if([...params.keys()].some(k=>params.getAll(k).length!==1))fail(400,'Duplicate report option');
  const options=parseReportRequest(Object.fromEntries(params));if(!id&&[...params.keys()].some(k=>k!=='locale'))fail(400,'Invalid catalog option');
  if(action==='email'&&params.size)fail(400,'Email options belong in JSON');
  if(method==='GET'&&request.body!==null)fail(400,'Unexpected body');
  const delivery=action==='email'?parseReportEmail(await emailBody(request)):null;
  const key=request.headers.get('idempotency-key');if(delivery&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400,'Idempotency-Key required');
  return await withDb(env,async db=>{
   await db.query(delivery?'BEGIN':'BEGIN ISOLATION LEVEL REPEATABLE READ');let committed=false;
   try {
    const actor=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token!)])).rows);
    if(!actor)fail(401,'Invalid session');if(!actor!.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==actor!.tenant_id))fail(403,'Forbidden');
    const identity=actor as Actor;
    if(!id){const reports=service.policy.catalog(identity,options.locale);await db.query('COMMIT');committed=true;return json({reports,resources:labels(options.locale)},200,safe);}
    service.policy.definition(identity,id,delivery?'email':action==='pdf'?'export':'view');
    if(delivery) {
     // Serialize claims and quota for this actor. Commit before the irreversible send.
     await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[identity.tenant_id+':'+identity.id+':reports']);
     const fingerprint=await sha256(JSON.stringify({id,...delivery}));
     const previous=(await db.query('SELECT request_hash,state FROM report_delivery WHERE actor_id=$1 AND tenant_id=$2 AND idempotency_key=$3',[identity.id,identity.tenant_id,key])).rows;
     if(previous.length){const row=requiredRow(previous);if(row.request_hash!==fingerprint)fail(409,'Idempotency key already used');if(typeof row.state!=='string'||!['sending','accepted','unknown'].includes(row.state))throw Error('Invalid delivery state');await db.query('COMMIT');committed=true;return json({state:row.state},row.state==='accepted'?200:409,safe);}
     const count=requiredRow((await db.query("SELECT COUNT(*)::int AS count FROM report_delivery WHERE actor_id=$1 AND tenant_id=$2 AND created_at>NOW()-INTERVAL '1 hour'",[identity.id,identity.tenant_id])).rows).count;
     if(typeof count!=='number'||!Number.isSafeInteger(count)||count<0)throw Error('Invalid delivery quota');if(count>=10){safe.set('retry-after','3600');fail(429,'Email report limit reached');}
     const mail=await configuredMail(db,env,identity.tenant_id);
     if(!mailReady(mail))fail(503,'Email delivery unavailable');
     const report=await service.run(db,identity,id,delivery.options,'email');
     const claim=requiredRow((await db.query("INSERT INTO report_delivery(actor_id,tenant_id,idempotency_key,request_hash,report_id,recipient,state) VALUES($1,$2,$3,$4,$5,$6,'sending') RETURNING id",[identity.id,identity.tenant_id,key,fingerprint,id,delivery.to])).rows);
     if(!claim.id)throw Error('Missing delivery claim');await db.query('COMMIT');committed=true;
     try {const messageId=await new ReportDeliveryService().send(mail,report,delivery);const changed=(await db.query("UPDATE report_delivery SET state='accepted',message_id=$2,updated_at=NOW() WHERE id=$1 AND state='sending' RETURNING id",[claim.id,messageId])).rows;if(changed.length!==1)throw Error('Acceptance audit failed');return json({state:'accepted'},202,safe);}
     catch {try{await db.query("UPDATE report_delivery SET state='unknown',updated_at=NOW() WHERE id=$1 AND state='sending'",[claim.id]);}catch{/* committed sending claim still prevents automatic resend */}return json({state:'unknown'},503,safe);}
    }
    const report=await service.run(db,identity,id,options,action==='pdf'?'export':'view');
    const bytes=action==='pdf'?new PdfReportRenderer().render(report):null;
    const audit=(await db.query('INSERT INTO report_audit(actor_id,tenant_id,report_id,operation) VALUES($1,$2,$3,$4) RETURNING id',[identity.id,identity.tenant_id,id,action==='pdf'?'pdf':'run'])).rows;if(audit.length!==1||!audit[0].id)throw Error('Report audit failed');
    await db.query('COMMIT');committed=true;
    if(bytes){safe.set('content-type','application/pdf');safe.set('content-disposition',`attachment; filename="${id}.pdf"`);const body=new ArrayBuffer(bytes.byteLength);new Uint8Array(body).set(bytes);return new Response(body,{headers:safe});}
    return json(report,200,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){return json({error:error instanceof ReportFailure?error.message:'Reporting unavailable'},error instanceof ReportFailure?error.status:503,safe);}
}
