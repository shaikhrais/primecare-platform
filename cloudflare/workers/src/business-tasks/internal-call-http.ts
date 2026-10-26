import {BoundedBinaryAdapterBase,CommunicationInputError} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {assertActor,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import {CommunicationSessionError} from './session.ts';
import type {InternalCallApplication} from './internal-call-application.ts';
import definition from '../../../../tools/governance-production/internal-call-contracts-registration.json' with {type:'json'};
import preparation from '../../../../tools/governance-production/internal-call-preparation-registration.json' with {type:'json'};
import validators from '../../../../packages/shared/src/communications/internal-call-schema-validators.mjs';
const schemas=validators as Record<string,(value:unknown)=>boolean>,headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
export type InternalCallHttpPorts={origin:string;appOrigins:readonly string[];application:InternalCallApplication;readiness?(request:Request):Promise<Response>;committed?(actor:Actor,key:string,input:any,result:any):Promise<void>;current?(request:Request,key:string):Promise<Actor>;authenticate?(request:Request):Promise<Actor>;authorize?(actor:Actor,key:string,request:Request):Promise<void>};
const origin=(v:string)=>{try{const u=new URL(v);return u.protocol==='https:'&&u.origin===v;}catch{return false;}};
/** Native bearer-only call boundary, with current session/API/screen checks before
 * body access, before invocation, and before releasing private results. */
export class InternalCallHttpAdapter extends BoundedBinaryAdapterBase {
 readonly ports:InternalCallHttpPorts;readonly origins:ReadonlySet<string>;
 constructor(ports:InternalCallHttpPorts){super(32768);if(!origin(ports.origin)||!ports.appOrigins.every(origin)||(typeof ports.current!=='function'&&(typeof ports.authenticate!=='function'||typeof ports.authorize!=='function'))||typeof ports.application?.dial!=='function')throw Error('Call HTTP ports required');this.ports=ports;this.origins=new Set([ports.origin,...ports.appOrigins]);}
 private async current(request:Request,key:string,expected?:Actor){const current=this.ports.current?await this.ports.current(request,key):await this.ports.authenticate!(request);assertActor(current);const actor=Object.freeze({id:current.id,tenantId:current.tenantId});if(expected&&(expected.id!==actor.id||expected.tenantId!==actor.tenantId))throw new CommunicationSessionError(401);if(!this.ports.current)await this.ports.authorize!(actor,key,request);return actor;}
 async respond(request:Request){if(this.ports.readiness&&new URL(request.url).pathname==='/v1/calls/prepare/read')return this.ports.readiness(request);let consumed=false,authorized=false,phase='native_boundary';
  try{
   const url=new URL(request.url),operations=[...definition.operations,...preparation.operations],index=operations.findIndex(o=>o.path===url.pathname),op=operations[index],schemaIndex=op?.key==='call.prepare'?4:index,schemaPrefix=op?.key==='call.prepare.read'?'internalPreparation1':'internalCall'+schemaIndex;
   if(url.origin!==this.ports.origin||!op)return Response.json({error:'not_found'},{status:404,headers});
   if(request.method!==op.method)return Response.json({error:'method_not_allowed'},{status:405,headers:{...headers,allow:op.method}});
   if(url.search||url.hash)throw new CommunicationInputError();
   const app=request.headers.get('origin');if(app!==null&&!this.origins.has(app)||app===null&&request.headers.get('sec-fetch-site')==='cross-site')throw new CommunicationSessionError(403);
   if(!/^Bearer [^\s]{1,8192}$/.test(request.headers.get('authorization')??''))throw new CommunicationSessionError(401);
   const actor=await this.current(request,op.key);
   if(request.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json'||request.headers.has('content-encoding'))return Response.json({error:'unsupported_media_type'},{status:415,headers});
   const length=request.headers.get('content-length');consumed=true;const bytes=length===null?await this.readBoundedBody(request.body!):await this.readBoundedStream(request.body!,/^\d+$/.test(length)?Number(length):NaN);let body:any;
   try{body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new CommunicationInputError();}
   if(schemas[schemaPrefix+'_request'](body)!==true)throw new CommunicationInputError();await this.current(request,op.key,actor);authorized=true;phase='native_application';
   const a=this.ports.application;let raw;
   switch(op.key){case 'call.directory':raw=await a.directory(actor,body.after);break;case 'call.extension':raw=await a.extension(actor,body.published);break;case 'call.dial':raw=await a.dial(actor,body.extension,body.requestId);break;case 'call.command':raw=await a.command(actor,body);break;case 'call.prepare.read':raw=await a.preparedRead(actor,body.id,body.callId);break;case 'call.prepare':raw=await a.prepare(actor,body.id,body.callId);break;case 'call.media':raw=await a.media(actor,body.id,body.callId);break;default:throw Error('Unavailable');}
   phase='response_schema';if(schemas[schemaPrefix+'_response'](raw)!==true)throw Error('Invalid call response');const result=structuredClone(raw);if(this.ports.committed)try{await this.ports.committed(actor,op.key,body,result);}catch{}phase='session_release';await this.current(request,op.key,actor);return Response.json(result,{headers});
  }catch(error){const known:Record<string,number>={'Forbidden':403,'Not found':404,'Call unavailable':404,'Call destination unavailable':404,'Version conflict':409,'Idempotency conflict':409,'Call conflict':409,'Call not accepted':409,'Invalid offer':400,'Invalid answer':400,'Invalid recipient':400,'Invalid signal':400,'Invalid candidate':400,'Invalid description':400};const status=error instanceof CommunicationSessionError?error.status:error instanceof CommunicationInputError?400:error instanceof Error?known[error.message]??503:503;const health=error instanceof Error?(error as Error&{communicationHealth?:string}).communicationHealth:undefined;const safeHealth=health&&/^(?:relay_http_[1-5][0-9]{2}|relay_(?:configuration|request|body|payload|quota))$/.test(health)?health:phase;return Response.json({error:({400:'invalid_request',401:'unauthorized',403:'forbidden',404:'not_found',409:'conflict'} as Record<number,string>)[status]??'unavailable'},{status,headers:{...headers,...(status===503&&authorized?{'x-primecare-calls-health':safeHealth}:{})}});
  }finally{if(!consumed)try{await request.body?.cancel();}catch{}}
 }
}
