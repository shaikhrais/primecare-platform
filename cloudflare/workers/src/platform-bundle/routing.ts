import type {Client} from 'pg';
import {registry,type BundleActor} from '../../../../packages/shared/src/platform-bundle/contract';
import territoryRegistry from '../../../../packages/shared/src/territories/registry.json';
import {keys,text,fail} from '../../../../packages/shared/src/growth/contract';
import {sha256} from '../auth';
import {optionalRow} from '../database-results';
import {matchesCatalog} from '../territories/service';
import {launchState} from './launch';
export async function matchTerritory(db:Client,fsa:string,service:string){
 const candidates=territoryRegistry.catalog.filter(c=>c.fsas.includes(fsa));if(candidates.length>1)throw Error('Ambiguous territory');
 const match=candidates[0];if(!match||match.is_reserve)return {territoryId:null,tenantId:null,reason:'no_territory'};
 const stored=optionalRow((await db.query('SELECT * FROM platform_territory_catalog WHERE id=$1',[match.id])).rows);if(!stored||!matchesCatalog(stored))throw Error('Catalog mismatch');
 const sale=optionalRow((await db.query('SELECT tenant_id,services FROM platform_territory_sales WHERE territory_id=$1 FOR SHARE',[match.id])).rows);
 if(!sale)return {territoryId:match.id,tenantId:null,reason:'no_territory'};
 if(!Array.isArray(sale.services)||!sale.services.includes(service))return {territoryId:match.id,tenantId:null,reason:'service_unavailable'};
 const active=optionalRow((await db.query("SELECT id FROM tenants WHERE id::text=$1 AND LOWER(status)='active' FOR UPDATE",[String(sale.tenant_id)])).rows);
 if(!active||(await launchState(db,String(sale.tenant_id),false)).state!=='approved')return {territoryId:match.id,tenantId:null,reason:'tenant_not_ready'};
 return {territoryId:match.id,tenantId:String(sale.tenant_id),reason:'offered'};
}
export async function routeCommand(db:Client,actor:BundleActor,global:boolean,id:string|undefined,body:Record<string,unknown>){
 // All enquiry writes serialize on one inexpensive advisory lock. No contact is delivered twice.
 await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['platform-enquiry-routing']);
 if(!id){if(!global)fail(403,'forbidden');const result=await captureTerritoryEnquiry(db,body,actor.id);return {id:result.id,version:result.version};}
 keys(body,['version','action','evidence']);if(!Number.isSafeInteger(body.version)||Number(body.version)<1||!['accept','decline','reroute','withdraw'].includes(String(body.action))||!text(body.evidence,500))fail(400);
 const row=optionalRow((await db.query('SELECT *,offer_due>NOW() AS current FROM platform_routed_enquiries WHERE id=$1'+(global?'':' AND tenant_id::text=$2')+' FOR UPDATE',global?[id]:[id,actor.tenant_id])).rows);if(!row)fail(404,'not_found');if(row.version!==body.version||row.status==='withdrawn')fail(409,'conflict');
 if(body.action==='reroute'){
  if(!global)fail(403,'forbidden');if(row.status==='accepted'||row.status==='pending'&&row.current)fail(409,'routing_conflict');
  const match=await matchTerritory(db,String(row.fsa),String(row.service));
  await db.query("UPDATE platform_routed_enquiries SET territory_id=$1,tenant_id=$2,status=$3,reason=$4,offer_due=CASE WHEN $3='pending' THEN NOW()+$5*INTERVAL '1 hour' ELSE NULL END,version=version+1 WHERE id=$6",[match.territoryId,match.tenantId,match.tenantId?'pending':'unmatched',match.reason,registry.offerHours,id]);
 }else if(body.action==='withdraw'){
  if(!global)fail(403,'forbidden');
  if(row.lead_id){await db.query('UPDATE growth_leads SET contact_blocked=TRUE,due_at=NULL,version=version+1 WHERE id=$1 AND tenant_id::text=$2',[row.lead_id,String(row.tenant_id)]);}
  await db.query("UPDATE platform_routed_enquiries SET status='withdrawn',version=version+1 WHERE id=$1",[id]);
 }else{
  // Only the receiving tenant administrator can accept/decline an offer.
  if(global||String(row.tenant_id)!==actor.tenant_id)fail(403,'forbidden');if(row.status!=='pending'||!row.current)fail(409,'routing_conflict');
  if(body.action==='decline')await db.query("UPDATE platform_routed_enquiries SET status='declined',version=version+1 WHERE id=$1",[id]);
  else{
   const match=await matchTerritory(db,String(row.fsa),String(row.service));if(match.tenantId!==actor.tenant_id||match.territoryId!==row.territory_id)fail(409,'routing_conflict');
   // Use the same tenant intake advisory lock as public enquiries; duplicates/opt-outs are never overwritten.
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['enquiry:'+actor.tenant_id+':client']);
   const duplicate=optionalRow((await db.query("SELECT id FROM growth_leads WHERE tenant_id::text=$1 AND pipeline='client' AND (contact_hash=$2 OR ($3<>'' AND LOWER(email)=$3) OR ($4<>'' AND regexp_replace(phone,'[^0-9]','','g')=$4)) LIMIT 1",[actor.tenant_id,row.contact_hash,row.email,String(row.phone).replace(/\D/g,'')])).rows);if(duplicate)fail(409,'routing_conflict');
   const leadId=crypto.randomUUID();await db.query("INSERT INTO growth_leads(id,tenant_id,pipeline,name,email,phone,source,reference,contact_basis,contact_hash,owner_id,due_at) VALUES($1,$2,'client',$3,$4,$5,$9,$6,'requested',$7,$8,NOW()+INTERVAL '1 day')",[leadId,actor.tenant_id,row.name,row.email,row.phone,(row.origin_link_id?'Intake '+row.origin_link_id+': '+row.attribution+'; ':'')+'Territory enquiry '+id,row.contact_hash,actor.id,row.source??'referral']);
   await db.query("INSERT INTO growth_milestones(tenant_id,lead_id,stage,evidence) VALUES($1,$2,'new',$3)",[actor.tenant_id,leadId,'Territory enquiry '+id+'; sharing consent recorded']);
   await db.query("UPDATE platform_routed_enquiries SET status='accepted',accepted_by=$1,lead_id=$2,version=version+1 WHERE id=$3",[actor.id,leadId,id]);
  }
 }
 return {id,version:Number(row.version)+1};
}

