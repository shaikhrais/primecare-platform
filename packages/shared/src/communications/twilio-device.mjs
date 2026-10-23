import {CommunicationResourceBase} from './adapter-base.mjs';

/** Unmounted Voice SDK lifecycle. The host supplies authenticated token transport
 * and a session-generation key that changes on logout/tenant/session changes.
 * A client scope key is lifecycle isolation, never server authorization.
 */
export class TwilioVoiceDevice extends CommunicationResourceBase {
 #device; #scope; #identity; #refreshing; #abort=new AbortController(); #timer;
 constructor({createDevice,fetchToken,currentScope,onIncoming=call=>call.reject(),onState=()=>{},registrationTimeoutMs=15000}) {
  super();
  if([createDevice,fetchToken,currentScope,onIncoming,onState].some(f=>typeof f!=='function')||!Number.isSafeInteger(registrationTimeoutMs)||registrationTimeoutMs<100||registrationTimeoutMs>60000)throw Error('Voice device ports required');
  this.createDevice=createDevice;this.fetchToken=fetchToken;this.currentScope=currentScope;
  this.onIncoming=onIncoming;this.onState=onState;this.registrationTimeoutMs=registrationTimeoutMs;this.state='idle';
  this.registerCleanup(()=>this.#abort.abort());
 }
 #current(){
  this.assertOpen();
  if(this.currentScope()!==this.#scope){this.close();throw Error('Voice session changed');}
 }
 #state(state){this.state=state;this.onState(state);}
 #listen(event,listener){
  this.#device.on(event,listener);
  this.registerCleanup(()=>this.#device.off(event,listener));
 }
 async #token(){
  this.#current();
  const started=Date.now(),result=await this.fetchToken({signal:this.#abort.signal});
  this.#current();
  if(!result||typeof result.token!=='string'||!result.token||result.token.length>16384||typeof result.identity!=='string'||!result.identity||!Number.isSafeInteger(result.ttlSeconds)||result.ttlSeconds<1||result.ttlSeconds>300||started+result.ttlSeconds*1000<=Date.now()||this.#identity&&result.identity!==this.#identity)throw Error('Voice token unavailable');
  this.#identity=result.identity;
  clearTimeout(this.#timer);
  // Fail closed at expiry even if SDK tokenWillExpire is never emitted.
  this.#timer=setTimeout(()=>this.close(),Math.max(1,started+result.ttlSeconds*1000-Date.now()));
  return result.token;
 }
 async start(){
  this.assertOpen();if(this.state!=='idle')throw Error('Voice device already started');
  this.#scope=this.currentScope();
  if(typeof this.#scope!=='string'||!this.#scope){this.close();throw Error('Voice session required');}
  try{
   this.#state('registering');const token=await this.#token();
   this.#device=this.createDevice(token);
   const device=this.#device;
   this.registerCleanup(()=>device.destroy());
   this.registerCleanup(()=>device.disconnectAll());
   if(!device||['on','off','register','updateToken','destroy','disconnectAll'].some(key=>typeof device[key]!=='function'))throw Error('Voice SDK device required');
   this.#listen('tokenWillExpire',()=>{void this.refresh().catch(()=>{});});
   this.#listen('incoming',call=>{
    try{this.#current();if(this.state!=='registered')throw Error('Voice unavailable');
     // The host must close the resource on auth changes and separately authorize
     // call actions. Never automatically answer a ringing call.
     const result=this.onIncoming(call);
     Promise.resolve(result).catch(()=>{try{call.reject();}finally{this.close();}});
    }catch{try{call.reject();}finally{this.close();}}
   });
   await new Promise((resolve,reject)=>{
    const timeout=setTimeout(()=>reject(Error('Voice registration timed out')),this.registrationTimeoutMs);
    let settled=false;
    const finish=(error)=>{if(settled)return;settled=true;clearTimeout(timeout);error?reject(error):resolve();};
    this.registerCleanup(()=>finish(Error('Voice device closed')));
    this.#listen('registered',()=>{try{this.#current();this.#state('registered');finish();}catch{finish(Error('Voice unavailable'));this.close();}});
    this.#listen('error',()=>{finish(Error('Voice device unavailable'));this.close();});
    this.#listen('unregistered',()=>{finish(Error('Voice device unregistered'));this.close();});
    this.#listen('destroyed',()=>{finish(Error('Voice device destroyed'));this.close();});
    Promise.resolve().then(()=>{this.#current();return device.register();}).catch(()=>{finish(Error('Voice registration failed'));this.close();});
   });
   this.#current();
  }catch{this.close();throw Error('Voice device unavailable');}
 }
 refresh(){
  if(this.#refreshing)return this.#refreshing;
  this.#refreshing=(async()=>{
   try{this.#current();if(!this.#device||this.state!=='registered')throw Error('Voice unavailable');
    const token=await this.#token();this.#current();await this.#device.updateToken(token);this.#current();
   }catch{this.close();throw Error('Voice token unavailable');}
  })().finally(()=>{this.#refreshing=null;});
  return this.#refreshing;
 }
 afterClose(){clearTimeout(this.#timer);this.#device=undefined;this.#identity=undefined;this.#state('closed');}
}
