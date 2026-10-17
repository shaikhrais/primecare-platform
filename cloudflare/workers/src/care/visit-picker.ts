import {registry,operational} from '../../../../packages/shared/src/care/contract';
import {requiredRow} from '../database-results';
import type {CareRepository} from './repository';

/** Operations-only appointment metadata. Search is applied before pagination. */
export async function visitPicker(repo:CareRepository,offset=0,query='',kind:'unassigned'|'recurring'='unassigned'){
 const recurring=kind==='recurring',limit=(recurring?registry.scheduleSourcePolicy:registry.visitPickerPolicy).pageSize;
 if(!operational(repo.actor))return {records:[],total:0,offset:0,limit,query:''};
 const serviceJoin=recurring?' JOIN services s ON s.id=v.service_id AND s.tenant_id=v.tenant_id':'',eligibility=recurring?" AND s.is_active=TRUE AND btrim(COALESCE(v.required_skills,''))<>'' AND COALESCE(v.status,'requested') NOT IN ('cancelled','rejected')":" AND COALESCE(v.status,'requested') NOT IN ('cancelled','rejected','completed') AND NOT EXISTS(SELECT 1 FROM care_cases c WHERE c.tenant_id=v.tenant_id AND c.visit_id=v.id)";
 const from=" FROM visits v JOIN client_profiles p ON p.id=v.client_id AND p.tenant_id=v.tenant_id JOIN users u ON u.id=p.user_id AND u.tenant_id=p.tenant_id"+serviceJoin+" WHERE v.tenant_id::text=$1 AND LOWER(u.status)='active'"+eligibility+" AND ($2='' OR strpos(lower(p.full_name),lower($2))>0 OR strpos(lower(v.id::text),lower($2))>0)";
 const args=[repo.actor.tenant_id,query];
 const total=requiredRow((await repo.db.query('SELECT COUNT(*)::int AS n'+from,args)).rows).n;
 const records=(await repo.db.query('SELECT v.id::text,v.requested_start_at,p.full_name'+from+(recurring?' ORDER BY v.requested_start_at DESC NULLS LAST,v.id':' ORDER BY v.requested_start_at,v.id')+' LIMIT $3 OFFSET $4',[...args,limit,offset])).rows;
 return {records,total,offset,limit,query};
}
