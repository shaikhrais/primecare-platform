import {taskActions,taskActionBody} from '../../../../packages/shared/src/growth/tasks';
import {GrowthPolicy,fail} from '../../../../packages/shared/src/growth/contract';
import {optionalRow,requiredRow} from '../database-results';
import type {GrowthRepository} from './repository';
export async function taskAction(repo:GrowthRepository,id:string,body:Record<string,unknown>){
 const {db,actor}=repo,v=taskActionBody(body),tenant=actor.tenant_id;
 const old=optionalRow((await db.query('SELECT owner_id,status,version,escalated_at FROM growth_tasks WHERE tenant_id::text=$1 AND id=$2 FOR UPDATE',[tenant,id])).rows);
 if(!old||GrowthPolicy.staff(actor)&&String(old.owner_id)!==actor.id)fail(404,'not_found');
 if(old!.version!==v.version||old!.status!=='open')fail(409,'conflict');
 if(!taskActions(actor,old as any).includes(v.action))fail(403,'forbidden');
 const owner=v.action==='reassign'?await repo.owner(v.ownerId):null;
 const result=requiredRow((await db.query("UPDATE growth_tasks SET owner_id=CASE WHEN $1='reassign' THEN $2 ELSE owner_id END,due_at=CASE WHEN $1='reschedule' THEN $3::timestamptz ELSE due_at END,priority=CASE WHEN $1='priority' THEN $4 ELSE priority END,escalated_at=CASE WHEN $1='escalate' THEN NOW() WHEN $1='resolve_escalation' THEN NULL ELSE escalated_at END,escalation_reason=CASE WHEN $1='escalate' THEN $5 WHEN $1='resolve_escalation' THEN '' ELSE escalation_reason END,version=version+1 WHERE id=$6 AND tenant_id::text=$7 RETURNING id,version",[v.action,owner,v.dueAt??null,v.priority??null,v.evidence,id,tenant])).rows);
 if(result.version!==v.version+1)throw Error('Invalid task version');
 await repo.audit('task_'+v.action,id,JSON.stringify(v));return {id:result.id,version:result.version};
}
export function decorateTasks(actor:any,tasks:any[]){return tasks.map(task=>({...task,actions:taskActions(actor,task)}));}
