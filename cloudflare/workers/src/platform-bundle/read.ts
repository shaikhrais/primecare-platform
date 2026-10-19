import {documentPage,messagePage,deadlinePage,launchPage} from './history';
import type {Client} from 'pg';
import {registry,type BundleActor,type BundleData,type Ticket,type Enquiry} from '../../../../packages/shared/src/platform-bundle/contract';
import {requiredRow} from '../database-results';
import {launchState} from './launch';
const iso=(v:unknown)=>v instanceof Date?v.toISOString():typeof v==='string'?v:null;
export async function readBundle(db:Client,actor:BundleActor,global:boolean,tenant:string|null,list:string,offset:number,search:string):Promise<BundleData>{
 const limit=registry.pageSize,scope=tenant??(global?null:actor.tenant_id),ticketOffset=list==='tickets'?offset:0,routeOffset=list==='routes'?offset:0;
 const launch=scope?await launchState(db,scope,global):null;
 const documents=scope?await documentPage(db,scope,global):[];
 const condition="($1::text IS NULL OR t.tenant_id::text=$1) AND ($2::text='' OR POSITION(LOWER($2) IN LOWER(t.subject||' '||t.id::text))>0)";
 const totals=requiredRow((await db.query(`SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE status<>'resolved' AND ((first_response_at IS NULL AND response_due<NOW()) OR resolution_due<NOW()))::int AS overdue FROM platform_support_tickets t WHERE ${condition}`,[scope,search])).rows);
 const ticketsRaw=(await db.query(`SELECT t.*,(t.status<>'resolved' AND ((t.first_response_at IS NULL AND t.response_due<NOW()) OR t.resolution_due<NOW())) AS overdue FROM platform_support_tickets t WHERE ${condition} ORDER BY (status='resolved'),resolution_due,id LIMIT $3 OFFSET $4`,[scope,search,limit,ticketOffset])).rows;
 const tickets:Ticket[]=[];
 for(const t of ticketsRaw){
  const messages=(await messagePage(db,String(t.tenant_id),String(t.id))).reverse();
  const timeline=await deadlinePage(db,String(t.tenant_id),String(t.id));
  tickets.push({timeline,id:String(t.id),tenant_id:String(t.tenant_id),subject:String(t.subject),priority:String(t.priority),status:String(t.status),owner_id:t.owner_id?String(t.owner_id):null,version:Number(t.version),response_due:iso(t.response_due)!,resolution_due:iso(t.resolution_due)!,first_response_at:iso(t.first_response_at),resolved_at:iso(t.resolved_at),overdue:t.overdue===true,responseLate:!!t.first_response_at&&new Date(String(t.first_response_at))>new Date(String(t.response_due)),resolutionLate:!!t.resolved_at&&new Date(String(t.resolved_at))>new Date(String(t.resolution_due)),messages,canTriage:global&&t.status!=='resolved',canReopen:t.status==='resolved'});
 }
 const routeCondition="($1::text IS NULL OR r.tenant_id::text=$1) AND ($2::text='' OR POSITION(LOWER($2) IN LOWER(r.id::text))>0)",routeScope=global?null:actor.tenant_id;
 const routeTotals=requiredRow((await db.query(`SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE status='unmatched')::int AS unmatched FROM platform_routed_enquiries r WHERE ${routeCondition}`,[routeScope,search])).rows);
 const routeRaw=(await db.query(`SELECT r.*,t.name AS tenant_name,r.offer_due<=NOW() AS expired FROM platform_routed_enquiries r LEFT JOIN tenants t ON t.id=r.tenant_id WHERE ${routeCondition} ORDER BY r.created_at DESC,r.id LIMIT $3 OFFSET $4`,[routeScope,search,limit,routeOffset])).rows;
 const routes:Enquiry[]=routeRaw.map(r=>{
  const pending=r.status==='pending'&&!r.expired,actions:string[]=[];
  if(global&&r.status!=='withdrawn')actions.push('withdraw');if(global&&['unmatched','declined'].includes(String(r.status))||global&&r.status==='pending'&&r.expired)actions.push('reroute');
  if(!global&&pending)actions.push('accept','decline');
  return {id:String(r.id),fsa:String(r.fsa),service:String(r.service),status:r.status==='pending'&&r.expired?'expired_offer':String(r.status),reason:String(r.reason),version:Number(r.version),offer_due:iso(r.offer_due),tenant_name:typeof r.tenant_name==='string'?r.tenant_name:null,lead_id:r.lead_id?String(r.lead_id):null,contact:global||r.status==='accepted'?{name:String(r.name),email:String(r.email),phone:String(r.phone)}:null,actions};
 });
 const owners=global?(await db.query("SELECT u.id,u.email AS label FROM users u JOIN tenants t ON t.id=u.tenant_id WHERE u.roles=ANY($1::text[]) AND LOWER(u.status)='active' AND LOWER(t.status)='active' ORDER BY LOWER(u.email),u.id",[Object.entries(registry.roles).filter(([,s])=>s==='global').map(([r])=>r)])).rows as {id:string;label:string}[]:[];
 const audit=scope?await launchPage(db,scope):[];
 const total=Number(list==='routes'?routeTotals.total:totals.total);
 const {fingerprint:_,...publicLaunch}=launch??{fingerprint:''};
 return {global,tenantId:scope,checkedAt:new Date().toISOString(),launch:launch?publicLaunch as BundleData['launch']:null,documents,tickets,routes,owners,audit,summary:{tickets:Number(totals.total),overdue:Number(totals.overdue),routes:Number(routeTotals.total),unmatched:Number(routeTotals.unmatched),renewals:documents.filter(d=>d.renewal!=='valid'&&d.revision===Math.max(...documents.filter(x=>x.kind===d.kind).map(x=>x.revision))).length},pagination:{list,offset,limit,total,hasMore:offset+limit<total}};
}
