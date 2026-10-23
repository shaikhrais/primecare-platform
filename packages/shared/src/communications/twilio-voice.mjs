import {validateRequest} from 'twilio/lib/webhooks/webhooks.js';
import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {BoundedBinaryAdapterBase,CommunicationInputError} from './adapter-base.mjs';
import requirement from '../../../../tools/governance-production/twilio-voice-requirement.json' with {type:'json'};

const extensionPattern=/^[1-9][0-9]{5}$/;
const sid=(prefix,value)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
const identifier=value=>typeof value==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(value);
const e164=value=>typeof value==='string'&&/^\+[1-9][0-9]{1,14}$/.test(value);
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const failure=status=>Response.json({error:status===503?'unavailable':'invalid_provider_request'},{status,headers});
const xml=response=>new Response(response.toString(),{headers:{...headers,'content-type':'application/xml; charset=utf-8'}});
function unavailable(){const response=new VoiceResponse();response.say('This extension is unavailable.');response.hangup();return xml(response);}
function publicUrl(value){
 if(typeof value!=='string')throw Error('Twilio voice configuration required');
 const url=new URL(value);
 if(url.protocol!=='https:'||url.username||url.password||url.hash||url.href!==value)throw Error('Twilio voice configuration required');
 return url;
}
function form(bytes){
 const text=new TextDecoder('utf-8',{fatal:true}).decode(bytes),params=Object.create(null),parts=text.split('&');
 if(parts.length>128)throw new CommunicationInputError('Invalid provider form');
 const decode=value=>decodeURIComponent(value.replaceAll('+',' '));
 for(const part of parts){
  const at=part.indexOf('='),key=decode(at<0?part:part.slice(0,at)),value=decode(at<0?'':part.slice(at+1));
  if(!key||/[\u0000-\u001f\u007f]/.test(key))throw new CommunicationInputError('Invalid provider form');
  if(Object.hasOwn(params,key))params[key]=Array.isArray(params[key])?[...params[key],value]:[params[key],value];else params[key]=value;
 }
 return params;
}
function destination(rows,extension){
 if(!Array.isArray(rows)||rows.length!==1)return null;
 const row=rows[0];
 if(!row||row.extension!==extension||!identifier(row.tenantId)||!identifier(row.userId)||row.published!==true||row.active!==true||row.tenantActive!==true||row.userActive!==true)return null;
 // Snapshot before hashing or another current-directory lookup suspends.
 return Object.freeze({extension,tenantId:row.tenantId,userId:row.userId});
}
/** Same identity function must be used by a separately authorized Voice SDK token issuer. */
export async function twilioVoiceIdentity({tenantId,userId}){
 if(!identifier(tenantId)||!identifier(userId))throw Error('Invalid voice identity');
 const source=new TextEncoder().encode(tenantId.length+':'+tenantId+userId.length+':'+userId);
 const digest=new Uint8Array(await crypto.subtle.digest('SHA-256',source));
 return 'primecare_'+Array.from(digest,byte=>byte.toString(16).padStart(2,'0')).join('');
}
/** Internal provider adapter, not a mounted endpoint or a native-user channel.
 * Requires governed webhook/token mounting, extension publication and live acceptance.
 */
export class TwilioVoiceExtensionAdapter extends BoundedBinaryAdapterBase {
 constructor({accountSid,authToken,sharedNumber,numberVerified,incomingUrl,gatherUrl,directory,maxWebhookBytes}){
  super(maxWebhookBytes);
  const incoming=publicUrl(incomingUrl),gather=publicUrl(gatherUrl);
  if(!sid('AC',accountSid)||typeof authToken!=='string'||!/^[a-fA-F0-9]{32}$/.test(authToken)||!e164(sharedNumber)||numberVerified!==true||incoming.origin!==gather.origin||incomingUrl===gatherUrl||typeof directory?.lookup!=='function'||requirement.rules.extensionDigits!==6)throw Error('Twilio voice configuration required');
  Object.defineProperties(this,{configuration:{value:Object.freeze({accountSid,authToken,sharedNumber,incomingUrl,gatherUrl})},directory:{value:directory}});
 }
 async respond(request){
  const config=this.configuration;
  const discard=async status=>{try{await request.body?.cancel();}catch{}return failure(status);};
  if(request.method!=='POST'||![config.incomingUrl,config.gatherUrl].includes(request.url))return discard(404);
  const type=request.headers.get('content-type')??'',encoding=request.headers.get('content-encoding');
  if(!/^application\/x-www-form-urlencoded(?:\s*;\s*charset\s*=\s*(?:utf-8|"utf-8"))?\s*$/i.test(type)||encoding&&encoding!=='identity')return discard(415);
  const signature=request.headers.get('x-twilio-signature');
  if(typeof signature!=='string'||!signature||signature.length>100)return discard(403);
  let params,bytes;
  try{
   const declared=request.headers.get('content-length');
   if(declared!==null&&!/^[0-9]+$/.test(declared))return discard(400);
   bytes=declared===null?await this.readBoundedBody(request.body):await this.readBoundedStream(request.body,Number(declared));
  }catch(error){return failure(error instanceof CommunicationInputError?400:503);}
  try{params=form(bytes);}catch{return failure(400);}
  try{if(!validateRequest(config.authToken,signature,request.url,params))return failure(403);}catch{return failure(403);}
  if(params.AccountSid!==config.accountSid||params.To!==config.sharedNumber||params.Direction!=='inbound'||!sid('CA',params.CallSid))return failure(403);
  if(request.url===config.incomingUrl){
   if(Object.hasOwn(params,'Digits'))return unavailable();
   const response=new VoiceResponse();response.gather({input:'dtmf',numDigits:6,finishOnKey:'#',timeout:5,action:config.gatherUrl,method:'POST',actionOnEmptyResult:true}).say('Enter the six digit extension.');response.hangup();return xml(response);
  }
  if(typeof params.Digits!=='string'||!extensionPattern.test(params.Digits))return unavailable();
  try{
   const first=destination(await this.directory.lookup(params.Digits,2),params.Digits);if(!first)return unavailable();
   const identity=await twilioVoiceIdentity(first);
   const current=destination(await this.directory.lookup(params.Digits,2),params.Digits);
   if(!current||current.tenantId!==first.tenantId||current.userId!==first.userId)return unavailable();
   const response=new VoiceResponse();response.dial({callerId:config.sharedNumber,answerOnBridge:true,timeout:20}).client().identity(identity);response.hangup();return xml(response);
  }catch{return failure(503);}
 }
}
