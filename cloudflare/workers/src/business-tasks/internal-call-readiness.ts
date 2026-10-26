import {BoundedBinaryAdapterBase,CommunicationInputError} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {CommunicationSessionError} from './session.ts';
import {internalCallView,internalCallExpired,type InternalCallApplication} from './internal-call-application.ts';
import type {PostgresInternalCallContext} from './internal-call-context.ts';
import validators from '../../../../packages/shared/src/communications/internal-call-schema-validators.mjs';
/** Read-only point-of-use authorization: the one native snapshot includes the
 * current session, all three API/screen gates, policy, state and participants.
 * No mutation, grant cache, or database await occurs after its scope check. */
export class InternalCallReadinessAdapter extends BoundedBinaryAdapterBase {
 readonly context:PostgresInternalCallContext;readonly application:InternalCallApplication;readonly origin:string;readonly appOrigins:readonly string[];
 constructor(context:PostgresInternalCallContext,application:InternalCallApplication,origin:string,appOrigins:readonly string[]){super(512);this.context=context;this.application=application;this.origin=origin;this.appOrigins=appOrigins;}
 async respond(request:Request){const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};try{
  if(request!==this.context.request)throw new CommunicationSessionError(401);
  const url=new URL(request.url),origin=request.headers.get('origin');
  if(url.origin!==this.origin||url.pathname!=='/v1/calls/prepare/read')throw Error('Not found');
  if(request.method!=='POST')return new Response(null,{status:405,headers:{...headers,allow:'POST'}});
  if(url.search||url.hash||origin!==null&&!this.appOrigins.includes(origin)||origin===null&&request.headers.get('sec-fetch-site')==='cross-site')throw Error('Forbidden');
  if(!/^Bearer [A-Za-z0-9_-]{43}$/.test(request.headers.get('authorization')??''))throw new CommunicationSessionError(401);
  if(request.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json'||request.headers.has('content-encoding'))return Response.json({error:'invalid_request'},{status:415,headers});
  let input:any;try{input=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(request.body!)));}catch{throw new CommunicationInputError();}
  if(validators.internalPreparation1_request(input)!==true)throw new CommunicationInputError();
  const snapshot=await this.context.snapshot(undefined,{id:input.id});if(snapshot.records.length!==1)throw Error('Not found');
  const state=snapshot.records[0];this.context.offer(state,snapshot);
  try{await this.application.core.calls.authorize(snapshot.actor,'conversation.read',state);}finally{this.context.discard(state);}
  const call=state.calls.find((c:any)=>c.id===input.callId);if(!call||state.id!==input.id||![call.callerId,call.recipientId].includes(snapshot.actor.id))throw Error('Not found');
  if(internalCallExpired(call,snapshot.actor,Date.now()))throw Error('Call not accepted');
  const result=internalCallView(state,snapshot.actor);if(validators.internalPreparation1_response(result)!==true)throw Error('Invalid call response');return Response.json(result,{headers});
 }catch(error){const known:Record<string,number>={'Forbidden':403,'Not found':404,'Call unavailable':404,'Call not accepted':409};const status=error instanceof CommunicationSessionError?error.status:error instanceof CommunicationInputError?400:error instanceof Error?known[error.message]??503:503;return Response.json({error:({400:'invalid_request',401:'unauthorized',403:'forbidden',404:'not_found',409:'conflict'} as Record<number,string>)[status]??'unavailable'},{status,headers});}}
}
