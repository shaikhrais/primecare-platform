import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
/** Bounded Workers transport for the official Verify SDK. Fixed service, URL,
 * credentials and two POST forms only. No redirects, retries or provider logs. */
export class TwilioVerifyFetchClient extends BoundedBinaryAdapterBase {
 #service;#key;#secret;#fetch;
 constructor({serviceSid,apiKeySid,apiKeySecret,fetch:transport=globalThis.fetch}){
  super(16384);
  if(!/^VA[a-f0-9]{32}$/i.test(serviceSid)||!/^SK[a-f0-9]{32}$/i.test(apiKeySid)||! /^[a-f0-9]{32}$/i.test(apiKeySecret)||typeof transport!=='function')throw Error('Verify transport configuration required');
  this.#service=serviceSid;this.#key=apiKeySid;this.#secret=apiKeySecret;this.#fetch=transport;
 }
 async request(options){
  const base='https://verify.twilio.com/v2/Services/'+this.#service;
  if(!options||options.method!=='post'||options.username!==this.#key||options.password!==this.#secret||!options.data||typeof options.data!=='object'||Array.isArray(options.data)||options.params&&Object.keys(options.params).length)throw Error('Verify transport denied');
  const data={...options.data},keys=Object.keys(data).sort().join(',');
  if(options.uri===base+'/Verifications'){
   if(keys!=='Channel,To'||data.Channel!=='sms'||typeof data.To!=='string'||data.To.length>16||data.To!==data.To.trim()||!/^\+[1-9][0-9]{6,14}$/.test(data.To))throw Error('Verify transport denied');
  }else if(options.uri===base+'/VerificationCheck'){
   if(keys!=='Code,VerificationSid'||typeof data.Code!=='string'||data.Code.length!==6||!/^\d{6}$/.test(data.Code)||!/^VE[a-f0-9]{32}$/i.test(data.VerificationSid))throw Error('Verify transport denied');
  }else throw Error('Verify transport denied');
  const response=await this.#fetch(options.uri,{method:'POST',redirect:'error',signal:AbortSignal.timeout(10000),headers:{authorization:'Basic '+btoa(this.#key+':'+this.#secret),'content-type':'application/x-www-form-urlencoded',accept:'application/json'},body:new URLSearchParams(data).toString()});
  if(response.status!==200&&response.status!==201){try{await response.body?.cancel();}catch{}throw Error('Verify provider unavailable');}
  const type=response.headers.get('content-type')?.split(';')[0].trim().toLowerCase();
  if(type!=='application/json'){await response.body?.cancel();throw Error('Verify provider unavailable');}
  const declared=response.headers.get('content-length');
  const bytes=declared===null?await this.readBoundedBody(response.body):await this.readBoundedStream(response.body,/^[0-9]+$/.test(declared)?Number(declared):NaN);
  return {statusCode:response.status,headers:{'content-type':'application/json'},body:new TextDecoder('utf-8',{fatal:true}).decode(bytes)};
 }
}
