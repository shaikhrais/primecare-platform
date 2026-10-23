import {ScopedServiceBase,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {twilioVoiceIdentity,type TwilioExtensionDirectory,type PublishedVoiceDestination} from '../../../../packages/shared/src/communications/twilio-voice.mjs';
export type VerifiedSdkCall={sid:string;accountSid:string;from:string;direction:string;status:string};
export interface VoiceCallVerifier {fetch(callSid:string):Promise<VerifiedSdkCall>}
const extension=(value:unknown):value is string=>typeof value==='string'&&/^[1-9][0-9]{5}$/.test(value);
/** Resolves provider-authenticated calls to current native identities, never browser
 * actor/tenant overrides. Internal and unmounted until voice.call.connect is registered.
 */
export class TwilioExtensionConnectService extends ScopedServiceBase {
 readonly voicemail?:{prepare(input:{callSid:string;destination:PublishedVoiceDestination}):Promise<void>};
 readonly directory:TwilioExtensionDirectory;readonly verifier:VoiceCallVerifier;readonly accountSid:string;
 constructor(store:AtomicStore,policy:AccessPolicy,directory:TwilioExtensionDirectory,verifier:VoiceCallVerifier,accountSid:string,voicemail?:TwilioExtensionConnectService['voicemail']){
  super(store,policy);
  if(typeof directory?.lookup!=='function'||typeof verifier?.fetch!=='function'||!/^AC[a-fA-F0-9]{32}$/.test(accountSid))throw Error('Voice connect ports required');
  this.directory=directory;this.verifier=verifier;this.accountSid=accountSid;this.voicemail=voicemail;
 }
 async #destination(value:string){
  const rows=await this.directory.lookup(value,2),row=rows[0];
  if(rows.length!==1||!row||row.extension!==value||row.active!==true||row.published!==true||row.tenantActive!==true||row.userActive!==true)throw Error('Voice unavailable');
  // Validate identifiers with the same function as token issuance, then snapshot.
  const snapshot=Object.freeze({...row});await twilioVoiceIdentity(snapshot);return snapshot;
 }
 async connect(input:{callSid:string;from:string;callerExtension:string;targetExtension:string}){
  try{
   // Copy provider input before suspending; no request-selected tenant or actor.
   const {callSid,from,callerExtension,targetExtension}=input;
   if(!/^CA[a-fA-F0-9]{32}$/.test(callSid)||typeof from!=='string'||!extension(callerExtension)||!extension(targetExtension)||callerExtension===targetExtension)throw Error('Voice unavailable');
   const verified=await this.verifier.fetch(callSid);
   if(!verified||verified.sid!==callSid||verified.accountSid!==this.accountSid||verified.from!==from||verified.direction!=='inbound'||!['queued','ringing','in-progress'].includes(verified.status))throw Error('Voice unavailable');
   const caller=await this.#destination(callerExtension),target=await this.#destination(targetExtension);
   if(from!=='client:'+await twilioVoiceIdentity(caller)||caller.tenantId!==target.tenantId||caller.userId===target.userId)throw Error('Voice unavailable');
   const actor=Object.freeze({id:caller.userId,tenantId:caller.tenantId});
   const authorize=async(row:PublishedVoiceDestination)=>{
    await this.checkAccess(actor,'voice.call.connect',{id:'voice:'+row.userId,tenantId:row.tenantId,kind:'voice_destination',version:1,userId:row.userId,extension:row.extension,published:true,active:true},['voice_destination']);
   };
   await authorize(target);
   const currentCaller=await this.#destination(callerExtension),currentTarget=await this.#destination(targetExtension);
   if(currentCaller.tenantId!==caller.tenantId||currentCaller.userId!==caller.userId||currentTarget.tenantId!==target.tenantId||currentTarget.userId!==target.userId)throw Error('Voice unavailable');
   await authorize(currentTarget);
   if(this.voicemail)await this.voicemail.prepare({callSid,destination:currentTarget});
   return Object.freeze({identity:await twilioVoiceIdentity(currentTarget)});
  }catch{throw Error('Voice unavailable');}
 }
}
