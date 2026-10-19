import {registry,operational,clinicalRole,fail,type Actor} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import type {CareRepository} from './repository';

export const preStartSql="c.state IN ('awaiting_plan','draft','pending_review','ready','accepted')";
const endSql='v.requested_start_at+v.duration_minutes*INTERVAL \'1 minute\'';
export const staffingReasonSql=`CASE
 WHEN v.requested_start_at IS NULL OR v.duration_minutes IS NULL OR v.duration_minutes<=0 THEN 'schedule_invalid'
 WHEN EXISTS(SELECT 1 FROM care_staff_windows w WHERE w.tenant_id=c.tenant_id AND w.staff_id IN (c.nurse_id,c.supervisor_id,c.worker_id) AND w.kind='leave' AND w.status='approved' AND w.starts_at<${endSql} AND w.ends_at>v.requested_start_at) THEN 'leave_conflict'
 WHEN NOT EXISTS(SELECT 1 FROM care_staff_windows w WHERE w.tenant_id=c.tenant_id AND w.staff_id=c.worker_id AND w.kind='availability' AND w.status='active' AND w.starts_at<=v.requested_start_at AND w.ends_at>=${endSql}) THEN 'availability_missing'
 WHEN EXISTS(SELECT 1 FROM visits x LEFT JOIN care_cases other ON other.visit_id=x.id AND other.tenant_id=x.tenant_id WHERE x.tenant_id=v.tenant_id AND x.assigned_provider_id=v.assigned_provider_id AND x.id<>v.id AND COALESCE(x.status,'requested') NOT IN ('cancelled','rejected','completed') AND (other.id IS NULL OR other.state NOT IN ('cancelled','coverage_needed','completed')) AND (x.requested_start_at IS NULL OR x.duration_minutes IS NULL OR x.duration_minutes<=0 OR x.requested_start_at<${endSql} AND x.requested_start_at+x.duration_minutes*INTERVAL '1 minute'>v.requested_start_at)) THEN 'visit_overlap'
 END`;
export const staffingBlockedSql=`(${preStartSql} AND (${staffingReasonSql}) IS NOT NULL)`;

export async function lockStaffSchedule(repo:CareRepository,ids:string[]){
 for(const id of [...new Set(ids)].sort())await repo.db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['care-schedule:'+repo.actor.tenant_id+':'+id]);
}

export async function checkStaffing(repo:CareRepository,visitId:string,nurseId:string,supervisorId:string,workerId:string,providerId:string,lock=true){
 if(lock)await lockStaffSchedule(repo,[nurseId,supervisorId,workerId]);
 const {db,actor}=repo;
 const visit=requiredRow((await db.query('SELECT requested_start_at,duration_minutes FROM visits WHERE id::text=$1 AND tenant_id::text=$2',[visitId,actor.tenant_id])).rows);
 const rawStart=visit.requested_start_at,start=rawStart instanceof Date?rawStart.getTime():typeof rawStart==='string'?Date.parse(rawStart):NaN,duration=Number(visit.duration_minutes);
 if(!visit.requested_start_at||!Number.isFinite(start)||!Number.isInteger(duration)||duration<=0)return 'schedule_invalid';
 const end=new Date(start+duration*60000).toISOString(),from=new Date(start).toISOString();
 const leave=optionalRow((await db.query("SELECT id FROM care_staff_windows WHERE tenant_id::text=$1 AND staff_id::text=ANY($2::text[]) AND kind='leave' AND status='approved' AND starts_at<$4::timestamptz AND ends_at>$3::timestamptz LIMIT 1",[actor.tenant_id,[nurseId,supervisorId,workerId],from,end])).rows);
 if(leave)return 'leave_conflict';
 const available=optionalRow((await db.query("SELECT id FROM care_staff_windows WHERE tenant_id::text=$1 AND staff_id::text=$2 AND kind='availability' AND status='active' AND starts_at<=$3::timestamptz AND ends_at>=$4::timestamptz LIMIT 1",[actor.tenant_id,workerId,from,end])).rows);
 if(!available)return 'availability_missing';
 const overlap=optionalRow((await db.query("SELECT x.id FROM visits x LEFT JOIN care_cases c ON c.visit_id=x.id AND c.tenant_id=x.tenant_id WHERE x.tenant_id::text=$1 AND x.assigned_provider_id::text=$2 AND x.id::text<>$3 AND COALESCE(x.status,'requested') NOT IN ('cancelled','rejected','completed') AND (c.id IS NULL OR c.state NOT IN ('cancelled','coverage_needed','completed')) AND (x.requested_start_at IS NULL OR x.duration_minutes IS NULL OR x.duration_minutes<=0 OR x.requested_start_at<$5::timestamptz AND x.requested_start_at+x.duration_minutes*INTERVAL '1 minute'>$4::timestamptz) LIMIT 1",[actor.tenant_id,providerId,visitId,from,end])).rows);
 return overlap?'visit_overlap':null;
}

