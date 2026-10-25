import {ConversationCallServiceBase,type ConversationCallLimits} from './call-service.ts';
import {assertActor,required,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {CallIceConfiguration} from '../../../../packages/shared/src/communications/cloudflare-turn.mjs';
export type AppCallRelayPorts={provider:{issue():Promise<CallIceConfiguration>};admit(actor:Actor,callId:string):Promise<boolean>};
/** Only an authenticated participant of the current accepted call may obtain
 * fresh relay credentials. Quota, current policy and call scope remain mandatory.
 */
export class InternalCallMediaService extends ConversationCallServiceBase {
 readonly relay:AppCallRelayPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,limits:ConversationCallLimits,relay:AppCallRelayPorts){super(store,policy,limits);if(typeof relay?.provider?.issue!=='function'||typeof relay.admit!=='function')throw Error('Call relay ports required');this.relay=relay;}
 private async accepted(actor:Actor,id:string,callId:string){const state=await this.read(actor,id);await this.authorize(actor,'conversation.call',state);const call=state.calls.find((c:any)=>c.id===callId);if(!call||call.status!=='accepted'||![call.callerId,call.recipientId].includes(actor.id))throw Error('Call not accepted');return {callerId:call.callerId,recipientId:call.recipientId};}
 async configuration(actor:Actor,id:string,callId:string){
  assertActor(actor);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});required(id);required(callId);const before=await this.accepted(actor,id,callId);
  if(await this.relay.admit(actor,callId)!==true)throw Error('Call relay unavailable');
  const result=structuredClone(await this.relay.provider.issue()),after=await this.accepted(actor,id,callId);
  if(before.callerId!==after.callerId||before.recipientId!==after.recipientId||!Number.isSafeInteger(result?.expiresAt)||result.expiresAt<Date.now()+30000||result.expiresAt>Date.now()+3600000||!Array.isArray(result.iceServers)||!result.iceServers.length)throw Error('Call relay unavailable');return result;
 }
}
