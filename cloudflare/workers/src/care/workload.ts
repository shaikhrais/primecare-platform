import {pendingDependencySql} from './task-dependencies';
import {registry,operational,careRole,fail} from '../../../../packages/shared/src/care/contract';
import {requiredRow} from '../database-results';
import type {CareRepository} from './repository';

/** Aggregates operational task state only; never joins clinical notes or qualifications. */
export async function workloadSnapshot(repo:CareRepository,offset:number,query:string){
 if(!operational(repo.actor)){
  if(offset||query)fail(403,'forbidden');
  return null;
 }
 const literal='%'+query.replace(/[!%_]/g,value=>'!'+value)+'%';
 const parameters=[repo.actor.tenant_id,literal];
 const grouped=`WITH owners AS (
  SELECT u.id::text AS owner_id,u.email,u.roles,u.status,
   COUNT(*)::int AS open,
   COUNT(*) FILTER(WHERE t.status='blocked')::int AS blocked,
   COUNT(*) FILTER(WHERE t.due_at<NOW())::int AS late,
   COUNT(*) FILTER(WHERE t.status='submitted')::int AS review,
   COUNT(*) FILTER(WHERE t.requested_due_at IS NOT NULL)::int AS extensions,
   COUNT(*) FILTER(WHERE ${pendingDependencySql})::int AS waiting,
   MIN(t.due_at) AS earliest_due
  FROM care_followups t JOIN users u ON u.id=t.owner_id AND u.tenant_id=t.tenant_id
  WHERE t.tenant_id::text=$1 AND t.status NOT IN ('completed','cancelled')
   AND (LOWER(COALESCE(u.email,'')) LIKE LOWER($2) ESCAPE '!' OR LOWER(u.id::text) LIKE LOWER($2) ESCAPE '!')
  GROUP BY u.id,u.email,u.roles,u.status
 ) `;
 const summary=requiredRow((await repo.db.query(grouped+`SELECT COUNT(*)::int AS total,
  COALESCE(SUM(open),0)::int AS open,COALESCE(SUM(blocked),0)::int AS blocked,
  COALESCE(SUM(late),0)::int AS late,COALESCE(SUM(review),0)::int AS review,
  COALESCE(SUM(extensions),0)::int AS extensions,COALESCE(SUM(waiting),0)::int AS waiting FROM owners`,parameters)).rows);
 const records=(await repo.db.query(grouped+'SELECT * FROM owners ORDER BY LOWER(COALESCE(email,\'\')),owner_id LIMIT $3 OFFSET $4',[...parameters,registry.workloadPolicy.pageSize,offset])).rows;
 return {records:records.map(row=>({...row,needsReassignment:String(row.status).toLowerCase()!=='active'||!careRole(row.roles)})),...summary,offset,limit:registry.workloadPolicy.pageSize,query};
}
