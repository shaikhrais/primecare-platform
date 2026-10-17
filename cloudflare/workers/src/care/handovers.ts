import {registry,assignedClinical,operational,canonical,fail} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import {sha256} from '../auth';
import {eligible} from './qualification';
import {lockStaffSchedule} from './staffing';
import type {CareRepository} from './repository';

const receivingStates=['awaiting_plan','draft','pending_review','ready','accepted'];
const activeVisit=(c:any)=>!['cancelled','completed','rejected'].includes(String(c.visit_status));
async function signature(repo:CareRepository,c:any){
 const revision=requiredRow((await repo.db.query("SELECT COALESCE(MAX(record_version),1)::int AS n FROM care_events WHERE tenant_id::text=$1 AND case_id=$2 AND action IN ('assigned','reassign','reschedule')",[repo.actor.tenant_id,c.id])).rows).n;
 return sha256(canonical({nurse:String(c.nurse_id),supervisor:String(c.supervisor_id),worker:String(c.worker_id),start:new Date(c.requested_start_at).toISOString(),duration:c.duration_minutes,revision}));
}
async function pair(repo:CareRepository,sourceId:string,targetId:string,lock=false){
 const rows=(await repo.db.query('SELECT c.*,v.client_id::text,v.requested_start_at,v.duration_minutes,v.status AS visit_status FROM care_cases c JOIN visits v ON v.id=c.visit_id AND v.tenant_id=c.tenant_id WHERE c.tenant_id::text=$1 AND c.id=ANY($2::uuid[]) ORDER BY c.id'+(lock?' FOR UPDATE OF c,v':''),[repo.actor.tenant_id,[sourceId,targetId]])).rows;
 if(rows.length!==2)fail(404,'not_found');return {source:rows.find(c=>c.id===sourceId),target:rows.find(c=>c.id===targetId)};
}
function sourceReviewer(repo:CareRepository,c:any,h:any,self:any){return eligible(self)&&registry.nurseRoles.includes(self.roles)&&[c.nurse_id,c.supervisor_id].map(String).includes(repo.actor.id)&&String(h.author_id)!==repo.actor.id;}

