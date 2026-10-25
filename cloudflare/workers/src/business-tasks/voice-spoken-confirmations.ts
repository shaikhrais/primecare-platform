import type {AtomicStore,AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {VoiceTaskConfirmationServiceBase} from './voice-confirmations.ts';
import type {VoiceTaskRepository,VoiceTaskTrust,VerifiedVoiceIdentity} from './voice-tasks.ts';
export type SpokenConfirmation={callSid:string;challengeId:string;intentId:string;digest:string;sessionId:string;userId:string;tenantId:string;state:'prepared'|'approved'|'declined'|'consumed';method:'signed-speech'|'dtmf'|null;createdAt:number;expiresAt:number;approvedAt:number|null};
export interface SpokenConfirmationRepository {
 prepare(proof:SpokenConfirmation):Promise<void>;
 read(callSid:string):Promise<SpokenConfirmation|null>;
 decide(proof:SpokenConfirmation,method:'signed-speech'|'dtmf'|null):Promise<boolean>;
 consume(proof:SpokenConfirmation):Promise<boolean>;
}
const uuid=(v:unknown)=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(v);
/** Same current OTP/session/tenant/proposal/policy base as native app approval.
 * Only ordinary booking requests may use spoken confirmation in this release.
 * The host keeps prepare/accept outside the model tool namespace and delivers
 * the exact readback before opening a dedicated signed Gather callback. */
export class SpokenVoiceTaskConfirmationService extends VoiceTaskConfirmationServiceBase {
 readonly repository:SpokenConfirmationRepository;
 constructor(store:AtomicStore,policy:AccessPolicy,identities:{current(callSid:string):Promise<VerifiedVoiceIdentity|null>},intents:VoiceTaskRepository,repository:SpokenConfirmationRepository){
  super(store,policy,identities,intents);if(['prepare','read','decide','consume'].some(k=>typeof repository?.[k as keyof SpokenConfirmationRepository]!=='function'))throw Error('Spoken confirmation ports required');this.repository=repository;
 }
 private async bound(callSid:string,intentId:string){
  const identity=await this.current(callSid);if(!identity)throw Error('Confirmation unavailable');
  const row=await this.proposal(identity.actor,intentId);
  if(row.callSid!==callSid||row.sessionId!==identity.sessionId||row.taskId!=='appointment.booking.request')throw Error('Phone confirmation not allowed');return row;
 }
 async prepare(callSid:string,intentId:string){
  const row=await this.bound(callSid,intentId),createdAt=Date.now();
  const proof:SpokenConfirmation={callSid,challengeId:crypto.randomUUID(),intentId:row.id,digest:row.digest,sessionId:row.sessionId,userId:row.actor.id,tenantId:row.actor.tenantId,state:'prepared',method:null,createdAt,expiresAt:Math.min(row.expiresAt,createdAt+60000),approvedAt:null};
  if(proof.expiresAt<=createdAt)throw Error('Confirmation expired');await this.repository.prepare(proof);
  return Object.freeze({challengeId:proof.challengeId,summary:row.summary,expiresAt:proof.expiresAt});
 }
 private async proof(callSid:string,challengeId?:string){
  const found=await this.repository.read(callSid);if(!found)throw Error('Confirmation unavailable');const proof=structuredClone(found);
  if(proof.callSid!==callSid||!uuid(proof.challengeId)||challengeId!==undefined&&proof.challengeId!==challengeId||proof.expiresAt<=Date.now())throw Error('Confirmation unavailable');
  const row=await this.bound(callSid,proof.intentId);
  if(row.digest!==proof.digest||row.sessionId!==proof.sessionId||row.actor.id!==proof.userId||row.actor.tenantId!==proof.tenantId)throw Error('Proposal changed');return proof;
 }
 /** Private provider callback only. Speech is an explicit decision after OTP,
  * never biometric identification. Generic 'yes', negation and mixed speech/
  * digits fail closed. One callback consumes the challenge's decision attempt. */
 async accept(callSid:string,challengeId:string,input:{speech?:string;digits?:string}){
  if(!uuid(challengeId)||!input||Object.keys(input).some(k=>!['speech','digits'].includes(k))||input.speech!==undefined&&(typeof input.speech!=='string'||input.speech.length>100)||input.digits!==undefined&&(typeof input.digits!=='string'||input.digits.length>1))throw Error('Invalid confirmation');
  input={...input};const proof=await this.proof(callSid,challengeId);if(proof.state!=='prepared')throw Error('Confirmation already attempted');
  const speech=input.speech?.trim().toLowerCase().replace(/[.!?]$/,'');
  const method=input.digits===undefined&&speech==='confirm appointment'?'signed-speech' as const:input.speech===undefined&&input.digits==='1'?'dtmf' as const:null;
  if(!await this.repository.decide(proof,method))throw Error('Confirmation already attempted');return {approved:method!==null};
 }
 async consumeConfirmation(input:Parameters<VoiceTaskTrust['consumeConfirmation']>[0]){
  input=structuredClone(input);let proof:SpokenConfirmation;
  try{proof=await this.proof(input.callSid);}catch{return null;}
  if(proof.state!=='approved'||!['signed-speech','dtmf'].includes(proof.method!)||proof.intentId!==input.intentId||proof.digest!==input.digest||proof.sessionId!==input.sessionId||proof.userId!==input.actor.id||proof.tenantId!==input.actor.tenantId||!Number.isSafeInteger(proof.approvedAt)||proof.approvedAt! > Date.now()||proof.approvedAt! < Date.now()-60000)return null;
  if(!await this.repository.consume(proof))return null;
  return Object.freeze({approved:true,method:proof.method!,approvedAt:proof.approvedAt!});
 }
}
