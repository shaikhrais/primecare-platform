import {attachDependencies,taskDependencies,releaseDependency,pendingDependencySql} from './task-dependencies';
import {registry,operational,clinicalRole,fail} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import {eligible} from './qualification';
import {checkStaffing,lockStaffSchedule} from './staffing';
import type {CareRepository} from './repository';

export function followupActions(repo:CareRepository,t:any,dependencies:any={ready:true,records:[]}){
 if(t.version>=registry.followupPolicy.maxVersions||['completed','cancelled'].includes(t.status))return [];
 const own=String(t.owner_id)===repo.actor.id,op=operational(repo.actor),actions:string[]=[];
 if(own){if(['open','blocked'].includes(t.status)&&t.version<=registry.followupPolicy.maxVersions-3)actions.push('start');if(['open','in_progress','blocked'].includes(t.status)){if(t.version<=registry.followupPolicy.maxVersions-3)actions.push('block');if(t.version<=registry.followupPolicy.maxVersions-2)actions.push('submit');}}
 if(own&&t.version<=registry.followupPolicy.maxVersions-3){if(t.requested_due_at)actions.push('withdraw_extension');else if(t.version<=registry.followupPolicy.maxVersions-5)actions.push('request_extension');}
 if(op&&!own&&t.requested_due_at&&t.version<=registry.followupPolicy.maxVersions-3)actions.push('approve_extension','decline_extension');
 if(op){if(!own&&t.version<=registry.followupPolicy.maxVersions-3)actions.push('reassign');actions.push('cancel');if(!own&&t.status==='submitted'){actions.push('verify');if(t.version<=registry.followupPolicy.maxVersions-3)actions.push('return');}}
 if(dependencies.records.some((p:any)=>p.canRelease))actions.push('release_dependency');
 return dependencies.ready?actions:actions.filter(a=>!['start','submit','verify'].includes(a));
}
async function validOwner(repo:CareRepository,c:any,ownerId:string,category:string){
 const owner=await repo.staffOne(ownerId,true),onTeam=[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(ownerId);
 if(!onTeam&&!registry.operationsRoles.includes(owner.roles)||category==='staff_clearance'&&!clinicalRole(owner.roles))fail(400);return owner;
}
export async function followupSourceSatisfied(repo:CareRepository,c:any,t:any){
 if(t.category==='other_operations')return true;
 if(t.category==='coverage')return ['cancelled','rejected'].includes(String(c.visit_status))||!['cancelled','coverage_needed'].includes(c.state)&&(await repo.team(c)).valid&&!await checkStaffing(repo,String(c.visit_id),String(c.nurse_id),String(c.supervisor_id),String(c.worker_id),String(c.provider_id),false);
 if(t.category==='plan_review')return !!c.plan_reviewer&&['ready','accepted','in_progress','submitted','completed'].includes(c.state);
 if(t.category==='visit_review')return c.state==='completed';
 if(t.category==='documentation')return ['submitted','completed'].includes(c.state);
 if(t.category==='staff_clearance'){const rows=await repo.staff([String(t.owner_id)]);return rows.length===1&&eligible(rows[0]);}
 if(t.category==='time_review')return !!optionalRow((await repo.db.query("SELECT case_id FROM care_time_records WHERE tenant_id::text=$1 AND case_id=$2 AND status='approved'",[repo.actor.tenant_id,c.id])).rows);
 if(t.category==='handover_review'){
  const result=requiredRow((await repo.db.query("SELECT COUNT(*)::int AS n,COUNT(*) FILTER(WHERE status NOT IN ('approved','withdrawn'))::int AS pending FROM care_handovers WHERE tenant_id::text=$1 AND (source_case_id=$2 OR target_case_id=$2)",[repo.actor.tenant_id,c.id])).rows);return Number(result.n)>0&&result.pending===0;
 }
 return false;
}
async function followupCase(repo:CareRepository,id:string,lock=true){
 const c=optionalRow((await repo.db.query('SELECT c.*,v.status AS visit_status,v.requested_start_at,v.duration_minutes,v.assigned_provider_id::text AS provider_id FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE c.tenant_id::text=$1 AND c.id=$2'+(lock?' FOR UPDATE OF c,v':''),[repo.actor.tenant_id,id])).rows);if(!c)fail(404,'not_found');return c;
}
export async function authorizeFollowup(repo:CareRepository,v:any){
 let t:any=v.action==='create'?null:optionalRow((await repo.db.query('SELECT * FROM care_followups WHERE tenant_id::text=$1 AND id=$2',[repo.actor.tenant_id,v.id])).rows);
 const check=()=>{
  if(v.action!=='create'&&!t)fail(404,'not_found');
  if(!operational(repo.actor)&&(!t||String(t.owner_id)!==repo.actor.id))fail(v.action==='create'?403:404,v.action==='create'?'forbidden':'not_found');
  if(['verify','return','reassign','cancel','approve_extension','decline_extension','release_dependency'].includes(v.action)&&(!operational(repo.actor)||['verify','return','reassign','approve_extension','decline_extension','release_dependency'].includes(v.action)&&String(t.owner_id)===repo.actor.id))fail(403,'forbidden');
 };
 check();
 // Case first, then task: prerequisite FKs and competing source-task decisions use the same lock order.
 const c=await followupCase(repo,String(t?.case_id??v.caseId));
 if(t){t=optionalRow((await repo.db.query('SELECT * FROM care_followups WHERE tenant_id::text=$1 AND id=$2 FOR UPDATE',[repo.actor.tenant_id,v.id])).rows);check();if(String(t.case_id)!==String(c.id))fail(409,'conflict');}
 if(v.action==='release_dependency'){const parent=(await taskDependencies(repo,t)).records.find(p=>p.id===v.prerequisiteId);if(parent?.ownerId===repo.actor.id)fail(403,'forbidden');}
 await lockStaffSchedule(repo,[c.nurse_id,c.supervisor_id,c.worker_id,t?.owner_id,v.ownerId].filter(Boolean).map(String));return {t,c};
}
export async function followupCommand(repo:CareRepository,context:any,v:any){
 const {t,c}=context,{db,actor}=repo;let id:string,version:number,status:string;
 const payload:any={note:v.note};
 if(v.action==='create'){
  await validOwner(repo,c,v.ownerId,v.category);id=crypto.randomUUID();version=1;status='open';
  await db.query("INSERT INTO care_followups(id,tenant_id,case_id,category,owner_id,created_by,status,version,due_at) VALUES($1,$2,$3,$4,$5,$6,'open',1,$7)",[id,actor.tenant_id,c.id,v.category,v.ownerId,actor.id,v.dueAt]);await attachDependencies(repo,c.id,id,v.prerequisiteIds);Object.assign(payload,{ownerId:v.ownerId,dueAt:v.dueAt,category:v.category,prerequisiteIds:v.prerequisiteIds});
 }else{
  if(t.version!==v.version)fail(409,'conflict');const dependencies=await taskDependencies(repo,t);
  if(['start','submit','verify'].includes(v.action)&&!dependencies.ready)fail(409,'followup_dependency_pending');
  if(!followupActions(repo,t,dependencies).includes(v.action))fail(409,'conflict');id=t.id;version=t.version+1;
  status=({start:'in_progress',block:'blocked',submit:'submitted',verify:'completed',return:'open',reassign:'open',cancel:'cancelled'} as Record<string,string>)[v.action]??t.status;
  if(v.action==='verify'){if(!await followupSourceSatisfied(repo,c,t))fail(409,'followup_source_missing');Object.assign(payload,{checked:true,sourceSatisfied:true,caseVersion:c.version,clinicalState:c.state});}
  if(v.action==='reassign'){await validOwner(repo,c,v.ownerId,t.category);Object.assign(payload,{previousOwner:String(t.owner_id),previousDue:t.due_at,ownerId:v.ownerId,dueAt:v.dueAt});}
  if(v.action==='release_dependency')Object.assign(payload,await releaseDependency(repo,t,v.prerequisiteId,v.note));
  let requestedDue=t.requested_due_at,requestedAt=t.extension_requested_at,requestedBy=t.extension_requested_by,due=v.action==='reassign'?v.dueAt:t.due_at;
  if(v.action==='request_extension'){
   if(Date.parse(v.dueAt)<=new Date(t.due_at).getTime())fail(400);requestedDue=v.dueAt;requestedAt=new Date().toISOString();requestedBy=actor.id;
   Object.assign(payload,{previousDue:t.due_at,requestedDue:v.dueAt,requestedAt,requestedBy:actor.id});
  }
  if(['approve_extension','decline_extension','withdraw_extension'].includes(v.action)){
   Object.assign(payload,{previousDue:t.due_at,requestedDue:t.requested_due_at,requestedAt:t.extension_requested_at,requestedBy:String(t.extension_requested_by)});
   if(v.action==='approve_extension'){
    if(new Date(t.requested_due_at).getTime()<=Date.now())fail(409,'followup_extension_expired');due=t.requested_due_at;payload.checked=true;
   }
   Object.assign(payload,{dueAt:due});requestedDue=null;requestedAt=null;requestedBy=null;
  }
  if(['reassign','verify','cancel'].includes(v.action)&&requestedDue){
   Object.assign(payload,{extensionClosed:true,requestedDue,requestedAt,requestedBy:String(requestedBy)});requestedDue=null;requestedAt=null;requestedBy=null;
  }
  await db.query('UPDATE care_followups SET status=$1,version=$2,owner_id=$3,due_at=$4,requested_due_at=$5,extension_requested_at=$6,extension_requested_by=$7,updated_at=NOW() WHERE tenant_id::text=$8 AND id=$9',[status,version,v.action==='reassign'?v.ownerId:t.owner_id,due,requestedDue,requestedAt,requestedBy,actor.tenant_id,id]);
 }
 await db.query('INSERT INTO care_followup_events(id,tenant_id,followup_id,actor_id,action,version,payload) VALUES($1,$2,$3,$4,$5,$6,$7)',[crypto.randomUUID(),actor.tenant_id,id,actor.id,v.action,version,JSON.stringify(payload)]);
 await repo.access(c.id,'followup_'+v.action);return {id,version,status};
}
export async function followupOptions(repo:CareRepository,c:any,knownStaff?:any[],includeParents=true){
 if(!operational(repo.actor))return {canCreate:false,owners:[]};const staff=knownStaff??await repo.staff(null),teamIds=[c.nurse_id,c.supervisor_id,c.worker_id].map(String),missing=teamIds.filter(id=>!staff.some(p=>p.id===id)),team=missing.length?await repo.staff(missing):[];
 const candidates=[...staff.filter(p=>teamIds.includes(p.id)),...team,...staff.filter(p=>!teamIds.includes(p.id))];
 const parents=includeParents?(await repo.db.query("SELECT id,owner_id::text,category,status FROM care_followups WHERE tenant_id::text=$1 AND case_id=$2 AND status<>'cancelled' ORDER BY created_at DESC,id LIMIT $3",[repo.actor.tenant_id,c.id,registry.dependencyPolicy.pickerLimit+1])).rows:[];
 return {canCreate:true,prerequisites:parents.slice(0,registry.dependencyPolicy.pickerLimit),prerequisitesTruncated:parents.length>registry.dependencyPolicy.pickerLimit,owners:candidates.filter(p=>[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(p.id)||registry.operationsRoles.includes(p.roles)).slice(0,200).map(p=>({id:p.id,label:p.email}))};
}
export async function followupSnapshot(repo:CareRepository,offset:number,view:string,ownerId?:string,knownStaff?:any[]){
 let ownerScope:any=null;
 if(ownerId){
  if(!operational(repo.actor)&&ownerId!==repo.actor.id)fail(403,'forbidden');
  const owner=optionalRow((await repo.db.query('SELECT id::text,email FROM users WHERE tenant_id::text=$1 AND id::text=$2',[repo.actor.tenant_id,ownerId])).rows);if(!owner)fail(404,'not_found');ownerScope=owner;
 }
 const {db,actor}=repo,op=operational(actor),base='t.tenant_id::text=$1 AND ($2 OR t.owner_id::text=$3)'+(ownerId?' AND t.owner_id::text=$6':''),filter=view==='mine'?" AND t.owner_id::text=$3 AND t.status NOT IN ('completed','cancelled')":view==='late'?" AND t.due_at<NOW() AND t.status NOT IN ('completed','cancelled')":view==='review'?" AND t.status='submitted'":view==='extensions'?" AND t.requested_due_at IS NOT NULL":view==='blocked'?" AND t.status='blocked'":view==='waiting'?' AND '+pendingDependencySql : '';
 const countBase=base.replace('$6','$4'),countArgs=[actor.tenant_id,op,actor.id,...(ownerId?[ownerId]:[])];
 const totals=requiredRow((await db.query("SELECT COUNT(*) FILTER(WHERE t.status NOT IN ('completed','cancelled'))::int AS open,COUNT(*) FILTER(WHERE t.status NOT IN ('completed','cancelled') AND t.due_at<NOW())::int AS late,COUNT(*) FILTER(WHERE t.status='submitted')::int AS review,COUNT(*) FILTER(WHERE t.requested_due_at IS NOT NULL)::int AS extensions,COUNT(*) FILTER(WHERE "+pendingDependencySql+")::int AS waiting FROM care_followups t WHERE "+countBase,countArgs)).rows);
 const total=requiredRow((await db.query('SELECT COUNT(*)::int AS n FROM care_followups t WHERE '+countBase+filter,countArgs)).rows).n;
 const rows=(await db.query('SELECT t.*,u.email FROM care_followups t JOIN users u ON u.id=t.owner_id AND u.tenant_id=t.tenant_id WHERE '+base+filter+" ORDER BY (t.status IN ('completed','cancelled')) ASC,(t.requested_due_at IS NOT NULL) DESC,(t.status='submitted') DESC,t.due_at,t.id LIMIT $4 OFFSET $5",[actor.tenant_id,op,actor.id,registry.followupPolicy.pageSize,offset,...(ownerId?[ownerId]:[])])).rows;
 const records=[],staff=op?(knownStaff??await repo.staff(null)):undefined;
 for(const t of rows){
  const dependencies=await taskDependencies(repo,t),c=await followupCase(repo,String(t.case_id),false),sourceVisible=op||[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(actor.id);
  const events=(await db.query('SELECT actor_id::text,action,version,payload,created_at FROM care_followup_events WHERE tenant_id::text=$1 AND followup_id=$2 ORDER BY version LIMIT 51',[actor.tenant_id,t.id])).rows;if(events.length>registry.followupPolicy.maxVersions)fail(413,'record_limit');
  const sourceSatisfied=t.status==='completed'?events.some(e=>e.action==='verify'&&e.payload.sourceSatisfied===true):sourceVisible?await followupSourceSatisfied(repo,c,t):false;
  const sourceReviewLabel=!sourceVisible&&t.status!=='completed'?'followup_limited':t.category==='other_operations'?(t.status==='completed'?'manual_review_recorded':'manual_review_required'):sourceSatisfied?'source_satisfied':'source_not_satisfied';
  records.push({...t,owner_id:String(t.owner_id),late:!['completed','cancelled'].includes(t.status)&&new Date(t.due_at).getTime()<Date.now(),sourceVisible,sourceSatisfied,sourceReviewLabel,dependencies,actions:followupActions(repo,t,dependencies),events,...await followupOptions(repo,c,staff,false)});
 }
 return {records,total,...totals,offset,limit:registry.followupPolicy.pageSize,view,ownerScope};
}
