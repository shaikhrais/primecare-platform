import {canManageIntake,canReceiveEnquiry,intakeLinkBody} from '../../../../packages/shared/src/growth/intake';
import {fail} from '../../../../packages/shared/src/growth/contract';
import {requiredRow} from '../database-results';
import type {GrowthRepository} from './repository';
export async function intakeLink(repo:GrowthRepository,id:string|undefined,method:string,body:Record<string,unknown>){
 if(!canManageIntake(repo.actor))fail(403,'forbidden');const v=intakeLinkBody(body,method==='PATCH'),{db,actor}=repo;
 if(method==='PATCH'){
  const rows=(await db.query('UPDATE growth_intake_links SET active=$1,version=version+1 WHERE id=$2 AND tenant_id::text=$3 AND version=$4 RETURNING id,version',[v.active,id,actor.tenant_id,v.version])).rows;
  if(!rows.length)fail(409,'conflict');const result=requiredRow(rows);await repo.audit('intake_link_status',id!,String(v.active));return {id:result.id,version:result.version};
 }
 const owner=await repo.owner(v.ownerId);const ownerRole=requiredRow((await db.query('SELECT roles FROM users WHERE id::text=$1 FOR SHARE',[owner])).rows);if(!canReceiveEnquiry(String(ownerRole.roles)))fail(400);
 const campaign=await repo.campaign(v.campaignId,v.source),newId=crypto.randomUUID(),publicKey=crypto.randomUUID().replaceAll('-','')+crypto.randomUUID().replaceAll('-','');
 // 244 random bits after UUID version/variant markers; this is a shareable route key, not a user session.
 const fields=[newId,actor.tenant_id,owner,campaign,v.pipeline,String(v.name).trim(),publicKey,v.source,v.attribution];
 if(v.routingMode==='territory')await db.query('INSERT INTO growth_intake_links(id,tenant_id,owner_id,campaign_id,pipeline,name,public_key,source,attribution,routing_mode) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',[...fields,v.routingMode]);
 else await db.query('INSERT INTO growth_intake_links(id,tenant_id,owner_id,campaign_id,pipeline,name,public_key,source,attribution) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)',fields);
 await repo.audit('intake_link_created',newId);return {id:newId,version:1};
}
export async function intakeLinks(repo:GrowthRepository){const links=canManageIntake(repo.actor)?(await repo.db.query(`SELECT COALESCE(to_jsonb(l)->>'routing_mode','direct') AS routing_mode,l.id,l.name,l.pipeline,l.owner_id,l.campaign_id,l.public_key,l.active,l.version,l.source,l.attribution,(SELECT COUNT(*)::int FROM growth_intake_receipts r WHERE r.link_id=l.id) AS receipts,(SELECT COUNT(*)::int FROM growth_intake_receipts r WHERE r.link_id=l.id AND r.new_lead=TRUE) AS new_leads,(SELECT COUNT(*)::int FROM growth_intake_receipts r WHERE r.link_id=l.id AND r.new_lead=FALSE) AS repeats,(SELECT COUNT(*)::int FROM growth_intake_receipts r WHERE r.link_id=l.id AND r.new_lead IS NULL) AS legacy_receipts FROM growth_intake_links l WHERE l.tenant_id::text=$1 ORDER BY l.created_at DESC,l.id LIMIT 100`,[repo.actor.tenant_id])).rows:[];
 const routed=links.filter(l=>l.routing_mode==='territory');
 if(routed.length){const counts=(await repo.db.query('SELECT link_id,COUNT(*)::int AS receipts FROM growth_territory_receipts WHERE tenant_id::text=$1 AND link_id=ANY($2::uuid[]) GROUP BY link_id',[repo.actor.tenant_id,routed.map(l=>l.id)])).rows;
  for(const link of routed)Object.assign(link,counts.find(c=>c.link_id===link.id)??{receipts:0},{new_leads:null,repeats:null,legacy_receipts:0});
 }
 return links;}
