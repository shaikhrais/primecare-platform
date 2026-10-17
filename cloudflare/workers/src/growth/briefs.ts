import {capacityReady} from './capacity';
import {campaignReadiness} from '../../../../packages/shared/src/growth/capacity';
import {reviewBody,reviewActions,reviewNext,type ReviewState} from '../../../../packages/shared/src/growth/reviews';
import {requiredRow,optionalRow} from '../database-results';
import {GrowthPolicy,fail,registry} from '../../../../packages/shared/src/growth/contract';
import {briefBody} from '../../../../packages/shared/src/growth/briefs';
import type {GrowthRepository} from './repository';
export class GrowthBriefs {
 constructor(readonly repo:GrowthRepository){}
 async save(id:string,body:Record<string,unknown>){
  const {db,actor}=this.repo,tenant=actor.tenant_id,v=briefBody(body);
  const campaign=optionalRow((await db.query('SELECT source FROM growth_campaigns WHERE id=$1 AND tenant_id::text=$2 FOR SHARE',[id,tenant])).rows);
  if(!campaign)fail(404,'not_found');GrowthPolicy.campaign(actor,campaign!.source);
  // The campaign-scoped key also serializes initial inserts, before a brief row exists.
  await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-brief:'+tenant+':'+id]);
  const previous=optionalRow((await db.query('SELECT owner_id,version,status FROM growth_campaign_briefs WHERE tenant_id::text=$1 AND campaign_id=$2 FOR UPDATE',[tenant,id])).rows);
  if(previous?.status==='pending_review')fail(409,'conflict');
  if((previous?.version??0)!==v.version)fail(409,'conflict');
  if(GrowthPolicy.staff(actor)&&(v.ownerId!==actor.id||previous&&String(previous.owner_id)!==actor.id))fail(403,'forbidden');
  const owner=optionalRow((await db.query("SELECT id,roles FROM users WHERE id::text=$1 AND tenant_id::text=$2 AND LOWER(status)='active' FOR SHARE",[v.ownerId,tenant])).rows);
  if(!owner||!GrowthPolicy.canOwnCampaign(String(owner.roles),String(campaign!.source)))fail(400);
  const result=requiredRow((await db.query('INSERT INTO growth_campaign_briefs(tenant_id,campaign_id,owner_id,audience,offer,creative,landing_url,pipeline,target_leads,start_date,end_date) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) ON CONFLICT(tenant_id,campaign_id) DO UPDATE SET owner_id=EXCLUDED.owner_id,audience=EXCLUDED.audience,offer=EXCLUDED.offer,creative=EXCLUDED.creative,landing_url=EXCLUDED.landing_url,pipeline=EXCLUDED.pipeline,target_leads=EXCLUDED.target_leads,start_date=EXCLUDED.start_date,end_date=EXCLUDED.end_date,status=\'draft\',version=growth_campaign_briefs.version+1,updated_at=NOW() RETURNING version',[tenant,id,v.ownerId,v.audience,v.offer,v.creative,v.landingUrl,v.pipeline,v.targetLeads,v.start,v.end])).rows);
  if(result.version!==v.version+1)throw Error('Invalid brief version');
  await this.repo.audit('campaign_brief_saved',id);return {id,version:result.version};
 }
 async review(id:string,body:Record<string,unknown>){
  const {db,actor}=this.repo,tenant=actor.tenant_id,v=reviewBody(body);
  const campaign=optionalRow((await db.query('SELECT source,budget_cents,version FROM growth_campaigns WHERE id=$1 AND tenant_id::text=$2 FOR SHARE',[id,tenant])).rows);
  if(!campaign)fail(404,'not_found');GrowthPolicy.campaign(actor,campaign!.source);
  await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-brief:'+tenant+':'+id]);
  const brief=optionalRow((await db.query('SELECT * FROM growth_campaign_briefs WHERE tenant_id::text=$1 AND campaign_id=$2 FOR UPDATE',[tenant,id])).rows);
  if(!brief)fail(404,'not_found');
  if(brief!.version!==v.version)fail(409,'conflict');
  if(!reviewActions(actor,String(brief!.owner_id),brief!.status as ReviewState).includes(v.action))fail(403,'forbidden');
  const version=v.version+1;
  await db.query('UPDATE growth_campaign_briefs SET status=$1,version=$2,updated_at=NOW() WHERE tenant_id::text=$3 AND campaign_id=$4',[reviewNext(v.action),version,tenant,id]);
  const selfReview=['approve','request_changes','reject'].includes(v.action)&&String(brief!.owner_id)===actor.id;
  await db.query('INSERT INTO growth_campaign_reviews(id,tenant_id,campaign_id,actor_id,actor_role,action,brief_version,result_version,evidence,self_review,snapshot) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)',[crypto.randomUUID(),tenant,id,actor.id,actor.roles,v.action,v.version,version,v.evidence,selfReview,JSON.stringify({...brief,campaignBudget:{budgetCents:String(campaign.budget_cents),campaignVersion:campaign.version,currency:registry.businessPolicy.currency}})]);
  await this.repo.audit('campaign_review_'+v.action,id,v.evidence);
  return {id,version};
 }

}
export async function decorateBriefs(repo:GrowthRepository,campaigns:any[],owners:any[]){
 if(!campaigns.length)return [];
 const briefs=(await repo.db.query('SELECT campaign_id,owner_id,audience,offer,creative,landing_url,pipeline,target_leads,start_date::text AS start,end_date::text AS end,version,status,updated_at FROM growth_campaign_briefs WHERE tenant_id::text=$1 AND campaign_id=ANY($2::uuid[])',[repo.actor.tenant_id,campaigns.map(c=>c.id)])).rows;
 const history=(await repo.db.query("SELECT campaign_id,actor_id,actor_role,action,brief_version,result_version,evidence,self_review,created_at,snapshot->'campaignBudget'->>'budgetCents' AS reviewed_budget FROM growth_campaign_reviews WHERE tenant_id::text=$1 AND campaign_id=ANY($2::uuid[]) ORDER BY created_at DESC,id",[repo.actor.tenant_id,campaigns.map(c=>c.id)])).rows;
 const schemaReady=await capacityReady(repo);
 const capacities=schemaReady?(await repo.db.query("SELECT DISTINCT ON (c.campaign_id) c.campaign_id,c.actor_id,c.brief_version,c.version,c.client_slots,c.expires_at,(LOWER(u.status)='active' AND u.tenant_id=c.tenant_id) AS actor_active,u.roles AS actor_role FROM growth_campaign_capacity c LEFT JOIN users u ON u.id=c.actor_id WHERE c.tenant_id::text=$1 AND c.campaign_id=ANY($2::uuid[]) ORDER BY c.campaign_id,c.version DESC",[repo.actor.tenant_id,campaigns.map(c=>c.id)])).rows:[];
 return campaigns.map(c=>{const brief=briefs.find(b=>b.campaign_id===c.id)??null,staff=GrowthPolicy.staff(repo.actor);const ownerApproved=!!brief&&history.some(h=>h.campaign_id===c.id&&h.action==='approve'&&h.result_version===brief.version&&registry.capacityPolicy.roles.includes(String(h.actor_role))&&String(h.reviewed_budget)===String(c.budget_cents));return {...c,brief,readiness:registry.capacityPolicy.sources.includes(c.source)?campaignReadiness(c,brief?{...brief,ownerApproved}:null,capacities.find(row=>row.campaign_id===c.id),schemaReady,GrowthPolicy.ownerAuthority(repo.actor)):null,briefReadOnlyReason:brief?.status==='pending_review'?'review_locked':'brief_owned_elsewhere',reviewActions:brief?reviewActions(repo.actor,String(brief.owner_id),brief.status as ReviewState):[],reviewHistory:history.filter(h=>h.campaign_id===c.id),canEditBrief:GrowthPolicy.capabilities(repo.actor).editBrief&&brief?.status!=='pending_review'&&(!staff||!brief||String(brief.owner_id)===repo.actor.id),briefOwners:owners.filter(o=>GrowthPolicy.canOwnCampaign(o.roles,c.source))};});
}
