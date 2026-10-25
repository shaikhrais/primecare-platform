import {required, type Actor, type AtomicStore, type AccessPolicy, type RecordState} from './store.ts';
import {ConversationCallServiceBase} from './call-service.ts';

export interface PictureRepository {
 /** Must decode, bound pixels, scan, strip metadata/re-encode and store privately before returning. */
 prepare(actor: Actor, threadId: string, bytes: Uint8Array, mediaType: string): Promise<{id:string;tenantId:string;threadId:string;mediaType:string;size:number;status:'clean'}>;
 get(actor: Actor, id: string): Promise<{id:string;tenantId:string;threadId:string;mediaType:string;size:number;status:string}>;
 /** Validate metadata on the actual returned object, including this conversation. */
 open?(actor: Actor, id: string, threadId: string): Promise<unknown>;
}
export type CommunicationLimits = {maxMembers:number;maxMessages:number;maxText:number;maxPictureBytes:number;maxPictures:number;ringMilliseconds:number;maxSignalBytes:number};

/** Messaging/media inherit the provider-neutral call lifecycle and scope. */
export class CommunicationService extends ConversationCallServiceBase {
 readonly pictures:PictureRepository;
 declare readonly limits:CommunicationLimits;
 constructor(store:AtomicStore,policy:AccessPolicy,pictures:PictureRepository,limits:CommunicationLimits,now=Date.now){
  super(store,policy,limits,now);
  for(const field of ['maxText','maxPictureBytes','maxPictures'] as const)if(!Number.isSafeInteger(limits[field])||limits[field]<1)throw Error('Invalid configured limit');
  this.pictures=pictures;this.limits={...limits};
 }
 async message(actor: Actor, id: string, key: string, expectedVersion: number, text: string, pictureIds: string[] = []) {
  if (typeof text !== 'string' || text.length > this.limits.maxText || /[\u0000\u000b\u000c]/.test(text)) throw Error('Invalid message');
  if (!Array.isArray(pictureIds) || pictureIds.length > this.limits.maxPictures || new Set(pictureIds).size !== pictureIds.length || !text.trim() && !pictureIds.length) throw Error('Empty or invalid message');
  pictureIds.forEach(picture => required(picture));
  // Keep validation, the idempotency fingerprint and persistence on one snapshot.
  pictureIds=[...pictureIds];
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.message',payload:{text,pictureIds}},
   state => this.authorize(actor,'conversation.message',state),async state => {
    if (state!.messages.length >= this.limits.maxMessages) throw Error('Conversation storage limit');
    for(const pictureId of pictureIds) {
     const picture = await this.pictures.get(actor,pictureId);
     if (picture.tenantId !== actor.tenantId || picture.threadId !== id || picture.status !== 'clean') throw Error('Picture unavailable');
    }
    state!.messages.push({id:key,authorId:actor.id,text:text.trim(),pictureIds:[...pictureIds],sequence:state!.messages.length+1,sentAt:new Date(this.now()).toISOString()});
    return {state:state!,event:'conversation.message'};
   });
 }
 async picture(actor: Actor, id: string, bytes: Uint8Array, mediaType: string) {
  actor=Object.freeze({...actor});
  if (!(bytes instanceof Uint8Array) || !bytes.length || bytes.length > this.limits.maxPictureBytes) throw Error('Invalid picture size');
  bytes=new Uint8Array(bytes);
  const png = bytes.length >= 8 && [137,80,78,71,13,10,26,10].every((value,index) => bytes[index] === value);
  const jpeg = bytes.length >= 3 && bytes[0]===255 && bytes[1]===216 && bytes[2]===255;
  if (!(mediaType === 'image/png' && png || mediaType === 'image/jpeg' && jpeg)) throw Error('Invalid picture type');
  const conversation = await this.read(actor,id);
  await this.policy.assert(actor,'conversation.picture',conversation);
  const picture = await this.pictures.prepare(actor,id,bytes,mediaType);
  if (picture.tenantId !== actor.tenantId || picture.threadId !== id || picture.status !== 'clean' || !['image/png','image/jpeg'].includes(picture.mediaType) || !Number.isSafeInteger(picture.size) || picture.size < 1 || picture.size > this.limits.maxPictureBytes) throw Error('Picture processing failed');
  await this.policy.assert(actor,'conversation.picture',await this.read(actor,id));
  return picture;
 }
 async openPicture(actor: Actor, id: string, pictureId: string) {
  actor=Object.freeze({...actor});
  await this.read(actor,id);
  const picture=await this.pictures.get(actor,pictureId);
  if(picture.tenantId!==actor.tenantId||picture.threadId!==id||picture.status!=='clean'||!this.pictures.open)throw Error('Picture unavailable');
  const object=await this.pictures.open(actor,pictureId,id);
  try {
   // Storage/scan work may suspend while an account or task relationship changes.
   await this.read(actor,id);
   return object;
  }catch(error){
   const body=(object as {body?:{cancel?:()=>Promise<void>}}|null)?.body;
   try{if(typeof body?.cancel==='function')await body.cancel();}catch{/* Preserve current-access denial. */}
   throw error;
  }
 }
 async markRead(actor: Actor, id: string, key: string, expectedVersion: number, sequence: number) {
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.read',payload:{sequence}},
   state => this.authorize(actor,'conversation.read',state),async state => {
    if (!Number.isSafeInteger(sequence) || sequence < (state!.readThrough[actor.id] ?? 0) || sequence > state!.messages.length) throw Error('Invalid read receipt');
    state!.readThrough[actor.id] = sequence;
    return {state:state!,event:'conversation.read'};
   });
 }
}
