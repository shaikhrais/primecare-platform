import {BoundedBinaryAdapterBase,CommunicationInputError} from './adapter-base.mjs';
import definition from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
import contacts from '../../../../tools/governance-production/voice-contact-contracts-registration.json' with {type:'json'};
import validators from './voice-schema-validators.mjs';

const contracts=definition.operations.filter(op=>op.authentication==='native-session-csrf')
 .map((op,index)=>Object.freeze({key:op.key,path:op.path,method:op.method,index}));
const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
const validId=value=>typeof value==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(value);
const deny=()=>new NativeVoiceHttpError(403);
export class NativeVoiceHttpError extends Error {
 constructor(status){super('Voice request denied');if(![401,403].includes(status))throw Error('Invalid voice denial');this.status=status;}
}
function sessionSnapshot(value){
 if(!value||!validId(value.actor?.id)||!validId(value.actor?.tenantId)||typeof value.sessionHash!=='string'||! /^[a-f0-9]{64}$/.test(value.sessionHash)||!Number.isSafeInteger(value.expiresAt)||value.expiresAt<=Date.now())throw new NativeVoiceHttpError(401);
 return Object.freeze({actor:Object.freeze({id:value.actor.id,tenantId:value.actor.tenantId}),sessionHash:value.sessionHash,expiresAt:value.expiresAt});
}
function method(port,key){if(typeof port?.[key]!=='function')throw Error('Native voice service required');return port[key].bind(port);}

/** Registered native API boundary, not a provider webhook or an AI tool.
 * The host supplies current session and exact API/screen authorization ports.
 * Construction does not mount routes, publish extensions or grant access.
 */
