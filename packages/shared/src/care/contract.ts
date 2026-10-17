import registry from './registry.json';
import {GrowthFailure,fail,keys,text,integer,date,timestamp,uuid,canonical} from '../growth/contract';
export {registry,GrowthFailure,fail,uuid,canonical};
export type Actor={id:string;tenant_id:string;roles:string};
export const identifier=(v:unknown):v is string=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
const paragraph=(v:unknown,max=2000)=>typeof v==='string'&&v.trim().length>0&&v.length<=max&&!/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(v);
export const careRole=(role:string)=>Object.hasOwn(registry.roles,role);
export const operational=(actor:Actor)=>registry.operationsRoles.includes(actor.roles);
export const clinicalRole=(role:string)=>registry.nurseRoles.includes(role)||registry.supportRoles.includes(role);
export function assignedClinical(actor:Actor,c:any,profileApproved:boolean){
 return profileApproved&&(String(c.nurse_id)===actor.id&&registry.nurseRoles.includes(actor.roles)||String(c.supervisor_id)===actor.id&&registry.supervisorRoles.includes(actor.roles)||String(c.worker_id)===actor.id&&registry.supportRoles.includes(actor.roles)&&!['cancelled','coverage_needed'].includes(c.state));
}
export function clearanceBody(v:Record<string,unknown>){
 keys(v,['staffId','version','status','expiresOn','registration','evidence','checked','profile']);
 if(!identifier(v.staffId)||!['active','revoked'].includes(String(v.status))||!text(v.registration,100,true)||!paragraph(v.evidence)||v.checked!==true)fail(400);
 if(v.profile!==undefined){const p=v.profile as Record<string,unknown>;if(!p||typeof p!=='object'||Array.isArray(p))fail(400);keys(p,['fullName','languages','serviceAreas','skills','approved']);if(v.status!=='active'||p.approved!==true||!['fullName','languages','serviceAreas','skills'].every(k=>text(p[k],1000)))fail(400);}
 const version=integer(v.version,2147483646),expiresOn=date(v.expiresOn),today=new Date().toISOString().slice(0,10);
 if(expiresOn<today||Date.parse(expiresOn)>Date.parse(today)+registry.maxClearanceDays*86400000)fail(400);
 return {...v,version,expiresOn,staffId:String(v.staffId),evidence:String(v.evidence).trim(),registration:String(v.registration).trim()};
}
export function caseBody(v:Record<string,unknown>){
 keys(v,['visitId','nurseId','supervisorId','workerId','evidence']);
 if(!['visitId','nurseId','supervisorId','workerId'].every(k=>identifier(v[k]))||!paragraph(v.evidence)||new Set([v.nurseId,v.supervisorId,v.workerId]).size!==3)fail(400);
 return v;
}
export function staffingBody(v:Record<string,unknown>){
 const action=String(v.action),create=['availability','request_leave'].includes(action);
 if(!registry.staffingPolicy.actions.includes(action)||!paragraph(v.note))fail(400);
 keys(v,['action','note',...(create?['staffId','startsAt','endsAt']:['id','version'])]);
 if(!create){if(!uuid(v.id))fail(400);const version=integer(v.version,3);if(!version)fail(400);return {...v,action,version};}
 if(!identifier(v.staffId))fail(400);
 const startsAt=timestamp(v.startsAt)!,endsAt=timestamp(v.endsAt)!,start=Date.parse(startsAt),end=Date.parse(endsAt),p=registry.staffingPolicy;
 if(end<=start||end-start>p.maxWindowDays*86400000||start<Date.now()-p.maxPastDays*86400000||end>Date.now()+p.maxFutureDays*86400000)fail(400);
 return {...v,action,startsAt,endsAt};
}
export function actionBody(v:Record<string,unknown>){
 const action=String(v.action),extra:Record<string,string[]>={save_plan:['assessment','risks','escalation','consentEvidence','consentChecked','validUntil','tasks'],start:['consentChecked'],task:['taskId','outcome'],follow_up:['eventId'],reassign:['nurseId','supervisorId','workerId'],report_unavailable:['reason'],reschedule:['startsAt','durationMinutes','confirmed'],cancel_visit:['confirmed']};
 if(!registry.actions.includes(action)||!paragraph(v.note))fail(400);
 keys(v,['version','action','note',...(extra[action]??[])]);const version=integer(v.version,2147483646);if(!version)fail(400);
 if(action==='save_plan'){
  if(!['assessment','risks','escalation','consentEvidence'].every(k=>paragraph(v[k]))||v.consentChecked!==true||!Array.isArray(v.tasks)||!v.tasks.length||v.tasks.length>registry.maxTasks)fail(400);
  const until=timestamp(v.validUntil)!;if(Date.parse(until)<=Date.now()||Date.parse(until)>Date.now()+registry.maxPlanDays*86400000)fail(400);
  for(const task of v.tasks as any[]){if(!task||typeof task!=='object'||Array.isArray(task))fail(400);keys(task,['kind','instructions']);if(!registry.taskKinds.includes(task.kind)||!paragraph(task.instructions,1000))fail(400);}
 }else if(action==='start'&&v.consentChecked!==true||action==='task'&&(!uuid(v.taskId)||!registry.outcomes.includes(String(v.outcome)))||action==='follow_up'&&!uuid(v.eventId))fail(400);
 if(action==='reassign'&&(!['nurseId','supervisorId','workerId'].every(k=>identifier(v[k]))||new Set([v.nurseId,v.supervisorId,v.workerId]).size!==3))fail(400);
 if(action==='reschedule'){const start=timestamp(v.startsAt)!;const duration=integer(v.durationMinutes,registry.schedulePolicy.maxDurationMinutes);if(v.confirmed!==true||duration<registry.schedulePolicy.minDurationMinutes||Date.parse(start)<=Date.now()||Date.parse(start)+duration*60000>Date.now()+registry.schedulePolicy.maxDaysAhead*86400000)fail(400);}
 if(action==='cancel_visit'&&v.confirmed!==true)fail(400);
 if(action==='report_unavailable'&&!registry.taskPolicy.unavailableReasons.includes(String(v.reason)))fail(400);
 return {...v,action,version,note:String(v.note).trim()};
}
export function allowedActions(actor:Actor,c:any,eligible:boolean){
 const assigned=[c.nurse_id,c.supervisor_id,c.worker_id].map(String).includes(actor.id),out:string[]=[];
 if(assigned&&!['cancelled','coverage_needed'].includes(c.state))out.push('concern','amendment');
 if(operational(actor)&&['awaiting_plan','draft','pending_review','ready','accepted','cancelled','coverage_needed'].includes(c.state))out.push('reassign');
 if(operational(actor)&&['awaiting_plan','draft','pending_review','ready','accepted','coverage_needed'].includes(c.state))out.push('cancel','reschedule','cancel_visit');
 if(String(c.worker_id)===actor.id&&registry.supportRoles.includes(actor.roles)){
  if(['awaiting_plan','draft','pending_review','ready','accepted'].includes(c.state))out.push('report_unavailable');
  if(c.state==='correction_requested')out.push('submit_visit');
 }
 if(String(c.worker_id)===actor.id&&registry.supportRoles.includes(actor.roles)&&c.state==='in_progress')out.push('task','submit_visit');
 if(!eligible)return out;
 if(String(c.nurse_id)===actor.id){if(['awaiting_plan','draft'].includes(c.state))out.push('save_plan');if(c.state==='draft')out.push('submit_plan');}
 if(String(c.supervisor_id)===actor.id&&registry.supervisorRoles.includes(actor.roles)){if(c.state==='pending_review'&&String(c.plan_author)!==actor.id)out.push('approve_plan','return_plan');if(c.state==='submitted')out.push('complete_review','return_visit');}
 if([c.nurse_id,c.supervisor_id].map(String).includes(actor.id))out.push('follow_up');
 if(String(c.worker_id)===actor.id&&registry.supportRoles.includes(actor.roles)){if(c.state==='ready')out.push('accept');if(c.state==='accepted')out.push('start');if(c.state==='in_progress')out.push('task','submit_visit');}
 return [...new Set(out)];
}
