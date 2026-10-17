import type {Client} from 'pg';
import {registry,type BundleActor} from '../../../../packages/shared/src/platform-bundle/contract';
import {requiredRow} from '../database-results';
/** One row per actionable record. No contact, filename, ticket subject or message is projected. */
const model=`WITH scoped_tenants AS (
 SELECT id::text AS tenant_id,name,slug FROM tenants WHERE $1::text IS NULL OR id::text=$1
), latest_documents AS (
 SELECT DISTINCT ON(d.tenant_id,d.kind) d.id,d.tenant_id,d.kind,d.revision,d.status,d.expires_on FROM platform_documents d
 JOIN scoped_tenants t ON t.tenant_id=d.tenant_id::text ORDER BY d.tenant_id,d.kind,d.revision DESC
), work AS (
 SELECT 'support'::text AS kind,s.id::text AS id,t.tenant_id,t.name,t.slug,
 CASE WHEN s.first_response_at IS NULL AND s.response_due<=s.resolution_due THEN 'response_late' ELSE 'resolution_late' END AS reason,
 LEAST(CASE WHEN s.first_response_at IS NULL THEN s.response_due ELSE NULL END,s.resolution_due) AS due_at,
 TRUE AS overdue,EXISTS(SELECT 1 FROM users u JOIN tenants h ON h.id=u.tenant_id WHERE u.id=s.owner_id AND u.roles=ANY($5::text[]) AND LOWER(u.status)='active' AND LOWER(h.status)='active') AS assigned,'support'::text AS destination
 FROM platform_support_tickets s JOIN scoped_tenants t ON t.tenant_id=s.tenant_id::text
 WHERE s.status<>'resolved' AND ((s.first_response_at IS NULL AND s.response_due<NOW()) OR s.resolution_due<NOW())
 UNION ALL
 SELECT 'documents',d.id::text,t.tenant_id,t.name,t.slug,
 CASE WHEN d.expires_on<=(NOW() AT TIME ZONE 'America/Toronto')::date+$4::int THEN 'document_renewal'
 WHEN d.status='pending' THEN 'document_review' ELSE 'document_rejected' END,
 CASE WHEN d.expires_on<=(NOW() AT TIME ZONE 'America/Toronto')::date+$4::int THEN (d.expires_on+1)::timestamp AT TIME ZONE 'America/Toronto' ELSE NULL END,d.expires_on<(NOW() AT TIME ZONE 'America/Toronto')::date,FALSE,'documents'
 FROM latest_documents d JOIN scoped_tenants t ON t.tenant_id=d.tenant_id::text
 WHERE d.expires_on<=(NOW() AT TIME ZONE 'America/Toronto')::date+$4::int OR d.status IN ('pending','rejected')
 UNION ALL
 SELECT 'offers',r.id::text,t.tenant_id,t.name,t.slug,CASE WHEN r.status='unmatched' THEN 'offer_unmatched' ELSE 'offer_expired' END,
 r.offer_due,(r.status='pending'),FALSE,'routing'
 FROM platform_routed_enquiries r LEFT JOIN scoped_tenants t ON t.tenant_id=r.tenant_id::text
 WHERE ($1::text IS NULL OR r.tenant_id::text=$1) AND (r.status='unmatched' OR (r.status='pending' AND r.offer_due<=NOW()))
 UNION ALL
 SELECT 'launch',l.tenant_id::text,t.tenant_id,t.name,t.slug,'launch_review',NULL::timestamptz,FALSE,FALSE,'launch'
 FROM platform_launch l JOIN scoped_tenants t ON t.tenant_id=l.tenant_id::text WHERE l.state='submitted'
), filtered AS (
 SELECT * FROM work WHERE ($3::text='all' OR kind=$3) AND ($2::text='' OR POSITION(LOWER($2) IN LOWER(COALESCE(name,'')||' '||COALESCE(slug,'')||' '||id))>0)
)`;
export async function readAttention(db:Client,actor:BundleActor,global:boolean,offset:number,search:string,kind:string){
 const params=[global?null:actor.tenant_id,search,kind,registry.renewalDays,Object.entries(registry.roles).filter(([,scope])=>scope==='global').map(([role])=>role)];
 const summary=requiredRow((await db.query(model+` SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE overdue)::int AS overdue,
 COUNT(*) FILTER(WHERE kind='support')::int AS support,COUNT(*) FILTER(WHERE kind='documents')::int AS documents,
 COUNT(*) FILTER(WHERE kind='offers')::int AS offers,COUNT(*) FILTER(WHERE kind='launch')::int AS launch FROM filtered`,params)).rows);
 if(Object.values(summary).some(v=>typeof v!=='number'||!Number.isSafeInteger(v)||v<0))throw Error('Invalid attention counts');
 const rows=(await db.query(model+' SELECT * FROM filtered ORDER BY overdue DESC,due_at ASC NULLS LAST,kind,id LIMIT $6 OFFSET $7',[...params,registry.pageSize,offset])).rows;
 const items=rows.map(r=>({key:String(r.kind)+'-'+String(r.id),kind:r.kind,id:r.id,reason:r.reason,dueAt:r.due_at instanceof Date?r.due_at.toISOString():typeof r.due_at==='string'?r.due_at:null,overdue:r.overdue===true,assigned:r.assigned===true,tenant:r.tenant_id?{id:r.tenant_id,name:r.name,slug:r.slug}:null,destination:r.destination}));
 return {scope:global?'global':'own',items,summary,pagination:{offset,limit:registry.pageSize,total:summary.total,hasMore:offset+items.length<Number(summary.total)}};
}
