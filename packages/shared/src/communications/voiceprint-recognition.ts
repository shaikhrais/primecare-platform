import {ScopedServiceBase,CommunicationChannelBase,assertActor,type Actor,type AtomicStore,type AccessPolicy,type RecordState} from './service-base.ts';
import type {VoiceprintProviderBase} from './voiceprint-provider.mjs';
export type VoiceprintPorts={
 /** Current independent OTP/passkey/native proof for enrollment and revocation;
  * never implement with the biometric result or a client identity claim. */
 authority:{assertFresh(actor:Actor):Promise<void>};
 /** Canonical live call and uniquely selected account, not authenticated by CLI. */
 calls:{assertCandidate(callSid:string,actor:Actor):Promise<void>};
 /** Host resolves signed provider recording, checks call binding/expiry and
  * durably consumes capture once. No model URL or arbitrary audio upload. */
 captures:{take(captureId:string,callSid:string,attemptId:string):Promise<{id:string;callSid:string;capturedAt:number;bytes:Uint8Array}>};
 provider:Pick<VoiceprintProviderBase,'enroll'|'verify'|'remove'>;
};
const uuid=(value:unknown)=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(value);
const fail=()=>Error('Voiceprint recognition unavailable');
function owner(actor:Actor):Actor{assertActor(actor);return Object.freeze({id:actor.id,tenantId:actor.tenantId});}
/** Provider-neutral, scoped biometric lifecycle used by Vapi/Twilio hosts.
 * Only opaque provider handles/receipts are durable here, never audio or vectors.
 * Recognition evidence does not mint a task authorization or approve a booking.
 */
