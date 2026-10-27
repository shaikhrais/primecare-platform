import {ScopedServiceBase,type Actor,type AtomicStore,type AccessPolicy,assertActor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {SpokenCandidate} from './vapi-spoken-verification.ts';
import {voiceTaskIntentDigest,type VoiceTaskRepository,type VoiceTaskIntent,type VerifiedVoiceIdentity} from './voice-tasks.ts';
export type CallPossessionProof={id:string;verifiedAt:number;expiresAt:number};
export type VerifiedCallSubject={actor:Actor;callId:string;callSid:string;proofId:string;authentication:'otp';verifiedAt:number;expiresAt:number;nativeSession:false;businessActionApproved:false};
export type CallIdentityPorts={
 /** Canonical provider reads plus current unique enrolled contact, never model JSON. */
 current(callId:string):Promise<SpokenCandidate|null>;
 /** Private durable repository only. Must match the complete candidate exactly. */
 proof(candidate:SpokenCandidate):Promise<CallPossessionProof|null>;
};
const uuid=(s:unknown):s is string=>typeof s==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(s);
const same=(a:SpokenCandidate,b:SpokenCandidate)=>a.callId===b.callId&&a.callSid===b.callSid&&a.phone===b.phone&&a.version===b.version&&a.actor.id===b.actor.id&&a.actor.tenantId===b.actor.tenantId;
function candidateSnapshot(value:SpokenCandidate|null,callId:string):SpokenCandidate{
 if(!value||value.callId!==callId||!/^CA[a-f0-9]{32}$/i.test(value.callSid)||!/^\+[1-9][0-9]{6,14}$/.test(value.phone)||!Number.isSafeInteger(value.version)||value.version<1)throw Error('Verified call unavailable');
 assertActor(value.actor);return {actor:{id:value.actor.id,tenantId:value.actor.tenantId},callId,callSid:value.callSid,phone:value.phone,version:value.version};
}
function validProof(p:CallPossessionProof|null):p is CallPossessionProof{return !!p&&uuid(p.id)&&Number.isSafeInteger(p.verifiedAt)&&Number.isSafeInteger(p.expiresAt)&&p.verifiedAt<=Date.now()&&p.expiresAt>Date.now()&&p.expiresAt>p.verifiedAt&&p.expiresAt-p.verifiedAt<=120000;}
type ProofNamespace={idFromName(name:string):object;get(id:object):{possession(candidate:SpokenCandidate):Promise<CallPossessionProof|null>}};
/** Private storage port. Its namespace binding is server-owned and its key is
 * identical to the verification writer; callers never supply a URL or object ID. */
export class DurableVapiCallProofRepository {
 readonly namespace:ProofNamespace;
 constructor(namespace:unknown){const n=namespace as ProofNamespace;if(typeof n?.idFromName!=='function'||typeof n?.get!=='function')throw Error('Private verification namespace required');this.namespace=n;}
 async read(candidate:SpokenCandidate):Promise<CallPossessionProof|null>{
  const bound=candidateSnapshot(candidate,candidate.callId);
  const bytes=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(bound.phone));
  const key=Array.from(new Uint8Array(bytes),x=>x.toString(16).padStart(2,'0')).join('');
  const result=await this.namespace.get(this.namespace.idFromName(key)).possession(bound);
  return validProof(result)?{id:result.id,verifiedAt:result.verifiedAt,expiresAt:result.expiresAt}:null;
 }
}
/** Server-only bridge from current-call SMS possession to a scoped subject.
 * Does not create auth_sessions, role grants, approvals or task permission.
 * Every consumer must enforce its own current business policy and confirmation.
 */
export class VapiVerifiedCallIdentityService extends ScopedServiceBase {
 readonly ports:CallIdentityPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,ports:CallIdentityPorts){super(store,policy);if(typeof ports?.current!=='function'||typeof ports?.proof!=='function')throw Error('Call identity ports required');this.ports=ports;}
 async current(callId:string):Promise<VerifiedCallSubject|null>{
  try{
   if(!uuid(callId))return null;
   const candidate=candidateSnapshot(await this.ports.current(callId),callId);
   const authorize=()=>this.checkAccess(candidate.actor,'voice.sms.spoken.verify',{id:'voice-call:'+callId,tenantId:candidate.actor.tenantId,ownerId:candidate.actor.id,kind:'voice_auth',version:1},['voice_auth']);
   await authorize();const proof=await this.ports.proof(structuredClone(candidate));if(!validProof(proof))return null;const snapshot={...proof};
   const latest=candidateSnapshot(await this.ports.current(callId),callId);if(!same(candidate,latest))return null;
   await authorize();const last=await this.ports.proof(structuredClone(latest));if(!validProof(last)||last.id!==snapshot.id||last.verifiedAt!==snapshot.verifiedAt||last.expiresAt!==snapshot.expiresAt)return null;
   return Object.freeze({actor:Object.freeze({...candidate.actor}),callId,callSid:candidate.callSid,proofId:snapshot.id,authentication:'otp',verifiedAt:snapshot.verifiedAt,expiresAt:snapshot.expiresAt,nativeSession:false,businessActionApproved:false});
  }catch{return null;}
 }
}
/** Task-core compatibility port. The call ID comes from the canonical provider
 * host, never task arguments. The opaque proof reference is an authentication
 * event binding, not an auth_sessions token. This port provides no approval. */
