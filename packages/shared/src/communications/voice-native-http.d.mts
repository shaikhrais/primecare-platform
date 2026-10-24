import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export type NativeVoiceActor=Readonly<{id:string;tenantId:string}>;
export type NativeVoiceSession=Readonly<{actor:NativeVoiceActor;sessionHash:string;expiresAt:number}>;
export type NativeVoiceHttpOptions={
 origin:string;maxRequestBytes:number;maxAudioBytes:number;
 /** Exact registered HTTPS portal origins; gateway owns matching CORS/preflight. Same origin is always allowed. */
 appOrigins?:readonly string[];
 /** Server-owned resolver. Recheck current native session and active membership. */
 authenticate(request:Request):Promise<NativeVoiceSession>;
 /** Current exact registered native API/screen grant plus any additional CSRF/rate-limit checks. No permissive default. */
 authorize(session:NativeVoiceSession,key:string,request:Request):Promise<void>;
 services:{
  /** Optional first-time enrollment capability; absent routes return 404. */
  contacts?:{status(sessionHash:string):Promise<unknown>;start(sessionHash:string,phone:string,requestId:string):Promise<unknown>;check(sessionHash:string,challengeId:string,code:string):Promise<unknown>};
  tokens:{issue(sessionHash:string):Promise<unknown>};
  extensions:{assign(actor:NativeVoiceActor,userId:string):Promise<unknown>;publish(actor:NativeVoiceActor,userId:string,version:number,published:boolean):Promise<unknown>};
  voicemail:{read(actor:NativeVoiceActor,recordingSid:string):Promise<unknown>;audio(actor:NativeVoiceActor,recordingSid:string,adapter:{download(sid:string):Promise<{bytes:Uint8Array;contentType:string}>}):Promise<{bytes:Uint8Array;contentType:string}>};
  audio:{download(sid:string):Promise<{bytes:Uint8Array;contentType:string}>};
  otp:{start(sessionHash:string,callSid:string,pairingCode:string):Promise<unknown>;check(sessionHash:string,callSid:string,code:string):Promise<unknown>};
  confirmations:{preview(actor:NativeVoiceActor,intentId:string):Promise<unknown>;approve(actor:NativeVoiceActor,intentId:string,digest:string):Promise<unknown>};
 };
};
export class NativeVoiceHttpError extends Error {constructor(status:401|403);readonly status:401|403;}
export class NativeVoiceHttpAdapter extends BoundedBinaryAdapterBase {
 constructor(options:NativeVoiceHttpOptions);
 respond(request:Request):Promise<Response>;
}
