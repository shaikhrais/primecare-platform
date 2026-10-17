import type {Client} from 'pg';
import {registry} from '../../../../packages/shared/src/platform-bundle/contract';
import {keys,text,date,fail} from '../../../../packages/shared/src/growth/contract';
import {requiredRow,optionalRow} from '../database-results';
export function documentBody(body:Record<string,unknown>){
 keys(body,['kind','expiresOn','filename','mediaType','contentBase64']);
 if(!registry.documentKinds.includes(String(body.kind))||!text(body.filename,150)||! /^[A-Za-z0-9][A-Za-z0-9_. -]{0,149}$/.test(String(body.filename))||!['application/pdf','image/png','image/jpeg'].includes(String(body.mediaType)))fail(400);
 const expires=date(body.expiresOn),base64=body.contentBase64;
 if(typeof base64!=='string'||base64.length>Math.ceil(registry.maxFileBytes/3)*4||base64.length%4!==0||! /^[A-Za-z0-9+/]*={0,2}$/.test(base64))fail(400);
 let binary:string;try{binary=atob(base64 as string);}catch{fail(400);}
 if(btoa(binary!)!==base64)fail(400);const bytes=Uint8Array.from(binary!,v=>v.charCodeAt(0));if(!bytes.length||bytes.length>registry.maxFileBytes)fail(400);
 const starts=(prefix:number[])=>prefix.every((n,i)=>bytes[i]===n);
 if(body.mediaType==='application/pdf'&&!starts([37,80,68,70,45])||body.mediaType==='image/png'&&!starts([137,80,78,71,13,10,26,10])||body.mediaType==='image/jpeg'&&!starts([255,216,255]))fail(400);
 return {kind:String(body.kind),expires,filename:String(body.filename),mediaType:String(body.mediaType),bytes};
}
export async function uploadDocument(db:Client,tenantId:string,actorId:string,body:Record<string,unknown>){
 const v=documentBody(body);const today=requiredRow((await db.query("SELECT (NOW() AT TIME ZONE 'America/Toronto')::date::text AS today")).rows).today;if(v.expires<String(today))fail(400);
 const next=requiredRow((await db.query('SELECT COALESCE(MAX(revision),0)+1 AS n FROM platform_documents WHERE tenant_id::text=$1 AND kind=$2',[tenantId,v.kind])).rows);
 const hash=[...new Uint8Array(await crypto.subtle.digest('SHA-256',v.bytes))].map(b=>b.toString(16).padStart(2,'0')).join('');const id=crypto.randomUUID();
 await db.query('INSERT INTO platform_documents(id,tenant_id,kind,revision,filename,media_type,content,content_hash,expires_on,uploaded_by) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',[id,tenantId,v.kind,next.n,v.filename,v.mediaType,v.bytes,hash,v.expires,actorId]);
 return {id,version:1,revision:next.n};
}
export async function reviewDocument(db:Client,tenantId:string,id:string,actorId:string,body:Record<string,unknown>){
 keys(body,['version','decision','evidence']);if(!Number.isSafeInteger(body.version)||Number(body.version)<1||!['approved','rejected'].includes(String(body.decision))||!text(body.evidence,500))fail(400);
 const row=optionalRow((await db.query('SELECT id,version,status,revision,kind FROM platform_documents WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenantId])).rows);if(!row)fail(404,'not_found');if(row.version!==body.version||row.status!=='pending')fail(409,'conflict');
 const latest=requiredRow((await db.query('SELECT MAX(revision) AS n FROM platform_documents WHERE tenant_id::text=$1 AND kind=$2',[tenantId,row.kind])).rows);if(latest.n!==row.revision)fail(409,'conflict');
 await db.query('UPDATE platform_documents SET status=$1,reviewed_by=$2,review_evidence=$3,version=version+1 WHERE id=$4',[body.decision,actorId,body.evidence,id]);return {id,version:Number(row.version)+1};
}
