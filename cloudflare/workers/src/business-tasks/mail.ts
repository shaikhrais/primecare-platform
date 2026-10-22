import {required, type Actor, type AtomicStore, type AccessPolicy} from './store.ts';

export interface BusinessMailTransport {
 send(message:{from:string;to:string;subject:string;text:string;html:string}): Promise<{messageId:string}>;
}
export interface MailboxPolicy {
 /** Resolve a configured owned inbound mailbox to its tenant. Never infer scope from From headers. */
 resolve(address:string): Promise<{tenantId:string;mailboxId:string}|null>;
 /** Must validate permission/contact basis and configured sender before queueing. */
 recipient(actor:Actor,address:string): Promise<void>;
}
function address(value:unknown): asserts value is string {
 required(value,254);
 if (!/^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(value)) throw Error('Invalid address');
}
const escape = (text:string) => text.replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]!));

/** No external sends occur unless a registered caller explicitly invokes deliver(). */
export class BusinessMailService {
 readonly store:AtomicStore;readonly policy:AccessPolicy;readonly mailboxes:MailboxPolicy;
 readonly transport:BusinessMailTransport;readonly sender:string;readonly maxBytes:number;
 constructor(store:AtomicStore,policy:AccessPolicy,mailboxes:MailboxPolicy,transport:BusinessMailTransport,sender:string,maxBytes:number) {
  address(sender);if(!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Invalid mail limit');
  this.store=store;this.policy=policy;this.mailboxes=mailboxes;this.transport=transport;this.sender=sender;this.maxBytes=maxBytes;
 }
 async queue(actor:Actor,id:string,key:string,to:string,subject:string,text:string) {
  address(to);required(subject,200);
  if(typeof text!=='string'||!text.trim()||new TextEncoder().encode(text).byteLength>this.maxBytes)throw Error('Invalid mail body');
  return this.store.run({actor,id,key,expectedVersion:0,type:'mail.queue',payload:{to,subject,text}},
   async state=>{await this.policy.assert(actor,'mail.queue',state);await this.mailboxes.recipient(actor,to);},async state=>{
    if(state)throw Error('Already exists');
    return {state:{id,tenantId:actor.tenantId,version:0,kind:'outbound_mail',from:this.sender,to,subject,text,status:'queued'},event:'mail.queued'};
   });
 }
 async deliver(actor:Actor,id:string,key:string,expectedVersion:number) {
  required(key,190); // Leave room for the atomic receipt command suffix before attempting a send.
  const token=crypto.randomUUID();
  const claimed=await this.store.run({actor,id,key,expectedVersion,type:'mail.claim',payload:{}},
   async state=>{if(!state||state.kind!=='outbound_mail')throw Error('Not found');await this.policy.assert(actor,'mail.deliver',state);await this.mailboxes.recipient(actor,state.to);},
   async state=>{if(state!.status!=='queued')throw Error('Mail already attempted');state!.status='sending';return {state:state!,event:'mail.claimed',result:{id,version:expectedVersion+1,claimToken:token}};});
  // A retry must never resend an ambiguous native transport request.
  if(claimed.claimToken!==token)return this.read(actor,id);
  const message=await this.read(actor,id);
  let receipt:string|null=null;
  try {
   const result=await this.transport.send({from:message.from,to:message.to,subject:message.subject,text:message.text,html:'<p>'+escape(message.text)+'</p>'});
   required(result?.messageId,500);receipt=result.messageId;
  } catch { /* Native acceptance may have occurred. Preserve unknown; do not retry. */ }
  await this.store.run({actor,id,key:key+':receipt',expectedVersion:claimed.version,type:'mail.receipt',payload:{receipt}},
   async state=>{if(!state||state.kind!=='outbound_mail')throw Error('Not found');await this.policy.assert(actor,'mail.deliver',state);},
   async state=>{if(state!.status!=='sending')throw Error('Mail state conflict');state!.status=receipt?'accepted':'unknown';state!.providerMessageId=receipt;return {state:state!,event:receipt?'mail.accepted':'mail.unknown'};});
  return this.read(actor,id);
 }
 async read(actor:Actor,id:string) {return this.store.read(actor,id,async state=>{if(!['outbound_mail','inbound_mail'].includes(state.kind))throw Error('Not found');await this.policy.assert(actor,'mail.read',state);});}
 /** Trusted inbound worker boundary only. Raw content stays quarantined and never executes actions. */
 async receive(envelope:{from:string;to:string;raw:Uint8Array}) {
  address(envelope.to);address(envelope.from);
  if(!(envelope.raw instanceof Uint8Array)||!envelope.raw.byteLength||envelope.raw.byteLength>this.maxBytes)throw Error('Invalid inbound size');
  const mailbox=await this.mailboxes.resolve(envelope.to.toLowerCase());if(!mailbox)throw Error('Unknown mailbox');
  const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new Uint8Array(envelope.raw))),byte=>byte.toString(16).padStart(2,'0')).join('');
  const id='mail:'+mailbox.mailboxId+':'+digest;
  const actor={id:'inbound-mail',tenantId:mailbox.tenantId};
  // The internal service identity still requires a registered permission policy.
  return this.store.run({actor,id,key:digest,expectedVersion:0,type:'mail.receive',payload:{from:envelope.from,to:envelope.to.toLowerCase(),digest}},
   state=>this.policy.assert(actor,'mail.receive',state),async state=>{
    if(state)throw Error('Already exists');
    let binary='';for(let i=0;i<envelope.raw.length;i+=8192)binary+=String.fromCharCode(...envelope.raw.subarray(i,i+8192));
    return {state:{id,tenantId:mailbox.tenantId,version:0,kind:'inbound_mail',mailboxId:mailbox.mailboxId,from:envelope.from,to:envelope.to.toLowerCase(),rawBase64:btoa(binary),digest,status:'quarantined',senderIdentityVerified:false},event:'mail.received'};
   });
 }
}
