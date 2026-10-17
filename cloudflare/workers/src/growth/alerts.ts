import {registry,GrowthPolicy} from '../../../../packages/shared/src/growth/contract';
import type {GrowthRepository} from './repository';
export async function growthAlerts(repo:GrowthRepository){
 const {db,actor}=repo,staff=GrowthPolicy.staff(actor),assigned=!staff||staff.scope==='assigned',scope=[actor.tenant_id,actor.id],limit=registry.alertPolicy.limitPerKind;
 const leads=assigned?(await db.query("SELECT id,name,due_at AS due,contact_blocked FROM growth_leads WHERE tenant_id::text=$1 AND ($2::text IS NULL OR owner_id::text=$2) AND contact_blocked=FALSE AND duplicate_of IS NULL AND contact_basis='requested' AND phone<>'' AND stage<>'lost' AND due_at<=NOW() ORDER BY due_at,id LIMIT $3",[scope[0],staff?scope[1]:null,limit])).rows:[];
 const appointments=assigned?(await db.query("SELECT a.id,l.name,a.starts_at AS due,l.contact_blocked FROM growth_appointments a JOIN growth_leads l ON l.id=a.lead_id AND l.tenant_id=a.tenant_id WHERE a.tenant_id::text=$1 AND ($2::text IS NULL OR a.owner_id::text=$2 AND l.owner_id::text=$2) AND a.status='scheduled' AND a.starts_at<=NOW()+INTERVAL '1 hour'*$3 ORDER BY a.starts_at,a.id LIMIT $4",[scope[0],staff?scope[1]:null,registry.alertPolicy.horizonHours,limit])).rows:[];
 const tasks=(await db.query("SELECT id,name,due_at AS due,FALSE AS contact_blocked FROM growth_tasks WHERE tenant_id::text=$1 AND ($2::text IS NULL OR owner_id::text=$2) AND status='open' AND (due_at<=NOW() OR escalated_at IS NOT NULL) ORDER BY (escalated_at IS NOT NULL) DESC,due_at,id LIMIT $3",[scope[0],staff?scope[1]:null,limit])).rows;
 return [...leads.map(r=>({...r,kind:'callback_due'})),...appointments.map(r=>({...r,kind:'appointment_due'})),...tasks.map(r=>({...r,kind:'task_attention'}))];
}
