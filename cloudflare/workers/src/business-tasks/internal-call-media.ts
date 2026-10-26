import {ConversationCallServiceBase,type ConversationCallLimits} from './call-service.ts';
import {assertActor,required,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {CallIceConfiguration} from '../../../../packages/shared/src/communications/cloudflare-turn.mjs';
export type AppCallRelayPorts={preparationProvider?:{issue():Promise<CallIceConfiguration>};provider:{issue():Promise<CallIceConfiguration>};admit(actor:Actor,callId:string):Promise<boolean>};
/** Accepted media remains separate from explicitly registered ringing preparation.
 * Both enforce current native policy, participant scope and relay quotas.
 */
export class InternalCallMediaService extends ConversationCallServiceBase {
 readonly relay:AppCallRelayPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,limits:ConversationCallLimits,relay:AppCallRelayPorts){super(store,policy,limits);if(typeof relay?.provider?.issue!=='function'||typeof relay.admit!=='function')throw Error('Call relay ports required');this.relay=relay;}
 private async accepted(actor:Actor,id:string,callId:string){const state=await this.read(actor,id);await this.authorize(actor,'conversation.call',state);const call=state.calls.find((c:any)=>c.id===callId);if(!call||call.status!=='accepted'||![call.callerId,call.recipientId].includes(actor.id))throw Error('Call not accepted');return {callerId:call.callerId,recipientId:call.recipientId};}
 private async preparable(actor:Actor,id:string,callId:string){const state=await this.read(actor,id);await this.authorize(actor,'conversation.call',state);const call=state.calls.find((c:any)=>c.id===callId);if(!call||!['ringing','accepted'].includes(call.status)||call.status==='ringing'&&call.expiresAt<=Date.now()||![call.callerId,call.recipientId].includes(actor.id))throw Error('Call not accepted');return {callerId:call.callerId,recipientId:call.recipientId};}
 async prepareConfiguration(actor:Actor,id:string,callId:string){
  assertActor(actor);actor=Object.freeze({...actor});required(id);required(callId);const before=await this.preparable(actor,id,callId);
  if(!this.relay.preparationProvider||await this.relay.admit(actor,callId)!==true)throw Error('Call relay unavailable');
  const result=structuredClone(await this.relay.preparationProvider.issue()),after=await this.preparable(actor,id,callId);
  if(before.callerId!==after.callerId||before.recipientId!==after.recipientId||!Number.isSafeInteger(result?.expiresAt)||result.expiresAt<Date.now()+30000||result.expiresAt>Date.now()+1800000||!Array.isArray(result.iceServers)||!result.iceServers.length)throw Error('Call relay unavailable');return result;
 }
 async configuration(actor:Actor,id:string,callId:string){
  assertActor(actor);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});required(id);required(callId);const before=await this.accepted(actor,id,callId);
  if(await this.relay.admit(actor,callId)!==true)throw Object.assign(Error('Call relay unavailable'),{communicationHealth:'relay_quota'});
  const result=structuredClone(await this.relay.provider.issue()),after=await this.accepted(actor,id,callId);
  if(before.callerId!==after.callerId||before.recipientId!==after.recipientId||!Number.isSafeInteger(result?.expiresAt)||result.expiresAt<Date.now()+30000||result.expiresAt>Date.now()+3600000||!Array.isArray(result.iceServers)||!result.iceServers.length)throw Error('Call relay unavailable');return result;
 }
}
