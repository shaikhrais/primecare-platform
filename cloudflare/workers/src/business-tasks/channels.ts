import {CommunicationChannelBase,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {CommunicationService} from './communication.ts';
import type {BusinessMailService} from './mail.ts';

type Versioned = {id:string;key:string;version:number};
export type MessageRequest =
 | {action:'create';id:string;key:string;members:string[];businessReference:string}
 | (Versioned & {action:'send';text:string;pictureIds?:string[]})
 | (Versioned & {action:'mark_read';sequence:number})
 | {action:'read';id:string}
 | {action:'inbox';limit?:number};
export class MessageChannel extends CommunicationChannelBase<MessageRequest,unknown> {
 readonly channel='message' as const;
 readonly service:CommunicationService;
 constructor(service:CommunicationService){super();this.service=service;}
 protected async perform(actor:Actor,request:MessageRequest) {
  switch(request.action) {
   case 'create':return this.service.create(actor,request.id,request.key,request.members,request.businessReference);
   case 'send':return this.service.message(actor,request.id,request.key,request.version,request.text,request.pictureIds);
   case 'mark_read':return this.service.markRead(actor,request.id,request.key,request.version,request.sequence);
   case 'read':return this.service.read(actor,request.id);
   case 'inbox':return this.service.inbox(actor,request.limit);
   default:throw Error('Invalid message action');
  }
 }
}
export type PictureRequest = {action:'upload';threadId:string;bytes:Uint8Array;mediaType:string}|{action:'open';threadId:string;pictureId:string};
export class PictureChannel extends CommunicationChannelBase<PictureRequest,unknown> {
 readonly channel='picture' as const;
 readonly service:CommunicationService;
 constructor(service:CommunicationService){super();this.service=service;}
 protected async perform(actor:Actor,request:PictureRequest) {
  switch(request.action) {
   case 'upload':return this.service.picture(actor,request.threadId,request.bytes,request.mediaType);
   case 'open':return this.service.openPicture(actor,request.threadId,request.pictureId);
   default:throw Error('Invalid picture action');
  }
 }
}
export type AudioRequest = (Versioned & {action:'invite'|'accept'|'decline'|'end'|'expire';callId:string;recipientId?:string})
 | (Versioned & {action:'signal';callId:string;signal:{type:string;description?:{type:string;sdp:string};candidate?:Record<string,unknown>}});
export class AudioChannel extends CommunicationChannelBase<AudioRequest,unknown> {
 readonly channel='audio' as const;
 readonly service:CommunicationService;
 constructor(service:CommunicationService){super();this.service=service;}
 protected async perform(actor:Actor,request:AudioRequest) {
  if(request.action==='signal')return this.service.signal(actor,request.id,request.key,request.version,request.callId,request.signal);
  if(!['invite','accept','decline','end','expire'].includes(request.action))throw Error('Invalid audio action');
  return this.service.call(actor,request.id,request.key,request.version,request.action,request.callId,request.recipientId);
 }
}
export type EmailRequest = {action:'queue';id:string;key:string;to:string;subject:string;text:string}
 | (Versioned & {action:'deliver'}) | {action:'read';id:string}
 | {action:'inbox';direction:'inbound'|'outbound';mailboxId?:string;limit?:number;after?:string};
export class EmailChannel extends CommunicationChannelBase<EmailRequest,unknown> {
 readonly channel='email' as const;
 readonly service:BusinessMailService;
 constructor(service:BusinessMailService){super();this.service=service;}
 protected async perform(actor:Actor,request:EmailRequest) {
  switch(request.action) {
   case 'queue':return this.service.queue(actor,request.id,request.key,request.to,request.subject,request.text);
   case 'deliver':return this.service.deliver(actor,request.id,request.key,request.version);
   case 'read':return this.service.read(actor,request.id);
   case 'inbox':return this.service.inbox(actor,request.direction,request.mailboxId,request.limit,request.after);
   default:throw Error('Invalid email action');
  }
 }
}
export type ChannelRequests = {message:MessageRequest;picture:PictureRequest;audio:AudioRequest;email:EmailRequest};

/** One composition root for every permitted user; never selects identity from the request. */
export class CommunicationCore {
 readonly channels:Readonly<{message:MessageChannel;picture:PictureChannel;audio:AudioChannel;email:EmailChannel}>;
 constructor(conversations:CommunicationService,mail:BusinessMailService) {
  this.channels=Object.freeze({message:new MessageChannel(conversations),picture:new PictureChannel(conversations),audio:new AudioChannel(conversations),email:new EmailChannel(mail)});
 }
 execute<K extends keyof ChannelRequests>(channel:K,actor:Actor,request:ChannelRequests[K]):Promise<unknown> {
  if(!Object.hasOwn(this.channels,channel))throw Error('Unknown communication channel');
  const selected=this.channels[channel] as CommunicationChannelBase<ChannelRequests[K],unknown>;
  return selected.execute(actor,request);
 }
}
