import {BoundedBinaryAdapterBase,CommunicationInputError} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import validators from '../../../../packages/shared/src/communications/sms-link-schema-validators.mjs';
import definition from '../../../../tools/governance-production/sms-link-contracts-registration.json' with {type:'json'};
import {NativeSmsLinkChannel,type NativeSmsLinkService,type SmsLinkRequest} from './sms-link-native.ts';
import {assertActor} from '../../../../packages/shared/src/communications/service-base.ts';
import type {NativeContext} from './sms-links.ts';

type Session=NativeContext&{expiresAt:number};
type Ports={origin:string;appOrigins:string[];maxRequestBytes:number;service:NativeSmsLinkService;authenticate(request:Request):Promise<Session>;authorize(session:Session,key:string,request:Request):Promise<void>};
const schemas=validators as Record<string,(value:unknown)=>boolean>;
const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
export class NativeSmsLinkHttpError extends Error {
 readonly status:401|403;
 constructor(status:401|403){super('Native SMS link denied');if(![401,403].includes(status))throw Error('Invalid denial');this.status=status;}
}
function sessionSnapshot(session:Session):Session{
 try{assertActor(session?.actor);}catch{throw new NativeSmsLinkHttpError(401);}
 if(typeof session.sessionHash!=='string'||!/^[a-f0-9]{64}$/.test(session.sessionHash)||!Number.isSafeInteger(session.expiresAt)||session.expiresAt<=Date.now())throw new NativeSmsLinkHttpError(401);
 return Object.freeze({actor:Object.freeze({id:session.actor.id,tenantId:session.actor.tenantId}),sessionHash:session.sessionHash,expiresAt:session.expiresAt});
}
const exactOrigin=(value:string)=>{try{const u=new URL(value);return u.protocol==='https:'&&u.origin===value&&!u.username&&!u.password;}catch{return false;}};
/** Bounded registered native boundary. No route is mounted by construction.
 * Authenticate and authorize must query current native session/API grants.
 * Bearer-only calls follow the existing native CSRF boundary; cookies alone
 * never authorize mutations. Runtime host composition remains separate. */
export class NativeSmsLinkHttpAdapter extends BoundedBinaryAdapterBase {
 readonly origin:string;readonly appOrigins:ReadonlySet<string>;readonly service:NativeSmsLinkService;
 readonly authenticate:Ports['authenticate'];readonly authorize:Ports['authorize'];
 constructor(ports:Ports){
  super(ports.maxRequestBytes);
  if(!exactOrigin(ports.origin)||ports.maxRequestBytes>4096||!Array.isArray(ports.appOrigins)||ports.appOrigins.length>16||!ports.appOrigins.every(exactOrigin)||typeof ports.authenticate!=='function'||typeof ports.authorize!=='function'||typeof ports.service?.execute!=='function')throw Error('Native SMS link HTTP ports required');
  this.origin=ports.origin;this.appOrigins=new Set([ports.origin,...ports.appOrigins]);this.service=ports.service;this.authenticate=ports.authenticate;this.authorize=ports.authorize;
  for(let i=0;i<3;i++)for(const kind of ['request','response'])if(typeof schemas['smsLink'+i+'_'+kind]!=='function')throw Error('SMS link validators required');
 }
 private async current(request:Request,key:string,expected?:Session){
  const session=sessionSnapshot(await this.authenticate(request));
  if(expected&&(expected.actor.id!==session.actor.id||expected.actor.tenantId!==session.actor.tenantId||expected.sessionHash!==session.sessionHash))throw new NativeSmsLinkHttpError(401);
  await this.authorize(session,key,request);
  if(session.expiresAt<=Date.now())throw new NativeSmsLinkHttpError(401);return session;
 }
 async respond(request:Request):Promise<Response>{
  let consumed=false;
  try{
   const url=new URL(request.url),index=definition.operations.findIndex(o=>o.path===url.pathname),op=definition.operations[index];
   if(url.origin!==this.origin||!op)return Response.json({error:'not_found'},{status:404,headers});
   if(request.method!==op.method)return Response.json({error:'method_not_allowed'},{status:405,headers:{...headers,allow:op.method}});
   if(url.search||url.hash)throw new CommunicationInputError('Invalid URL');
   const bearer=request.headers.get('authorization');if(!bearer||bearer.length>8192||!/^Bearer [^\s]+$/i.test(bearer))throw new NativeSmsLinkHttpError(401);
   const origin=request.headers.get('origin');if(origin!==null&&!this.appOrigins.has(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')throw new NativeSmsLinkHttpError(403);
   const session=await this.current(request,op.key);
   if(request.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')return Response.json({error:'unsupported_media_type'},{status:415,headers});
   const declared=request.headers.get('content-length');consumed=true;
   const bytes=declared===null?await this.readBoundedBody(request.body!):await this.readBoundedStream(request.body!,/^\d+$/.test(declared)?Number(declared):NaN);
   let input;try{input=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new CommunicationInputError('Invalid JSON');}
   if(schemas['smsLink'+index+'_request'](input)!==true)throw new CommunicationInputError('Invalid request');
   await this.current(request,op.key,session);
   const channel=new NativeSmsLinkChannel(this.service,session);
   const raw=await channel.execute(session.actor,{action:op.key.slice(5),...input} as SmsLinkRequest);
   if(schemas['smsLink'+index+'_response'](raw)!==true)throw Error('Invalid response');
   const result=structuredClone(raw);await this.current(request,op.key,session);
   return Response.json(result,{headers});
  }catch(error){
   const status=error instanceof NativeSmsLinkHttpError?error.status:error instanceof CommunicationInputError?400:503;
   return Response.json({error:status===400?'invalid_request':status===401?'unauthorized':status===403?'forbidden':'unavailable'},{status,headers});
  }finally{if(!consumed)try{await request.body?.cancel();}catch{}}
 }
}