export class NativeVoiceHttpAdapter extends BoundedBinaryAdapterBase {
 #origin;#appOrigins;#authenticate;#authorize;#dispatch;#audio;#contracts;
 constructor({origin,appOrigins=[],maxRequestBytes,maxAudioBytes,authenticate,authorize,services,_contactsOnly=false,_tasksOnly=false}){
  super(maxRequestBytes);
  const url=new URL(origin);
  if(url.protocol!=='https:'||url.origin!==origin||url.username||url.password||maxRequestBytes>65536||!Number.isSafeInteger(maxAudioBytes)||maxAudioBytes<12||maxAudioBytes>33554432||typeof authenticate!=='function'||typeof authorize!=='function'||contracts.length!==9)throw Error('Native voice HTTP configuration required');
  if(!Array.isArray(appOrigins)||appOrigins.length>16||appOrigins.some(value=>{try{const u=new URL(value);return u.protocol!=='https:'||u.origin!==value;}catch{return true;}}))throw Error('Exact approved app origins required');
  if(typeof _contactsOnly!=='boolean'||typeof _tasksOnly!=='boolean'||_contactsOnly&&_tasksOnly||_contactsOnly&&services?.contacts===undefined||_tasksOnly&&services?.confirmations===undefined)throw Error('Native contact capability required');
  this.#contracts=Object.freeze([...(_contactsOnly?[]:_tasksOnly?contracts.filter(op=>op.key==='task.preview'||op.key==='task.approve'):contracts),...(services?.contacts===undefined?[]:contacts.operations.map((op,index)=>Object.freeze({key:op.key,path:op.path,method:op.method,index:index+9})))]);
  this.#origin=origin;this.#appOrigins=new Set([origin,...appOrigins]);this.#authenticate=authenticate;this.#authorize=authorize;this.#audio=new BoundedBinaryAdapterBase(maxAudioBytes);
  const contactDispatch={};
  if(services?.contacts!==undefined){
   const status=method(services.contacts,'status'),startContact=method(services.contacts,'start'),checkContact=method(services.contacts,'check');
   Object.assign(contactDispatch,{'contact.status':s=>status(s.sessionHash),'contact.start':(s,p)=>startContact(s.sessionHash,p.phone,p.requestId),'contact.check':(s,p)=>checkContact(s.sessionHash,p.challengeId,p.code)});
  }
  let legacyDispatch={};
  if(!_contactsOnly&&!_tasksOnly){
  const token=method(services?.tokens,'issue'),assign=method(services?.extensions,'assign'),publish=method(services?.extensions,'publish');
  const read=method(services?.voicemail,'read'),audio=method(services?.voicemail,'audio');
  const start=method(services?.otp,'start'),check=method(services?.otp,'check');
  const preview=method(services?.confirmations,'preview'),approve=method(services?.confirmations,'approve');
  if(typeof services?.audio?.download!=='function')throw Error('Native voice audio adapter required');
  const audioPort=Object.freeze({download:services.audio.download.bind(services.audio)});
   legacyDispatch={
    token:(s,p)=>token(s.sessionHash),
    'extension.assign':(s,p)=>assign(s.actor,p.userId),
    'extension.publish':(s,p)=>publish(s.actor,p.userId,p.version,p.published),
    'voicemail.read':(s,p)=>read(s.actor,p.recordingSid),
    'voicemail.audio':(s,p)=>audio(s.actor,p.recordingSid,audioPort),
    'otp.start':(s,p)=>start(s.sessionHash,p.callSid,p.pairingCode),
    'otp.check':(s,p)=>check(s.sessionHash,p.callSid,p.code),
    'task.preview':(s,p)=>preview(s.actor,p.intentId),
    'task.approve':(s,p)=>approve(s.actor,p.intentId,p.digest),
   };
  }
  const taskDispatch={};
  if(_tasksOnly){
   const preview=method(services.confirmations,'preview'),approve=method(services.confirmations,'approve');
   Object.assign(taskDispatch,{'task.preview':(s,p)=>preview(s.actor,p.intentId),'task.approve':(s,p)=>approve(s.actor,p.intentId,p.digest)});
  }
  this.#dispatch=Object.freeze({...legacyDispatch,...contactDispatch,...taskDispatch});
  for(const op of this.#contracts)for(const kind of ['request','response'])if(typeof validators['voice'+op.index+'_'+kind]!=='function')throw Error('Native voice validator missing');
 }
 async #current(request,op,expected){
  const current=sessionSnapshot(await this.#authenticate(request));
  if(expected&&(current.actor.id!==expected.actor.id||current.actor.tenantId!==expected.actor.tenantId||current.sessionHash!==expected.sessionHash))throw new NativeVoiceHttpError(401);
  await this.#authorize(current,op.key,request);
  if(current.expiresAt<=Date.now())throw new NativeVoiceHttpError(401);
  return current;
 }
 async respond(request){
  let consumed=false;
  try{
   const url=new URL(request.url),op=this.#contracts.find(c=>c.path===url.pathname);
   if(url.origin!==this.#origin||!op)return Response.json({error:'not_found'},{status:404,headers});
   if(request.method!==op.method)return Response.json({error:'method_not_allowed'},{status:405,headers:{...headers,allow:op.method}});
   if(url.search||url.hash)throw new CommunicationInputError('Invalid URL');
   // Bearer-only native calls cannot be authorized by an ambient cookie.
   const bearer=request.headers.get('authorization');
   if(typeof bearer!=='string'||bearer.length>8192||!/^Bearer [^\s]+$/i.test(bearer))throw new NativeVoiceHttpError(401);
   const appOrigin=request.headers.get('origin');
   if(appOrigin!==null&&!this.#appOrigins.has(appOrigin)||request.headers.get('sec-fetch-site')==='cross-site'&&appOrigin===null)throw deny();
   const session=await this.#current(request,op);
   if(request.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')return Response.json({error:'unsupported_media_type'},{status:415,headers});
   const declared=request.headers.get('content-length');let bytes;
   consumed=true;
   if(declared!==null){
    const size=/^[0-9]+$/.test(declared)?Number(declared):NaN;
    bytes=await this.readBoundedStream(request.body,size);
   }else bytes=await this.readBoundedBody(request.body);
   let input;try{input=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new CommunicationInputError('Invalid JSON');}
   if(validators['voice'+op.index+'_request'](input)!==true)throw new CommunicationInputError('Invalid voice command');
   // Body reading can suspend. Recheck the same current identity and grant
   // immediately before service invocation; body fields never supply identity.
   await this.#current(request,op,session);
   const raw=await this.#dispatch[op.key](session,Object.freeze(input));
   // Own validated service output before current-session I/O suspends. A
   // provider/service may reuse its object or audio buffer for another call.
   let result;
   if(op.key==='voicemail.audio'){
    const bytes=raw?.bytes;try{this.#audio.validateBytes(bytes);}catch{throw Error('Invalid audio response');}
    if(raw.contentType!=='audio/wav'||bytes.length<12||String.fromCharCode(...bytes.subarray(0,4))!=='RIFF'||String.fromCharCode(...bytes.subarray(8,12))!=='WAVE')throw Error('Invalid audio response');
    result={bytes:bytes.slice()};
   }else{
    if(op.key.startsWith('contact.')&&Object.hasOwn(raw??{},'error')||validators['voice'+op.index+'_response'](raw)!==true)throw Error('Invalid voice response');
    result=structuredClone(raw);
   }
   // Do not expose tokens or private audio after a session/grant changes.
   // A mutation may already have committed; failure never triggers a retry.
   await this.#current(request,op,session);
   if(op.key==='voicemail.audio'){
    return new Response(result.bytes,{headers:{...headers,'content-type':'audio/wav','content-length':String(result.bytes.length)}});
   }
   return Response.json(result,{headers});
  }catch(error){
   const status=error instanceof NativeVoiceHttpError?error.status:error instanceof CommunicationInputError?400:503;
   return Response.json({error:status===400?'invalid_voice_request':status===401?'unauthorized':status===403?'forbidden':'voice_unavailable'},{status,headers});
  }finally{
   if(!consumed)try{await request.body?.cancel();}catch{}
  }
 }
}

/** The same bounded native boundary, exposing only the three enrollment contracts.
 * No placeholder extension, voicemail, call-OTP or AI service is installed. */
export class NativeVoiceContactHttpAdapter extends NativeVoiceHttpAdapter {
 constructor({service,...options}){super({...options,_contactsOnly:true,_tasksOnly:false,maxAudioBytes:12,services:{contacts:service}});}
}

/** App approval only: uses the existing registered task contracts and current native identity. */
export class NativeVoiceTaskHttpAdapter extends NativeVoiceHttpAdapter {
 constructor({service,...options}){super({...options,_contactsOnly:false,_tasksOnly:true,maxAudioBytes:12,services:{confirmations:service}});}
}
