import {ConversationCallServiceBase,type ConversationCallLimits} from './call-service.ts';
import {CommunicationChannelBase,assertActor,required,type Actor,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
export type InternalExtension={extension:string;tenantId:string;userId?:string;published:boolean;active:boolean;tenantActive:boolean;userActive:boolean;version:number};
export interface InternalExtensionDirectory {lookup(extension:string,limit:2):Promise<InternalExtension[]>}
export type ExtensionDialRequest={id:string;key:string;version:number;callId:string;extension:string};
const unavailable=()=>Error('Call destination unavailable');
/** App-to-app extension dialer over the same native PostgreSQL directory used
 * for telephone routing. Extension equality is routing, never authentication.
 * No Twilio SDK, provider token, telephone number or model broker is required.
 */
export class InternalExtensionCallService extends ConversationCallServiceBase {
 readonly directory:InternalExtensionDirectory;
 constructor(store:AtomicStore,policy:AccessPolicy,directory:InternalExtensionDirectory,limits:ConversationCallLimits,now=Date.now){
  super(store,policy,limits,now);if(typeof directory?.lookup!=='function')throw unavailable();this.directory=directory;
 }
 private async destination(actor:Actor,extension:string){
  const found=await this.directory.lookup(extension,2);if(!Array.isArray(found)||found.length!==1)throw unavailable();const row={...found[0]};
  if(row.extension!==extension||row.tenantId!==actor.tenantId||row.userId===actor.id||row.active!==true||row.published!==true||row.tenantActive!==true||row.userActive!==true||!Number.isSafeInteger(row.version)||row.version<1)throw unavailable();required(row.userId);
  return Object.freeze({extension:row.extension,tenantId:row.tenantId,userId:row.userId,version:row.version});
 }
 async dial(actor:Actor,input:ExtensionDialRequest){
  assertActor(actor);actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  if(!input||Object.keys(input).sort().join(',')!=='callId,extension,id,key,version'||typeof input.extension!=='string'||!/^[1-9][0-9]{3}$/.test(input.extension))throw unavailable();
  input={...input};required(input.id);required(input.key);required(input.callId);if(!Number.isSafeInteger(input.version)||input.version<1)throw unavailable();
  const conversation=await this.read(actor,input.id),target=await this.destination(actor,input.extension);
  if(!conversation.members.includes(target.userId))throw unavailable();
  await this.policy.assignee(actor,target.userId,'communication');
  // Directory/eligibility I/O can suspend. Resolve the same current assignment
  // again immediately before the inherited atomic invitation. The recipient
  // independently authenticates/authorizes acceptance before media starts.
  const current=await this.destination(actor,input.extension);
  if(current.userId!==target.userId||current.version!==target.version||current.tenantId!==target.tenantId)throw unavailable();
  return this.call(actor,input.id,input.key,input.version,'invite',input.callId,target.userId);
 }
}
export type InternalCallRequest=({action:'dial'}&ExtensionDialRequest)
 |{action:'accept'|'decline'|'end'|'expire';id:string;key:string;version:number;callId:string}
 |{action:'signal';id:string;key:string;version:number;callId:string;signal:{type:string;description?:{type:string;sdp:string};candidate?:Record<string,unknown>}};
/** Internal channel only; host registration is required before mounting a new
 * extension-dial contract. Existing registered audio endpoints are unchanged. */
export class InternalExtensionCallChannel extends CommunicationChannelBase<InternalCallRequest,unknown> {
 readonly channel='audio' as const;readonly service:InternalExtensionCallService;
 constructor(service:InternalExtensionCallService){super();this.service=service;}
 protected async perform(actor:Actor,request:InternalCallRequest){
  const {action,...input}=request,keys=Object.keys(request).sort().join(',');
  if(action==='dial')return this.service.dial(actor,input as ExtensionDialRequest);
  if(action==='signal'&&keys==='action,callId,id,key,signal,version')return this.service.signal(actor,request.id,request.key,request.version,request.callId,(request as Extract<InternalCallRequest,{action:'signal'}>).signal);
  if(['accept','decline','end','expire'].includes(action)&&keys==='action,callId,id,key,version')return this.service.call(actor,request.id,request.key,request.version,action as 'accept'|'decline'|'end'|'expire',request.callId);
  throw Error('Invalid call action');
 }
}
