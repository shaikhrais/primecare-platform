import {CommunicationResourceBase,BoundedBinaryAdapterBase} from './adapter-base.mjs';
const fail=()=>Error('Voiceprint provider unavailable');
const name=bytes=>String.fromCharCode(...bytes);
/** Shared bounded audio/resource base for genuine speaker verification engines.
 * No transcript, LLM judgment, caller ID or browser-reported score is accepted.
 * This first capture contract accepts canonical mono PCM16 WAV only. */
export class VoiceprintProviderBase extends CommunicationResourceBase {
 audio(bytes){
  this.assertOpen();if(!(bytes instanceof Uint8Array)||bytes.length<44||bytes.length>1920044)throw fail();bytes=bytes.slice();
  const v=new DataView(bytes.buffer,bytes.byteOffset,bytes.byteLength);
  if(name(bytes.subarray(0,4))!=='RIFF'||v.getUint32(4,true)!==bytes.length-8||name(bytes.subarray(8,12))!=='WAVE'||name(bytes.subarray(12,16))!=='fmt '||v.getUint32(16,true)!==16||v.getUint16(20,true)!==1||v.getUint16(22,true)!==1||v.getUint16(34,true)!==16||name(bytes.subarray(36,40))!=='data'||v.getUint32(40,true)!==bytes.length-44)throw fail();
  const rate=v.getUint32(24,true),size=bytes.length-44;
  if(![8000,16000].includes(rate)||v.getUint32(28,true)!==rate*2||v.getUint16(32,true)!==2||size%2||size<rate*2*3||size>rate*2*60)throw fail();
  return bytes;
 }
 subject(value){this.assertOpen();if(typeof value!=='string'||!/^pc-[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(value))throw fail();return value;}
 async enroll(){throw fail();}async verify(){throw fail();}async remove(){throw fail();}
}
/** Documented Aculab Users API. Host config pins region, user group and
 * nonnegative sensitivity. Audio uploads only; no arbitrary recording URLs.
 * No retries, redirects or provider error bodies leave this resource. */
export class AculabVoiceprintProvider extends VoiceprintProviderBase {
 #origin;#auth;#fetch;#sensitivity;#active=new Set();
 constructor({cloudId,username,groupKey,sensitivity,fetch:request=globalThis.fetch}){
  super();
  if(typeof cloudId!=='string'||!/^\d{1,3}-\d{1,3}-\d{1,3}$/.test(cloudId)||typeof username!=='string'||!username.trim()||username.length>200||/[:\x00-\x20\x7f-\uffff]/.test(username)||typeof groupKey!=='string'||groupKey.length<16||groupKey.length>512||/[^\x21-\x7e]/.test(groupKey)||!Number.isFinite(sensitivity)||sensitivity<0||sensitivity>10||typeof request!=='function')throw fail();
  this.#origin='https://ws-'+cloudId+'.aculabcloud.net';this.#auth='Basic '+btoa(cloudId+'/'+username+':'+groupKey);this.#fetch=request;this.#sensitivity=sensitivity;
  this.registerCleanup(()=>{for(const c of this.#active)c.abort();this.#active.clear();this.#auth='';});
 }
 async #request(operation,subject,bytes,signal){
  this.subject(subject);if(!signal||signal.aborted||this.#active.size>=4)throw fail();
  const url=new URL(this.#origin+'/voice_biometrics/v1/user/'+operation);url.searchParams.set('user_id',subject);
  if(operation==='verify'){url.searchParams.set('enable_pad','true');url.searchParams.set('text_dependent','true');url.searchParams.set('sensitivity',String(this.#sensitivity));}
  const controller=new AbortController(),abort=()=>controller.abort();this.#active.add(controller);signal.addEventListener('abort',abort,{once:true});const timer=setTimeout(abort,12000);
  try{
   const send=this.#fetch;
   const response=await send(url.href,{method:operation==='delete'?'POST':'PUT',redirect:'manual',headers:{authorization:this.#auth,accept:'application/json',...(bytes?{'content-type':'audio/wav'}:{})},...(bytes?{body:bytes}:{}),signal:controller.signal});
   if(!response.ok||controller.signal.aborted){try{await response.body?.cancel();}catch{}throw fail();}
   if(response.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')throw fail();
   const reader=new BoundedBinaryAdapterBase(8192),body=await reader.readBoundedBody(response.body.pipeThrough(new TransformStream(),{signal:controller.signal}));
   const result=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(body));this.assertOpen();
   if(controller.signal.aborted||!result||typeof result!=='object'||Array.isArray(result)||Object.hasOwn(result,'error')||typeof result.transaction_id!=='string'||!/^[A-Za-z0-9.-]{1,160}$/.test(result.transaction_id))throw fail();return result;
  }catch{throw fail();}finally{clearTimeout(timer);signal.removeEventListener('abort',abort);controller.abort();this.#active.delete(controller);}
 }
 async enroll({subject,audio,signal}){
  const bytes=this.audio(audio);if(bytes.length-44<new DataView(bytes.buffer).getUint32(24,true)*20)throw fail();
  const result=await this.#request('register',subject,bytes,signal);
  if(typeof result.application_instance_id!=='string'||!result.application_instance_id||result.application_instance_id.length>160)throw fail();return Object.freeze({enrolled:true,receipt:result.transaction_id});
 }
 async verify({subject,audio,signal}){
  const result=await this.#request('verify',subject,this.audio(audio),signal);
  if(typeof result.verified!=='boolean'||!Number.isFinite(result.confidence))throw fail();
  // Some responses/documentation use PAD_detected capitalization. Any presence,
  // including malformed/null, fails closed rather than accepting verified:true.
  const spoofed=Object.keys(result).some(k=>k.toLowerCase()==='pad_detected');
  return Object.freeze({matched:result.verified===true&&result.confidence>=1&&!spoofed,spoofed,receipt:result.transaction_id});
 }
 async remove({subject,signal}){
  const result=await this.#request('delete',subject,undefined,signal);
  if(result.user_id!==subject||typeof result.deleted!=='string'||!/^\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}$/.test(result.deleted))throw fail();return Object.freeze({deleted:true,receipt:result.transaction_id});
 }
}
