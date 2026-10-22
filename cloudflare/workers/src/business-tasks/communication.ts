import {required, type Actor, type AtomicStore, type AccessPolicy, type RecordState} from './store.ts';
import {ScopedServiceBase} from '../../../../packages/shared/src/communications/service-base.ts';

export interface PictureRepository {
 /** Must decode, bound pixels, scan, strip metadata/re-encode and store privately before returning. */
 prepare(actor: Actor, threadId: string, bytes: Uint8Array, mediaType: string): Promise<{id:string;tenantId:string;threadId:string;mediaType:string;size:number;status:'clean'}>;
 get(actor: Actor, id: string): Promise<{id:string;tenantId:string;threadId:string;mediaType:string;size:number;status:string}>;
 open?(actor: Actor, id: string): Promise<unknown>;
}
export type CommunicationLimits = {maxMembers:number;maxMessages:number;maxText:number;maxPictureBytes:number;maxPictures:number;ringMilliseconds:number;maxSignalBytes:number};

/** Internal orchestration only. No public messaging/call API exists until registration. */
export class CommunicationService extends ScopedServiceBase {
 readonly pictures: PictureRepository;
 readonly limits: CommunicationLimits;
 readonly now: () => number;
 constructor(store: AtomicStore, policy: AccessPolicy, pictures: PictureRepository, limits: CommunicationLimits, now = Date.now) {
  super(store,policy);
  for (const field of ['maxMembers','maxMessages','maxText','maxPictureBytes','maxPictures','ringMilliseconds','maxSignalBytes'] as const) {
   if (!limits || !Number.isSafeInteger(limits[field]) || limits[field] < 1) throw Error('Invalid configured limit');
  }
  this.pictures=pictures;this.limits={...limits};this.now=now;
 }
 async inbox(actor:Actor,limit=50) {
  await this.policy.assert(actor,'conversation.inbox',null);
  return {items:await this.store.inbox(actor,'conversation',state=>this.authorize(actor,'conversation.read',state),limit)};
 }
 async authorize(actor: Actor, action: string, state: RecordState | null) {
  if (!state || state.kind !== 'conversation' || !state.members.includes(actor.id)) throw Error('Not found');
  await this.checkAccess(actor,action,state,['conversation']);
 }
 async create(actor: Actor, id: string, key: string, members: string[], businessReference: string) {
  required(businessReference);
  if (!Array.isArray(members) || !members.includes(actor.id) || members.length < 2 || members.length > this.limits.maxMembers || new Set(members).size !== members.length) throw Error('Invalid members');
  members.forEach(member => required(member));
  const memberIds=[...members];
  const draft={id,tenantId:actor.tenantId,version:0,kind:'conversation',members:memberIds,businessReference,messages:[],readThrough:{},calls:[]};
  return this.store.run({actor,id,key,expectedVersion:0,type:'conversation.create',payload:{members:memberIds,businessReference}},
   async state => {await this.checkCreation(actor,'conversation.create',state,draft,['conversation']);for(const member of memberIds) await this.policy.assignee(actor,member,'communication');},
   async state => {
    if(state) throw Error('Already exists');
    return {state:structuredClone(draft),event:'conversation.created'};
   });
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
  if (!(bytes instanceof Uint8Array) || !bytes.length || bytes.length > this.limits.maxPictureBytes) throw Error('Invalid picture size');
  bytes=new Uint8Array(bytes);
  const png = bytes.length >= 8 && [137,80,78,71,13,10,26,10].every((value,index) => bytes[index] === value);
  const jpeg = bytes.length >= 3 && bytes[0]===255 && bytes[1]===216 && bytes[2]===255;
  if (!(mediaType === 'image/png' && png || mediaType === 'image/jpeg' && jpeg)) throw Error('Invalid picture type');
  const conversation = await this.read(actor,id);
  await this.policy.assert(actor,'conversation.picture',conversation);
  const picture = await this.pictures.prepare(actor,id,bytes,mediaType);
  if (picture.tenantId !== actor.tenantId || picture.threadId !== id || picture.status !== 'clean' || !['image/png','image/jpeg'].includes(picture.mediaType) || !Number.isSafeInteger(picture.size) || picture.size < 1 || picture.size > this.limits.maxPictureBytes) throw Error('Picture processing failed');
  return picture;
 }
 async openPicture(actor: Actor, id: string, pictureId: string) {
  await this.read(actor,id);
  const picture=await this.pictures.get(actor,pictureId);
  if(picture.tenantId!==actor.tenantId||picture.threadId!==id||picture.status!=='clean'||!this.pictures.open)throw Error('Picture unavailable');
  return this.pictures.open(actor,pictureId);
 }
 async markRead(actor: Actor, id: string, key: string, expectedVersion: number, sequence: number) {
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.read',payload:{sequence}},
   state => this.authorize(actor,'conversation.read',state),async state => {
    if (!Number.isSafeInteger(sequence) || sequence < (state!.readThrough[actor.id] ?? 0) || sequence > state!.messages.length) throw Error('Invalid read receipt');
    state!.readThrough[actor.id] = sequence;
    return {state:state!,event:'conversation.read'};
   });
 }
 async call(actor: Actor, id: string, key: string, expectedVersion: number, action: 'invite'|'accept'|'decline'|'end'|'expire', callId: string, recipientId?: string) {
  required(callId);
  if (!['invite','accept','decline','end','expire'].includes(action)) throw Error('Invalid call action');
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.call.'+action,payload:{callId,recipientId:recipientId??null}},
   state => this.authorize(actor,'conversation.call',state),async state => {
    const calls = state!.calls;
    let call = calls.find((candidate:any) => candidate.id === callId);
    const now = this.now();
    if (action === 'invite') {
     if (call || calls.some((candidate:any) => ['ringing','accepted'].includes(candidate.status)) || calls.length >= this.limits.maxMessages) throw Error('Call conflict');
     if (!recipientId || recipientId === actor.id || !state!.members.includes(recipientId)) throw Error('Invalid recipient');
     call = {id:callId,callerId:actor.id,recipientId,status:'ringing',expiresAt:now+this.limits.ringMilliseconds};calls.push(call);
    } else {
     if (!call || ![call.callerId,call.recipientId].includes(actor.id)) throw Error('Not found');
     if (action === 'accept' || action === 'decline') {
      if (actor.id !== call.recipientId || call.status !== 'ringing' || now >= call.expiresAt) throw Error('Call conflict');
      call.status = action === 'accept' ? 'accepted' : 'declined';
     } else if (action === 'expire') {
      if (call.status !== 'ringing' || now < call.expiresAt) throw Error('Call conflict');
      call.status='missed';
     } else {
      if (!['ringing','accepted'].includes(call.status)) throw Error('Call conflict');
      call.status='ended';
     }
    }
    return {state:state!,event:'conversation.call.'+action};
   });
 }
 async signal(actor: Actor, id: string, key: string, expectedVersion: number, callId: string, signal: {type:string;description?:{type:string;sdp:string};candidate?:Record<string,unknown>}) {
  required(callId);
  if(!signal||!['offer','answer','candidate'].includes(signal.type)||new TextEncoder().encode(JSON.stringify(signal)).length>this.limits.maxSignalBytes)throw Error('Invalid signal');
  signal=structuredClone(signal);
  const keys=Object.keys(signal);
  if(signal.type==='candidate') {
   if(keys.some(key=>!['type','candidate'].includes(key))||!signal.candidate||typeof signal.candidate!=='object'||Array.isArray(signal.candidate)||typeof signal.candidate.candidate!=='string')throw Error('Invalid candidate');
  } else if(keys.some(key=>!['type','description'].includes(key))||signal.description?.type!==signal.type||typeof signal.description.sdp!=='string'||!signal.description.sdp)throw Error('Invalid description');
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.signal',payload:{callId,signal}},
   async state=>{await this.authorize(actor,'conversation.call',state);const call=state!.calls.find((candidate:any)=>candidate.id===callId);if(!call||![call.callerId,call.recipientId].includes(actor.id))throw Error('Not found');},
   async state=>{
    const call=state!.calls.find((candidate:any)=>candidate.id===callId);
    if(call.status!=='accepted')throw Error('Call not accepted');
    if(signal.type==='offer') {if(actor.id!==call.callerId||call.offered)throw Error('Invalid offer');call.offered=true;}
    if(signal.type==='answer') {if(actor.id!==call.recipientId||!call.offered||call.answered)throw Error('Invalid answer');call.answered=true;}
    call.signals??=[];if(call.signals.length>=this.limits.maxMessages)throw Error('Signal limit');
    call.signals.push({sequence:call.signals.length+1,actorId:actor.id,signal:structuredClone(signal)});
    return {state:state!,event:'conversation.signal'};
   });
 }
 async read(actor: Actor, id: string) {
  const state=await this.store.read(actor,id,candidate => this.authorize(actor,'conversation.read',candidate));
  state.calls=state.calls.map((call:any)=>[call.callerId,call.recipientId].includes(actor.id)?call:{...call,signals:[]});
  return state;
 }
}
