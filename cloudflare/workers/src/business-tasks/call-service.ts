import {required,type Actor,type AtomicStore,type AccessPolicy,type RecordState} from './store.ts';
import {ScopedServiceBase} from '../../../../packages/shared/src/communications/service-base.ts';
export type ConversationCallLimits={maxMembers:number;maxMessages:number;ringMilliseconds:number;maxSignalBytes:number};
/** Provider-neutral call state/signaling base. App-to-app calls require neither
 * Twilio, a telephone number, mail configuration nor picture storage. Current
 * native identity, scoped policy and durable store are always mandatory. */
export class ConversationCallServiceBase extends ScopedServiceBase {
 readonly limits:ConversationCallLimits;readonly now:()=>number;
 constructor(store:AtomicStore,policy:AccessPolicy,limits:ConversationCallLimits,now=Date.now){
  super(store,policy);
  for(const field of ['maxMembers','maxMessages','ringMilliseconds','maxSignalBytes'] as const)if(!limits||!Number.isSafeInteger(limits[field])||limits[field]<1)throw Error('Invalid configured limit');
  if(typeof now!=='function')throw Error('Invalid call clock');this.limits={...limits};this.now=now;
 }
 async inbox(actor:Actor,limit=50) {
  await this.policy.assert(actor,'conversation.inbox',null);
  const records=await this.store.inbox(actor,'conversation',state=>this.authorize(actor,'conversation.read',state),limit);
  return {items:records.map(state=>this.privateView(actor,state))};
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
      if(action==='accept')this.acceptedTransition(call,now);
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
 protected acceptedTransition(call:any,now:number){}
 async signal(actor: Actor, id: string, key: string, expectedVersion: number, callId: string, signal: {type:string;description?:{type:string;sdp:string};candidate?:Record<string,unknown>}) {
  return this.recordSignal(actor,id,key,expectedVersion,callId,signal,false);
 }
 protected async recordSignal(actor:Actor,id:string,key:string,expectedVersion:number,callId:string,signal:{type:string;description?:{type:string;sdp:string};candidate?:Record<string,unknown>},preparation:boolean){
  required(callId);
  if(!signal||!['offer','answer','ice'].includes(signal.type)||new TextEncoder().encode(JSON.stringify(signal)).length>this.limits.maxSignalBytes)throw Error('Invalid signal');
  signal=structuredClone(signal);
  const keys=Object.keys(signal);
  if(signal.type==='ice') {
   if(keys.some(key=>!['type','candidate'].includes(key))||!signal.candidate||typeof signal.candidate!=='object'||Array.isArray(signal.candidate)||typeof signal.candidate.candidate!=='string')throw Error('Invalid candidate');
  } else if(keys.some(key=>!['type','description'].includes(key))||signal.description?.type!==signal.type||typeof signal.description.sdp!=='string'||!signal.description.sdp)throw Error('Invalid description');
  return this.store.run({actor,id,key,expectedVersion,type:'conversation.signal',payload:{callId,signal}},
   async state=>{await this.authorize(actor,'conversation.call',state);const call=state!.calls.find((candidate:any)=>candidate.id===callId);if(!call||![call.callerId,call.recipientId].includes(actor.id))throw Error('Not found');},
   async state=>{
    const call=state!.calls.find((candidate:any)=>candidate.id===callId);
    if(call.status!=='accepted'&&!(preparation&&call.status==='ringing'&&this.now()<call.expiresAt))throw Error('Call not accepted');
    if(signal.type==='offer') {if(actor.id!==call.callerId||call.offered)throw Error('Invalid offer');call.offered=true;}
    if(signal.type==='answer') {if(actor.id!==call.recipientId||!call.offered||call.answered)throw Error('Invalid answer');call.answered=true;}
    call.signals??=[];if(call.signals.length>=this.limits.maxMessages)throw Error('Signal limit');
    call.signals.push({sequence:call.signals.length+1,actorId:actor.id,signal:structuredClone(signal)});
    return {state:state!,event:'conversation.signal'};
   });
 }
 async read(actor: Actor, id: string) {
  const state=await this.store.read(actor,id,candidate => this.authorize(actor,'conversation.read',candidate));
  return this.privateView(actor,state);
 }
 /** Apply the same call-party projection to every conversation read surface. */
 private privateView(actor:Actor,state:RecordState){
  const view=structuredClone(state);
  view.calls=view.calls.map((call:any)=>[call.callerId,call.recipientId].includes(actor.id)?call:{...call,signals:[]});
  return view;
 }
}
