import {BaseWorker} from '../core/base-worker';
import {CommunicationSessionError} from './session.ts';
import type {Actor} from './store.ts';
import type {CommunicationCore,ChannelRequests} from './channels.ts';
import catalog from '../../../../packages/shared/src/communications/registered-contracts.json';

type Dependencies<E>={
 core:CommunicationCore;
 authenticate:(request:Request,env:E)=>Promise<Actor>;
 /** Must check the current registered API/screen grant, never the client role. */
 authorizeEndpoint:(actor:Actor,apiId:number,request:Request,env:E)=>Promise<void>;
 /** Production must inject its JSON Schema compiler; no permissive fallback. */
 validate:(schema:unknown,value:unknown)=>boolean;
 maxRequestBytes:number;
};
export class CommunicationHttpError extends Error {
 constructor(readonly status:number){super('Communication request failed');}
}
const channelFor=(path:string)=>path.endsWith('/pictures')?'picture':path.endsWith('/calls')?'audio':path.endsWith('/email')?'email':'message';
const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};

/** Registered adapter only. Deployment still requires real auth, policy and storage. */
export class CommunicationHttpWorker<E> extends BaseWorker<E> {
 readonly dependencies:Dependencies<E>;
 constructor(dependencies:Dependencies<E>){
  super();
  if(!dependencies?.core||typeof dependencies.authenticate!=='function'||typeof dependencies.authorizeEndpoint!=='function'||typeof dependencies.validate!=='function'||!Number.isSafeInteger(dependencies.maxRequestBytes)||dependencies.maxRequestBytes<1)throw Error('Communication HTTP adapters required');
  this.dependencies=dependencies;
 }
 private async body(request:Request){
  const declared=request.headers.get('content-length');
  if(declared!==null&&(!/^\d+$/.test(declared)||Number(declared)>this.dependencies.maxRequestBytes))throw new CommunicationHttpError(413);
  const reader=request.body?.getReader();if(!reader)throw new CommunicationHttpError(400);
  const chunks:Uint8Array[]=[];let length=0;
  try{
   while(true){const part=await reader.read();if(part.done)break;length+=part.value.length;if(length>this.dependencies.maxRequestBytes){await reader.cancel();throw new CommunicationHttpError(413);}chunks.push(part.value);}
  }finally{reader.releaseLock();}
  if(declared!==null&&length!==Number(declared))throw new CommunicationHttpError(400);
  const bytes=new Uint8Array(length);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}return bytes;
 }
 protected override async handle(request:Request,env:E){
  const url=new URL(request.url);
  const contract=catalog.apis.find(api=>api.path===url.pathname&&api.method===request.method);
  if(!contract){
   if(catalog.apis.some(api=>api.path===url.pathname))return Response.json({error:'method_not_allowed'},{status:405,headers:{...headers,allow:catalog.apis.filter(api=>api.path===url.pathname).map(api=>api.method).join(', ')}});
   throw new CommunicationHttpError(404);
  }
  const actor=await this.dependencies.authenticate(request,env);
  await this.dependencies.authorizeEndpoint(actor,contract.id,request,env);
  const channel=channelFor(contract.path);
  let input:Record<string,unknown>=Object.create(null);let binary:Uint8Array|undefined;
  if(request.method==='GET'){
   if(request.body)throw new CommunicationHttpError(400);
   for(const [key,value] of url.searchParams){if(Object.hasOwn(input,key))throw new CommunicationHttpError(400);input[key]=key==='limit'&&/^\d+$/.test(value)?Number(value):value;}
  }else{
   if(url.search)throw new CommunicationHttpError(400);
   const type=request.headers.get('content-type')?.split(';')[0].trim().toLowerCase();
   const bytes=await this.body(request);
   if(contract.operation==='picture.upload'){
    if(type!=='multipart/form-data')throw new CommunicationHttpError(415);
    let form:FormData;try{form=await new Request(request.url,{method:'POST',headers:request.headers,body:bytes}).formData();}catch{throw new CommunicationHttpError(400);}
    for(const [key,value] of form){if(Object.hasOwn(input,key))throw new CommunicationHttpError(400);if(key==='file'){
     if(typeof value==='string'||!value.size||value.size>this.dependencies.core.channels.picture.service.limits.maxPictureBytes)throw new CommunicationHttpError(413);
     binary=new Uint8Array(await value.arrayBuffer());input.file='binary';
    }else{if(typeof value!=='string')throw new CommunicationHttpError(400);input[key]=value;}}
   }else{
    if(type!=='application/json')throw new CommunicationHttpError(415);
    try{input=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new CommunicationHttpError(400);}
   }
  }
  if(!this.dependencies.validate(contract.requestSchema,input))throw new CommunicationHttpError(400);
  if(contract.operation==='message.inbox')input={action:'inbox',...input};
  if(binary){const {file,...fields}=input;input={...fields,bytes:binary};}
  const result=await this.dependencies.core.execute(channel,actor,input as ChannelRequests[typeof channel]);
  if(contract.operation==='picture.open'){
   const object=result as {body?:BodyInit;size?:number;httpMetadata?:{contentType?:string}};
   if(!object?.body||object.httpMetadata?.contentType!=='image/png'||!Number.isSafeInteger(object.size)||object.size!<1||object.size!>this.dependencies.core.channels.picture.service.limits.maxPictureBytes)throw new CommunicationHttpError(503);
   return new Response(object.body,{headers:{...headers,'content-type':'image/png','content-length':String(object.size)}});
  }
  if(!this.dependencies.validate(contract.responseSchema,result))throw new CommunicationHttpError(503);
  return Response.json(result,{headers});
 }
 protected override onError(error:unknown){
  const known:Record<string,number>={'Not found':404,'Forbidden':403,'Version conflict':409,'Idempotency conflict':409,'Invalid input':400,'Invalid inbox':400,'Picture unavailable':404};
  for(const name of ['Invalid members','Invalid message','Empty or invalid message','Invalid picture size','Invalid picture type','Invalid read receipt','Invalid call action','Invalid recipient','Invalid signal','Invalid candidate','Invalid description','Invalid offer','Invalid answer','Invalid address','Invalid mail body'])known[name]=400;
  for(const name of ['Already exists','Call conflict','Call not accepted','Mail already attempted','Mail state conflict','Conversation storage limit'])known[name]=409;
  known['Signal limit']=413;
  const status=error instanceof CommunicationHttpError||error instanceof CommunicationSessionError?error.status:error instanceof Error?known[error.message]??503:503;
  const names:Record<number,string>={400:'invalid_request',401:'unauthorized',403:'forbidden',404:'not_found',409:'conflict',413:'too_large',415:'unsupported_media_type',503:'unavailable'};
  return Response.json({error:names[status]??'unavailable'},{status,headers});
 }
}
