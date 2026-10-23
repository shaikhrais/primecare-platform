import {ScopedServiceBase,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {PublishedVoiceDestination,TwilioExtensionDirectory} from '../../../../packages/shared/src/communications/twilio-voice.mjs';
export type VoicemailRoute={accountSid:string;callSid:string;extension:string;tenantId:string;userId:string};
export interface VoicemailRepository {
 find(accountSid:string,recordingSid:string):Promise<VoicemailRoute|null>;
 reserve(route:VoicemailRoute):Promise<void>;
 read(accountSid:string,callSid:string):Promise<VoicemailRoute|null>;
 recording(route:VoicemailRoute,recordingSid:string,duration:number):Promise<void>;
 notified(route:VoicemailRoute,recordingSid:string):Promise<void>;
}
export interface VoicemailPorts {
 directory:TwilioExtensionDirectory;
 recordings:{fetch(sid:string):Promise<{sid:string;accountSid:string;callSid:string;status:string;source:string;duration:number}>};
 mailboxes:{recipient(owner:Actor):Promise<{email:string;verified:boolean;active:boolean}>};
 notifications:{enqueue(input:{actor:Actor;key:string;to:string;subject:string;text:string}):Promise<void>};
}
/** Provider service inherits current tenant/policy boundaries. No raw recording
 * URLs, recipients or tenant fields from webhook forms become trusted input.
 */
export class VoicemailService extends ScopedServiceBase {
 readonly repository:VoicemailRepository;readonly ports:VoicemailPorts;readonly config:{accountSid:string;providerPrincipal:string;playbackBaseUrl:string};
 constructor(store:AtomicStore,policy:AccessPolicy,repository:VoicemailRepository,ports:VoicemailPorts,config:{accountSid:string;providerPrincipal:string;playbackBaseUrl:string}){
  super(store,policy);this.repository=repository;this.ports=ports;this.config=Object.freeze({...config});
  const url=new URL(config.playbackBaseUrl);
  if(!/^AC[a-fA-F0-9]{32}$/.test(config.accountSid)||!config.providerPrincipal||url.protocol!=='https:'||url.username||url.password||url.search||url.hash||!url.pathname.endsWith('/')||['reserve','read','recording','notified','find'].some(key=>typeof (repository as any)?.[key]!=='function')||typeof ports?.directory?.lookup!=='function'||typeof ports?.recordings?.fetch!=='function'||typeof ports?.mailboxes?.recipient!=='function'||typeof ports?.notifications?.enqueue!=='function')throw Error('Voicemail ports required');
 }
 async #current(route:VoicemailRoute,action:string){
  const rows=await this.ports.directory.lookup(route.extension,2),row=rows[0];
  if(rows.length!==1||!row||row.extension!==route.extension||row.tenantId!==route.tenantId||row.userId!==route.userId||row.active!==true||row.published!==true||row.tenantActive!==true||row.userActive!==true)throw Error('Voicemail unavailable');
  const actor=Object.freeze({id:this.config.providerPrincipal,tenantId:route.tenantId});
  await this.checkAccess(actor,action,{id:'voicemail:'+route.callSid,tenantId:route.tenantId,kind:'voicemail',version:1,userId:route.userId,extension:route.extension},['voicemail']);
  return actor;
 }
 async prepare(input:{callSid:string;destination:PublishedVoiceDestination}){
  if(!/^CA[a-fA-F0-9]{32}$/.test(input.callSid))throw Error('Voicemail unavailable');
  const d=input.destination,route=Object.freeze({accountSid:this.config.accountSid,callSid:input.callSid,extension:d.extension,tenantId:d.tenantId,userId:d.userId});
  await this.#current(route,'voice.voicemail.capture');await this.repository.reserve(route);
 }
 async fallback(callSid:string,status:string){
  if(!['busy','no-answer','failed'].includes(status))return false;
  const route=await this.repository.read(this.config.accountSid,callSid);if(!route)return false;
  await this.#current(route,'voice.voicemail.capture');return true;
 }
 async read(actor:Actor,recordingSid:string){
  actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  if(!/^RE[a-fA-F0-9]{32}$/.test(recordingSid))throw Error('Voicemail unavailable');
  const route=await this.repository.find(this.config.accountSid,recordingSid);
  if(!route||route.tenantId!==actor.tenantId||route.userId!==actor.id)throw Error('Voicemail unavailable');
  await this.checkAccess(actor,'voice.voicemail.read',{id:'voicemail:'+route.callSid,tenantId:route.tenantId,kind:'voicemail',version:1,userId:route.userId},['voicemail']);
  return Object.freeze({recordingSid,callSid:route.callSid,extension:route.extension});
 }
 async audio(actor:Actor,recordingSid:string,adapter:{download(sid:string):Promise<{bytes:Uint8Array;contentType:string}>}){
  actor=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  await this.read(actor,recordingSid);
  const result=await adapter.download(recordingSid);
  await this.read(actor,recordingSid);
  return result;
 }
 async completed(input:{callSid:string;recordingSid:string;duration:number}){
  const {callSid,recordingSid,duration}=input;
  if(!/^CA[a-fA-F0-9]{32}$/.test(callSid)||!/^RE[a-fA-F0-9]{32}$/.test(recordingSid)||!Number.isSafeInteger(duration)||duration<1||duration>120)throw Error('Voicemail unavailable');
  const route=await this.repository.read(this.config.accountSid,callSid);if(!route)throw Error('Voicemail unavailable');
  await this.#current(route,'voice.voicemail.notify');
  const recording=await this.ports.recordings.fetch(recordingSid);
  if(!recording||recording.sid!==recordingSid||recording.accountSid!==this.config.accountSid||recording.callSid!==callSid||recording.status!=='completed'||recording.source!=='RecordVerb'||recording.duration!==duration)throw Error('Voicemail unavailable');
  await this.repository.recording(route,recordingSid,duration);
  const actor=await this.#current(route,'voice.voicemail.notify');
  const mailbox=await this.ports.mailboxes.recipient({id:route.userId,tenantId:route.tenantId});
  if(!mailbox||mailbox.verified!==true||mailbox.active!==true||typeof mailbox.email!=='string'||mailbox.email.length>254||! /^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(mailbox.email))throw Error('Voicemail mailbox unavailable');
  const to=mailbox.email;await this.#current(route,'voice.voicemail.notify');
  // The app link must require current owner/tenant access when opened. It is not
  // a public Twilio RecordingUrl or a bearer link to audio.
  const link=new URL(recordingSid,this.config.playbackBaseUrl).href;
  await this.ports.notifications.enqueue({actor,key:'voicemail:'+this.config.accountSid+':'+recordingSid,to,subject:'New voicemail',text:`You have a ${duration} second voicemail for extension ${route.extension}. Sign in to listen: ${link}`});
  await this.repository.notified(route,recordingSid);
 }
}
/** Atomic native ledger. Schema is a candidate migration, never applied here. */
export class PostgresVoicemailRepository implements VoicemailRepository {
 readonly pool:any;
 constructor(pool:any){if(typeof pool?.query!=='function')throw Error('Voicemail database required');this.pool=pool;}
 async find(accountSid:string,recordingSid:string){const rows=(await this.pool.query(`SELECT account_sid AS "accountSid",call_sid AS "callSid",extension,tenant_id AS "tenantId",user_id AS "userId" FROM communication_voicemails WHERE account_sid=$1 AND recording_sid=$2`,[accountSid,recordingSid])).rows;return rows.length===1?rows[0]:null;}
 async reserve(r:VoicemailRoute){
  const result=await this.pool.query(`INSERT INTO communication_voicemails(account_sid,call_sid,extension,tenant_id,user_id) VALUES($1,$2,$3,$4,$5)
   ON CONFLICT(account_sid,call_sid) DO UPDATE SET call_sid=EXCLUDED.call_sid
   WHERE communication_voicemails.extension=EXCLUDED.extension AND communication_voicemails.tenant_id=EXCLUDED.tenant_id AND communication_voicemails.user_id=EXCLUDED.user_id RETURNING call_sid`,[r.accountSid,r.callSid,r.extension,r.tenantId,r.userId]);
  if(result.rows.length!==1)throw Error('Voicemail route conflict');
 }
 async read(accountSid:string,callSid:string){const rows=(await this.pool.query(`SELECT account_sid AS "accountSid",call_sid AS "callSid",extension,tenant_id AS "tenantId",user_id AS "userId" FROM communication_voicemails WHERE account_sid=$1 AND call_sid=$2`,[accountSid,callSid])).rows;return rows.length===1?rows[0]:null;}
 async recording(r:VoicemailRoute,sid:string,duration:number){
  const result=await this.pool.query(`UPDATE communication_voicemails SET recording_sid=$6,duration=$7 WHERE account_sid=$1 AND call_sid=$2 AND extension=$3 AND tenant_id=$4 AND user_id=$5 AND (recording_sid IS NULL OR recording_sid=$6 AND duration=$7) RETURNING call_sid`,[r.accountSid,r.callSid,r.extension,r.tenantId,r.userId,sid,duration]);if(result.rows.length!==1)throw Error('Voicemail recording conflict');
 }
 async notified(r:VoicemailRoute,sid:string){const result=await this.pool.query('UPDATE communication_voicemails SET notification_queued=true WHERE account_sid=$1 AND call_sid=$2 AND tenant_id=$3 AND user_id=$4 AND recording_sid=$5 RETURNING call_sid',[r.accountSid,r.callSid,r.tenantId,r.userId,sid]);if(result.rows.length!==1)throw Error('Voicemail notification conflict');}
}

/** Uses the existing inherited mail outbox; enqueue is not proof of delivery.
 * A retry reuses exactly the same command/aggregate identity. Existing mail
 * dispatch claims once and preserves an ambiguous provider result as unknown.
 */
export class BusinessMailVoicemailNotifier {
 readonly mail:{queue(actor:Actor,id:string,key:string,to:string,subject:string,text:string):Promise<unknown>};
 constructor(mail:BusinessMailVoicemailNotifier['mail']){if(typeof mail?.queue!=='function')throw Error('Mail outbox required');this.mail=mail;}
 async enqueue(input:{actor:Actor;key:string;to:string;subject:string;text:string}){
  await this.mail.queue(input.actor,input.key,input.key,input.to,input.subject,input.text);
 }
}
