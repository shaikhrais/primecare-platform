import {registry,operational,fail} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import type {CareRepository} from './repository';

export const timeNeedsSubmissionSql="(c.started_at IS NOT NULL AND c.state IN ('submitted','completed','correction_requested') AND NOT EXISTS(SELECT 1 FROM care_time_records t WHERE t.tenant_id=c.tenant_id AND t.case_id=c.id AND t.status IN ('pending','approved')))";
export const timeReviewPendingSql="EXISTS(SELECT 1 FROM care_time_records t WHERE t.tenant_id=c.tenant_id AND t.case_id=c.id AND t.status='pending')";

export async function authorizeTime(repo:CareRepository,v:any){
 const c=await repo.currentCase(v.caseId,true),own=String(c.worker_id)===repo.actor.id;
 if(v.action==='submit'?!own||!registry.supportRoles.includes(repo.actor.roles):!operational(repo.actor)||own)fail(403,'forbidden');
 return c;
}
export async function timeCommand(repo:CareRepository,c:any,v:any){
 const {db,actor}=repo,previous=optionalRow((await db.query('SELECT * FROM care_time_records WHERE tenant_id::text=$1 AND case_id=$2 FOR UPDATE',[actor.tenant_id,v.caseId])).rows);
 if((previous?.version??0)!==v.version)fail(409,'conflict');
 let payload:any={note:v.note},status:string;
 if(v.action==='submit'){
  if(!c.started_at||!['submitted','completed','correction_requested'].includes(c.state)||previous&&previous.status!=='returned')fail(409,'conflict');
  status='pending';Object.assign(payload,{actualStart:v.actualStart,actualEnd:v.actualEnd,breakMinutes:v.breakMinutes,netMinutes:v.netMinutes,attested:true});
  await db.query("INSERT INTO care_time_records(tenant_id,case_id,worker_id,status,version,actual_start,actual_end,break_minutes,net_minutes) VALUES($1,$2,$3,'pending',1,$4,$5,$6,$7) ON CONFLICT(tenant_id,case_id) DO UPDATE SET status='pending',version=care_time_records.version+1,actual_start=EXCLUDED.actual_start,actual_end=EXCLUDED.actual_end,break_minutes=EXCLUDED.break_minutes,net_minutes=EXCLUDED.net_minutes,reviewer_id=NULL,updated_at=NOW()",[actor.tenant_id,v.caseId,c.worker_id,v.actualStart,v.actualEnd,v.breakMinutes,v.netMinutes]);
 }else{
  if(!previous||v.action==='approve'&&previous.status!=='pending'||v.action==='return'&&!['pending','approved'].includes(String(previous.status)))fail(409,'conflict');
  status=v.action==='approve'?'approved':'returned';Object.assign(payload,{checked:v.action==='approve',recordedVersion:previous.version,clinicalStatus:c.state});
  await db.query('UPDATE care_time_records SET status=$1,version=version+1,reviewer_id=$2,updated_at=NOW() WHERE tenant_id::text=$3 AND case_id=$4',[status,actor.id,actor.tenant_id,v.caseId]);
 }
 await db.query('INSERT INTO care_time_events(id,tenant_id,case_id,actor_id,action,version,payload) VALUES($1,$2,$3,$4,$5,$6,$7)',[crypto.randomUUID(),actor.tenant_id,v.caseId,actor.id,v.action,v.version+1,JSON.stringify(payload)]);
 await repo.access(v.caseId,'time_'+v.action);return {caseId:v.caseId,version:v.version+1,status};
}
export async function timeDetail(repo:CareRepository,c:any){
 const own=String(c.worker_id)===repo.actor.id,manager=operational(repo.actor);if(!own&&!manager)return null;
 const report:any=optionalRow((await repo.db.query('SELECT * FROM care_time_records WHERE tenant_id::text=$1 AND case_id=$2',[repo.actor.tenant_id,c.id])).rows);
 const events=report?(await repo.db.query('SELECT actor_id::text,action,version,payload,created_at FROM care_time_events WHERE tenant_id::text=$1 AND case_id=$2 ORDER BY version LIMIT 51',[repo.actor.tenant_id,c.id])).rows:[];
 if(events.length>registry.timePolicy.maxVersions)fail(413,'record_limit');
 return {report,events,electronicStart:c.started_at,clinicalStatus:c.state,discrepancy:!!report&&Math.abs(new Date(report.actual_start).getTime()-new Date(c.started_at).getTime())>registry.timePolicy.discrepancyMinutes*60000,canSubmit:(!report||report.version<registry.timePolicy.maxVersions)&&own&&registry.supportRoles.includes(repo.actor.roles)&&!!c.started_at&&['submitted','completed','correction_requested'].includes(c.state)&&(!report||report.status==='returned'),actions:manager&&!own&&report&&report.version<registry.timePolicy.maxVersions?(report.status==='pending'?['approve','return']:report.status==='approved'?['return']:[]):[]};
}
export async function timeSnapshot(repo:CareRepository,offset:number){
 const {actor,db}=repo,manager=operational(actor),where='r.tenant_id::text=$1 AND ($2 OR r.worker_id::text=$3)';
 const totals=requiredRow((await db.query("SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE r.status='pending')::int AS pending,COUNT(*) FILTER(WHERE r.status='returned')::int AS returned FROM care_time_records r WHERE "+where,[actor.tenant_id,manager,actor.id])).rows);
 const records=(await db.query('SELECT r.case_id,r.worker_id::text,r.status,r.net_minutes,r.version,c.visit_id::text FROM care_time_records r JOIN care_cases c ON c.id=r.case_id AND c.tenant_id=r.tenant_id WHERE '+where+" ORDER BY (r.status='pending') DESC,r.updated_at DESC,r.case_id LIMIT $4 OFFSET $5",[actor.tenant_id,manager,actor.id,registry.timePolicy.pageSize,offset])).rows;
 return {...totals,records,offset,limit:registry.timePolicy.pageSize};
}
