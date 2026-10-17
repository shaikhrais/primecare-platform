import {registry,type Actor} from '../../../../packages/shared/src/care/contract';

import {staffingBlockedSql} from './staffing';
import {timeNeedsSubmissionSql,timeReviewPendingSql} from './time-records';

// SQL expressions contain governed policy constants only; query values stay bound.
const policy=registry.taskPolicy;
const stages=policy.stages as Record<string,{step:string;owner:string}>;
export const taskOwnerSql="CASE WHEN "+staffingBlockedSql+" THEN NULL "+Object.entries(stages).filter(([,v])=>v.owner!=='operations').map(([state,v])=>`WHEN c.state='${state}' THEN c.${v.owner}_id::text`).join(' ')+" END";
const eventTime=(action:string)=>`(SELECT e.created_at FROM care_events e WHERE e.tenant_id=c.tenant_id AND e.case_id=c.id AND e.action='${action}' ORDER BY e.record_version DESC LIMIT 1)`;
export const taskDueSql=`CASE
 WHEN ${staffingBlockedSql} THEN COALESCE(v.requested_start_at,c.created_at)
 WHEN c.state IN ('awaiting_plan','draft','pending_review','ready','accepted') THEN v.requested_start_at
 WHEN c.state='in_progress' THEN v.requested_start_at+(v.duration_minutes+${policy.documentationGraceMinutes})*INTERVAL '1 minute'
 WHEN c.state='submitted' THEN c.submitted_at+${policy.reviewDueHours}*INTERVAL '1 hour'
 WHEN c.state='correction_requested' THEN ${eventTime('return_visit')}+${policy.correctionDueHours}*INTERVAL '1 hour'
 WHEN c.state='coverage_needed' THEN ${eventTime('report_unavailable')}
 END`;
export const concernSql="EXISTS(SELECT 1 FROM care_events e WHERE e.tenant_id=c.tenant_id AND e.case_id=c.id AND (e.action='concern' OR e.action='task' AND e.payload->>'outcome'='concern') AND NOT EXISTS(SELECT 1 FROM care_events f WHERE f.tenant_id=e.tenant_id AND f.case_id=e.case_id AND f.action='follow_up' AND f.payload->>'eventId'=e.id::text))";
export function queueFilter(view:string,actor:Actor){
 if(view==='mine')return ` AND (${taskOwnerSql}=$3 OR (c.state='coverage_needed' OR ${staffingBlockedSql}) AND $2 OR ${timeNeedsSubmissionSql} AND c.worker_id::text=$3 OR ${timeReviewPendingSql} AND $2 AND c.worker_id::text<>$3 OR ${concernSql} AND (c.nurse_id::text=$3 OR c.supervisor_id::text=$3) AND ${registry.nurseRoles.includes(actor.roles)?'TRUE':'FALSE'})`;
 if(view==='late')return ` AND (${taskDueSql})<NOW()`;
 if(view==='concerns')return ' AND '+concernSql;
 if(view==='coverage')return " AND (c.state='coverage_needed' OR "+staffingBlockedSql+")";
 return '';
}
export function workItem(c:any,now=Date.now()){
 const stage=c.staffing_reason?{step:'task_restore_coverage',owner:'operations'}:stages[c.state];if(!stage)return null;
 const due=new Date(c.work_due).getTime();if(!Number.isFinite(due))throw Error('Missing care task deadline');
 return {step:stage.step,ownerId:stage.owner==='operations'?null:String(c[stage.owner+'_id']),ownerKind:stage.owner,dueAt:new Date(due).toISOString(),late:due<now,lateMinutes:Math.max(0,Math.ceil((now-due)/60000))};
}
