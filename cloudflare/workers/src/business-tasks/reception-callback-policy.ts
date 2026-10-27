import {PostgresRegisteredCommunicationEndpointPolicy} from './endpoint-policy.ts';
import {assertActor,type Actor,type AccessPolicy,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import contracts from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
/** Own callback v1 only. Both native preview and approve permissions must remain
 * current. A provider credential, administrator label or OTP alone grants none
 * of these permissions; no staff/appointment/delegated action is authorized. */
export class PostgresReceptionCallbackAccessPolicy extends PostgresRegisteredCommunicationEndpointPolicy implements AccessPolicy {
 async assert(actor:Actor,action:string,state:RecordState|null):Promise<void>{
  assertActor(actor);const owner={id:actor.id,tenantId:actor.tenantId};
  if(!['voice.task.propose','voice.task.confirm','voice.task.execute'].includes(action)||!state||state.kind!=='voice_task'||state.version!==1||state.ownerId!==owner.id||state.tenantId!==owner.tenantId||state.taskId!=='reception.callback.request'||! /^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(state.id))throw Error('Forbidden');
  for(const key of ['task.preview','task.approve']){
   const op=contracts.operations.find(o=>o.key===key);
   if(!op||op.authentication!=='native-session-csrf'||op.permission!=='role_screen_permissions')throw Error('Forbidden');
   await this.authorizeRegistered(owner,null,op.method,op.path,'TWILIO_'+key.replaceAll('.','_').toUpperCase());
  }
 }
 async assignee():Promise<void>{throw Error('Forbidden');}
}
