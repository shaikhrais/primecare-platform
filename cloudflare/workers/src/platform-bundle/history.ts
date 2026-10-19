import type {Client} from 'pg';
import {registry,type BundleHistory,type DocumentRow,type SupportMessage,type DeadlineEvent,type LaunchEvent} from '../../../../packages/shared/src/platform-bundle/contract';
import {optionalRow,requiredRow} from '../database-results';
import {fail} from '../../../../packages/shared/src/growth/contract';

const iso=(value:unknown)=>value instanceof Date?value.toISOString():typeof value==='string'?value:null;
export const documentRow=(d:Record<string,unknown>,global:boolean):DocumentRow=>({id:String(d.id),kind:String(d.kind),revision:Number(d.revision),filename:String(d.filename),media_type:String(d.media_type),expires_on:String(d.expires_on),status:String(d.status),version:Number(d.version),review_evidence:String(d.review_evidence),renewal:String(d.renewal),canReview:global&&d.latest===true&&d.status==='pending'});
export const messageRow=(m:Record<string,unknown>):SupportMessage=>({id:String(m.id),message:String(m.message),created_at:iso(m.created_at)!,author:String(m.author)});
export const deadlineRow=(e:Record<string,unknown>):DeadlineEvent=>{const c=(e.state as {current?:Record<string,unknown>})?.current??{};return {id:String(e.id),action:String(e.action),createdAt:iso(e.created_at)!,status:String(c.status??'open'),priority:String(c.priority??'normal'),responseDue:iso(c.response_due),resolutionDue:iso(c.resolution_due),firstResponseAt:iso(c.first_response_at),resolvedAt:iso(c.resolved_at)};};
export const launchEvent=(e:Record<string,unknown>):LaunchEvent=>({id:String(e.id),action:String(e.action),evidence:String(e.evidence),created_at:iso(e.created_at)!});

export async function documentPage(db:Client,tenant:string,global:boolean,offset=0):Promise<DocumentRow[]>{
 const rows=(await db.query(`SELECT id,kind,revision,filename,media_type,expires_on::text,status,version,review_evidence,
 CASE WHEN expires_on<(NOW() AT TIME ZONE 'America/Toronto')::date THEN 'expired' WHEN expires_on<=(NOW() AT TIME ZONE 'America/Toronto')::date+$2::int THEN 'due_soon' ELSE 'valid' END AS renewal,
 revision=MAX(revision) OVER(PARTITION BY kind) AS latest FROM platform_documents WHERE tenant_id::text=$1
 ORDER BY latest DESC,kind,revision DESC,id LIMIT $3 OFFSET $4`,[tenant,registry.renewalDays,registry.historyPolicy.pageSize,offset])).rows;
 return rows.map(d=>documentRow(d,global));
}
export async function messagePage(db:Client,tenant:string,ticket:string,offset=0):Promise<SupportMessage[]>{
 const rows=(await db.query("SELECT m.id,m.message,m.created_at,CASE WHEN u.roles=ANY($3::text[]) THEN 'platform' ELSE 'tenant' END AS author FROM platform_support_messages m JOIN users u ON u.id=m.actor_id WHERE m.ticket_id=$1 AND m.tenant_id::text=$2 ORDER BY m.created_at DESC,m.id DESC LIMIT $4 OFFSET $5",[ticket,tenant,Object.entries(registry.roles).filter(([,scope])=>scope==='global').map(([role])=>role),registry.historyPolicy.pageSize,offset])).rows;
 return rows.map(messageRow);
}
export async function deadlinePage(db:Client,tenant:string,ticket:string,offset=0):Promise<DeadlineEvent[]>{
 const rows=(await db.query("SELECT id,action,state,created_at FROM platform_bundle_audit WHERE target_id=$1 AND tenant_id::text=$2 AND action LIKE 'tickets_%' ORDER BY (state->'current'->>'version')::int DESC NULLS LAST,created_at DESC,id DESC LIMIT $3 OFFSET $4",[ticket,tenant,registry.historyPolicy.pageSize,offset])).rows;
 return rows.map(deadlineRow);
}
export async function launchPage(db:Client,tenant:string,offset=0):Promise<LaunchEvent[]>{
 const rows=(await db.query("SELECT id,action,evidence,created_at FROM platform_bundle_audit WHERE tenant_id::text=$1 AND action LIKE 'launch_%' ORDER BY (state->>'version')::int DESC NULLS LAST,created_at DESC,id DESC LIMIT $2 OFFSET $3",[tenant,registry.historyPolicy.pageSize,offset])).rows;
 return rows.map(launchEvent);
}
export async function readHistory(db:Client,tenant:string,global:boolean,kind:string,ticket:string|null,offset:number):Promise<BundleHistory>{
 if(ticket&&!optionalRow((await db.query('SELECT id FROM platform_support_tickets WHERE id=$1 AND tenant_id::text=$2',[ticket,tenant])).rows))fail(404,'not_found');
 const limit=registry.historyPolicy.pageSize;
 // Table/condition choices are internal constants; all identifiers and offsets are parameters.
 const count=async(sql:string,values:unknown[])=>Number(requiredRow((await db.query(sql,values)).rows).total);
 let total=0;
 if(kind==='documents')total=await count('SELECT COUNT(*)::int AS total FROM platform_documents WHERE tenant_id::text=$1',[tenant]);
 else if(kind==='messages')total=await count('SELECT COUNT(*)::int AS total FROM platform_support_messages WHERE tenant_id::text=$1 AND ticket_id=$2',[tenant,ticket]);
 else total=await count("SELECT COUNT(*)::int AS total FROM platform_bundle_audit WHERE tenant_id::text=$1 AND (($2='launch' AND action LIKE 'launch_%') OR ($2='deadlines' AND target_id=$3 AND action LIKE 'tickets_%'))",[tenant,kind,ticket]);
 const base={tenantId:tenant,ticketId:ticket,pagination:{offset,limit,total,hasMore:offset+limit<total}};
 if(kind==='documents')return {...base,kind,items:await documentPage(db,tenant,global,offset)};
 if(kind==='messages')return {...base,kind,items:await messagePage(db,tenant,ticket!,offset)};
 if(kind==='deadlines')return {...base,kind,items:await deadlinePage(db,tenant,ticket!,offset)};
 return {...base,kind:'launch',items:await launchPage(db,tenant,offset)};
}