/** Shared API capture; anonymous submissions have no invented human actor. */
export async function captureTerritoryEnquiry(db:Client,body:Record<string,unknown>,actorId:string|null,origin?:{linkId:string;source:string;attribution:string}){
 await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['platform-enquiry-routing']);
 keys(body,['name','email','phone','postalCode','service','consent','confirmed']);
  const email=String(body.email??'').trim().toLowerCase(),phone=String(body.phone??'').trim(),digits=phone.replace(/\D/g,''),postal=String(body.postalCode??'').toUpperCase().replace(/\s/g,'');
  if(!text(body.name,150)||!text(body.consent,500)||body.confirmed!==true||!registry.services.includes(String(body.service))||! /^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTVWXYZ]\d[ABCEGHJ-NPRSTVWXYZ]\d$/.test(postal)||!email&&!phone||email&&! /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)||email.length>254||phone&&(! /^[+()\d .-]{5,40}$/.test(phone)||digits.length<5))fail(400);
  const hash=await sha256(email||digits);
  const existing=optionalRow((await db.query("SELECT id,version FROM platform_routed_enquiries WHERE contact_hash=$1 OR ($2<>'' AND LOWER(email)=$2) OR ($3<>'' AND regexp_replace(phone,'[^0-9]','','g')=$3) LIMIT 1",[hash,email,digits])).rows);if(existing){if(origin)return {id:String(existing.id),version:Number(existing.version),created:false};fail(409,'routing_conflict');}
  const match=await matchTerritory(db,postal.slice(0,3),String(body.service));const id=crypto.randomUUID();
  await db.query("INSERT INTO platform_routed_enquiries(id,name,email,phone,postal_code,fsa,service,consent,contact_hash,territory_id,tenant_id,status,reason,offer_due,created_by) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,CASE WHEN $12='pending' THEN NOW()+$14*INTERVAL '1 hour' ELSE NULL END,$15)",[id,body.name,email,phone,postal,postal.slice(0,3),body.service,body.consent,hash,match.territoryId,match.tenantId,match.tenantId?'pending':'unmatched',match.reason,registry.offerHours,actorId]);
  if(origin)await db.query('UPDATE platform_routed_enquiries SET source=$1,origin_link_id=$2,attribution=$3 WHERE id=$4',[origin.source,origin.linkId,origin.attribution,id]);
  return {id,version:1,created:true};
}
