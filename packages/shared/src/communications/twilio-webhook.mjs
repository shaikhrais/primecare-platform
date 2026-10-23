import {validateRequest} from 'twilio/lib/webhooks/webhooks.js';
import {BoundedBinaryAdapterBase,CommunicationInputError} from './adapter-base.mjs';
export const twilioSid=(prefix,value)=>typeof value==='string'&&value.length===prefix.length+32&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
export function twilioPublicUrl(value){
 if(typeof value!=='string')throw Error('Provider configuration required');
 const url=new URL(value);
 if(url.protocol!=='https:'||url.username||url.password||url.hash||url.href!==value)throw Error('Provider configuration required');
 return value;
}
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
export const twilioFailure=status=>Response.json({error:status===503?'unavailable':'invalid_provider_request'},{status,headers});
/** Shared signed form boundary. No tenant or actor is accepted from provider fields. */
export class TwilioSignedFormAdapter extends BoundedBinaryAdapterBase{
 #account;#token;#urls;
 constructor({accountSid,authToken,webhookUrl,webhookUrls,maxWebhookBytes}){
  super(maxWebhookBytes);
  if(!twilioSid('AC',accountSid)||typeof authToken!=='string'||!/^[a-fA-F0-9]{32}$/.test(authToken))throw Error('Provider configuration required');
  if(webhookUrl!==undefined&&webhookUrls!==undefined)throw Error('Provider configuration required');
  const urls=webhookUrls??[webhookUrl];
  if(!Array.isArray(urls)||!urls.length||urls.length>2||new Set(urls).size!==urls.length)throw Error('Provider configuration required');
  this.#account=accountSid;this.#token=authToken;this.#urls=Object.freeze(urls.map(twilioPublicUrl));
 }
 async validate(request){
  const discard=async status=>{try{await request.body?.cancel();}catch{}return {response:twilioFailure(status)};};
  if(request.method!=='POST'||!this.#urls.includes(request.url))return discard(404);
  if(!/^application\/x-www-form-urlencoded(?:\s*;\s*charset\s*=\s*(?:utf-8|"utf-8"))?\s*$/i.test(request.headers.get('content-type')??'')||!['identity',null].includes(request.headers.get('content-encoding')))return discard(415);
  const signature=request.headers.get('x-twilio-signature');
  if(!signature||signature.length>100)return discard(403);
  let bytes;
  try{
   const length=request.headers.get('content-length');
   if(length!==null&&!/^[0-9]+$/.test(length))return discard(400);
   bytes=length===null?await this.readBoundedBody(request.body):await this.readBoundedStream(request.body,Number(length));
  }catch(error){return {response:twilioFailure(error instanceof CommunicationInputError?400:503)};}
  const params=Object.create(null);
  try{
   const parts=new TextDecoder('utf-8',{fatal:true}).decode(bytes).split('&');
   if(parts.length>128)throw Error('form');
   const decode=value=>decodeURIComponent(value.replaceAll('+',' '));
   for(const part of parts){
    const at=part.indexOf('='),key=decode(at<0?part:part.slice(0,at)),value=decode(at<0?'':part.slice(at+1));
    if(!key||/[\u0000-\u001f\u007f]/.test(key))throw Error('form');
    if(Object.hasOwn(params,key))params[key]=Array.isArray(params[key])?[...params[key],value]:[params[key],value];else params[key]=value;
   }
  }catch{return {response:twilioFailure(400)};}
  try{if(!validateRequest(this.#token,signature,request.url,params)||params.AccountSid!==this.#account)return {response:twilioFailure(403)};}catch{return {response:twilioFailure(403)};}
  return {params};
 }
}
