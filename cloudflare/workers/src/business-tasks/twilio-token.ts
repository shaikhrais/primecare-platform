import AccessToken from 'twilio/lib/jwt/AccessToken.js';
import {ScopedServiceBase, type AtomicStore, type AccessPolicy, type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import {twilioVoiceIdentity} from '../../../../packages/shared/src/communications/twilio-voice.mjs';

type VoiceSession = {id:string;userId:string;tenantId:string;expiresAt:number;active:boolean};
type VoiceDestination = {extension:string;tenantId:string;userId:string;published:boolean;active:boolean;tenantActive:boolean;userActive:boolean};
export interface VoiceTokenDirectory {
 currentSession(id:string):Promise<VoiceSession|null>;
 destinations(actor:Actor,limit:2):Promise<ReadonlyArray<VoiceDestination>>;
}
type Configuration = {accountSid:string;apiKeySid:string;apiKeySecret:string;applicationSid:string;ttlSeconds:number};
const sid=(prefix:string,value:unknown)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
const denied=()=>Error('Voice unavailable');

/** Internal, unmounted service. Trusted server session handle only; no HTTP token route.
 * Production requires registered contracts, current policy and durable directory ports.
 */
export class TwilioVoiceTokenService extends ScopedServiceBase {
 #configuration:Readonly<Configuration>;
 #directory:VoiceTokenDirectory;
 constructor(store:AtomicStore,policy:AccessPolicy,directory:VoiceTokenDirectory,configuration:Configuration){
  super(store,policy);
  if(!configuration||!sid('AC',configuration.accountSid)||!sid('SK',configuration.apiKeySid)||!sid('AP',configuration.applicationSid)||typeof configuration.apiKeySecret!=='string'||!/^[a-fA-F0-9]{32}$/.test(configuration.apiKeySecret)||!Number.isSafeInteger(configuration.ttlSeconds)||configuration.ttlSeconds<1||configuration.ttlSeconds>300||typeof directory?.currentSession!=='function'||typeof directory?.destinations!=='function')throw Error('Voice token configuration required');
  this.#configuration=Object.freeze({...configuration});this.#directory=directory;
 }
 async #session(id:string){
  const row=await this.#directory.currentSession(id);
  if(!row||row.id!==id||row.active!==true||typeof row.userId!=='string'||typeof row.tenantId!=='string'||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())throw denied();
  return Object.freeze({id:row.id,userId:row.userId,tenantId:row.tenantId,expiresAt:row.expiresAt});
 }
 async #destination(actor:Actor){
  const rows=await this.#directory.destinations(actor,2);
  if(!Array.isArray(rows)||rows.length!==1)throw denied();
  const row=rows[0];
  if(!row||row.tenantId!==actor.tenantId||row.userId!==actor.id||typeof row.extension!=='string'||! /^[1-9][0-9]{3}$/.test(row.extension)||row.active!==true||row.published!==true||row.tenantActive!==true||row.userActive!==true)throw denied();
  return Object.freeze({extension:row.extension,tenantId:row.tenantId,userId:row.userId});
 }
 async issue(sessionId:string){
  if(typeof sessionId!=='string'||!sessionId||sessionId.length>200||/[\u0000-\u0020\u007f]/.test(sessionId))throw denied();
  try{
   const session=await this.#session(sessionId),actor=Object.freeze({id:session.userId,tenantId:session.tenantId});
   await this.checkAccess(actor,'voice.token',null,[],true);
   const destination=await this.#destination(actor),identity=await twilioVoiceIdentity(actorToIdentity(actor));
   const current=await this.#session(sessionId);
   if(current.userId!==session.userId||current.tenantId!==session.tenantId)throw denied();
   const latest=await this.#destination(actor);
   if(latest.extension!==destination.extension)throw denied();
   await this.checkAccess(actor,'voice.token',null,[],true);
   const ttl=Math.min(this.#configuration.ttlSeconds,Math.floor((Math.min(session.expiresAt,current.expiresAt)-Date.now())/1000));
   if(ttl<1)throw denied();
   const c=this.#configuration,token=new AccessToken(c.accountSid,c.apiKeySid,c.apiKeySecret,{identity,ttl});
   token.addGrant(new AccessToken.VoiceGrant({incomingAllow:true,outgoingApplicationSid:c.applicationSid}));
   return {token:token.toJwt(),identity,ttlSeconds:ttl};
  }catch{throw denied();}
 }
}
function actorToIdentity(actor:Actor){return {tenantId:actor.tenantId,userId:actor.id};}
