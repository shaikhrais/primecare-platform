import {registry,operational,fail,canonical} from '../../../../packages/shared/src/care/contract';
import {optionalRow,requiredRow} from '../database-results';
import {visitPicker} from './visit-picker';
import {sha256} from '../auth';
import type {CareRepository} from './repository';

export async function lockClientSchedule(repo:CareRepository,clientId:string){await repo.db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['care-client-schedule:'+repo.actor.tenant_id+':'+clientId]);}
export async function clientConflict(repo:CareRepository,clientId:string,startsAt:string,duration:number,exclude:string){
 return !!optionalRow((await repo.db.query("SELECT id FROM visits WHERE tenant_id::text=$1 AND client_id::text=$2 AND id::text<>$3 AND COALESCE(status,'requested') NOT IN ('cancelled','rejected','completed') AND (requested_start_at IS NULL OR duration_minutes IS NULL OR duration_minutes<=0 OR requested_start_at<$4::timestamptz+$5*INTERVAL '1 minute' AND requested_start_at+duration_minutes*INTERVAL '1 minute'>$4::timestamptz) LIMIT 1",[repo.actor.tenant_id,clientId,exclude,startsAt,duration])).rows);
}
export async function scheduleCommand(repo:CareRepository,v:any){
 const {db,actor}=repo;if(!operational(actor))fail(403,'forbidden');
 if(v.action==='cancel_occurrence'){
  const visit:any=optionalRow((await db.query('SELECT v.id,v.client_id::text,v.updated_at,v.status,v.requested_start_at FROM visits v JOIN care_series_visits m ON m.visit_id=v.id AND m.tenant_id=v.tenant_id WHERE v.id::text=$1 AND v.tenant_id::text=$2 FOR UPDATE OF v',[v.visitId,actor.tenant_id])).rows);
  if(!visit)fail(404,'not_found');
  if(new Date(visit.updated_at).toISOString()!==v.updatedAt||new Date(visit.requested_start_at).getTime()<=Date.now()||['completed','cancelled','rejected'].includes(String(visit.status)))fail(409,'conflict');
  await lockClientSchedule(repo,visit.client_id);
  if(optionalRow((await db.query('SELECT id FROM care_cases WHERE tenant_id::text=$1 AND visit_id::text=$2',[actor.tenant_id,v.visitId])).rows))fail(409,'conflict');
  await db.query("UPDATE visits SET status='cancelled',updated_at=NOW() WHERE id::text=$1 AND tenant_id::text=$2",[v.visitId,actor.tenant_id]);
  await db.query("INSERT INTO care_schedule_events(id,tenant_id,visit_id,actor_id,action,payload) VALUES($1,$2,$3,$4,'cancel_occurrence',$5)",[crypto.randomUUID(),actor.tenant_id,v.visitId,actor.id,JSON.stringify({note:v.note})]);
  await repo.access(null,'schedule_cancel');return {visitId:v.visitId};
 }
 const source:any=optionalRow((await db.query("SELECT v.*,p.full_name,u.status AS client_status,s.is_active AS service_active,s.name AS service_name FROM visits v JOIN client_profiles p ON p.id=v.client_id AND p.tenant_id=v.tenant_id JOIN users u ON u.id=p.user_id AND u.tenant_id=p.tenant_id JOIN services s ON s.id=v.service_id AND s.tenant_id=v.tenant_id WHERE v.id::text=$1 AND v.tenant_id::text=$2 FOR SHARE OF v,u,s",[v.sourceVisitId,actor.tenant_id])).rows);
 if(!source)fail(404,'not_found');if(String(source.client_status).toLowerCase()!=='active'||source.service_active!==true||!source.required_skills?.trim()||['cancelled','rejected'].includes(String(source.status)))fail(409,'conflict');
 await lockClientSchedule(repo,String(source.client_id));
 for(const date of v.occurrences)if(await clientConflict(repo,String(source.client_id),date.startsAt,v.durationMinutes,''))fail(409,'schedule_conflict');
 const definition={sourceVisitId:v.sourceVisitId,localStart:v.localStart,timeZone:v.timeZone,count:v.count,intervalWeeks:v.intervalWeeks,durationMinutes:v.durationMinutes},hash=await sha256(canonical(definition));
 if(v.action==='preview'){
  await db.query('INSERT INTO care_schedule_previews(tenant_id,actor_id,request_hash,source_updated_at) SELECT $1,$2,$3,updated_at FROM visits WHERE id=$4 ON CONFLICT(tenant_id,actor_id,request_hash) DO UPDATE SET source_updated_at=EXCLUDED.source_updated_at,created_at=NOW()',[actor.tenant_id,actor.id,hash,source.id]);
  await repo.access(null,'schedule_preview');return {preview:true,definition,client:source.full_name,service:source.service_name,address:[source.service_address_line1,source.service_address_line2,source.service_city,source.service_province,source.service_postal_code].filter(Boolean).join(', '),skills:source.required_skills,occurrences:v.occurrences};
 }
 const preview=optionalRow((await db.query("SELECT p.request_hash FROM care_schedule_previews p JOIN visits v ON v.id::text=$4 AND v.tenant_id=p.tenant_id WHERE p.tenant_id::text=$1 AND p.actor_id::text=$2 AND p.request_hash=$3 AND p.source_updated_at=v.updated_at AND p.created_at>NOW()-$5*INTERVAL '1 minute'",[actor.tenant_id,actor.id,hash,v.sourceVisitId,registry.schedulePolicy.previewMinutes])).rows);
 if(!preview)fail(409,'preview_required');
 if(optionalRow((await db.query('SELECT id FROM care_visit_series WHERE tenant_id::text=$1 AND request_hash=$2',[actor.tenant_id,hash])).rows))fail(409,'conflict');
 const id=crypto.randomUUID();await db.query('INSERT INTO care_visit_series(id,tenant_id,source_visit_id,request_hash,definition,created_by) VALUES($1,$2,$3,$4,$5,$6)',[id,actor.tenant_id,source.id,hash,JSON.stringify({...definition,confirmationEvidence:v.note}),actor.id]);
 const occurrences=[];
 for(const [n,date] of v.occurrences.entries()){
  const visitId=crypto.randomUUID();
  await db.query("INSERT INTO visits(id,tenant_id,client_id,service_id,requested_start_at,duration_minutes,status,required_skills,service_address_line1,service_address_line2,service_city,service_province,service_postal_code,service_lat,service_lng,created_at,updated_at) VALUES($1,$2,$3,$4,$5,$6,'requested',$7,$8,$9,$10,$11,$12,$13,$14,NOW(),NOW())",[visitId,actor.tenant_id,source.client_id,source.service_id,date.startsAt,v.durationMinutes,source.required_skills,source.service_address_line1,source.service_address_line2,source.service_city,source.service_province,source.service_postal_code,source.service_lat,source.service_lng]);
  await db.query('INSERT INTO care_series_visits(tenant_id,series_id,visit_id,ordinal) VALUES($1,$2,$3,$4)',[actor.tenant_id,id,visitId,n+1]);
  await db.query("INSERT INTO care_schedule_events(id,tenant_id,visit_id,actor_id,action,payload) VALUES($1,$2,$3,$4,'create_occurrence',$5)",[crypto.randomUUID(),actor.tenant_id,visitId,actor.id,JSON.stringify({seriesId:id,note:v.note,startsAt:date.startsAt,durationMinutes:v.durationMinutes})]);
  occurrences.push({visitId,...date});
 }
 await repo.access(null,'schedule_create');return {id,definition,occurrences};
}
export async function scheduleSnapshot(repo:CareRepository,offset:number,sourceOffset=0,sourceQuery=''){
 const {records:templates,...sourcePicker}=await visitPicker(repo,sourceOffset,sourceQuery,'recurring');
 if(!operational(repo.actor))return {canManage:false,templates,sourcePicker,series:[],total:0,offset:0,limit:registry.schedulePolicy.pageSize};
 const {db,actor}=repo;

 const total=requiredRow((await db.query('SELECT COUNT(*)::int AS n FROM care_visit_series WHERE tenant_id::text=$1',[actor.tenant_id])).rows).n;
 const series=(await db.query('SELECT id,definition,created_at FROM care_visit_series WHERE tenant_id::text=$1 ORDER BY created_at DESC,id LIMIT $2 OFFSET $3',[actor.tenant_id,registry.schedulePolicy.pageSize,offset])).rows;
 const visits=series.length?(await db.query("SELECT m.series_id,m.ordinal,v.id::text,v.requested_start_at,v.status,v.updated_at,c.id AS case_id FROM care_series_visits m JOIN visits v ON v.id=m.visit_id AND v.tenant_id=m.tenant_id LEFT JOIN care_cases c ON c.visit_id=v.id AND c.tenant_id=v.tenant_id WHERE m.tenant_id::text=$1 AND m.series_id=ANY($2::uuid[]) ORDER BY m.series_id,m.ordinal",[actor.tenant_id,series.map(s=>s.id)])).rows:[];
 return {canManage:true,templates,sourcePicker,series:series.map(s=>({...s,occurrences:visits.filter(v=>v.series_id===s.id).map(v=>({...v,canCancel:!v.case_id&&!['cancelled','rejected','completed'].includes(String(v.status))&&new Date(v.requested_start_at).getTime()>Date.now()}))})),total,offset,limit:registry.schedulePolicy.pageSize};
}
