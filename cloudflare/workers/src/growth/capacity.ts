import {capacityBody} from '../../../../packages/shared/src/growth/capacity';
import {GrowthPolicy,registry,fail} from '../../../../packages/shared/src/growth/contract';
import {requiredRow,optionalRow} from '../database-results';
import type {GrowthRepository} from './repository';

export async function capacityReady(repo:GrowthRepository){return requiredRow((await repo.db.query("SELECT to_regclass('growth_campaign_capacity') IS NOT NULL AS ready")).rows).ready===true;}

export async function confirmCapacity(repo:GrowthRepository,id:string,body:Record<string,unknown>){
 const {db,actor}=repo,scope=actor.tenant_id;
 if(!GrowthPolicy.ownerAuthority(actor))fail(403,'forbidden');const v=capacityBody(body);
 if(!await capacityReady(repo))fail(503,'unavailable');
 const campaign=optionalRow((await db.query('SELECT source,budget_cents FROM growth_campaigns WHERE id=$1 AND tenant_id::text=$2 FOR SHARE',[id,scope])).rows);
 if(!campaign)fail(404,'not_found');if(!registry.capacityPolicy.sources.includes(String(campaign.source)))fail(400);
 await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-brief:'+scope+':'+id]);
 const brief=optionalRow((await db.query('SELECT version,status,pipeline,end_date::text AS end FROM growth_campaign_briefs WHERE tenant_id::text=$1 AND campaign_id=$2 FOR UPDATE',[scope,id])).rows);
 if(!brief)fail(404,'not_found');if(brief.version!==v.briefVersion||brief.status!=='approved'||brief.pipeline!=='client'||Date.parse(String(brief.end)+'T23:59:59.999Z')<Date.now())fail(409,'conflict');
 const approval=optionalRow((await db.query("SELECT id FROM growth_campaign_reviews WHERE tenant_id::text=$1 AND campaign_id=$2 AND result_version=$3 AND action='approve' AND actor_role=ANY($4::text[]) AND snapshot->'campaignBudget'->>'budgetCents'=$5 LIMIT 1",[scope,id,brief.version,registry.capacityPolicy.roles,String(campaign.budget_cents)])).rows);if(!approval)fail(409,'conflict');
 const previous=optionalRow((await db.query('SELECT version FROM growth_campaign_capacity WHERE tenant_id::text=$1 AND campaign_id=$2 ORDER BY version DESC LIMIT 1',[scope,id])).rows);
 if((previous?.version??0)!==v.version)fail(409,'conflict');
 await db.query('INSERT INTO growth_campaign_capacity(id,tenant_id,campaign_id,actor_id,brief_version,version,client_slots,expires_at,evidence) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)',[crypto.randomUUID(),scope,id,actor.id,v.briefVersion,v.version+1,v.clientSlots,v.expiresAt,v.evidence]);
 await repo.audit('campaign_capacity_recorded',id,v.evidence);return {id,version:v.version+1};
}