export class VoiceprintRecognitionService extends ScopedServiceBase {
 readonly ports:VoiceprintPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,ports:VoiceprintPorts){
  super(store,policy);if([ports?.authority?.assertFresh,ports?.calls?.assertCandidate,ports?.captures?.take,ports?.provider?.enroll,ports?.provider?.verify,ports?.provider?.remove].some(fn=>typeof fn!=='function'))throw fail();this.ports=ports;
 }
 private async access(actor:Actor,action:string,state:RecordState|null,kinds:string[]){
  if(state?.ownerId!==actor.id)throw fail();await this.checkAccess(actor,action,structuredClone(state),kinds);
 }
 private async profile(actor:Actor,id:string,action:string){
  if(!uuid(id))throw fail();return this.store.read(actor,id,async state=>{await this.access(actor,action,state,['voiceprint_profile']);if(state.status!=='ready')throw fail();});
 }
 private async live(actor:Actor,callSid:string){if(typeof callSid!=='string'||!/^CA[a-fA-F0-9]{32}$/.test(callSid))throw fail();await this.ports.calls.assertCandidate(callSid,actor);}
 private async capture(captureId:string,callSid:string,attemptId:string){
  if(!uuid(captureId))throw fail();const capture=await this.ports.captures.take(captureId,callSid,attemptId);
  if(capture?.id!==captureId||capture.callSid!==callSid||!Number.isSafeInteger(capture.capturedAt)||capture.capturedAt>Date.now()||capture.capturedAt<Date.now()-60000||!(capture.bytes instanceof Uint8Array)||capture.bytes.length<44||capture.bytes.length>1920044)throw fail();return capture.bytes.slice();
 }
 private async fresh(actor:Actor){await this.ports.authority.assertFresh(actor);}
 async enroll(actor:Actor,callSid:string,id:string,captureId:string,consent:true){
  actor=owner(actor);if(!uuid(id)||!uuid(captureId)||consent!==true)throw fail();await this.fresh(actor);await this.live(actor,callSid);
  const claim=crypto.randomUUID(),draft={id,tenantId:actor.tenantId,version:0,kind:'voiceprint_profile',ownerId:actor.id,provider:'aculab',subject:'pc-'+id,consentVersion:'voiceprint-v1',status:'enrolling',receipt:null,deletion:'not_requested'};
  const result=await this.store.run({actor,id,key:'enroll',expectedVersion:0,type:'voiceprint.enroll',payload:{callSid,captureId,consent:true}},
   async state=>{await this.fresh(actor);if(state)await this.access(actor,'voiceprint.enroll',state,['voiceprint_profile']);else await this.checkAccess(actor,'voiceprint.enroll',structuredClone(draft),['voiceprint_profile']);},
   async state=>{if(state)throw fail();return {state:draft,event:'voiceprint.enrollment_claimed',result:{claim}};});
  if(result.claim!==claim)throw Error('Voiceprint enrollment already attempted');
  const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),15000);let receipt:string|null=null;
  try{
   const audio=await this.capture(captureId,callSid,id);await this.fresh(actor);await this.live(actor,callSid);
   const response=await this.ports.provider.enroll({subject:draft.subject,audio,signal:controller.signal});
   if(controller.signal.aborted||response?.enrolled!==true||typeof response.receipt!=='string'||!response.receipt||response.receipt.length>160)throw fail();
   await this.fresh(actor);await this.live(actor,callSid);receipt=response.receipt;
  }catch{}finally{clearTimeout(timer);controller.abort();}
  await this.store.run({actor,id,key:'enroll-result',expectedVersion:1,type:'voiceprint.enroll_result',payload:{receipt}},state=>this.access(actor,'voiceprint.enroll',state,['voiceprint_profile']),async state=>{
   if(state!.status!=='enrolling')throw fail();state!.status=receipt?'ready':'unknown';state!.receipt=receipt;return {state:state!,event:receipt?'voiceprint.enrolled':'voiceprint.enrollment_unknown'};
  });
  if(!receipt)throw fail();return {id,version:2,enrolled:true};
 }
 async verify(actor:Actor,callSid:string,profileId:string,attemptId:string,captureId:string){
  actor=owner(actor);if(!uuid(attemptId)||!uuid(captureId)||attemptId===profileId)throw fail();await this.live(actor,callSid);
  const profile=structuredClone(await this.profile(actor,profileId,'voiceprint.verify')),claim=crypto.randomUUID();
  const draft={id:attemptId,tenantId:actor.tenantId,version:0,kind:'voiceprint_attempt',ownerId:actor.id,profileId,profileVersion:profile.version,callSid,captureId,status:'checking',matched:false,expiresAt:0};
  const result=await this.store.run({actor,id:attemptId,key:'verify',expectedVersion:0,type:'voiceprint.verify',payload:{profileId,profileVersion:profile.version,callSid,captureId}},
   async state=>{if(state)await this.access(actor,'voiceprint.verify',state,['voiceprint_attempt']);else await this.checkAccess(actor,'voiceprint.verify',structuredClone(draft),['voiceprint_attempt']);},
   async state=>{if(state)throw fail();return {state:draft,event:'voiceprint.verification_claimed',result:{claim}};});
  if(result.claim!==claim)throw Error('Voiceprint verification already attempted');
  const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),15000);let matched=false,status='unknown';
  try{
   const audio=await this.capture(captureId,callSid,attemptId);
   if((await this.profile(actor,profileId,'voiceprint.verify')).version!==profile.version)throw fail();await this.live(actor,callSid);
   const response=await this.ports.provider.verify({subject:profile.subject,audio,signal:controller.signal});
   if(controller.signal.aborted||typeof response?.matched!=='boolean'||typeof response.spoofed!=='boolean')throw fail();
   if((await this.profile(actor,profileId,'voiceprint.verify')).version!==profile.version)throw fail();await this.live(actor,callSid);
   matched=response.matched===true&&response.spoofed===false;status=matched?'matched':'rejected';
  }catch{}finally{clearTimeout(timer);controller.abort();}
  await this.store.run({actor,id:attemptId,key:'verify-result',expectedVersion:1,type:'voiceprint.verify_result',payload:{matched,status}},state=>this.access(actor,'voiceprint.verify',state,['voiceprint_attempt']),async state=>{
   if(state!.status!=='checking')throw fail();Object.assign(state!,{status,matched,expiresAt:matched?Date.now()+30000:0});return {state:state!,event:'voiceprint.verification_'+status};
  });
  // Recheck immediately before releasing recognition evidence after result I/O.
  if((await this.profile(actor,profileId,'voiceprint.verify')).version!==profile.version)throw fail();await this.live(actor,callSid);
  return {attemptId,matched,requiresAuthorization:true};
 }
 async revoke(actor:Actor,id:string,version:number){
  actor=owner(actor);if(!uuid(id)||!Number.isSafeInteger(version)||version<1)throw fail();await this.fresh(actor);
  const state=await this.store.read(actor,id,s=>this.access(actor,'voiceprint.revoke',s,['voiceprint_profile'])),subject=state.subject;
  const claim=crypto.randomUUID();const result=await this.store.run({actor,id,key:'revoke:'+version,expectedVersion:version,type:'voiceprint.revoke',payload:{}},async s=>{await this.fresh(actor);await this.access(actor,'voiceprint.revoke',s,['voiceprint_profile']);},async s=>{s!.status='revoked';s!.deletion='pending';return {state:s!,event:'voiceprint.revoked',result:{claim}};});
  if(result.claim!==claim)throw Error('Voiceprint revocation already attempted');
  const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),15000);let deleted=false;
  try{const response=await this.ports.provider.remove({subject,signal:controller.signal});deleted=!controller.signal.aborted&&response?.deleted===true;}catch{}finally{clearTimeout(timer);controller.abort();}
  await this.store.run({actor,id,key:'revoke-result:'+version,expectedVersion:version+1,type:'voiceprint.revoke_result',payload:{deleted}},s=>this.access(actor,'voiceprint.revoke',s,['voiceprint_profile']),async s=>{if(s!.status!=='revoked')throw fail();s!.deletion=deleted?'confirmed':'unknown';return {state:s!,event:'voiceprint.deletion_'+s!.deletion};});
  return {revoked:true,providerDeletionConfirmed:deleted};
 }
}
export type VoiceprintRequest={action:'enroll';id:string;captureId:string;consent:true}|{action:'verify';id:string;profileId:string;captureId:string}|{action:'revoke';id:string;version:number};
/** Request-scoped provider-neutral channel. Its call/actor come from canonical
 * server context; Vapi/Twilio do not implement separate recognition rules. */
export class VoiceprintRecognitionChannel extends CommunicationChannelBase<VoiceprintRequest,unknown> {
 readonly channel='audio' as const;readonly service:VoiceprintRecognitionService;readonly actor:Actor;readonly callSid:string;
 constructor(service:VoiceprintRecognitionService,context:{actor:Actor;callSid:string}){super();this.service=service;this.actor=owner(context.actor);if(!/^CA[a-fA-F0-9]{32}$/.test(context.callSid))throw fail();this.callSid=context.callSid;}
 protected async perform(actor:Actor,input:VoiceprintRequest){
  if(actor.id!==this.actor.id||actor.tenantId!==this.actor.tenantId)throw fail();const keys=Object.keys(input).sort().join(',');
  if(input.action==='enroll'&&keys==='action,captureId,consent,id')return this.service.enroll(actor,this.callSid,input.id,input.captureId,input.consent);
  if(input.action==='verify'&&keys==='action,captureId,id,profileId')return this.service.verify(actor,this.callSid,input.profileId,input.id,input.captureId);
  if(input.action==='revoke'&&keys==='action,id,version')return this.service.revoke(actor,input.id,input.version);throw fail();
 }
}