export function staffingActions(actor:Actor,w:any){
 const own=String(w.staff_id)===actor.id,manager=operational(actor),actions:string[]=[];
 if((own||manager)&&(w.kind==='availability'&&w.status==='active'||w.kind==='leave'&&w.status==='pending'))actions.push('withdraw');
 if(manager&&!own&&w.kind==='leave'){if(w.status==='pending')actions.push('approve_leave','reject_leave');if(w.status==='approved')actions.push('revoke_leave');}
 return actions;
}

export async function authorizeStaffing(repo:CareRepository,v:any){
 const {actor,db}=repo;
 if(['availability','request_leave'].includes(v.action)){
  const target=await repo.staffOne(v.staffId,true);
  if(!clinicalRole(target.roles)||!operational(actor)&&actor.id!==v.staffId)fail(403,'forbidden');return null;
 }
 const w=optionalRow((await db.query('SELECT * FROM care_staff_windows WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[v.id,actor.tenant_id])).rows);
 if(!w||!operational(actor)&&String(w.staff_id)!==actor.id)fail(404,'not_found');
 if(['approve_leave','reject_leave','revoke_leave'].includes(v.action)&&(!operational(actor)||String(w.staff_id)===actor.id))fail(403,'forbidden');
 return w;
}

export async function staffingCommand(repo:CareRepository,v:any,context:any){
 const {db,actor}=repo,create=['availability','request_leave'].includes(v.action),staffId=create?v.staffId:String(context.staff_id);
 await lockStaffSchedule(repo,[staffId]);
 let id:string,version:number;
 if(create){
  id=crypto.randomUUID();version=1;await db.query('INSERT INTO care_staff_windows(id,tenant_id,staff_id,kind,starts_at,ends_at,status,version,created_by) VALUES($1,$2,$3,$4,$5,$6,$7,1,$8)',[id,actor.tenant_id,staffId,v.action==='availability'?'availability':'leave',v.startsAt,v.endsAt,v.action==='availability'?'active':'pending',actor.id]);
 }else{
  if(context.version!==v.version||!staffingActions(actor,context).includes(v.action))fail(409,'conflict');
  const status=({withdraw:'withdrawn',approve_leave:'approved',reject_leave:'rejected',revoke_leave:'revoked'} as Record<string,string>)[v.action];
  id=v.id;version=v.version+1;const row=requiredRow((await db.query('UPDATE care_staff_windows SET status=$1,version=version+1,updated_at=NOW() WHERE id=$2 AND tenant_id::text=$3 AND version=$4 RETURNING version',[status,id,actor.tenant_id,v.version])).rows);if(row.version!==version)throw Error('Invalid staffing version');
 }
 await db.query('INSERT INTO care_staffing_events(id,tenant_id,window_id,actor_id,action,version,note) VALUES($1,$2,$3,$4,$5,$6,$7)',[crypto.randomUUID(),actor.tenant_id,id,actor.id,v.action,version,v.note]);
 await repo.access(null,'staffing_'+v.action);return {id,version};
}

export async function staffingSnapshot(repo:CareRepository,offset:number,staff?:string,knownStaff?:any[]){
 const {db,actor}=repo,manager=operational(actor),selfClinical=clinicalRole(actor.roles),selected=manager?(staff??null):actor.id;
 if(!manager&&staff&&staff!==actor.id)fail(403,'forbidden');
 const selectedPerson=staff?await repo.staffOne(staff):undefined;
 const filter='tenant_id::text=$1 AND ($2::text IS NULL OR staff_id::text=$2)';
 const total=requiredRow((await db.query('SELECT COUNT(*)::int AS n FROM care_staff_windows WHERE '+filter,[actor.tenant_id,selected])).rows).n;
 const records=(await db.query('SELECT id,staff_id::text,kind,starts_at,ends_at,status,version,created_by::text FROM care_staff_windows WHERE '+filter+" ORDER BY (status='pending') DESC,starts_at DESC,id LIMIT $3 OFFSET $4",[actor.tenant_id,selected,registry.staffingPolicy.pageSize,offset])).rows;
 const events=records.length?(await db.query('SELECT window_id,actor_id::text,action,version,note,created_at FROM care_staffing_events WHERE tenant_id::text=$1 AND window_id=ANY($2::uuid[]) ORDER BY window_id,version',[actor.tenant_id,records.map(w=>w.id)])).rows:[];
 if(events.length>records.length*3)throw Error('Invalid staffing history');
 const found=manager&&knownStaff?knownStaff:await repo.staff(manager?null:[actor.id]),people=selectedPerson&&!found.some(p=>p.id===selectedPerson.id)?[selectedPerson,...found]:found;
 return {records:records.map(w=>({...w,actions:staffingActions(actor,w),events:events.filter(e=>e.window_id===w.id)})),total,offset,limit:registry.staffingPolicy.pageSize,canManage:manager,canCreate:manager||selfClinical,createActions:['availability','request_leave'],staffOptions:people.filter(p=>clinicalRole(p.roles)).slice(0,200).map(p=>({id:p.id,label:p.email}))};
}
