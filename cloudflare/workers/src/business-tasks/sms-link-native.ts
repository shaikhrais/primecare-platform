import {ScopedServiceBase,CommunicationChannelBase,assertActor,required,type Actor,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import type {MessagingLink} from '../../../../packages/shared/src/communications/messaging-ai.ts';
import type {NativeContext} from './sms-links.ts';

export interface NativeSmsLinkRepository {
 status(context:NativeContext,conversationId:string):Promise<MessagingLink|null>;
 bind(context:NativeContext,input:{id:string;conversationId:string;consent:true}):Promise<MessagingLink>;
 revoke(context:NativeContext,id:string):Promise<void>;
}
export type SmsLinkRequest={action:'status';conversationId:string}|{action:'bind';id:string;conversationId:string;consent:true}|{action:'revoke';id:string};
const uuid=(v:unknown)=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(v);
function contextSnapshot(context:NativeContext):NativeContext{
 assertActor(context?.actor);if(!/^[a-f0-9]{64}$/.test(context.sessionHash))throw Error('Messaging link unavailable');
 return Object.freeze({actor:Object.freeze({id:context.actor.id,tenantId:context.actor.tenantId}),sessionHash:context.sessionHash});
}
function publicLink(context:NativeContext,conversationId:string,link:MessagingLink){
 if(!link||link.actorId!==context.actor.id||link.tenantId!==context.actor.tenantId||link.conversationId!==conversationId||link.provider!=='twilio'||link.channel!=='sms'||!uuid(link.id)||!Number.isSafeInteger(link.version)||link.version<1||link.version>9007199254740990)throw Error('Messaging link unavailable');
 return {id:link.id,version:link.version,conversationId:link.conversationId,channel:'sms' as const};
}
/** Owner operations use the same scoped service base as all channels. Repository
 * transactions independently enforce current native sessions and exact policy.
 * No public output contains provider address, account or native session data. */
export class NativeSmsLinkService extends ScopedServiceBase {
 readonly repository:NativeSmsLinkRepository;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:NativeSmsLinkRepository){
  super(store,policy);if(['status','bind','revoke'].some(k=>typeof repository?.[k as keyof NativeSmsLinkRepository]!=='function'))throw Error('Native SMS link repository required');this.repository=repository;
 }
 private async conversation(context:NativeContext,id:string,action:string){
  required(id);return this.store.read(context.actor,id,async state=>{
   await this.checkAccess(context.actor,action,state,['conversation']);
   if(!Array.isArray(state.members)||!state.members.includes(context.actor.id))throw Error('Not found');
  });
 }
 async execute(context:NativeContext,request:SmsLinkRequest){
  context=contextSnapshot(context);
  if(!request||typeof request!=='object'||Array.isArray(request))throw Error('Invalid input');
  request={...request};const keys=Object.keys(request).sort().join(',');
  if(request.action==='status'&&keys==='action,conversationId'){
   await this.conversation(context,request.conversationId,'messaging.link.status');
   const link=await this.repository.status(context,request.conversationId);
   return link===null?{linked:false}:{linked:true,link:publicLink(context,request.conversationId,link)};
  }
  if(request.action==='bind'&&keys==='action,consent,conversationId,id'&&request.consent===true&&uuid(request.id)){
   await this.conversation(context,request.conversationId,'messaging.link.bind');
   const link=await this.repository.bind(context,{id:request.id,conversationId:request.conversationId,consent:true});
   if(link.id!==request.id)throw Error('Messaging link unavailable');
   return {linked:true,link:publicLink(context,request.conversationId,link)};
  }
  // Revoke authorization includes the persisted conversation inside the native
  // repository transaction; no conversation or phone is selected by the body.
  if(request.action==='revoke'&&keys==='action,id'&&uuid(request.id)){
   await this.repository.revoke(context,request.id);return {revoked:true};
  }
  throw Error('Invalid input');
 }
}
/** Request-scoped channel: the host supplies an authenticated native context.
 * Never retain this instance across requests or derive session from body data. */
export class NativeSmsLinkChannel extends CommunicationChannelBase<SmsLinkRequest,unknown> {
 readonly channel='message' as const;readonly service:NativeSmsLinkService;readonly context:NativeContext;
 constructor(service:NativeSmsLinkService,context:NativeContext){super();this.service=service;this.context=contextSnapshot(context);}
 protected async perform(actor:Actor,request:SmsLinkRequest){
  if(actor.id!==this.context.actor.id||actor.tenantId!==this.context.actor.tenantId)throw Error('Messaging link unavailable');
  return this.service.execute(this.context,request);
 }
}