export async function authorizeHandover(repo:CareRepository,v:any){
 const h:any=v.action==='create'?null:optionalRow((await repo.db.query('SELECT * FROM care_handovers WHERE tenant_id::text=$1 AND id=$2 FOR UPDATE',[repo.actor.tenant_id,v.id])).rows);
 if(v.action!=='create'&&!h)fail(404,'not_found');
 const {source,target}=await pair(repo,String(h?.source_case_id??v.sourceCaseId),String(h?.target_case_id??v.targetCaseId),true);
 await lockStaffSchedule(repo,[source.nurse_id,source.supervisor_id,source.worker_id,target.nurse_id,target.supervisor_id,target.worker_id].map(String));
 const self=await repo.staffOne(repo.actor.id,true),sourceRead=assignedClinical(repo.actor,source,self.profile_approved===true),targetRead=assignedClinical(repo.actor,target,self.profile_approved===true);
 if(!sourceRead&&!targetRead&&!operational(repo.actor))fail(404,'not_found');
 const allowed=v.action==='create'?sourceRead:v.action==='revise'?sourceRead&&String(h.author_id)===repo.actor.id:v.action==='acknowledge'?targetRead&&eligible(self):sourceRead&&sourceReviewer(repo,source,h,self);
 if(!allowed)fail(403,'forbidden');return {h,source,target,self};
}
export async function handoverCommand(repo:CareRepository,context:any,v:any){
 const {h,source,target}=context,{actor,db}=repo;
 if(source.client_id!==target.client_id||!source.started_at||new Date(target.requested_start_at).getTime()<=new Date(source.requested_start_at).getTime())fail(400);
 if(!receivingStates.includes(target.state)||!activeVisit(target))fail(409,'conflict');
 if(h&&h.version!==v.version)fail(409,'conflict');
 if(v.action==='acknowledge'){
  if(h.status!=='approved')fail(409,'handover_pending');const targetSignature=await signature(repo,target),id=crypto.randomUUID();
  const existing=optionalRow((await db.query('SELECT id FROM care_handover_receipts WHERE tenant_id::text=$1 AND handover_id=$2 AND approved_version=$3 AND target_signature=$4 AND actor_id::text=$5',[actor.tenant_id,h.id,h.version,targetSignature,actor.id])).rows);if(existing)fail(409,'conflict');
  await db.query('INSERT INTO care_handover_receipts(id,tenant_id,handover_id,approved_version,target_signature,actor_id,note) VALUES($1,$2,$3,$4,$5,$6,$7)',[id,actor.tenant_id,h.id,h.version,targetSignature,actor.id,v.note]);await repo.access(target.id,'handover_receipt');return {id:h.id,version:h.version,acknowledged:true};
 }
 if(h&&(h.version>=registry.handoverPolicy.maxVersions||['revise','return'].includes(v.action)&&h.version>=registry.handoverPolicy.maxVersions-1))fail(413,'record_limit');
 const id=h?.id??crypto.randomUUID(),version=(h?.version??0)+1;
 let status='pending',payload:any={note:v.note};
 if(v.action==='create'){
  for(const c of [source,target]){const count=requiredRow((await db.query('SELECT COUNT(*)::int AS n FROM care_handovers WHERE tenant_id::text=$1 AND (source_case_id=$2 OR target_case_id=$2)',[actor.tenant_id,c.id])).rows).n;if(Number(count)>=registry.handoverPolicy.maxPerCase)fail(413,'record_limit');}
  await db.query("INSERT INTO care_handovers(id,tenant_id,source_case_id,target_case_id,author_id,status,version,summary,outstanding,precautions) VALUES($1,$2,$3,$4,$5,'pending',1,$6,$7,$8)",[id,actor.tenant_id,source.id,target.id,actor.id,v.summary,v.outstanding,v.precautions]);
 }else{
  if(v.action==='revise'){if(!['returned','approved'].includes(h.status))fail(409,'conflict');}
  else if(v.action==='approve'||v.action==='return'){if(h.status!=='pending')fail(409,'conflict');status=v.action==='approve'?'approved':'returned';}
  else if(v.action==='withdraw'){if(!['pending','returned'].includes(h.status))fail(409,'conflict');status='withdrawn';}
  await db.query('UPDATE care_handovers SET status=$1,version=$2,summary=$3,outstanding=$4,precautions=$5,reviewer_id=$6,updated_at=NOW() WHERE tenant_id::text=$7 AND id=$8',[status,version,v.action==='revise'?v.summary:h.summary,v.action==='revise'?v.outstanding:h.outstanding,v.action==='revise'?v.precautions:h.precautions,v.action==='revise'?null:actor.id,actor.tenant_id,id]);
 }
 if(['create','revise'].includes(v.action))Object.assign(payload,{summary:v.summary,outstanding:v.outstanding,precautions:v.precautions});
 await db.query('INSERT INTO care_handover_events(id,tenant_id,handover_id,actor_id,action,version,payload) VALUES($1,$2,$3,$4,$5,$6,$7)',[crypto.randomUUID(),actor.tenant_id,id,actor.id,v.action,version,JSON.stringify(payload)]);
 if(v.action==='approve'&&['ready','accepted'].includes(target.state)){
  const row=requiredRow((await db.query("UPDATE care_cases SET state='draft',plan_reviewer=NULL,version=version+1,updated_at=NOW() WHERE tenant_id::text=$1 AND id=$2 RETURNING version",[actor.tenant_id,target.id])).rows);
  await repo.event(target.id,'handover_received',{note:registry.locales.en.handover_received,handoverId:id},Number(row.version));
 }
 await repo.access(source.id,'handover_'+v.action);return {id,version,status};
}

export async function handoverGate(repo:CareRepository,target:any,workerRequired:boolean){
 const hands=(await repo.db.query("SELECT id,status,version FROM care_handovers WHERE tenant_id::text=$1 AND target_case_id=$2 AND status<>'withdrawn'",[repo.actor.tenant_id,target.id])).rows;
 if(!hands.length)return null;if(hands.some(h=>h.status!=='approved'))return 'handover_pending';
 const sig=await signature(repo,target),receipts=(await repo.db.query('SELECT handover_id,approved_version,actor_id::text FROM care_handover_receipts WHERE tenant_id::text=$1 AND handover_id=ANY($2::uuid[]) AND target_signature=$3',[repo.actor.tenant_id,hands.map(h=>h.id),sig])).rows;
 for(const h of hands){const actors=receipts.filter(r=>r.handover_id===h.id&&r.approved_version===h.version).map(r=>r.actor_id);if(!actors.some(a=>[target.nurse_id,target.supervisor_id].map(String).includes(a))||workerRequired&&!actors.includes(String(target.worker_id)))return 'handover_receipts_needed';}
 return null;
}

