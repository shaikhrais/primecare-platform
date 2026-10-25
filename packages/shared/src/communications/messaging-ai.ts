import {ScopedServiceBase,CommunicationChannelBase,required,type Actor,type AtomicStore,type AccessPolicy,type RecordState} from './service-base.ts';

export type MessagingLink=Readonly<{id:string;version:number;actorId:string;tenantId:string;conversationId:string;provider:string;channel:'sms'|'whatsapp'|'telegram';address:string}>;
export interface MessagingLinkPolicy {
 /** Must require a currently verified, unrevoked account link, current opt-in,
  * unique tenant context and matching conversation. Phone equality is not proof.
  * Must also serialize/deny competing active AI turns for the same conversation.
  */
 resolve(actor:Actor,conversationId:string):Promise<MessagingLink>;
}
export interface MessagingReplyModel {reply(input:{text:string;signal:AbortSignal}):Promise<string>}
export interface MessagingReplyOutbox {
 /** Durable, idempotent queue only; revalidate the exact current link and consent
  * atomically with queueing. No direct send or automatic transport retry here.
  */
 queue(actor:Actor,input:{id:string;link:MessagingLink;text:string}):Promise<{id:string;status:'queued'}>;
}
type TurnInput={conversationId:string;eventId:string;text:string};
function text(value:unknown){if(typeof value!=='string'||!value.trim()||value.length>1600||new TextEncoder().encode(value).length>6400||/[\u0000\u000b\u000c]/.test(value))throw Error('Invalid reply text');}
function linkSnapshot(actor:Actor,conversationId:string,value:MessagingLink):MessagingLink {
 if(!value||value.actorId!==actor.id||value.tenantId!==actor.tenantId||value.conversationId!==conversationId||!['sms','whatsapp','telegram'].includes(value.channel)||!Number.isSafeInteger(value.version)||value.version<1)throw Error('Verified channel link required');
 for(const item of [value.id,value.provider,value.address])required(item);
 return Object.freeze({id:value.id,version:value.version,actorId:actor.id,tenantId:actor.tenantId,conversationId,provider:value.provider,channel:value.channel,address:value.address});
}
/** Shared linked-message orchestration. Provider adapters do not choose identity,
 * execute tasks, approve proposals or bypass this service's current policy.
 * This first reply lane is text-only: the model receives no task tools or OTPs.
 */
