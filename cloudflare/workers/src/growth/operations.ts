import {optionalRow,requiredRow} from '../database-results';
import {GrowthRepository} from './repository';
import {GrowthPolicy,fail,uuid,teamBody,callBody,appointmentBody} from '../../../../packages/shared/src/growth/contract';
/** Coordination records only: never provisions accounts, dials, or delivers care. */
export class GrowthOperations {
 constructor(readonly repo:GrowthRepository){}
 async execute(entity:string,id:string|undefined,method:string,body:Record<string,unknown>){
  const {db,actor}=this.repo,tenant=actor.tenant_id;
  if(entity==='team'){
   GrowthPolicy.team(actor);const v=teamBody(body);await this.repo.owner(id);
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-team:'+tenant+':'+id]);
   const old=optionalRow((await db.query('SELECT version FROM growth_team WHERE tenant_id::text=$1 AND member_id::text=$2 FOR UPDATE',[tenant,id])).rows);
   if((old?.version??0)!==v.version)fail(409,'conflict');
   const result=requiredRow((await db.query('INSERT INTO growth_team(tenant_id,member_id,specialty) VALUES($1,$2,$3) ON CONFLICT(tenant_id,member_id) DO UPDATE SET specialty=EXCLUDED.specialty,version=growth_team.version+1 RETURNING version',[tenant,id,v.specialty])).rows);
   await this.repo.audit('team_specialty_saved',id!);return {id,version:result.version};
  }
  if(entity==='calls'){
   const v=callBody(body);const lead=optionalRow((await db.query('SELECT owner_id,version,contact_blocked,stage,phone,contact_basis FROM growth_leads WHERE tenant_id::text=$1 AND id=$2 FOR UPDATE',[tenant,v.leadId])).rows);
   if(!lead)fail(404,'not_found');GrowthPolicy.lead(actor,lead!.owner_id);if(lead!.version!==v.leadVersion)fail(409,'conflict');if(lead!.contact_blocked)fail(409,'contact_blocked');
   // An opt-out may be recorded even before contact permission exists.
   if(v.outcome!=='do_not_contact'&&(lead!.stage==='lost'||!lead!.phone||lead!.contact_basis!=='requested'))fail(400);
   const callId=crypto.randomUUID();await db.query('INSERT INTO growth_calls(id,tenant_id,lead_id,actor_id,outcome,notes) VALUES($1,$2,$3,$4,$5,$6)',[callId,tenant,v.leadId,actor.id,v.outcome,v.notes]);
   const result=requiredRow((await db.query('UPDATE growth_leads SET contact_blocked=$1,due_at=$2,version=version+1 WHERE tenant_id::text=$3 AND id=$4 RETURNING version',[v.outcome==='do_not_contact',v.dueAt,tenant,v.leadId])).rows);
   await this.repo.audit('call_recorded',callId,v.outcome as string);return {id:callId,leadVersion:result.version};
  }
  if(entity==='appointments'){
   const v=appointmentBody(body,method==='PATCH');
   if(method==='PATCH'){
    const old=optionalRow((await db.query('SELECT a.version,a.status,a.starts_at,a.owner_id,l.owner_id AS lead_owner FROM growth_appointments a JOIN growth_leads l ON l.id=a.lead_id AND l.tenant_id=a.tenant_id WHERE a.tenant_id::text=$1 AND a.id=$2 FOR UPDATE OF a,l',[tenant,id])).rows);
    if(!old)fail(404,'not_found');if(GrowthPolicy.staff(actor)){GrowthPolicy.lead(actor,old!.lead_owner);if(String(old!.owner_id)!==actor.id)fail(404,'not_found');}if(old!.version!==v.version||old!.status!=='scheduled')fail(409,'conflict');
    if(v.status!=='cancelled'&&Date.parse(String(old!.starts_at))>Date.now())fail(400);
    const result=requiredRow((await db.query('UPDATE growth_appointments SET status=$1,notes=$2,version=version+1 WHERE tenant_id::text=$3 AND id=$4 RETURNING version',[v.status,v.notes,tenant,id])).rows);
    await this.repo.audit('appointment_outcome_saved',id!,v.status as string);return {id,version:result.version};
   }
   const lead=optionalRow((await db.query('SELECT owner_id,contact_blocked,stage,contact_basis FROM growth_leads WHERE tenant_id::text=$1 AND id=$2 FOR UPDATE',[tenant,v.leadId])).rows);
   if(!lead)fail(404,'not_found');GrowthPolicy.lead(actor,lead!.owner_id);if(lead!.contact_blocked)fail(409,'contact_blocked');if(lead!.stage==='lost'||lead!.contact_basis!=='requested')fail(400);
   if(GrowthPolicy.staff(actor)&&v.ownerId!==actor.id)fail(403,'forbidden');const owner=await this.repo.owner(v.ownerId);
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['growth-appointment:'+tenant+':'+owner]);
   const overlap=await db.query("SELECT id FROM growth_appointments WHERE tenant_id::text=$1 AND (owner_id::text=$2 OR lead_id=$5) AND status='scheduled' AND starts_at<$4::timestamptz AND ends_at>$3::timestamptz LIMIT 1",[tenant,owner,v.startsAt,v.endsAt,v.leadId]);
   if(overlap.rows.length)fail(409,'conflict');
   const appointmentId=crypto.randomUUID();await db.query('INSERT INTO growth_appointments(id,tenant_id,lead_id,owner_id,starts_at,ends_at,notes) VALUES($1,$2,$3,$4,$5,$6,$7)',[appointmentId,tenant,v.leadId,owner,v.startsAt,v.endsAt,v.notes]);
   await this.repo.audit('appointment_booked',appointmentId);return {id:appointmentId,version:1};
  }
  fail(404,'not_found');
 }
}
