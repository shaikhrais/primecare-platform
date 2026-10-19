import {registry,operational,clinicalRole,allowedActions,fail,type Actor} from '../../../../packages/shared/src/care/contract';
import {requiredRow,optionalRow} from '../database-results';
import {CareRepository,eligible} from './repository';
import {checkStaffing,lockStaffSchedule} from './staffing';
import {handoverGate} from './handovers';
import {lockClientSchedule,clientConflict} from './schedules';

export async function authorizeCareCommand(repo:CareRepository,kind:string,id:string|undefined,v:any){
 const {actor}=repo;
 if(kind==='clearances'){
  await lockStaffSchedule(repo,[actor.id,v.staffId]);const self=await repo.staffOne(actor.id,true);
  if(!(actor.roles==='clinical_director'||actor.roles==='rn_field_supervisor'&&eligible(self))||actor.id===v.staffId)fail(403,'forbidden');return null;
 }
 if(kind==='cases'){if(!operational(actor))fail(403,'forbidden');return null;}
 const c=await repo.currentCase(id!,true);
 await lockStaffSchedule(repo,[String(c.nurse_id),String(c.supervisor_id),String(c.worker_id),...(v.action==='reassign'?[v.nurseId,v.supervisorId,v.workerId]:[])]);
 const self=await repo.staffOne(actor.id,true),assigned=[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(actor.id),qualified=eligible(self),a=v.action;
 const permitted=['concern','amendment'].includes(a)?assigned:['reassign','cancel','reschedule','cancel_visit'].includes(a)?operational(actor):['save_plan','submit_plan'].includes(a)?qualified&&String(c.nurse_id)===actor.id&&registry.nurseRoles.includes(actor.roles):['approve_plan','return_plan','complete_review','return_visit'].includes(a)?qualified&&String(c.supervisor_id)===actor.id&&registry.supervisorRoles.includes(actor.roles):a==='follow_up'?qualified&&[c.nurse_id,c.supervisor_id].map(String).includes(actor.id)&&registry.nurseRoles.includes(actor.roles):(qualified||['task','submit_visit','report_unavailable'].includes(a))&&String(c.worker_id)===actor.id&&registry.supportRoles.includes(actor.roles);
 if(!permitted||a==='task'&&v.outcome==='done'&&!qualified)fail(403,'forbidden');return c;
}

export class CareCommands {
 constructor(readonly repo:CareRepository){}
 async verify(v:any){
  const {db,actor}=this.repo,target=await this.repo.staffOne(v.staffId,true);
  if(!clinicalRole(target.roles)||!v.registration.trim())fail(400);
  await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['care-clearance:'+actor.tenant_id+':'+v.staffId]);
  const previous=optionalRow((await db.query('SELECT version FROM care_staff_clearances WHERE tenant_id::text=$1 AND staff_id::text=$2 ORDER BY version DESC LIMIT 1',[actor.tenant_id,v.staffId])).rows);
  if((previous?.version??0)!==v.version)fail(409,'conflict');
  if(v.profile){
   const p=v.profile,providerType=target.roles==='rpn'?'RPN':registry.nurseRoles.includes(target.roles)?'RN':target.roles.toUpperCase();
   const profile=optionalRow((await db.query('INSERT INTO provider_profiles(id,user_id,tenant_id,full_name,languages,service_areas,provider_type,skills,is_approved,approved_at,has_completed_induction,is_locked_for_retraining,created_at) VALUES($1,$2,$3,$4,$5,$6,$7,$8,TRUE,NOW(),TRUE,FALSE,NOW()) ON CONFLICT(user_id) DO UPDATE SET full_name=EXCLUDED.full_name,languages=EXCLUDED.languages,service_areas=EXCLUDED.service_areas,provider_type=EXCLUDED.provider_type,skills=EXCLUDED.skills,is_approved=TRUE,approved_at=NOW(),has_completed_induction=TRUE WHERE provider_profiles.tenant_id=EXCLUDED.tenant_id AND NOT provider_profiles.is_locked_for_retraining RETURNING id',[crypto.randomUUID(),v.staffId,actor.tenant_id,p.fullName,p.languages,p.serviceAreas,providerType,p.skills])).rows);if(!profile)fail(409,'conflict');
  }
  const id=crypto.randomUUID();await db.query('INSERT INTO care_staff_clearances(id,tenant_id,staff_id,version,staff_role,status,registration,expires_on,reviewer_id,evidence) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',[id,actor.tenant_id,v.staffId,v.version+1,target.roles,v.status,v.registration,v.expiresOn,actor.id,v.evidence]);
  await this.repo.access(null,'clearance_'+v.status);return {id,version:v.version+1};
 }
 async assignment(nurseId:string,supervisorId:string,workerId:string){
  const ids=[nurseId,supervisorId,workerId];await lockStaffSchedule(this.repo,ids);
  const people=await this.repo.staff(ids,true),nurse=people.find(p=>p.id===nurseId),supervisor=people.find(p=>p.id===supervisorId),worker=people.find(p=>p.id===workerId);
  if(new Set(ids).size!==3||people.length!==3||!eligible(nurse)||!registry.nurseRoles.includes(nurse.roles)||!eligible(supervisor)||!registry.supervisorRoles.includes(supervisor.roles)||!eligible(worker)||!registry.supportRoles.includes(worker.roles))fail(400);
  return {nurse,supervisor,worker};
 }
 async create(v:any){
  const {db,actor}=this.repo;
  const visit=optionalRow((await db.query("SELECT v.id,v.status FROM visits v JOIN client_profiles p ON p.id=v.client_id AND p.tenant_id=v.tenant_id JOIN users u ON u.id=p.user_id AND u.tenant_id=p.tenant_id WHERE v.id::text=$1 AND v.tenant_id::text=$2 AND LOWER(u.status)='active' FOR UPDATE OF v",[v.visitId,actor.tenant_id])).rows);
  if(!visit)fail(404,'not_found');if(!['requested','accepted','assigned','scheduled','pending'].includes(String(visit.status??'requested')))fail(409,'conflict');
  if(optionalRow((await db.query('SELECT id FROM care_cases WHERE tenant_id::text=$1 AND visit_id::text=$2',[actor.tenant_id,v.visitId])).rows))fail(409,'conflict');
  const {worker}=await this.assignment(v.nurseId,v.supervisorId,v.workerId),id=crypto.randomUUID();
  const conflict=await checkStaffing(this.repo,v.visitId,v.nurseId,v.supervisorId,v.workerId,String(worker.provider_id));if(conflict)fail(409,conflict);
  await db.query('UPDATE visits SET assigned_provider_id=$1,updated_at=NOW() WHERE id::text=$2 AND tenant_id::text=$3',[worker.provider_id,v.visitId,actor.tenant_id]);
  await db.query('INSERT INTO care_cases(id,tenant_id,visit_id,nurse_id,supervisor_id,worker_id) VALUES($1,$2,$3,$4,$5,$6)',[id,actor.tenant_id,v.visitId,v.nurseId,v.supervisorId,v.workerId]);
  await this.repo.event(id,'assigned',{note:v.evidence,nurseId:v.nurseId,supervisorId:v.supervisorId,workerId:v.workerId},1);return {id,version:1};
 }
 async action(c:any,v:any){
  const {db,actor}=this.repo,id=String(c.id),scope=actor.tenant_id;
  if(c.version!==v.version)fail(409,'conflict');
  const self=await this.repo.staffOne(actor.id),qualified=eligible(self);
  if(!allowedActions(actor,c,qualified).includes(v.action))fail(409,'conflict');
  const events=await this.repo.events(id);if(events.length>=1000)fail(413,'record_limit');
  const team=await this.repo.team(c,true),visitActive=!['cancelled','rejected','completed'].includes(String(c.visit_status));
  if(['save_plan','submit_plan','approve_plan','accept','start','reschedule'].includes(v.action)&&(!team.valid||!visitActive))fail(409,'conflict');
  if(['submit_plan','approve_plan','accept','start'].includes(v.action)&&(!c.plan||Date.parse(c.plan.validUntil)<=Date.now()))fail(409,'conflict');
  if(['approve_plan','start'].includes(v.action)){const blocked=await handoverGate(this.repo,c,v.action==='start');if(blocked)fail(409,blocked);}
  let state=c.state,plan=c.plan,author=c.plan_author,reviewer=c.plan_reviewer,started=c.started_at,submitted=c.submitted_at,completed=c.completed_at;
  const payload:any={note:v.note};
  if(v.action==='save_plan'){
   if(Date.parse(String(v.validUntil))<new Date(c.requested_start_at).getTime()+Number(c.duration_minutes)*60000)fail(400);
   plan={assessment:v.assessment,risks:v.risks,escalation:v.escalation,consentEvidence:v.consentEvidence,validUntil:v.validUntil,competenceChecked:true,tasks:v.tasks.map((task:any)=>({id:crypto.randomUUID(),kind:task.kind,instructions:task.instructions}))};
   state='draft';author=actor.id;reviewer=null;payload.plan=plan;
  }else if(v.action==='submit_plan')state='pending_review';
  else if(v.action==='approve_plan'){if(String(author)===actor.id)fail(403,'forbidden');state='ready';reviewer=actor.id;payload.plan=plan;}
  else if(v.action==='return_plan'){state='draft';reviewer=null;}
  else if(v.action==='accept')state='accepted';
  else if(v.action==='start'){
   const conflict=await checkStaffing(this.repo,String(c.visit_id),String(c.nurse_id),String(c.supervisor_id),String(c.worker_id),String(team.worker.provider_id));if(conflict)fail(409,conflict);
   if(new Date(c.requested_start_at).getTime()-registry.earlyStartMinutes*60000>Date.now())fail(409,'conflict');
   state='in_progress';started=new Date().toISOString();payload.consentChecked=true;payload.workerProviderId=team.worker.provider_id;payload.clearances=team.rows.map(s=>({staffId:s.id,role:s.roles,version:s.clearance_version,expiresOn:s.expires_on}));
  }else if(v.action==='task'){
   if((!qualified||!team.valid||Date.parse(String(plan?.validUntil))<=Date.now())&&v.outcome==='done')fail(403,'forbidden');
   if(!plan?.tasks.some((task:any)=>task.id===v.taskId)||!visitActive&&v.outcome==='done')fail(409,'conflict');
   payload.taskId=v.taskId;payload.outcome=v.outcome;
  }else if(v.action==='follow_up'){
   const concern=events.find(e=>e.id===v.eventId&&(e.action==='concern'||e.action==='task'&&e.payload.outcome==='concern'));
   if(!concern||events.some(e=>e.action==='follow_up'&&e.payload.eventId===v.eventId))fail(409,'conflict');payload.eventId=v.eventId;
  }else if(v.action==='submit_visit'){
   if(!plan?.tasks.length||plan.tasks.some((task:any)=>!events.some(e=>e.action==='task'&&e.payload.taskId===task.id)))fail(409,'conflict');
   if(c.state==='correction_requested'){
    const returned=[...events].reverse().find(e=>e.action==='return_visit');
    if(!returned||!events.some(e=>e.action==='amendment'&&String(e.actor_id)===actor.id&&e.record_version>returned.record_version))fail(409,'conflict');
   }
   state='submitted';submitted=new Date().toISOString();
  }else if(v.action==='return_visit'){
   if(String(c.plan_author)===actor.id||String(c.worker_id)===actor.id)fail(403,'forbidden');
   state='correction_requested';
  }else if(v.action==='report_unavailable'){
   state='coverage_needed';payload.reason=v.reason;
  }else if(v.action==='complete_review'){
   if(String(c.plan_author)===actor.id||String(c.worker_id)===actor.id)fail(403,'forbidden');
   const startEvent=events.find(e=>e.action==='start');if(!startEvent?.payload.workerProviderId||String(c.provider_id)!==String(startEvent.payload.workerProviderId))fail(409,'conflict');
   const concerns=events.filter(e=>e.action==='concern'||e.action==='task'&&e.payload.outcome==='concern');
   if(concerns.some(e=>!events.some(f=>f.action==='follow_up'&&f.payload.eventId===e.id)))fail(409,'conflict');
   state='completed';completed=new Date().toISOString();
   if(visitActive)await db.query("UPDATE visits SET status='completed',updated_at=NOW() WHERE id::text=$1 AND tenant_id::text=$2 AND assigned_provider_id::text=$3",[String(c.visit_id),scope,String(startEvent.payload.workerProviderId)]);
  }else if(v.action==='reassign'){
   if(!visitActive)fail(409,'conflict');const next=await this.assignment(v.nurseId,v.supervisorId,v.workerId);
   const conflict=await checkStaffing(this.repo,String(c.visit_id),v.nurseId,v.supervisorId,v.workerId,String(next.worker.provider_id));if(conflict)fail(409,conflict);
   await db.query('UPDATE visits SET assigned_provider_id=$1,updated_at=NOW() WHERE id::text=$2 AND tenant_id::text=$3',[next.worker.provider_id,String(c.visit_id),scope]);
   await db.query('UPDATE care_cases SET nurse_id=$1,supervisor_id=$2,worker_id=$3 WHERE id=$4 AND tenant_id::text=$5',[v.nurseId,v.supervisorId,v.workerId,id,scope]);
   state='awaiting_plan';plan=null;author=null;reviewer=null;Object.assign(payload,{nurseId:v.nurseId,supervisorId:v.supervisorId,workerId:v.workerId});
  }else if(v.action==='reschedule'){
   if(!visitActive)fail(409,'conflict');const visit=requiredRow((await db.query('SELECT client_id::text AS client_id FROM visits WHERE id::text=$1 AND tenant_id::text=$2',[String(c.visit_id),scope])).rows);
   await lockClientSchedule(this.repo,String(visit.client_id));if(await clientConflict(this.repo,String(visit.client_id),v.startsAt,v.durationMinutes,String(c.visit_id)))fail(409,'schedule_conflict');
   await db.query('UPDATE visits SET requested_start_at=$1,duration_minutes=$2,updated_at=NOW() WHERE id::text=$3 AND tenant_id::text=$4',[v.startsAt,v.durationMinutes,String(c.visit_id),scope]);
   const conflict=await checkStaffing(this.repo,String(c.visit_id),String(c.nurse_id),String(c.supervisor_id),String(c.worker_id),String(c.provider_id));if(conflict)fail(409,conflict);
   Object.assign(payload,{previousStart:c.requested_start_at,previousDuration:c.duration_minutes,startsAt:v.startsAt,durationMinutes:v.durationMinutes,confirmed:true});
   state='awaiting_plan';plan=null;author=null;reviewer=null;
  }else if(v.action==='cancel_visit'){
   if(!visitActive)fail(409,'conflict');await db.query("UPDATE visits SET status='cancelled',cancellation_reason=$1,updated_at=NOW() WHERE id::text=$2 AND tenant_id::text=$3",[v.note,String(c.visit_id),scope]);state='cancelled';payload.confirmed=true;payload.previousVisitStatus=c.visit_status;
  }else if(v.action==='cancel')state='cancelled';
  const updated=requiredRow((await db.query('UPDATE care_cases SET state=$1,plan=$2,plan_author=$3,plan_reviewer=$4,started_at=$5,submitted_at=$6,completed_at=$7,version=version+1,updated_at=NOW() WHERE id=$8 AND tenant_id::text=$9 AND version=$10 RETURNING version',[state,plan?JSON.stringify(plan):null,author,reviewer,started,submitted,completed,id,scope,v.version])).rows);
  if(updated.version!==v.version+1)throw Error('Invalid care version');
  await this.repo.event(id,v.action,payload,Number(updated.version));return {id,version:updated.version};
 }
}
