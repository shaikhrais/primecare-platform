import {required, type Actor, type AtomicStore, type AccessPolicy} from './store.ts';
import {InboundMailTextPreview,boundedMailPreview,type InboundMailPreviewPort} from '../../../../packages/shared/src/communications/mail-preview.mjs';
import {ScopedServiceBase} from '../../../../packages/shared/src/communications/service-base.ts';

export interface BusinessMailTransport {
 send(message:{from:string;to:string;subject:string;text:string;html:string}): Promise<{messageId:string}>;
}
export interface MailboxPolicy {
 /** Resolve a configured owned inbound mailbox to its tenant. Never infer scope from From headers. */
 resolve(address:string): Promise<{tenantId:string;mailboxId:string}|null>;
 /** Must validate permission/contact basis and configured sender before queueing. */
 recipient(actor:Actor,address:string): Promise<void>;
 /** Current mailbox membership/delegation must be checked on every inbound read. */
 access(actor:Actor,mailboxId:string): Promise<void>;
}
function address(value:unknown): asserts value is string {
 required(value,254);
 if (!/^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(value)) throw Error('Invalid address');
}
const escape = (text:string) => text.replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]!));

/** No external sends occur unless a registered caller explicitly invokes deliver(). */
export class BusinessMailService extends ScopedServiceBase {
 readonly mailboxes:MailboxPolicy;
 readonly preview:InboundMailPreviewPort;
 readonly transport:BusinessMailTransport;readonly sender:string;readonly maxBytes:number;
 constructor(store:AtomicStore,policy:AccessPolicy,mailboxes:MailboxPolicy,transport:BusinessMailTransport,sender:string,maxBytes:number,preview?:InboundMailPreviewPort) {
  super(store,policy);
  address(sender);if(!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Invalid mail limit');
  if(!mailboxes||typeof mailboxes.resolve!=='function'||typeof mailboxes.recipient!=='function'||typeof mailboxes.access!=='function')throw Error('Mailbox policy adapters required');
  if(preview!==undefined&&typeof preview?.project!=='function')throw Error('Configured mail preview required');
  this.preview=preview??new InboundMailTextPreview(maxBytes);
  this.mailboxes=mailboxes;this.transport=transport;this.sender=sender;this.maxBytes=maxBytes;
 }
 async authorizeMail(actor:Actor,action:string,state:import('./store.ts').RecordState|null,creating=false) {
  if(state?.kind==='outbound_mail'&&state.ownerId!==actor.id)throw Error('Not found');
  await this.checkAccess(actor,action,state,action==='mail.read'?['outbound_mail','inbound_mail']:['outbound_mail'],creating);
  if(state?.kind==='inbound_mail'){required(state.mailboxId);await this.mailboxes.access(actor,state.mailboxId);}
 }
 async queue(actor:Actor,id:string,key:string,to:string,subject:string,text:string) {
  address(to);required(subject,200);
  if(typeof text!=='string'||!text.trim()||new TextEncoder().encode(text).byteLength>this.maxBytes)throw Error('Invalid mail body');
  const draft={id,tenantId:actor.tenantId,version:0,kind:'outbound_mail',ownerId:actor.id,from:this.sender,to,subject,text,status:'queued'};
  return this.store.run({actor,id,key,expectedVersion:0,type:'mail.queue',payload:{to,subject,text}},
   async state=>{await this.checkCreation(actor,'mail.queue',state,draft,['outbound_mail'],current=>this.authorizeMail(actor,'mail.queue',current,true));await this.mailboxes.recipient(actor,to);},async state=>{
    if(state)throw Error('Already exists');
    return {state:structuredClone(draft),event:'mail.queued'};
   });
 }
 async deliver(actor:Actor,id:string,key:string,expectedVersion:number) {
  actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  required(key,190); // Leave room for the atomic receipt command suffix before attempting a send.
  const token=crypto.randomUUID();
  const claimed=await this.store.run({actor,id,key,expectedVersion,type:'mail.claim',payload:{}},
   async state=>{await this.authorizeMail(actor,'mail.deliver',state);await this.mailboxes.recipient(actor,state!.to);},
   async state=>{if(state!.status!=='queued')throw Error('Mail already attempted');state!.status='sending';return {state:state!,event:'mail.claimed',result:{id,version:expectedVersion+1,claimToken:token}};});
  // A retry must never resend an ambiguous native transport request.
  if(claimed.claimToken!==token)return this.read(actor,id);
  const message=await this.read(actor,id);
  // Claim/read cross storage and policy awaits. Resolve the current recipient
  // basis again, then current delivery permission before the irreversible send.
  // A denial leaves the durable claim in sending: never reopen it or retry.
  await this.mailboxes.recipient(actor,message.to);
  await this.authorizeMail(actor,'mail.deliver',message);
  let receipt:string|null=null;
  try {
   const result=await this.transport.send({from:message.from,to:message.to,subject:message.subject,text:message.text,html:'<p>'+escape(message.text)+'</p>'});
   required(result?.messageId,500);receipt=result.messageId;
  } catch { /* Native acceptance may have occurred. Preserve unknown; do not retry. */ }
  await this.store.run({actor,id,key:key+':receipt',expectedVersion:claimed.version,type:'mail.receipt',payload:{receipt}},
   state=>this.authorizeMail(actor,'mail.deliver',state),
   async state=>{if(state!.status!=='sending')throw Error('Mail state conflict');state!.status=receipt?'accepted':'unknown';state!.providerMessageId=receipt;return {state:state!,event:receipt?'mail.accepted':'mail.unknown'};});
  return this.read(actor,id);
 }
 async read(actor:Actor,id:string) {
  const state=await this.store.read(actor,id,state=>this.authorizeMail(actor,'mail.read',state));
  if(state.kind!=='inbound_mail')return state;
  if(state.status!=='quarantined'||state.senderIdentityVerified!==false)throw Error('Inbound quarantine unavailable');
  let contentPreview=boundedMailPreview(undefined,this.maxBytes);
  try{contentPreview=boundedMailPreview(await this.preview.project(state.rawBase64),this.maxBytes);}catch{/* Keep the envelope available without leaking parser errors. */}
  // Membership may be revoked during parsing: recheck before exposing content.
  await this.authorizeMail(actor,'mail.read',state);
  return {id:state.id,tenantId:state.tenantId,version:state.version,kind:state.kind,mailboxId:state.mailboxId,from:state.from,to:state.to,status:'quarantined',senderIdentityVerified:false,contentPreview};
 }
 async inbox(actor:Actor,direction:'inbound'|'outbound',mailboxId?:string,limit=50,after?:string) {
  if(!['inbound','outbound'].includes(direction)||!Number.isSafeInteger(limit)||limit<1||limit>100||direction==='outbound'&&mailboxId!==undefined)throw Error('Invalid inbox');
  if(direction==='inbound')required(mailboxId);if(after!==undefined)required(after);
  // Supply the selected mailbox scope to current policy before any storage read.
  const scope={id:mailboxId??actor.id,tenantId:actor.tenantId,version:0,kind:direction==='inbound'?'inbound_mail':'outbound_mail',ownerId:actor.id,...(mailboxId===undefined?{}:{mailboxId})};
  await this.checkAccess(actor,'mail.inbox',scope,[scope.kind]);
  if(direction==='inbound')await this.mailboxes.access(actor,mailboxId!);
  if(typeof this.store.mailInbox!=='function')throw Error('Mailbox listing storage required');
  const page=await this.store.mailInbox(actor,direction,mailboxId,state=>this.authorizeMail(actor,'mail.read',state),limit,after);
  return {items:page.items.map(state=>({id:state.id,version:state.version,kind:state.kind,status:state.status,from:state.from,to:state.to,...(typeof state.subject==='string'?{subject:state.subject}:{})})),nextAfter:page.nextAfter};
 }
 /** Trusted inbound worker boundary only. Raw content stays quarantined and never executes actions. */
 async receive(envelope:{from:string;to:string;raw:Uint8Array}) {
  address(envelope.to);address(envelope.from);
  if(!(envelope.raw instanceof Uint8Array)||!envelope.raw.byteLength||envelope.raw.byteLength>this.maxBytes)throw Error('Invalid inbound size');
  const raw=new Uint8Array(envelope.raw),from=envelope.from,to=envelope.to.toLowerCase();
  const mailbox=await this.mailboxes.resolve(to);if(!mailbox)throw Error('Unknown mailbox');
  required(mailbox.tenantId);required(mailbox.mailboxId);
  const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',raw)),byte=>byte.toString(16).padStart(2,'0')).join('');
  const id='mail:'+mailbox.mailboxId+':'+digest;
  const actor={id:'inbound-mail',tenantId:mailbox.tenantId};
  let binary='';for(let i=0;i<raw.length;i+=8192)binary+=String.fromCharCode(...raw.subarray(i,i+8192));
  const draft={id,tenantId:mailbox.tenantId,version:0,kind:'inbound_mail',mailboxId:mailbox.mailboxId,from,to,rawBase64:btoa(binary),digest,status:'quarantined',senderIdentityVerified:false};
  // The internal service identity still requires a registered permission policy.
  return this.store.run({actor,id,key:digest,expectedVersion:0,type:'mail.receive',payload:{from,to,digest}},
   state=>this.checkCreation(actor,'mail.receive',state,draft,['inbound_mail']),async state=>{
    if(state)throw Error('Already exists');
    return {state:structuredClone(draft),event:'mail.received'};
   });
 }
}