export class MessagingAiReplyService extends ScopedServiceBase {
 readonly links:MessagingLinkPolicy;readonly model:MessagingReplyModel;readonly outbox:MessagingReplyOutbox;
 constructor(store:AtomicStore,policy:AccessPolicy,ports:{links:MessagingLinkPolicy;model:MessagingReplyModel;outbox:MessagingReplyOutbox}){
  super(store,policy);
  if(typeof ports?.links?.resolve!=='function'||typeof ports?.model?.reply!=='function'||typeof ports?.outbox?.queue!=='function')throw Error('Messaging reply ports required');
  this.links=ports.links;this.model=ports.model;this.outbox=ports.outbox;
 }
 private async authorize(actor:Actor,action:string,state:RecordState|null){
  if(state?.ownerId!==actor.id)throw Error('Not found');
  await this.checkAccess(actor,action,state,['messaging_ai_turn']);
  const current=linkSnapshot(actor,state.conversationId,await this.links.resolve(actor,state.conversationId));
  if(JSON.stringify(current)!==JSON.stringify(state.link))throw Error('Channel link changed');
 }
 async queue(actor:Actor,id:string,key:string,input:TurnInput){
  if(!input||Object.keys(input).some(k=>!['conversationId','eventId','text'].includes(k)))throw Error('Invalid reply input');
  required(input.conversationId);required(input.eventId,180);text(input.text);
  if(id!==input.eventId)throw Error('Reply ID must match durable inbound event');
  actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});input={...input};
  const link=linkSnapshot(actor,input.conversationId,await this.links.resolve(actor,input.conversationId));
  const draft={id,tenantId:actor.tenantId,version:0,kind:'messaging_ai_turn',ownerId:actor.id,...input,link,status:'pending',reply:null,outboxId:null};
  return this.store.run({actor,id,key,expectedVersion:0,type:'messaging.ai.queue',payload:input},
   async state=>{await this.checkCreation(actor,'messaging.ai.queue',state,draft,['messaging_ai_turn'],async current=>{if(current)await this.authorize(actor,'messaging.ai.queue',current);});await this.authorize(actor,'messaging.ai.queue',draft);},
   async state=>{if(state)throw Error('Already exists');return {state:structuredClone(draft),event:'messaging.ai.queued'};});
 }
 async read(actor:Actor,id:string){return this.store.read(actor,id,state=>this.authorize(actor,'messaging.ai.read',state));}
 async generate(actor:Actor,id:string,key:string,version:number){
  required(key,180);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});const claim=crypto.randomUUID();
  const result=await this.store.run({actor,id,key,expectedVersion:version,type:'messaging.ai.claim',payload:{}},state=>this.authorize(actor,'messaging.ai.generate',state),async state=>{
   if(state!.status!=='pending')throw Error('Reply already attempted');state!.status='generating';return {state:state!,event:'messaging.ai.claimed',result:{claim,version:version+1}};
  });
  if(result.claim!==claim)return this.read(actor,id);
  const state=await this.read(actor,id);let reply:string|null=null;
  const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),15000);
  try{
   await this.authorize(actor,'messaging.ai.generate',state);
   const pending=this.model.reply({text:state.text,signal:controller.signal});
   // Bound even a faulty model port that ignores abort; no result after timeout
   // can be persisted or queued. The model has no business-action tools.
   const value=await Promise.race([pending,new Promise<never>((_,reject)=>controller.signal.addEventListener('abort',()=>reject(Error('Reply generation timeout')),{once:true}))]);
   text(value);await this.authorize(actor,'messaging.ai.generate',state);reply=value;
  }catch{/* Never automatically regenerate an uncertain attempt. */}
  finally{clearTimeout(timer);controller.abort();}
  await this.store.run({actor,id,key:key+':result',expectedVersion:result.version,type:'messaging.ai.result',payload:{reply}},current=>this.authorize(actor,'messaging.ai.generate',current),async current=>{
   if(current!.status!=='generating')throw Error('Reply state conflict');current!.status=reply===null?'generation_failed':'ready';current!.reply=reply;return {state:current!,event:reply===null?'messaging.ai.failed':'messaging.ai.ready'};
  });return this.read(actor,id);
 }
 async queueReply(actor:Actor,id:string,key:string,version:number){
  required(key,180);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});const claim=crypto.randomUUID();
  const result=await this.store.run({actor,id,key,expectedVersion:version,type:'messaging.ai.outbox_claim',payload:{}},state=>this.authorize(actor,'messaging.ai.reply',state),async state=>{
   if(state!.status!=='ready')throw Error('Reply not ready');state!.status='queueing';return {state:state!,event:'messaging.ai.outbox_claimed',result:{claim,version:version+1}};
  });
  if(result.claim!==claim)return this.read(actor,id);
  const state=await this.read(actor,id);await this.authorize(actor,'messaging.ai.reply',state);
  // Deterministic outbox ID allows explicit reconciliation if queueing succeeds
  // but the result is lost. No delivery success is inferred from queue acceptance.
  const outboxId='ai-reply:'+id;required(outboxId);
  const receipt=await this.outbox.queue(actor,{id:outboxId,link:structuredClone(state.link),text:state.reply});
  if(receipt?.id!==outboxId||receipt.status!=='queued')throw Error('Reply queue outcome unknown');
  await this.store.run({actor,id,key:key+':queued',expectedVersion:result.version,type:'messaging.ai.outbox_result',payload:{outboxId}},current=>this.authorize(actor,'messaging.ai.reply',current),async current=>{
   if(current!.status!=='queueing')throw Error('Reply state conflict');current!.status='queued';current!.outboxId=outboxId;return {state:current!,event:'messaging.ai.reply_queued'};
  });return this.read(actor,id);
 }
}
export type MessagingAiRequest=
 | {action:'queue';id:string;key:string;input:TurnInput}
 | {action:'generate'|'queue_reply';id:string;key:string;version:number}
 | {action:'read';id:string};
/** One inherited channel for linked SMS, WhatsApp and Telegram messages. */
export class MessagingAiReplyChannel extends CommunicationChannelBase<MessagingAiRequest,unknown>{
 readonly channel='message' as const;readonly service:MessagingAiReplyService;
 constructor(service:MessagingAiReplyService){super();this.service=service;}
 protected async perform(actor:Actor,request:MessagingAiRequest){
  switch(request.action){
   case 'queue':return this.service.queue(actor,request.id,request.key,request.input);
   case 'generate':return this.service.generate(actor,request.id,request.key,request.version);
   case 'queue_reply':return this.service.queueReply(actor,request.id,request.key,request.version);
   case 'read':return this.service.read(actor,request.id);
   default:throw Error('Invalid AI reply action');
  }
 }
}