export async function handoverDetail(repo:CareRepository,c:any,self:any){
 const rows=(await repo.db.query('SELECT * FROM care_handovers WHERE tenant_id::text=$1 AND (source_case_id=$2 OR target_case_id=$2) ORDER BY created_at,id LIMIT $3',[repo.actor.tenant_id,c.id,registry.handoverPolicy.maxPerCase+1])).rows;if(rows.length>registry.handoverPolicy.maxPerCase)fail(413,'record_limit');
 const records=[];
 for(const h of rows){
  const {source,target}=await pair(repo,String(h.source_case_id),String(h.target_case_id)),sourceRead=assignedClinical(repo.actor,source,self.profile_approved===true),targetRead=assignedClinical(repo.actor,target,self.profile_approved===true),clinical=sourceRead||targetRead&&h.status==='approved',sig=await signature(repo,target);
  const events=sourceRead?(await repo.db.query('SELECT actor_id::text,action,version,payload,created_at FROM care_handover_events WHERE tenant_id::text=$1 AND handover_id=$2 ORDER BY version',[repo.actor.tenant_id,h.id])).rows:[];
  const receipts=(await repo.db.query('SELECT actor_id::text,created_at FROM care_handover_receipts WHERE tenant_id::text=$1 AND handover_id=$2 AND approved_version=$3 AND target_signature=$4',[repo.actor.tenant_id,h.id,h.version,sig])).rows;
  const canChange=receivingStates.includes(target.state)&&activeVisit(target),review=canChange&&sourceRead&&sourceReviewer(repo,source,h,self)&&h.version<registry.handoverPolicy.maxVersions;
  const actions=review?(h.status==='pending'?['approve','return','withdraw']:h.status==='returned'?['withdraw']:[]):[];
  if(h.version>=registry.handoverPolicy.maxVersions-1){const i=actions.indexOf('return');if(i>=0)actions.splice(i,1);}
  if(canChange&&h.status==='approved'&&targetRead&&eligible(self)&&!receipts.some(r=>r.actor_id===repo.actor.id))actions.push('acknowledge');
  records.push({id:h.id,sourceCaseId:h.source_case_id,targetCaseId:h.target_case_id,authorId:h.author_id,status:h.status,version:h.version,clinical,...(clinical?{summary:h.summary,outstanding:h.outstanding,precautions:h.precautions}:{}),events,receipts,actions,canRevise:canChange&&sourceRead&&String(h.author_id)===repo.actor.id&&['returned','approved'].includes(h.status)&&h.version<registry.handoverPolicy.maxVersions-1});
 }
 const canCreate=!!c.started_at&&assignedClinical(repo.actor,c,self.profile_approved===true)&&rows.length<registry.handoverPolicy.maxPerCase;
 const targets=canCreate?(await repo.db.query("SELECT t.id,t.visit_id::text,v.requested_start_at FROM care_cases t JOIN visits v ON v.id=t.visit_id AND v.tenant_id=t.tenant_id JOIN visits s ON s.id=$1 AND s.tenant_id=t.tenant_id WHERE t.tenant_id::text=$2 AND t.id<>$3 AND v.client_id=s.client_id AND v.requested_start_at>s.requested_start_at AND t.state IN ('awaiting_plan','draft','pending_review','ready','accepted') AND COALESCE(v.status,'requested') NOT IN ('cancelled','completed','rejected') ORDER BY v.requested_start_at,t.id LIMIT 100",[c.visit_id,repo.actor.tenant_id,c.id])).rows:[];
 return {records,canCreate,targets};
}
export async function handoverSnapshot(repo:CareRepository,offset:number){
 const {db,actor}=repo,where='h.tenant_id::text=$1 AND ($2 OR $3 IN (s.nurse_id::text,s.supervisor_id::text,s.worker_id::text,t.nurse_id::text,t.supervisor_id::text,t.worker_id::text))',join=' FROM care_handovers h JOIN care_cases s ON s.id=h.source_case_id AND s.tenant_id=h.tenant_id JOIN care_cases t ON t.id=h.target_case_id AND t.tenant_id=h.tenant_id';
 const total=requiredRow((await db.query('SELECT COUNT(*)::int AS n'+join+' WHERE '+where,[actor.tenant_id,operational(actor),actor.id])).rows).n;
 const records=(await db.query('SELECT h.id,h.source_case_id,h.target_case_id,h.status,h.version,s.nurse_id::text AS source_nurse,s.supervisor_id::text AS source_supervisor,s.worker_id::text AS source_worker'+join+' WHERE '+where+" ORDER BY (h.status='pending') DESC,h.created_at DESC,h.id LIMIT $4 OFFSET $5",[actor.tenant_id,operational(actor),actor.id,registry.handoverPolicy.pageSize,offset])).rows.map(h=>({...h,openCaseId:[h.source_nurse,h.source_supervisor,h.source_worker].includes(actor.id)?h.source_case_id:operational(actor)?h.source_case_id:h.target_case_id}));
 return {records,total,offset,limit:registry.handoverPolicy.pageSize};
}
