import {PostgresRegisteredCommunicationEndpointPolicy} from './endpoint-policy.ts';
import type {Actor,RecordState,AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import contracts from '../../../../tools/governance-production/voice-contact-contracts-registration.json' with {type:'json'};
import access from '../../../../tools/governance-production/voice-contact-access-registration.json' with {type:'json'};
/** Own contact only, current registered API AND linked-screen rights on every
 * service action, including rechecks after provider I/O. No delegation. */
export class PostgresVoiceContactAccessPolicy extends PostgresRegisteredCommunicationEndpointPolicy implements AccessPolicy {
 async assert(actor:Actor,action:string,state:RecordState|null):Promise<void>{
  const key=action.startsWith('voice.')?action.slice(6):'';
  const op=contracts.operations.find(o=>o.key===key),id=access.apiIds[key as keyof typeof access.apiIds];
  if(!op||!id||!state||state.kind!=='voice_contact'||state.ownerId!==actor.id||state.tenantId!==actor.tenantId||state.id!=='voice-contact:'+actor.id||state.version!==1)throw Error('Forbidden');
  await this.authorizeRegistered(actor,id,op.method,op.path,'VOICE_'+key.replaceAll('.','_').toUpperCase());
 }
 async assignee():Promise<void>{throw Error('Forbidden');}
}
