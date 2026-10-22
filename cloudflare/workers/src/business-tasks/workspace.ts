import type {Actor} from './store.ts';
import type {BusinessWorkflowService} from './workflow.ts';
import type {CommunicationService} from './communication.ts';

/** Connect business tasks to communication without exposing an unregistered public route. */
export class BusinessWorkspaceService {
 readonly workflows:BusinessWorkflowService;readonly communication:CommunicationService;
 constructor(workflows:BusinessWorkflowService,communication:CommunicationService) {
  this.workflows=workflows;this.communication=communication;
 }
 async openConversation(actor:Actor,taskId:string,threadId:string,key:string,members:string[]) {
  const task=await this.workflows.read(actor,taskId);
  const allowed=new Set([task.originatorId,task.ownerId,task.reviewerId]);
  if(members.some(member=>!allowed.has(member)))throw Error('Task participant required');
  // Conversation IDs and task IDs must use different namespaces; storage rejects collisions.
  return this.communication.create(actor,threadId,key,members,task.id);
 }
}
