import {registry,operational,fail} from '../../../../packages/shared/src/care/contract';
import type {CareRepository} from './repository';

// Alias t is owned by the server queries below. Closed tasks are never an active waiting queue item.
export const pendingDependencySql=`(t.status NOT IN ('completed','cancelled') AND EXISTS(
 SELECT 1 FROM care_followup_dependencies d
 JOIN care_followups p ON p.tenant_id=d.tenant_id AND p.id=d.prerequisite_id
 LEFT JOIN care_followup_dependency_releases r ON r.tenant_id=d.tenant_id AND r.followup_id=d.followup_id AND r.prerequisite_id=d.prerequisite_id
 WHERE d.tenant_id=t.tenant_id AND d.followup_id=t.id AND p.status<>'completed' AND r.reviewer_id IS NULL
))`;

/** Caller holds the source case lock, also used by all prerequisite state changes. */
export async function attachDependencies(repo:CareRepository,caseId:string,id:string,parents:string[]){
 if(!parents.length)return;
 if(parents.length>registry.dependencyPolicy.maxParents)fail(400);
 const rows=(await repo.db.query('SELECT id,status FROM care_followups WHERE tenant_id::text=$1 AND case_id=$2 AND id=ANY($3::uuid[])',[repo.actor.tenant_id,caseId,parents])).rows;
 if(rows.length!==parents.length||rows.some(p=>p.status==='cancelled'))fail(409,'followup_dependency_invalid');
 // Only already-existing records may be parents; edges cannot be added after creation, so cycles cannot be introduced through the API.
 for(const parent of parents)await repo.db.query('INSERT INTO care_followup_dependencies(tenant_id,case_id,followup_id,prerequisite_id,author_id) VALUES($1,$2,$3,$4,$5)',[repo.actor.tenant_id,caseId,id,parent,repo.actor.id]);
}
export async function taskDependencies(repo:CareRepository,t:any){
 const rows=(await repo.db.query(`SELECT d.prerequisite_id,p.owner_id::text,p.category,p.status,r.reviewer_id::text,r.created_at AS released_at
  FROM care_followup_dependencies d JOIN care_followups p ON p.tenant_id=d.tenant_id AND p.id=d.prerequisite_id
  LEFT JOIN care_followup_dependency_releases r ON r.tenant_id=d.tenant_id AND r.followup_id=d.followup_id AND r.prerequisite_id=d.prerequisite_id
  WHERE d.tenant_id::text=$1 AND d.followup_id=$2 ORDER BY d.created_at,d.prerequisite_id LIMIT $3`,[repo.actor.tenant_id,t.id,registry.dependencyPolicy.maxParents+1])).rows;
 if(rows.length>registry.dependencyPolicy.maxParents)fail(413,'record_limit');
 const active=!['completed','cancelled'].includes(t.status),reviewer=operational(repo.actor)&&String(t.owner_id)!==repo.actor.id&&t.version<=registry.followupPolicy.maxVersions-3;
 const records=rows.map(p=>({id:p.prerequisite_id,ownerId:p.owner_id,category:p.category,status:p.status,released:!!p.reviewer_id,releasedBy:p.reviewer_id,releasedAt:p.released_at,fulfilled:p.status==='completed'||!!p.reviewer_id,canRelease:active&&reviewer&&p.owner_id!==repo.actor.id&&p.status!=='completed'&&!p.reviewer_id}));
 const ready=records.every(p=>p.fulfilled);return {records,ready,waiting:active&&!ready};
}
export async function releaseDependency(repo:CareRepository,t:any,parentId:string,note:string){
 const d=await taskDependencies(repo,t),parent=d.records.find(p=>p.id===parentId);
 if(!parent?.canRelease)fail(409,'conflict');
 await repo.db.query('INSERT INTO care_followup_dependency_releases(tenant_id,followup_id,prerequisite_id,reviewer_id,note,checked) VALUES($1,$2,$3,$4,$5,TRUE)',[repo.actor.tenant_id,t.id,parentId,repo.actor.id,note]);
 return {prerequisiteId:parentId,prerequisiteStatus:parent.status,prerequisiteOwner:parent.ownerId,checked:true};
}
