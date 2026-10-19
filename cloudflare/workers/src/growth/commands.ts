import {confirmCapacity} from './capacity';
import {businessCommand} from './business';
import {intakeLink} from './intake-links';
import {taskAction} from './tasks';
import {GrowthBriefs} from './briefs';
import {GrowthContacts} from './contacts';
import {GrowthOperations} from './operations';
import {requiredRow,optionalRow} from '../database-results';
import {sha256} from '../auth';
import {GrowthRepository} from './repository';
import {campaignBody,leadBody,patchLead,planBody,taskBody,GrowthPolicy,fail,stages,uuid,integer,type Pipeline} from '../../../../packages/shared/src/growth/contract';
export class GrowthCommands {
 constructor(readonly repo:GrowthRepository){}
 async execute(entity:string,id:string|undefined,method:string,body:Record<string,unknown>){
  if(['onboarding','handoffs','finance'].includes(entity))return businessCommand(this.repo,entity,id,method,body);
  if(entity==='capacity')return confirmCapacity(this.repo,id!,body);
  if(entity==='intake-links')return intakeLink(this.repo,id,method,body);
  if(entity==='task-actions')return taskAction(this.repo,id!,body);
  if(entity==='reviews')return new GrowthBriefs(this.repo).review(id!,body);
  if(entity==='briefs')return new GrowthBriefs(this.repo).save(id!,body);
  if(['contacts','duplicates'].includes(entity))return new GrowthContacts(this.repo).execute(entity,id,body);
  if(['team','calls','appointments'].includes(entity))return new GrowthOperations(this.repo).execute(entity,id,method,body);
  const {db,actor}=this.repo,tenant=actor.tenant_id;
  const saved=(rows:Record<string,unknown>[])=>{if(!rows.length)fail(409,'conflict');const r=requiredRow(rows);if(!uuid(r.id)||typeof r.version!=='number'||r.version<1)throw Error('Invalid mutation');return {id:r.id,version:r.version};};
  if(entity==='plan'){
   GrowthPolicy.plan(actor);const v=planBody(body);
   const old=optionalRow((await db.query('SELECT version FROM growth_plans WHERE tenant_id::text=$1 FOR UPDATE',[tenant])).rows);
   if((old?.version??0)!==v.version)fail(409,'conflict');
   const result=old?await db.query('UPDATE growth_plans SET start_date=$1,end_date=$2,targets=$3,version=version+1 WHERE tenant_id::text=$4 RETURNING version',[v.start,v.end,JSON.stringify(v.targets),tenant]):await db.query('INSERT INTO growth_plans(tenant_id,start_date,end_date,targets) VALUES($1,$2,$3,$4) RETURNING version',[tenant,v.start,v.end,JSON.stringify(v.targets)]);
   const version=requiredRow(result.rows).version;if(version!==v.version+1)throw Error('Invalid plan mutation');await this.repo.audit('plan_saved',tenant);return {version};
  }
  if(entity==='leads'){
   if(method==='POST'){
    const v=leadBody(body),leadId=crypto.randomUUID();const owner=await this.repo.owner(v.ownerId),campaign=await this.repo.campaign(v.campaignId,v.source);
    const contact=(v.email as string)||String(v.phone).replace(/\D/g,'')||String(v.name).toLowerCase().replace(/\s+/g,' ');
    const hash=await sha256(contact);
    const result=saved((await db.query('INSERT INTO growth_leads(id,tenant_id,pipeline,name,email,phone,source,reference,contact_basis,contact_hash,campaign_id,owner_id,due_at) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13) RETURNING id,version',[leadId,tenant,v.pipeline,v.name,v.email,v.phone,v.source,v.reference,v.contactBasis,hash,campaign,owner,v.dueAt])).rows);
    await db.query('INSERT INTO growth_milestones(tenant_id,lead_id,stage,evidence) VALUES($1,$2,$3,$4)',[tenant,leadId,'new',v.reference]);await this.repo.audit('lead_created',leadId);return result;
   }
   const v=patchLead(body);const old=optionalRow((await db.query('SELECT pipeline,stage,version FROM growth_leads WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenant])).rows);if(!old)fail(404,'not_found');
   if(old!.version!==v.version)fail(409,'conflict');
   const next=GrowthPolicy.next(old!.pipeline as Pipeline,old!.stage as string);
   if(old!.stage==='lost'||v.stage!==old!.stage&&v.stage!=='lost'&&v.stage!==next)fail(400);
   const owner=await this.repo.owner(v.ownerId);
   const result=saved((await db.query('UPDATE growth_leads SET stage=$1,owner_id=$2,due_at=$3,version=version+1 WHERE id=$4 AND tenant_id::text=$5 RETURNING id,version',[v.stage,owner,v.dueAt,id,tenant])).rows);
   if(v.stage!=='lost')await db.query('INSERT INTO growth_milestones(tenant_id,lead_id,stage,evidence) VALUES($1,$2,$3,$4) ON CONFLICT(tenant_id,lead_id,stage) DO NOTHING',[tenant,id,v.stage,v.evidence]);
   await this.repo.audit('lead_updated',id!,v.evidence as string);return result;
  }
  if(entity==='campaigns'){
   const v=campaignBody(body,method==='PATCH');let previousBudget:unknown;
   if(!GrowthPolicy.ownerAuthority(actor)&&(method==='PATCH'||v.budgetCents!==0||v.spendCents!==0))fail(403,'forbidden');
   if(method==='POST')GrowthPolicy.campaign(actor,v.source);else{const old=optionalRow((await db.query('SELECT source,budget_cents FROM growth_campaigns WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenant])).rows);if(!old)fail(404,'not_found');GrowthPolicy.campaign(actor,old!.source);previousBudget=old!.budget_cents;}
   const result=method==='POST'?saved((await db.query('INSERT INTO growth_campaigns(id,tenant_id,name,source,reference,budget_cents,spend_cents) VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING id,version',[crypto.randomUUID(),tenant,String(v.name).trim(),v.source,v.reference,v.budgetCents,v.spendCents])).rows):saved((await db.query('UPDATE growth_campaigns SET budget_cents=$1,spend_cents=$2,version=version+1 WHERE id=$3 AND tenant_id::text=$4 AND version=$5 RETURNING id,version',[v.budgetCents,v.spendCents,id,tenant,v.version])).rows);
   if(method==='PATCH'&&String(previousBudget)!==String(v.budgetCents)){
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-brief:'+tenant+':'+id]);
    const invalidated=(await db.query("UPDATE growth_campaign_briefs SET status='draft',version=version+1,updated_at=NOW() WHERE tenant_id::text=$1 AND campaign_id=$2 RETURNING version",[tenant,id])).rows;
    if(invalidated.length)await this.repo.audit('campaign_budget_review_reset',id!);
   }
   await this.repo.audit(method==='POST'?'campaign_created':'campaign_updated',result.id as string);return result;
  }
  if(entity==='tasks'){
   const v=taskBody(body,method==='PATCH');
   if(method==='PATCH'){const old=optionalRow((await db.query('SELECT owner_id FROM growth_tasks WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenant])).rows);if(!old)fail(404,'not_found');if(GrowthPolicy.staff(actor)&&String(old!.owner_id)!==actor.id)fail(404,'not_found');}
   const result=method==='POST'?saved((await db.query('INSERT INTO growth_tasks(id,tenant_id,name,owner_id,due_at) VALUES($1,$2,$3,$4,$5) RETURNING id,version',[crypto.randomUUID(),tenant,String(v.name).trim(),await this.repo.owner(v.ownerId),v.dueAt])).rows):saved((await db.query("UPDATE growth_tasks SET status='done',completed_at=NOW(),evidence=$1,version=version+1 WHERE id=$2 AND tenant_id::text=$3 AND version=$4 AND status='open' RETURNING id,version",[v.evidence,id,tenant,v.version])).rows);
   await this.repo.audit(method==='POST'?'task_created':'task_completed',result.id as string);return result;
  }
  fail(404,'not_found');
 }
}
