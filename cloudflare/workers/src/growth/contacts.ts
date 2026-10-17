import {optionalRow,requiredRow} from '../database-results';
import {sha256} from '../auth';
import {GrowthPolicy,fail} from '../../../../packages/shared/src/growth/contract';
import {contactBody,contactIdentity,duplicateBody,shareContact} from '../../../../packages/shared/src/growth/contacts';
import type {GrowthRepository} from './repository';
export class GrowthContacts {
 constructor(readonly repo:GrowthRepository){}
 async execute(entity:string,id:string|undefined,body:Record<string,unknown>){
  const {db,actor}=this.repo,tenant=actor.tenant_id;
  if(entity==='contacts'){
   const v=contactBody(body);const old=optionalRow((await db.query('SELECT owner_id,version,duplicate_of FROM growth_leads WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenant])).rows);
   if(!old)fail(404,'not_found');GrowthPolicy.lead(actor,old!.owner_id);if(old!.version!==v.version)fail(409,'conflict');if(old!.duplicate_of)fail(409,'conflict');
   const hash=await sha256(contactIdentity(v));
   const result=requiredRow((await db.query('UPDATE growth_leads SET name=$1,email=$2,phone=$3,contact_hash=$4,contact_version=contact_version+1,version=version+1 WHERE id=$5 AND tenant_id::text=$6 RETURNING version',[v.name,v.email,v.phone,hash,id,tenant])).rows);
   await this.repo.audit('contact_corrected',id!,String(v.evidence));return {id,version:result.version};
  }
  const v=duplicateBody(body),ids=[v.canonicalId,v.duplicateId].sort();
  const rows=(await db.query('SELECT id,name,email,phone,pipeline,version,contact_version,duplicate_of,contact_blocked FROM growth_leads WHERE tenant_id::text=$1 AND id=ANY($2::uuid[]) ORDER BY id FOR UPDATE',[tenant,ids])).rows;
  if(rows.length!==2)fail(404,'not_found');const keep=rows.find(l=>l.id===v.canonicalId)!,duplicate=rows.find(l=>l.id===v.duplicateId)!;
  if(keep.version!==v.canonicalVersion||duplicate.version!==v.duplicateVersion)fail(409,'conflict');
  if(keep.duplicate_of||duplicate.duplicate_of||keep.pipeline!==duplicate.pipeline||!shareContact(keep,duplicate))fail(400);
  const previous=optionalRow((await db.query('SELECT version FROM growth_duplicate_reviews WHERE tenant_id::text=$1 AND lead_a=$2 AND lead_b=$3 FOR UPDATE',[tenant,...ids])).rows);
  if((previous?.version??0)!==v.reviewVersion)fail(409,'conflict');
  if(v.decision==='duplicate_confirmed'){
   // Do not create a duplicate chain: keep earlier dependent records attached to their chosen original.
   if((await db.query('SELECT id FROM growth_leads WHERE tenant_id::text=$1 AND duplicate_of=$2 LIMIT 1',[tenant,v.duplicateId])).rows.length)fail(409,'conflict');
   if(duplicate.contact_blocked&&!keep.contact_blocked)await db.query('UPDATE growth_leads SET contact_blocked=TRUE,due_at=NULL,version=version+1 WHERE tenant_id::text=$1 AND id=$2',[tenant,v.canonicalId]);
   await db.query("UPDATE growth_leads SET duplicate_of=$1,stage='lost',contact_blocked=TRUE,due_at=NULL,version=version+1 WHERE tenant_id::text=$2 AND id=$3",[v.canonicalId,tenant,v.duplicateId]);
  }
  const result=requiredRow((await db.query('INSERT INTO growth_duplicate_reviews(tenant_id,lead_a,lead_b,a_version,b_version,decision,evidence,actor_id) VALUES($1,$2,$3,$4,$5,$6,$7,$8) ON CONFLICT(tenant_id,lead_a,lead_b) DO UPDATE SET a_version=EXCLUDED.a_version,b_version=EXCLUDED.b_version,decision=EXCLUDED.decision,evidence=EXCLUDED.evidence,actor_id=EXCLUDED.actor_id,version=growth_duplicate_reviews.version+1,reviewed_at=NOW() RETURNING version',[tenant,...ids,rows[0].contact_version,rows[1].contact_version,v.decision,v.evidence,actor.id])).rows);
  await this.repo.audit('duplicate_reviewed',v.duplicateId,String(v.decision));return {id:v.duplicateId,version:result.version};
 }
}
