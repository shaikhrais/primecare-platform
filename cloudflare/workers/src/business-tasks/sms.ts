import {ScopedServiceBase,required,type Actor,type AtomicStore,type AccessPolicy,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import {smsDeliveryProjection,type TwilioSmsTransport,type SmsDeliveryObservation} from '../../../../packages/shared/src/communications/twilio-sms.mjs';
export interface SmsRecipientPolicy{
 /** Resolve contact ownership, consent, current opt-out, destination country and quotas.
  * E.164 +1 alone does not prove Canada; this trusted policy must check it.
  */
 recipient(actor:Actor,to:string):Promise<void>;
}
/** Internal inherited outbox. No public SMS route or permission is created here. */
export class SmsNotificationService extends ScopedServiceBase{
 readonly transport:Pick<TwilioSmsTransport,'send'>;readonly recipients:SmsRecipientPolicy;
 readonly sender:string;readonly accountSid:string;readonly messagingServiceSid:string;readonly maxTextBytes:number;
 constructor(store:AtomicStore,policy:AccessPolicy,recipients:SmsRecipientPolicy,transport:Pick<TwilioSmsTransport,'send'>,config:{sender:string;accountSid:string;messagingServiceSid:string;maxTextBytes:number}){
  super(store,policy);
  if(typeof recipients?.recipient!=='function'||typeof transport?.send!=='function'||!/^\+[1-9][0-9]{1,14}$/.test(config?.sender)||!/^AC[a-fA-F0-9]{32}$/.test(config?.accountSid)||!/^MG[a-fA-F0-9]{32}$/.test(config?.messagingServiceSid)||!Number.isSafeInteger(config?.maxTextBytes)||config.maxTextBytes<1||config.maxTextBytes>6400)throw Error('SMS service configuration required');
  this.recipients=recipients;this.transport=transport;this.sender=config.sender;this.accountSid=config.accountSid;this.messagingServiceSid=config.messagingServiceSid;this.maxTextBytes=config.maxTextBytes;
 }
 async authorize(actor:Actor,action:string,state:RecordState|null,creating=false){
  if(state?.ownerId!==actor.id&&action!=='sms.status.receive'&&state!==null)throw Error('Not found');
  await this.checkAccess(actor,action,state,['outbound_sms'],creating);
 }
 async queue(actor:Actor,id:string,key:string,to:string,text:string){
  if(typeof to!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(to)||typeof text!=='string'||text.length>1600||!text.trim()||/[\u0000\u000b\u000c]/.test(text)||new TextEncoder().encode(text).length>this.maxTextBytes)throw Error('Invalid SMS');
  const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  const draft={id,tenantId:owner.tenantId,version:0,kind:'outbound_sms',ownerId:owner.id,to,text,from:this.sender,accountSid:this.accountSid,messagingServiceSid:this.messagingServiceSid,status:'queued',providerMessageId:null,observations:[]};
  return this.store.run({actor:owner,id,key,expectedVersion:0,type:'sms.queue',payload:{to,text}},async state=>{
   await this.checkCreation(owner,'sms.queue',state,draft,['outbound_sms'],current=>this.authorize(owner,'sms.queue',current,true));await this.recipients.recipient(owner,to);
  },async state=>{if(state)throw Error('Already exists');return {state:structuredClone(draft),event:'sms.queued'};});
 }
 async read(actor:Actor,id:string){return this.store.read(actor,id,state=>this.authorize(actor,'sms.read',state));}
 async deliver(actor:Actor,id:string,key:string,expectedVersion:number){
  required(key,190);const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId}),claim=crypto.randomUUID();
  const claimed=await this.store.run({actor:owner,id,key,expectedVersion,type:'sms.claim',payload:{}},async state=>{
   await this.authorize(owner,'sms.deliver',state);
   if(state!.from!==this.sender||state!.accountSid!==this.accountSid||state!.messagingServiceSid!==this.messagingServiceSid)throw Error('SMS sender configuration changed');
   await this.recipients.recipient(owner,state!.to);
  },async state=>{if(state!.status!=='queued')throw Error('SMS already attempted');state!.status='sending';return {state:state!,event:'sms.claimed',result:{id,version:expectedVersion+1,claim}};});
  if(claimed.claim!==claim)return this.read(owner,id);
  const state=await this.read(owner,id);let receipt:{messageSid:string;status:string}|null=null;
  // Consent/opt-out can change after queue or claim; check immediately before send.
  await this.recipients.recipient(owner,state.to);await this.authorize(owner,'sms.deliver',state);
  try{const result=await this.transport.send({to:state.to,text:state.text});if(!/^SM[a-fA-F0-9]{32}$/.test(result?.messageSid)||!['accepted','scheduled','queued','sending','sent','delivered','undelivered','failed','canceled'].includes(result?.status))throw Error('receipt');receipt={messageSid:result.messageSid,status:result.status};}catch{/* May have been accepted: never resend this claim. */}
  await this.store.run({actor:owner,id,key:key+':receipt',expectedVersion:claimed.version,type:'sms.receipt',payload:{receipt}},current=>this.authorize(owner,'sms.deliver',current),async current=>{
   if(current!.status!=='sending')throw Error('SMS state conflict');current!.providerMessageId=receipt?.messageSid??null;current!.status=receipt?'accepted':'unknown';current!.observations=receipt?[receipt.status]:[];
   return {state:current!,event:receipt?'sms.accepted':'sms.unknown'};
  });return this.read(owner,id);
 }
 /** Trusted signature-verified callback pipeline only. actor/id must be resolved
  * from the durable provider SID mapping, never from webhook tenant/user fields.
  * Caller retries version conflicts; identical observations are idempotent.
  */
 async observe(actor:Actor,id:string,expectedVersion:number,event:SmsDeliveryObservation){
  const observation=structuredClone(event),owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  if(!/^SM[a-fA-F0-9]{32}$/.test(observation?.messageSid)||observation.accountSid!==this.accountSid||observation.messagingServiceSid!==this.messagingServiceSid||observation.from!==this.sender||observation.errorCode!==null&&!/^\d{1,8}$/.test(observation.errorCode))throw Error('Invalid SMS observation');
  smsDeliveryProjection([observation.status]);
  const key='status:'+observation.messageSid+':'+observation.status+':'+(observation.errorCode??'none');
  return this.store.run({actor:owner,id,key,expectedVersion,type:'sms.status',payload:observation},state=>this.authorize(owner,'sms.status.receive',state),async state=>{
   if(state!.providerMessageId!==observation.messageSid||state!.accountSid!==observation.accountSid||state!.messagingServiceSid!==observation.messagingServiceSid||state!.from!==observation.from||state!.to!==observation.to)throw Error('Provider mapping conflict');
   state!.observations=[...new Set([...state!.observations,observation.status])];state!.delivery=smsDeliveryProjection(state!.observations);state!.lastErrorCode=observation.errorCode;
   return {state:state!,event:'sms.status.observed'};
  });
 }
}
