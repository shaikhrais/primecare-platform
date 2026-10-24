import {ScopedServiceBase,type Actor,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
export type ContactEnrollmentRow={id:string;userId:string;tenantId:string;sessionHash:string;requestId:string;phone:string;state:string;verificationSid:string|null;expiresAt:number};
export interface ContactEnrollmentRepository{
 status(actor:Actor):Promise<{exists:boolean;verified:boolean}>;
 claim(input:{actor:Actor;sessionHash:string;requestId:string;phone:string;expiresAt:number}):Promise<{row:ContactEnrollmentRow;created:boolean}>;
 sent(actor:Actor,id:string,verificationSid:string):Promise<void>;
 read(actor:Actor,id:string):Promise<ContactEnrollmentRow|null>;
 claimCheck(actor:Actor,id:string,sessionHash:string):Promise<boolean>;
 finish(actor:Actor,id:string,sessionHash:string,approved:boolean):Promise<void>;
 unknown(actor:Actor,id:string):Promise<void>;
}
export type ContactEnrollmentSession={id:string;userId:string;tenantId:string;active:boolean;createdAt:number;expiresAt:number};
export type ContactEnrollmentPorts={sessions:{currentSession(hash:string):Promise<ContactEnrollmentSession|null>};provider(phone:string):{start():Promise<{verificationSid:string;status:'pending'}>;check(sid:string,code:string):Promise<{approved:boolean}>}};
const uuid=(v:unknown)=>typeof v==='string'&&v.length===36&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(v);
const phone=(v:unknown)=>typeof v==='string'&&v===v.trim()&&v.length<=16&&/^\+[1-9][0-9]{6,14}$/.test(v);
type EnrollmentSessionSnapshot={actor:Actor;expiresAt:number;createdAt:number};
const denied=()=>Error('Contact enrollment unavailable');
/** First-time only, native app service. Existing/revoked records are preserved.
 * No actor, phone verification flag or session handle is taken from model input.
 * The host must supply registered native endpoint policy and CSRF transport.
 * Neither SMS send nor approved provider status by itself grants voice identity.
 */
export class VoiceContactEnrollmentService extends ScopedServiceBase{
 readonly repository:ContactEnrollmentRepository;readonly ports:ContactEnrollmentPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:ContactEnrollmentRepository,ports:ContactEnrollmentPorts){
  super(store,policy);if(['status','claim','sent','read','claimCheck','finish','unknown'].some(key=>typeof (repository as any)?.[key]!=='function')||typeof ports?.sessions?.currentSession!=='function'||typeof ports?.provider!=='function')throw Error('Native contact enrollment ports required');this.repository=repository;this.ports=ports;
 }
 async #session(hash:string,fresh:boolean):Promise<EnrollmentSessionSnapshot>{
  if(typeof hash!=='string'||hash.length!==64||!/^[a-f0-9]{64}$/.test(hash))throw denied();
  const row=await this.ports.sessions.currentSession(hash);
  if(!row||row.id!==hash||row.active!==true||typeof row.userId!=='string'||!row.userId||typeof row.tenantId!=='string'||!row.tenantId||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now()||!Number.isSafeInteger(row.createdAt)||row.createdAt>Date.now()||fresh&&row.createdAt<Date.now()-300000)throw denied();
  return Object.freeze({actor:Object.freeze({id:row.userId,tenantId:row.tenantId}),expiresAt:row.expiresAt,createdAt:row.createdAt});
 }
 async #authorized(actor:Actor,action:string){await this.checkAccess(actor,action,{id:'voice-contact:'+actor.id,tenantId:actor.tenantId,ownerId:actor.id,kind:'voice_contact',version:1},['voice_contact']);}
 async #same(hash:string,expected:EnrollmentSessionSnapshot){const current=await this.#session(hash,true);if(current.actor.id!==expected.actor.id||current.actor.tenantId!==expected.actor.tenantId)throw denied();return current;}
 async status(hash:string){
  const session=await this.#session(hash,false);await this.#authorized(session.actor,'voice.contact.status');const result=await this.repository.status(session.actor);
  if(typeof result?.exists!=='boolean'||typeof result?.verified!=='boolean'||result.verified&&!result.exists)throw denied();
  const latest=await this.#session(hash,false);if(latest.actor.id!==session.actor.id||latest.actor.tenantId!==session.actor.tenantId)throw denied();await this.#authorized(latest.actor,'voice.contact.status');
  return {verified:result.verified,enrollmentAllowed:!result.exists};
 }
 async start(hash:string,number:string,requestId:string){
  if(!phone(number)||!uuid(requestId))throw denied();requestId=requestId.toLowerCase();const session=await this.#session(hash,true);await this.#authorized(session.actor,'voice.contact.start');
  if((await this.repository.status(session.actor)).exists)throw denied();await this.#same(hash,session);
  const claimed=await this.repository.claim({actor:session.actor,sessionHash:hash,requestId,phone:number,expiresAt:Math.min(session.expiresAt,Date.now()+120000)}),row=Object.freeze({...claimed.row});
  if(!row||!uuid(row.id)||row.userId!==session.actor.id||row.tenantId!==session.actor.tenantId||row.sessionHash!==hash||row.requestId!==requestId||row.phone!==number||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now()||row.expiresAt>Date.now()+120000||typeof claimed.created!=='boolean')throw denied();
  if(!claimed.created){if(row.state!=='pending')throw denied();return {challengeId:row.id,verificationRequested:true as const,expiresAt:row.expiresAt};}
  try{
   if(row.state!=='sending')throw denied();await this.#same(hash,session);await this.#authorized(session.actor,'voice.contact.start');
   const receipt=await this.ports.provider(number).start();if(!/^VE[a-f0-9]{32}$/i.test(receipt?.verificationSid)||receipt.status!=='pending')throw denied();
   await this.repository.sent(session.actor,row.id,receipt.verificationSid);await this.#same(hash,session);await this.#authorized(session.actor,'voice.contact.start');
   return {challengeId:row.id,verificationRequested:true as const,expiresAt:row.expiresAt};
  }catch{try{await this.repository.unknown(session.actor,row.id);}catch{}throw Error('Verification send outcome unknown; do not resend automatically');}
 }
 async #bound(hash:string,id:string,state:string){
  const session=await this.#session(hash,true);await this.#authorized(session.actor,'voice.contact.check');const stored=await this.repository.read(session.actor,id),row=stored?Object.freeze({...stored}):null;
  if(!row||row.id!==id||row.userId!==session.actor.id||row.tenantId!==session.actor.tenantId||row.sessionHash!==hash||row.state!==state||!phone(row.phone)||typeof row.verificationSid!=='string'||!/^VE[a-f0-9]{32}$/i.test(row.verificationSid)||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())throw denied();
  if((await this.repository.status(session.actor)).exists)throw denied();await this.#same(hash,session);return {session,row:Object.freeze({...row})};
 }
 async check(hash:string,id:string,code:string){
  if(!uuid(id)||typeof code!=='string'||code.length!==6||!/^\d{6}$/.test(code))throw denied();id=id.toLowerCase();const initial=await this.#bound(hash,id,'pending');
  if(!await this.repository.claimCheck(initial.session.actor,id,hash))throw denied();
  try{
   await this.#bound(hash,id,'checking');const receipt=await this.ports.provider(initial.row.phone).check(initial.row.verificationSid!,code);
   const latest=await this.#bound(hash,id,'checking');if(typeof receipt?.approved!=='boolean')throw denied();
   await this.repository.finish(latest.session.actor,id,hash,receipt.approved);return {verified:receipt.approved};
  }catch{try{await this.repository.unknown(initial.session.actor,id);}catch{}throw Error('Contact verification outcome unavailable; check status in the app');}
 }
}
