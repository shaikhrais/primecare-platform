/** Foundation evaluator only. Not exposed as an API or connected to payroll. */
export type WorkItem={id:string;ownerId:string;state:'assigned'|'in_progress'|'blocked'|'submitted'|'accepted'|'rework'|'cancelled';originalDueAt:string;effectiveDueAt:string;submittedAt?:string;acceptedAt?:string;acceptedBy?:string;reviewDueAt?:string;evidence?:string;blocker?:'employee'|'dependency'|'system'|'manager'|'approved_leave'|'unknown';extension?:{approvedBy:string;approvedAt:string;reason:string}};
const states=new Set(['assigned','in_progress','blocked','submitted','accepted','rework','cancelled']);
function instant(value:string):number{if(!/^\d{4}-\d{2}-\d{2}T.*(?:Z|[+-]\d{2}:\d{2})$/.test(value))throw Error('Timezone-aware timestamp required');const time=Date.parse(value);if(!Number.isFinite(time))throw Error('Invalid timestamp');return time;}
export class WorkAccountability {
 static assess(task:WorkItem,now:string){
  const time=instant(now),original=instant(task.originalDueAt),due=instant(task.effectiveDueAt);if(!task.id||!task.ownerId||!states.has(task.state))throw Error('Invalid work identity or state');
  if(original!==due){if(!task.extension?.approvedBy||!task.extension.reason.trim())throw Error('Approved deadline change required');if(instant(task.extension.approvedAt)>time)throw Error('Future deadline approval');if(task.extension.approvedBy===task.ownerId)throw Error('Owner cannot approve own deadline change');}
  const submitted=task.submittedAt?instant(task.submittedAt):null,accepted=task.acceptedAt?instant(task.acceptedAt):null,reviewDue=task.reviewDueAt?instant(task.reviewDueAt):null;
  if(submitted!==null&&submitted>time||accepted!==null&&accepted>time)throw Error('Future completion event');
  if(['submitted','accepted'].includes(task.state)&&(submitted===null||!task.evidence?.trim()))throw Error('Submission evidence required');
  if(task.state==='accepted'&&(accepted===null||submitted===null||accepted<submitted||!task.acceptedBy||task.acceptedBy===task.ownerId))throw Error('Independent acceptance required');
  const closed=task.state==='accepted'||task.state==='cancelled',waiting=task.state==='submitted';
  const deadlineMissed=!closed&&!waiting&&time>due;
  const externalBlock=['dependency','system','manager','approved_leave'].includes(task.blocker??'');
  return {taskId:task.id,status:task.state==='cancelled'?'cancelled':task.state==='accepted'?'accepted':waiting?'awaiting_manager_review':deadlineMissed?'overdue_open':'not_due',deadlineMissed,submittedOnTime:submitted===null?null:submitted<=due,submittedOnOriginalDeadline:submitted===null?null:submitted<=original,managerReviewOverdue:waiting&&reviewDue!==null&&time>reviewDue,employeeReview:deadlineMissed?(externalBlock?'blocked_non_employee':task.blocker==='employee'?'employee_reason_review':'cause_not_established'):'none',acceptedWork:task.state==='accepted',originalDueAt:task.originalDueAt,effectiveDueAt:task.effectiveDueAt,payDecision:'separate_payroll_review' as const};
 }
 static summary(items:WorkItem[],now:string){const results=items.map(t=>this.assess(t,now));return {assigned:items.length,accepted:results.filter(r=>r.acceptedWork).length,overdueOpen:results.filter(r=>r.deadlineMissed).length,reviewBacklog:results.filter(r=>r.status==='awaiting_manager_review').length,managerReviewOverdue:results.filter(r=>r.managerReviewOverdue).length,externalBlockerOverdue:results.filter(r=>r.employeeReview==='blocked_non_employee').length,unknownCauseOverdue:results.filter(r=>r.employeeReview==='cause_not_established').length,employeeReasonReview:results.filter(r=>r.employeeReview==='employee_reason_review').length};}
}
