import {ScopedServiceBase,assertActor,required,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {VerifiedVoiceIdentity} from './voice-tasks.ts';
import type {VoiceCallVerifier} from './twilio-connect.ts';
export type CallAccount=Readonly<{actor:Actor;reference:string;directoryVersion:number;phone:string;contactVersion:number}>;
export type PhoneCallGrant=CallAccount&{callSid:string;state:'sending'|'pending'|'checking'|'verified'|'unknown';verificationSid:string|null;sessionId:string|null;expiresAt:number};
export interface PhoneCallGrantRepository {
 begin(row:PhoneCallGrant):Promise<void>;
 read(callSid:string):Promise<PhoneCallGrant|null>;
 sent(callSid:string,verificationSid:string):Promise<void>;
 claimCheck(callSid:string):Promise<boolean>;
 checked(callSid:string,approved:boolean,sessionId:string,expiresAt:number):Promise<void>;
 unknown(callSid:string):Promise<void>;
}
export type CallAuthorizationPorts={calls:VoiceCallVerifier;accounts:{resolve(reference:string):Promise<CallAccount|null>};provider(account:CallAccount):{start():Promise<{verificationSid:string;status:'pending'}>;check(sid:string,code:string):Promise<{approved:boolean}>}};
const sid=(prefix:string,value:unknown)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
const denied=()=>Error('Call authorization unavailable');
function accountSnapshot(value:CallAccount|null):CallAccount {
 if(!value)throw denied();assertActor(value.actor);
 if(!/^[1-9][0-9]{3}$/.test(value.reference)||!/^\+[1-9][0-9]{1,14}$/.test(value.phone)||![value.directoryVersion,value.contactVersion].every(v=>Number.isSafeInteger(v)&&v>0&&v<Number.MAX_SAFE_INTEGER))throw denied();
 return Object.freeze({actor:Object.freeze({id:value.actor.id,tenantId:value.actor.tenantId}),reference:value.reference,directoryVersion:value.directoryVersion,phone:value.phone,contactVersion:value.contactVersion});
}
function sameAccount(a:CallAccount,b:CallAccount){return a.actor.id===b.actor.id&&a.actor.tenantId===b.actor.tenantId&&a.reference===b.reference&&a.directoryVersion===b.directoryVersion&&a.phone===b.phone&&a.contactVersion===b.contactVersion;}
/** Shared call identity/policy base. A public extension selects a candidate
 * account only. Neither caller ID nor speech recognition proves its identity. */
export abstract class CallAuthorizationServiceBase extends ScopedServiceBase {
 readonly ports:CallAuthorizationPorts;readonly config:Readonly<{accountSid:string;sharedNumber:string}>;
 constructor(store:AtomicStore,policy:AccessPolicy,ports:CallAuthorizationPorts,config:{accountSid:string;sharedNumber:string}){
  super(store,policy);
  if(!sid('AC',config?.accountSid)||!/^\+[1-9][0-9]{1,14}$/.test(config?.sharedNumber)||typeof ports?.calls?.fetch!=='function'||typeof ports?.accounts?.resolve!=='function'||typeof ports?.provider!=='function')throw denied();
  this.ports=ports;this.config=Object.freeze({accountSid:config.accountSid,sharedNumber:config.sharedNumber});
 }
 protected async live(callSid:string){
  if(!sid('CA',callSid))throw denied();const call=await this.ports.calls.fetch(callSid);
  if(call?.sid!==callSid||call.accountSid!==this.config.accountSid||call.to!==this.config.sharedNumber||call.direction!=='inbound'||call.status!=='in-progress')throw denied();
 }
 protected async account(reference:string){
  if(typeof reference!=='string'||!/^[1-9][0-9]{3}$/.test(reference))throw denied();
  const account=accountSnapshot(await this.ports.accounts.resolve(reference));if(account.reference!==reference)throw denied();return account;
 }
 protected async authorize(account:CallAccount,callSid:string,action:string){
  await this.checkAccess(account.actor,action,{id:'phone-auth:'+callSid,tenantId:account.actor.tenantId,kind:'voice_auth',version:1,userId:account.actor.id},['voice_auth']);
 }
 abstract current(callSid:string):Promise<VerifiedVoiceIdentity|null>;
}
/** Phone-only OTP broker. start/check are private signed telephony operations,
 * never model tools. Codes and registered phone numbers never enter AI context.
 * A durable send claim and shared contact quota precede the no-retry Verify call.
 */
export class PhoneOtpCallAuthorizationService extends CallAuthorizationServiceBase {
 readonly repository:PhoneCallGrantRepository;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:PhoneCallGrantRepository,ports:CallAuthorizationPorts,config:CallAuthorizationServiceBase['config']){
  super(store,policy,ports,config);if(['begin','read','sent','claimCheck','checked','unknown'].some(k=>typeof repository?.[k as keyof PhoneCallGrantRepository]!=='function'))throw denied();this.repository=repository;
 }
 async start(callSid:string,accountReference:string){
  await this.live(callSid);const account=await this.account(accountReference);await this.authorize(account,callSid,'voice.otp.start');
  await this.repository.begin({...account,callSid,state:'sending',verificationSid:null,sessionId:null,expiresAt:Date.now()+120000});
  try{
   const bound=await this.bound(callSid,'sending','voice.otp.start');
   const result=await this.ports.provider(bound).start();if(!sid('VE',result?.verificationSid)||result.status!=='pending')throw denied();
   await this.bound(callSid,'sending','voice.otp.start');await this.repository.sent(callSid,result.verificationSid);
   return {verificationRequested:true};
  }catch{try{await this.repository.unknown(callSid);}catch{}throw denied();}
 }
 private async bound(callSid:string,state:PhoneCallGrant['state'],action:string){
  const found=await this.repository.read(callSid);if(!found)throw denied();const row=structuredClone(found);
  if(row.callSid!==callSid||row.state!==state||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())throw denied();
  const current=await this.account(row.reference);if(!sameAccount(row,current))throw denied();
  await this.live(callSid);await this.authorize(current,callSid,action);return Object.freeze({...row,actor:current.actor});
 }
 async check(callSid:string,code:string){
  if(typeof code!=='string'||!/^[0-9]{6}$/.test(code))throw denied();
  await this.bound(callSid,'pending','voice.otp.check');if(!await this.repository.claimCheck(callSid))throw denied();
  try{
   const row=await this.bound(callSid,'checking','voice.otp.check');if(!sid('VE',row.verificationSid))throw denied();
   const result=await this.ports.provider(row).check(row.verificationSid!,code);
   await this.bound(callSid,'checking','voice.otp.check');if(typeof result?.approved!=='boolean')throw denied();
   await this.repository.checked(callSid,result.approved,crypto.randomUUID(),Date.now()+300000);
   return {verified:result.approved};
  }catch{try{await this.repository.unknown(callSid);}catch{}throw denied();}
 }
 async current(callSid:string):Promise<VerifiedVoiceIdentity|null>{
  try{const row=await this.bound(callSid,'verified','voice.otp.use');required(row.sessionId);
   return Object.freeze({actor:row.actor,sessionId:row.sessionId!,authentication:'otp',active:true,expiresAt:row.expiresAt});
  }catch{return null;}
 }
}
