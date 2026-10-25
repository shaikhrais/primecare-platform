import {CommunicationResourceBase,BoundedBinaryAdapterBase} from './adapter-base.mjs';
const healthPattern=/^(?:relay_http_[1-5][0-9]{2}|relay_(?:configuration|request|body|payload|quota))$/;
const fail=(health='relay_request')=>Object.assign(Error('Call relay unavailable'),{communicationHealth:healthPattern.test(health)?health:'relay_request'});
const text=(v,max)=>typeof v==='string'&&v.length>=16&&v.length<=max&&!/[^\x21-\x7e]/.test(v);
/** Server-owned TURN key issues only expiring client credentials. No telephone
 * carrier or Twilio SDK is involved. Never expose the long-lived key to a client.
 */
export class CloudflareTurnProvider extends CommunicationResourceBase {
 #id;#token;#ttl;#fetch;#active=new Set();
 constructor({keyId,apiToken,ttlSeconds,fetch:request=globalThis.fetch}){
  super();if(!text(keyId,128)||!/^[A-Za-z0-9_-]+$/.test(keyId)||!text(apiToken,512)||!Number.isSafeInteger(ttlSeconds)||ttlSeconds<120||ttlSeconds>3600||typeof request!=='function')throw fail('relay_configuration');
  this.#id=keyId;this.#token=apiToken;this.#ttl=ttlSeconds;this.#fetch=request;this.registerCleanup(()=>{for(const c of this.#active)c.abort();this.#active.clear();this.#token='';});
 }
 async issue(){
  this.assertOpen();if(this.#active.size>=16)throw fail('relay_request');const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),8000),started=Date.now();this.#active.add(controller);let stage='relay_request';
  try{
   const response=await this.#fetch('https://rtc.live.cloudflare.com/v1/turn/keys/'+this.#id+'/credentials/generate-ice-servers',{method:'POST',redirect:'error',headers:{authorization:'Bearer '+this.#token,'content-type':'application/json',accept:'application/json'},body:JSON.stringify({ttl:this.#ttl}),signal:controller.signal});
   stage=response.status===201?'relay_body':'relay_http_'+response.status;
   if(response.status!==201||controller.signal.aborted){try{await response.body?.cancel();}catch{}throw fail(stage);}
   if(response.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')throw fail(stage);
   const bytes=await new BoundedBinaryAdapterBase(16384).readBoundedBody(response.body.pipeThrough(new TransformStream(),{signal:controller.signal})),payload=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));
   stage='relay_payload';
   if(!Array.isArray(payload?.iceServers)||payload.iceServers.length<1||payload.iceServers.length>4)throw fail(stage);let turn=false;
   const iceServers=payload.iceServers.map(server=>{
    if(!server||!Array.isArray(server.urls)||!server.urls.length||server.urls.length>12)throw fail(stage);
    const urls=server.urls.map(url=>{if(typeof url!=='string'||! /^(?:stun:stun\.cloudflare\.com:(?:3478|443)|turn:turn\.cloudflare\.com:(?:3478|443|80)\?transport=(?:udp|tcp)|turns:turn\.cloudflare\.com:(?:5349|443)\?transport=tcp)$/.test(url))throw fail(stage);return url;});
    if(urls.some(u=>u.startsWith('turn:')||u.startsWith('turns:'))){if(!text(server.username,512)||!text(server.credential,512))throw fail(stage);turn=true;return {urls,username:server.username,credential:server.credential};}
    return {urls};
   });
   this.assertOpen();const expiresAt=started+this.#ttl*1000;if(controller.signal.aborted||!turn||expiresAt<Date.now()+30000)throw fail(stage);return {iceServers,expiresAt};
  }catch(error){if(healthPattern.test(error?.communicationHealth??''))throw error;throw fail(stage);}finally{clearTimeout(timer);controller.abort();this.#active.delete(controller);}
 }
}
