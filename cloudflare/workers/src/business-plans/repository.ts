import type {Client} from 'pg';
import {instantiateTemplate,lessonData,applyPatch} from '../../../../packages/shared/src/business-plans/template-learning.mjs';
import {changeCycle} from '../../../../packages/shared/src/business-plans/execution.mjs';
import {manager,globalManager,publisher,publicCycle,businessRoles,managers,authorizeAction,loopSummary} from '../../../../packages/shared/src/business-plans/policy.mjs';
import {fail,uuid,type Actor} from '../../../../packages/shared/src/growth/contract';
const text=(v:unknown,max=2000)=>{if(typeof v!=='string'||!v.trim()||v.length>max)fail(400);return (v as string).trim();};
export class BusinessPlanRepository {
 constructor(readonly db:Client,readonly actor:Actor,readonly scope:string){}
 async audit(action:string,cycle:string|null,detail:unknown){await this.db.query('INSERT INTO business_plan_audit(id,tenant_id,cycle_id,actor_id,action,detail) VALUES($1,$2,$3,$4,$5,$6)',[crypto.randomUUID(),this.scope,cycle,this.actor.id,action,JSON.stringify(detail)]);}
 async cycle(id:unknown,lock=false){if(!uuid(id))fail(400);const row=(await this.db.query('SELECT * FROM business_plan_cycles WHERE id=$1 AND tenant_id=$2'+(lock?' FOR UPDATE':''),[id,this.scope])).rows[0];if(!row||!manager(this.actor)&&!row.data.tasks.some((t:any)=>t.ownerUserId===this.actor.id))fail(404,'not_found');return row;}
 async notice(cycle:string,title:string,message:string,recipient:string|null=null){await this.db.query('INSERT INTO business_plan_notices(id,tenant_id,recipient_id,roles,title,message,cycle_id) VALUES($1,$2,$3,$4,$5,$6,$7)',[crypto.randomUUID(),this.scope,recipient,JSON.stringify(recipient?businessRoles:managers),title,message,cycle]);}
 async list(id?:string){
  const templates=(await this.db.query('SELECT id,flow,family,version,name,published_at,payload FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY flow,family ORDER BY version DESC) AS n FROM business_plan_templates) v WHERE n<=5 ORDER BY flow,family,version DESC')).rows;
  const scopes=globalManager(this.actor)?(await this.db.query("SELECT id::text,name,slug FROM tenants WHERE LOWER(status)='active' ORDER BY name LIMIT 300")).rows:[];
  const rows=id?[await this.cycle(id)]:(await this.db.query('SELECT * FROM business_plan_cycles WHERE tenant_id=$1'+(manager(this.actor)?'':" AND EXISTS(SELECT 1 FROM jsonb_array_elements(data->'tasks') t WHERE t->>'ownerUserId'=$2)")+' ORDER BY created_at DESC,id DESC LIMIT 100',manager(this.actor)?[this.scope]:[this.scope,this.actor.id])).rows;
  const cycles=rows.map((r:any)=>{const p=publicCycle(r,this.actor);return {...p,summary:loopSummary(p.data,new Date().toISOString().slice(0,10))};});
  const members=manager(this.actor)?(await this.db.query("SELECT id::text,email,roles FROM users WHERE tenant_id::text=$1 AND LOWER(status)='active' AND roles=ANY($2::text[]) ORDER BY email LIMIT 300",[this.scope,businessRoles])).rows:[];
  const lessons=manager(this.actor)?(await this.db.query('SELECT id,cycle_id,template_id,data,status,review_reason,published_template_id,created_at FROM business_plan_lessons WHERE '+(publisher(this.actor)?'TRUE':'tenant_id=$1')+' ORDER BY created_at DESC LIMIT 100',publisher(this.actor)?[]:[this.scope])).rows:[];
  const notices=(await this.db.query('SELECT n.id,n.title,n.message,n.cycle_id,(r.user_id IS NOT NULL) AS read FROM business_plan_notices n LEFT JOIN business_plan_notice_reads r ON r.notice_id=n.id AND r.user_id=$1 WHERE (n.tenant_id IS NULL OR n.tenant_id=$2) AND (n.recipient_id IS NULL OR n.recipient_id=$1) AND n.roles ? $3 ORDER BY n.created_at DESC,n.id DESC LIMIT 100',[this.actor.id,this.scope,this.actor.roles])).rows;
  const audit=id?(await this.db.query('SELECT actor_id,action,detail,created_at FROM business_plan_audit WHERE cycle_id=$1 AND tenant_id=$2'+(manager(this.actor)?'':' AND actor_id=$3')+' ORDER BY created_at DESC LIMIT 100',manager(this.actor)?[id,this.scope]:[id,this.scope,this.actor.id])).rows:[];
  const organization=(await this.db.query('SELECT name FROM tenants WHERE id::text=$1',[this.scope])).rows[0]?.name||this.scope;
  return {identity:{userId:this.actor.id,role:this.actor.roles,tenantId:this.scope,organization},canManage:manager(this.actor),canPublish:publisher(this.actor),scopes,templates:manager(this.actor)?templates:[],cycles,members,lessons,notices,audit,limit:100};
 }
 async execute(body:any){const action=body.action,v=body.value||{},now=new Date().toISOString();
  if(action==='acknowledge'){if(!uuid(v.id))fail(400);const accessible=(await this.list()).notices.some((n:any)=>n.id===v.id);if(!accessible)fail(404,'not_found');await this.db.query('INSERT INTO business_plan_notice_reads(notice_id,user_id) VALUES($1,$2) ON CONFLICT DO NOTHING',[v.id,this.actor.id]);return {saved:true};}
  if(action==='create'){
   if(!manager(this.actor))fail(403,'forbidden');if(!uuid(v.templateId))fail(400);const template=(await this.db.query('SELECT * FROM business_plan_templates WHERE id=$1',[v.templateId])).rows[0];if(!template)fail(404,'not_found');if(template.flow==='master'&&!globalManager(this.actor)&&this.actor.roles!=='ceo')fail(403,'forbidden');
   const tenant=(await this.db.query("SELECT name FROM tenants WHERE id::text=$1 AND LOWER(status)='active'",[this.scope])).rows[0];if(!tenant)fail(404,'not_found');
   const d=instantiateTemplate(template,{name:text(v.name,200),organization:tenant.name,tenantCode:'T-'+this.scope.replaceAll('-','').slice(0,20)},now);
   d.tenantContext={baseline:text(v.baseline),capacity:text(v.capacity),ownerConfirmed:false};
   if(v.previousCycleId){const p=await this.cycle(v.previousCycleId);if(p.data.flow!==d.flow)fail(400);d.previousCycle={id:p.id,code:p.data.code,version:p.version,end:p.data.end,goals:p.data.goals.map((g:any)=>({code:g.code,title:g.title,actual:g.actual,target:g.target,hasEvidence:g.updates.length>0})),note:'Prior results are baseline context. New achievements remain zero.'};}
   const id=crypto.randomUUID();await this.db.query('INSERT INTO business_plan_cycles(id,tenant_id,name,data,created_by) VALUES($1,$2,$3,$4,$5)',[id,this.scope,d.name,JSON.stringify(d),this.actor.id]);await this.audit('create',id,{templateId:template.id,version:template.version,previous:v.previousCycleId||null});await this.notice(id,'New six-month plan: '+d.name,'Draft created. Confirm named owners, readiness, baseline and start date before launch.');return {id,saved:true};
  }
  if(action==='reviewLesson'){
   if(!publisher(this.actor))fail(403,'forbidden');if(!uuid(v.id)||!['publish','reject'].includes(v.decision)||v.attested!==true)fail(400);const lesson=(await this.db.query('SELECT * FROM business_plan_lessons WHERE id=$1 FOR UPDATE',[v.id])).rows[0];if(!lesson)fail(404,'not_found');if(lesson.status!=='pending')fail(409,'conflict');const reason=text(v.reason);let nextId=null;
   if(v.decision==='publish'){const base=(await this.db.query('SELECT * FROM business_plan_templates WHERE id=$1',[lesson.template_id])).rows[0];await this.db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['business-template:'+base.flow+':'+base.family]);const latest=(await this.db.query('SELECT version FROM business_plan_templates WHERE flow=$1 AND family=$2 ORDER BY version DESC LIMIT 1',[base.flow,base.family])).rows[0];if(latest.version!==base.version)fail(409,'conflict');const payload=applyPatch(base.payload,base.flow,lesson.data.patch);nextId=crypto.randomUUID();await this.db.query('INSERT INTO business_plan_templates(id,flow,family,version,name,payload,published_by) VALUES($1,$2,$3,$4,$5,$6,$7)',[nextId,base.flow,base.family,base.version+1,base.name,JSON.stringify(payload),this.actor.id]);}
   await this.db.query('UPDATE business_plan_lessons SET status=$1,reviewed_by=$2,review_reason=$3,published_template_id=$4 WHERE id=$5',[nextId?'published':'rejected',this.actor.id,reason,nextId,v.id]);await this.audit('lesson_'+v.decision,null,{lessonId:v.id,newTemplate:nextId,reason});return {saved:true,templateId:nextId};
  }
  const row=await this.cycle(body.id,true);if(row.version!==body.version)fail(409,'conflict');const d=row.data;
  if(action==='lesson'){
   if(!manager(this.actor))fail(403,'forbidden');const base=(await this.db.query('SELECT * FROM business_plan_templates WHERE id=$1',[d.templateOrigin.id])).rows[0];const data=lessonData(v,{...base,payload:JSON.stringify(base.payload)},d);const id=crypto.randomUUID();await this.db.query('INSERT INTO business_plan_lessons(id,tenant_id,cycle_id,template_id,data,submitted_by) VALUES($1,$2,$3,$4,$5,$6)',[id,this.scope,row.id,base.id,JSON.stringify(data),this.actor.id]);await this.audit('lesson_submitted',row.id,{lessonId:id,kind:data.kind});return {saved:true};
  }
  if(d.archived&&action!=='reopen')fail(409,'conflict');let result:any;
  if(action==='assign'){
   if(!manager(this.actor))fail(403,'forbidden');const t=d.tasks.find((t:any)=>t.id===v.id);if(!t)fail(404,'not_found');const user=(await this.db.query("SELECT id::text,email,roles FROM users WHERE id::text=$1 AND tenant_id::text=$2 AND LOWER(status)='active' AND roles=ANY($3::text[]) FOR SHARE",[v.userId,this.scope,businessRoles])).rows[0];if(!user)fail(400);t.ownerUserId=user.id;t.owner=user.email;t.manager=this.actor.id;t.submission=null;result={data:d,detail:{taskId:t.id,assignedTo:user.id},action};await this.notice(row.id,'Task assigned: '+t.code,t.title+' — open Business plans and review the instructions and deadline.',user.id);
  }else if(action==='submitTask'||action==='reviewTask'){
   const t=d.tasks.find((t:any)=>t.id===v.id);if(!t)fail(404,'not_found');
   if(action==='submitTask'){if(!manager(this.actor)&&t.ownerUserId!==this.actor.id)fail(404,'not_found');if(!t.ownerUserId)fail(400);if(t.status==='done'||t.submission?.status==='pending')fail(409,'conflict');t.submission={status:'pending',evidence:text(v.evidence),at:now,by:this.actor.id};await this.notice(row.id,'Task ready for review: '+t.code,t.title,t.manager||null);result={data:d,action,detail:{taskId:t.id,evidence:t.submission.evidence}};
   }else{if(!manager(this.actor))fail(403,'forbidden');if(t.submission?.status!=='pending'||!['accept','revise'].includes(v.decision))fail(409,'conflict');const reason=text(v.reason);if(v.decision==='accept'){if(t.submission.by===this.actor.id)fail(400,'A different manager must review your own submission.');const deps=String(t.dependencies||'').split(',').map((x:string)=>x.trim()).filter(Boolean);if(deps.some((code:string)=>d.tasks.find((x:any)=>x.code===code)?.status!=='done'))fail(400,'Complete dependencies before accepting this task.');result=changeCycle(d,{action:'taskUpdate',value:{id:t.id,status:'done',owner:t.owner,reason,evidence:t.submission.evidence,accepted:'on',actual:v.actual??t.actual}},now);result.data.tasks.find((x:any)=>x.id===t.id).submission={...t.submission,status:'accepted',reviewer:this.actor.id,reason};}else{t.submission={...t.submission,status:'revise',reviewer:this.actor.id,reason};t.status='in_progress';result={data:d,action,detail:{taskId:t.id,reason}};}await this.notice(row.id,'Task review: '+t.code,reason,t.ownerUserId);}
  }else{
   const allowed=['rescheduleGrowth','editGoal','progress','taskUpdate','check','plan','archive','reopen','developmentPlan','reviewDevelopment'];if(!allowed.includes(action))fail(400);if(action==='taskUpdate'&&v.status==='done')fail(400,'Submit evidence for manager review.');authorizeAction(this.actor,d,action,v);
   if(action==='plan'&&v.plan==='A'&&(!d.start||!d.tenantContext?.ownerConfirmed||d.checks.some((c:any)=>c.status!=='working')||d.tasks.some((t:any)=>!t.ownerUserId)))fail(400,'Confirm the baseline, schedule, readiness and task owners before Plan A.');
   if(action==='taskUpdate'){const t=d.tasks.find((t:any)=>t.id===v.id);v.owner=t?.owner;}
   if(action==='editGoal'&&d.goals.find((g:any)=>g.id===v.id)?.updates.length)fail(400,'Preserve measured targets; use a new cycle to change an evidenced target.');
   if(action==='progress'){v.reporter=this.actor.id;v.verification='reviewed';}
   if(action==='check')v.reviewer=this.actor.id;
   if(action==='plan')v.owner=this.actor.id;
   if(action==='rescheduleGrowth'){if(v.baselineConfirmed!==true)fail(400);d.tenantContext.ownerConfirmed=true;}
   result=changeCycle(d,{action,value:v},now);
  }
  if(JSON.stringify(result.data).length>1500000)fail(413,'Plan history limit reached; create a successor cycle.');
  await this.db.query('UPDATE business_plan_cycles SET data=$1,version=version+1,updated_at=NOW() WHERE id=$2 AND tenant_id=$3',[JSON.stringify(result.data),row.id,this.scope]);await this.audit(action,row.id,result.detail);
  return {saved:true,id:row.id,version:row.version+1};
 }
}
