import type {Client} from 'pg';
import {registry,operational,clinicalRole,assignedClinical,allowedActions,fail,type Actor} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import {taskDueSql,concernSql,queueFilter,workItem} from './task-queue';
import {handoverDetail,handoverSnapshot} from './handovers';
import {followupSnapshot,followupOptions} from './followups';
import {visitPicker} from './visit-picker';
import {workloadSnapshot} from './workload';
import {scheduleSnapshot} from './schedules';
import {timeDetail,timeSnapshot,timeNeedsSubmissionSql,timeReviewPendingSql} from './time-records';
import {preStartSql,staffingReasonSql,checkStaffing,staffingSnapshot} from './staffing';

export {eligible} from './qualification';
import {eligible} from './qualification';
export class CareRepository {
 constructor(readonly db:Client,readonly actor:Actor){}
 async staff(ids:string[]|null,lock=false,query=''){
  const scope=this.actor.tenant_id;
  if(lock&&ids?.length)await this.db.query('SELECT id FROM users WHERE tenant_id::text=$1 AND id::text=ANY($2::text[]) ORDER BY id FOR SHARE',[scope,ids]);
  const rows=(await this.db.query("SELECT u.id::text AS id,u.email,u.roles,p.id::text AS provider_id,p.is_approved AS profile_approved,p.has_completed_induction AS induction,p.is_locked_for_retraining AS retraining,c.version AS clearance_version,c.status AS clearance_status,c.staff_role AS clearance_role,c.expires_on::text,c.registration AS clearance_reference,c.evidence AS clearance_evidence,c.reviewer_id::text AS clearance_reviewer FROM users u LEFT JOIN provider_profiles p ON p.user_id=u.id AND p.tenant_id=u.tenant_id LEFT JOIN LATERAL(SELECT version,status,staff_role,expires_on,registration,evidence,reviewer_id FROM care_staff_clearances WHERE tenant_id=u.tenant_id AND staff_id=u.id ORDER BY version DESC LIMIT 1)c ON TRUE WHERE u.tenant_id::text=$1 AND LOWER(u.status)='active' AND u.roles=ANY($2::text[]) AND ($3::text[] IS NULL OR u.id::text=ANY($3::text[])) AND ($4='' OR strpos(lower(u.email),lower($4))>0 OR strpos(lower(u.id::text),lower($4))>0) ORDER BY u.email,u.id LIMIT 201",[scope,Object.keys(registry.roles),ids,query])).rows;
  if(new Set(rows.map(r=>r.id)).size!==rows.length)throw Error('Ambiguous staff profiles');return rows;
 }
 async staffOne(id:string,lock=false){const rows=await this.staff([id],lock);if(rows.length!==1)fail(400);return rows[0];}
 async currentCase(id:string,lock=false):Promise<any>{
  const c=optionalRow((await this.db.query('SELECT c.*,v.status AS visit_status,v.requested_start_at,v.duration_minutes,v.assigned_provider_id::text AS provider_id FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE c.id=$1 AND c.tenant_id::text=$2'+(lock?' FOR UPDATE OF c,v':''),[id,this.actor.tenant_id])).rows);
  if(!c||!operational(this.actor)&&![c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(this.actor.id))fail(404,'not_found');return c;
 }
 async team(c:any,lock=false){
  const ids=[String(c.nurse_id),String(c.supervisor_id),String(c.worker_id)],rows=await this.staff(ids,lock);
  const nurse=rows.find(s=>s.id===ids[0]),supervisor=rows.find(s=>s.id===ids[1]),worker=rows.find(s=>s.id===ids[2]);
  return {rows,nurse,supervisor,worker,valid:rows.length===3&&eligible(nurse)&&registry.nurseRoles.includes(nurse?.roles)&&eligible(supervisor)&&registry.supervisorRoles.includes(supervisor?.roles)&&eligible(worker)&&registry.supportRoles.includes(worker?.roles)&&String(worker?.provider_id)===String(c.provider_id)};
 }
 async events(id:string){return (await this.db.query('SELECT id,actor_id::text,actor_role,record_version,action,payload,created_at FROM care_events WHERE tenant_id::text=$1 AND case_id=$2 ORDER BY record_version LIMIT 1001',[this.actor.tenant_id,id])).rows;}
 async event(id:string,action:string,payload:unknown,version:number){await this.db.query('INSERT INTO care_events(id,tenant_id,case_id,actor_id,actor_role,action,payload,record_version) VALUES($1,$2,$3,$4,$5,$6,$7,$8)',[crypto.randomUUID(),this.actor.tenant_id,id,this.actor.id,this.actor.roles,action,JSON.stringify(payload),version]);}
 async access(id:string|null,operation:string){await this.db.query('INSERT INTO care_access_log(id,tenant_id,actor_id,case_id,operation) VALUES($1,$2,$3,$4,$5)',[crypto.randomUUID(),this.actor.tenant_id,this.actor.id,id,operation]);}
 async snapshot(offset:number,id?:string,view='all',staffingOffset=0,staff?:string,seriesOffset=0,timeOffset=0,handoverOffset=0,followupOffset=0,followupView='all',followupOwner?:string,workloadOffset=0,workloadQuery='',rosterQuery='',visitOffset=0,visitQuery='',sourceOffset=0,sourceQuery=''){
  const op=operational(this.actor),scope=this.actor.tenant_id;
  const where="c.tenant_id::text=$1 AND ($2 OR c.nurse_id::text=$3 OR c.supervisor_id::text=$3 OR c.worker_id::text=$3)";
  const total=requiredRow((await this.db.query('SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE state=\'submitted\')::int AS review_backlog,COUNT(*) FILTER(WHERE state IN (\'awaiting_plan\',\'draft\',\'pending_review\',\'ready\',\'accepted\') AND v.requested_start_at<NOW())::int AS overdue FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE '+where,[scope,op,this.actor.id])).rows);
  const concernFilter=concernSql,filter=queueFilter(view,this.actor);
  const concernCount=requiredRow((await this.db.query('SELECT COUNT(*)::int AS count FROM care_cases c WHERE '+where+' AND '+concernFilter,[scope,op,this.actor.id])).rows).count;
  const filtered=requiredRow((await this.db.query('SELECT COUNT(*)::int AS count FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE '+where+filter,[scope,op,this.actor.id])).rows).count;
  const rows=(await this.db.query('SELECT c.id,c.visit_id::text,c.nurse_id::text,c.supervisor_id::text,c.worker_id::text,c.state,c.version,v.requested_start_at,'+concernFilter+' AS has_concerns,('+timeNeedsSubmissionSql+') AS time_needs_submission,('+timeReviewPendingSql+') AS time_review_pending,(CASE WHEN '+preStartSql+' THEN '+staffingReasonSql+' END) AS staffing_reason,('+taskDueSql+') AS work_due FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE '+where+filter+' ORDER BY has_concerns DESC,(c.state=\'coverage_needed\') DESC,(c.state=\'submitted\') DESC,(c.state IN (\'completed\',\'cancelled\')) ASC,work_due,c.id LIMIT $4 OFFSET $5',[scope,op,this.actor.id,registry.pageSize,offset])).rows;
  const cases=rows.map(({work_due,staffing_reason,...c})=>({...c,timeWork:c.time_needs_submission?{step:'task_submit_time',ownerId:c.worker_id}:c.time_review_pending?{step:'task_review_time',ownerId:null}:null,staffingReason:staffing_reason,work:workItem({...c,work_due,staffing_reason})}));
  let detail:any=null,people=await this.staff(op?null:[this.actor.id],false,op?rosterQuery:'');
  const self=await this.staffOne(this.actor.id),qualified=eligible(self);
  const verifier=this.actor.roles==='clinical_director'||this.actor.roles==='rn_field_supervisor'&&qualified;
  if(id){
   const c=await this.currentCase(id),team=await this.team(c),assigned=[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(this.actor.id);
   const clinical=assignedClinical(this.actor,c,self.profile_approved===true);
   const events=clinical?await this.events(id):[];if(events.length>1000)fail(413,'record_limit');
   const openConcerns=events.filter(e=>e.action==='concern'||e.action==='task'&&e.payload.outcome==='concern').filter(e=>!events.some(f=>f.action==='follow_up'&&f.payload.eventId===e.id));
   detail={...Object.fromEntries(['id','visit_id','nurse_id','supervisor_id','worker_id','state','version','requested_start_at','visit_status','started_at','submitted_at','completed_at'].map(k=>[k,c[k]])),clinical,teamReady:team.valid,plan:clinical?c.plan:null,events,openConcerns,actions:allowedActions(this.actor,c,qualified).filter(a=>a!=='follow_up'||openConcerns.length>0).filter(a=>a!=='submit_visit'||c.plan?.tasks?.every((task:any)=>events.some(e=>e.action==='task'&&e.payload.taskId===task.id))),allowedOutcomes:qualified&&team.valid&&Date.parse(String(c.plan?.validUntil))>Date.now()?registry.outcomes:registry.outcomes.filter(o=>o!=='done'),taskOutcomes:clinical?(c.plan?.tasks??[]).map((task:any)=>({...task,outcome:[...events].reverse().find(e=>e.action==='task'&&e.payload.taskId===task.id)?.payload??null})):[]};
   if(clinical){const visit=requiredRow((await this.db.query('SELECT p.full_name,v.service_address_line1,v.service_city,v.service_postal_code FROM visits v JOIN client_profiles p ON p.id=v.client_id AND p.tenant_id=v.tenant_id WHERE v.id::text=$1 AND v.tenant_id::text=$2',[String(c.visit_id),scope])).rows);detail.client=visit;}
   if(['awaiting_plan','draft','pending_review','ready','accepted'].includes(c.state))detail.staffingReason=await checkStaffing(this,String(c.visit_id),String(c.nurse_id),String(c.supervisor_id),String(c.worker_id),String(c.provider_id),false);
   detail.timeRecord=await timeDetail(this,c);detail.handovers=await handoverDetail(this,c,self);detail.followup=await followupOptions(this,c,people);
   if(c.state==='coverage_needed'){
    const exception=requiredRow((await this.db.query("SELECT payload->>'reason' AS reason,created_at FROM care_events WHERE tenant_id::text=$1 AND case_id=$2 AND action='report_unavailable' ORDER BY record_version DESC LIMIT 1",[scope,id])).rows);
    detail.exception={reason:exception.reason,createdAt:exception.created_at};
   }
   if(c.state==='correction_requested'&&clinical){
    const returned=[...events].reverse().find(e=>e.action==='return_visit');
    detail.correctionRequest=returned??null;
    if(!returned||!events.some(e=>e.action==='amendment'&&String(e.actor_id)===this.actor.id&&e.record_version>returned.record_version))detail.actions=detail.actions.filter((a:string)=>a!=='submit_visit');
   }
   if(!op)people=await this.staff([this.actor.id,...team.rows.map(s=>s.id)]);
  }
  const {records:visits,...visitPickerMeta}=await visitPicker(this,visitOffset,visitQuery);
  await this.access(id??null,id?'case_read':'worklist_read');
  const staffing=await staffingSnapshot(this,staffingOffset,staff,people),schedules=await scheduleSnapshot(this,seriesOffset,sourceOffset,sourceQuery),timesheets=await timeSnapshot(this,timeOffset),handovers=await handoverSnapshot(this,handoverOffset),followups=await followupSnapshot(this,followupOffset,followupView,followupOwner,people),workload=await workloadSnapshot(this,workloadOffset,workloadQuery);
  return {visitPicker:visitPickerMeta,rosterQuery:op?rosterQuery:'',staffing,schedules,timesheets,handovers,followups,workload,identity:{userId:this.actor.id,tenantId:scope,role:this.actor.roles},capabilities:{operations:op,verifyClearance:verifier,qualified},cases,total:filtered,assignmentTotal:total.total,view,reviewBacklog:total.review_backlog,concerns:concernCount,overdue:total.overdue,offset,limit:registry.pageSize,people:people.slice(0,200).map(s=>{const {clearance_reference,clearance_evidence,clearance_reviewer,...safe}=s;return {...safe,...(verifier?{clearance_reference,clearance_evidence,clearance_reviewer}:{}),eligible:eligible(s),clearable:verifier&&clinicalRole(s.roles)&&s.id!==this.actor.id,canNurse:eligible(s)&&registry.nurseRoles.includes(s.roles),canSupervise:eligible(s)&&registry.supervisorRoles.includes(s.roles),canSupport:eligible(s)&&registry.supportRoles.includes(s.roles)}}),rosterTruncated:people.length>200,visits,detail};
 }
}