export class VapiCallTaskIdentityBroker {
 readonly identities:VapiVerifiedCallIdentityService;readonly callId:string;
 constructor(identities:VapiVerifiedCallIdentityService,callId:string){if(!(identities instanceof VapiVerifiedCallIdentityService)||!uuid(callId))throw Error('Canonical call binding required');this.identities=identities;this.callId=callId;}
 async current(callSid:string):Promise<VerifiedVoiceIdentity|null>{
  if(typeof callSid!=='string'||!/^CA[a-f0-9]{32}$/i.test(callSid))return null;
  const subject=await this.identities.current(this.callId);if(!subject||subject.callSid!==callSid)return null;
  return {actor:subject.actor,sessionId:vapiTaskProofBinding(subject.callId,subject.proofId),authentication:'otp',active:true,expiresAt:subject.expiresAt};
 }
}

/** Opaque authentication-event reference, compatible with app confirmation
 * bounds. Includes the canonical provider call so a stored owner intent can
 * resolve its original proof; it never represents a native auth session. */
export function vapiTaskProofBinding(callId:string,proofId:string):string{
 if(!uuid(callId)||!uuid(proofId))throw Error('Canonical proof binding required');
 return 'vapi_'+callId+'_'+proofId;
}
function binding(value:unknown){
 if(typeof value!=='string')return null;
 const match=/^vapi_([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})_([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$/i.exec(value);
 return match?{callId:match[1],proofId:match[2]}:null;
}
/** Native app lookup for one owner-selected stored callback intent. Only the
 * host-supplied authenticated actor and repository may choose the call binding.
 * No phone, provider call ID or proof may be supplied by the app/model body. */
export class VapiAppTaskIdentityBroker {
 readonly identities:VapiVerifiedCallIdentityService;readonly intents:VoiceTaskRepository;
 readonly actor:Readonly<Actor>;readonly intentId:string;
 constructor(identities:VapiVerifiedCallIdentityService,intents:VoiceTaskRepository,actor:Actor,intentId:string){
  assertActor(actor);
  if(!(identities instanceof VapiVerifiedCallIdentityService)||typeof intents?.read!=='function'||!uuid(intentId))throw Error('Owned callback intent required');
  this.identities=identities;this.intents=intents;this.actor=Object.freeze({...actor});this.intentId=intentId;
 }
 private async proposal(callSid:string):Promise<VoiceTaskIntent|null>{
  const found=await this.intents.read(this.intentId);if(!found)return null;const row=structuredClone(found);
  if(row.id!==this.intentId||row.callSid!==callSid||row.status!=='proposed'||row.taskId!=='reception.callback.request'||row.taskVersion!==1||row.actor?.id!==this.actor.id||row.actor?.tenantId!==this.actor.tenantId||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now()||await voiceTaskIntentDigest(row)!==row.digest)return null;
  return row;
 }
 async current(callSid:string):Promise<VerifiedVoiceIdentity|null>{
  try{
   if(typeof callSid!=='string'||!/^CA[a-f0-9]{32}$/i.test(callSid))return null;
   const row=await this.proposal(callSid),ref=binding(row?.sessionId);if(!row||!ref)return null;
   const resolve=async()=>{
    const subject=await this.identities.current(ref.callId);
    if(!subject||subject.actor.id!==this.actor.id||subject.actor.tenantId!==this.actor.tenantId||subject.callSid!==callSid||subject.proofId!==ref.proofId||vapiTaskProofBinding(subject.callId,subject.proofId)!==row.sessionId)return null;
    return subject;
   };
   const subject=await resolve();if(!subject)return null;
   const latest=await this.proposal(callSid);if(!latest||latest.digest!==row.digest||latest.sessionId!==row.sessionId)return null;
   const current=await resolve();if(!current||current.expiresAt!==subject.expiresAt||current.verifiedAt!==subject.verifiedAt)return null;
   return Object.freeze({actor:this.actor,sessionId:row.sessionId,authentication:'otp',active:true,expiresAt:Math.min(row.expiresAt,current.expiresAt)});
  }catch{return null;}
 }
}
