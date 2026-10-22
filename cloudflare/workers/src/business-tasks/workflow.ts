import {BusinessTaskFlowBase, type TaskFlow} from '../../../../packages/shared/src/business/task-flow.ts';
import {required, type Actor, type AtomicStore, type AccessPolicy, type RecordState} from './store.ts';
import {ScopedServiceBase} from '../../../../packages/shared/src/communications/service-base.ts';

export class BusinessWorkflowService extends ScopedServiceBase {
 readonly flows: ReadonlyMap<string, BusinessTaskFlowBase>;
 constructor(store: AtomicStore, policy: AccessPolicy, definitions: readonly TaskFlow[]) {
  super(store,policy);
  this.flows = new Map(definitions.map(definition => [definition.id,new BusinessTaskFlowBase(definition)]));
  if (this.flows.size !== definitions.length) throw Error('Duplicate flow');
 }
 async create(actor: Actor, id: string, key: string, flowId: string, ownerId: string, reviewerId: string, dueAt: string) {
  const flow = this.flows.get(flowId); if (!flow) throw Error('Unknown flow');
  required(ownerId); required(reviewerId);
  if (ownerId === reviewerId) throw Error('Independent reviewer required');
  if (!/^\d{4}-\d{2}-\d{2}T.*(?:Z|[+-]\d{2}:\d{2})$/.test(dueAt) || !Number.isFinite(Date.parse(dueAt))) throw Error('Timezone deadline required');
  return this.store.run({actor,id,key,expectedVersion:0,type:'workflow.create',payload:{flowId,ownerId,reviewerId,dueAt}},
   async state => { await this.checkAccess(actor,'workflow.create',state,['workflow'],true); await this.policy.assignee(actor,ownerId,flow.definition.steps[0].responsibility); await this.policy.assignee(actor,reviewerId,'review'); },
   async state => {
    if (state) throw Error('Already exists');
    return {state:{id,tenantId:actor.tenantId,version:0,kind:'workflow',flowId,definition:flow.definition,stepIndex:0,status:'draft',originatorId:actor.id,ownerId,reviewerId,dueAt,originalDueAt:dueAt,createdAt:new Date().toISOString(),submissions:[],history:[]},event:'workflow.created'};
   });
 }
 async act(actor: Actor, id: string, key: string, expectedVersion: number, action: 'submit'|'return'|'accept'|'block'|'resume', input: {evidence?: Record<string,string>; reason?: string; nextOwnerId?: string; nextReviewerId?: string; nextDueAt?: string} = {}) {
  if (!['submit','return','accept','block','resume'].includes(action)) throw Error('Unknown action');
  return this.store.run({actor,id,key,expectedVersion,type:'workflow.'+action,payload:input},
   async state => {
    if (!state || state.kind !== 'workflow') throw Error('Not found');
    await this.checkAccess(actor,'workflow.'+action,state,['workflow']);
   }, async state => {
    const task = state!;
    if (task.status === 'closed') throw Error('Closed task');
    const flow = new BusinessTaskFlowBase(task.definition);
    const step = flow.definition.steps[task.stepIndex];
    if (action === 'submit') {
     if (actor.id !== task.ownerId || !['draft','returned'].includes(task.status)) throw Error('Submission forbidden');
     for(const value of Object.values(input.evidence ?? {}))required(value,500);
     const proposal = flow.prepareSubmission(step.id,input.evidence ?? {});
     if (!proposal.ready) throw Error('Required evidence missing');
     task.submissions.push({stepId:step.id,submittedBy:actor.id,evidence:proposal.evidence,revision:task.version+1,submittedAt:new Date().toISOString()});
     task.status = 'awaiting_review';
    } else if (action === 'return' || action === 'accept') {
     if (actor.id !== task.reviewerId || actor.id === task.ownerId || task.status !== 'awaiting_review') throw Error('Review forbidden');
     required(input.reason,1000);
     if (action === 'return') { task.status = 'returned'; task.correctionReason = input.reason; }
     else {
      const next = flow.definition.steps[task.stepIndex+1];
      if (!next) task.status = 'closed';
      else {
       required(input.nextOwnerId); required(input.nextReviewerId);
       if (input.nextOwnerId === input.nextReviewerId) throw Error('Independent reviewer required');
       if (typeof input.nextDueAt !== 'string' || !/^\d{4}-\d{2}-\d{2}T.*(?:Z|[+-]\d{2}:\d{2})$/.test(input.nextDueAt) || !Number.isFinite(Date.parse(input.nextDueAt))) throw Error('Timezone deadline required');
       await this.policy.assignee(actor,input.nextOwnerId,next.responsibility);
       await this.policy.assignee(actor,input.nextReviewerId,'review');
       task.stepIndex++; task.ownerId=input.nextOwnerId; task.reviewerId=input.nextReviewerId;
       task.dueAt=input.nextDueAt; task.originalDueAt=input.nextDueAt; task.status='draft';
      }
     }
    } else {
     if (actor.id !== task.ownerId) throw Error('Owner required');
     required(input.reason,1000);
     if (action === 'block' && ['draft','returned'].includes(task.status)) {task.resumeStatus=task.status;task.status='blocked';}
     else if (action === 'resume' && task.status === 'blocked') task.status=task.resumeStatus;
     else throw Error('Invalid state');
    }
    task.history.push({action,actorId:actor.id,stepId:step.id,reason:input.reason??null,revision:task.version+1,recordedAt:new Date().toISOString()});
    return {state:task,event:'workflow.'+action};
   });
 }
 async read(actor: Actor, id: string): Promise<RecordState> {
  return this.store.read(actor,id,state=>this.checkAccess(actor,'workflow.read',state,['workflow']));
 }
 async inbox(actor: Actor, limit=50) {
  return this.store.inbox(actor,'workflow',state=>this.checkAccess(actor,'workflow.read',state,['workflow']),limit);
 }
}
