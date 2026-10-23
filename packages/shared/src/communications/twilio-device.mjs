import {CommunicationResourceBase} from './adapter-base.mjs';

/** Own an incoming call before asynchronous host UI construction completes.
 * A late panel is disposed even after cancellation or a newer offer. */
class IncomingVoiceOffer extends CommunicationResourceBase {
 #session;#accepted=false;#ended=false;
 constructor(call){
  super();if(!call||['on','off','reject','disconnect'].some(key=>typeof call[key]!=='function'))throw Error('Incoming call required');
  this.registerCleanup(()=>{if(this.#session)this.#session.close();else if(!this.#ended){if(this.#accepted)call.disconnect();else call.reject();}});
  const accept=()=>{this.#accepted=true;};call.on('accept',accept);this.registerCleanup(()=>call.off('accept',accept));
  for(const event of ['cancel','disconnect','reject','error']){
   const end=()=>{this.#ended=event!=='error';this.close();};call.on(event,end);this.registerCleanup(()=>call.off(event,end));
  }
 }
 get available(){return !this.closed&&!this.#session?.closed;}
 adopt(session){
  if(!session||typeof session.close!=='function'||typeof session.closed!=='boolean'){this.close();return;}
  if(this.closed||session.closed){try{session.close();}finally{this.close();}return;}
  this.#session=session;
 }
}

/** Unmounted Voice SDK lifecycle. The host supplies authenticated token transport
 * and a session-generation key that changes on logout/tenant/session changes.
 * A client scope key is lifecycle isolation, never server authorization.
 */
export class TwilioVoiceDevice extends CommunicationResourceBase {
 #device; #incomingSession; #call; #connecting=false; #scope; #identity; #refreshing; #abort=new AbortController(); #timer;
 constructor({createDevice,fetchToken,currentScope,onIncoming=()=>{},onState=()=>{},registrationTimeoutMs=15000}) {
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
    let offer;
    try{this.#current();if(this.state!=='registered')throw Error('Voice unavailable');
     // Own the raw call before host code can suspend, close or replace scope.
     if(this.#connecting||this.#call||this.#incomingSession?.available){call.reject();return;}
     this.#incomingSession?.close();offer=new IncomingVoiceOffer(call);this.#incomingSession=offer;
     const complete=session=>{
      // A late result belongs to this offer, never the next incoming call.
      try{this.#current();}catch{offer.close();}
      offer.adopt(session);
     };
     const result=this.onIncoming(call);
     if(result&&typeof result.then==='function')Promise.resolve(result).then(complete).catch(()=>{
      const active=this.#incomingSession===offer&&offer.available;offer.close();if(active)this.close();
     });else complete(result);
    }catch{try{if(offer)offer.close();else call.reject();}finally{this.close();}}
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
 /** Calls only a six-digit extension; the server resolves and authorizes both ends. */
 async connect({callerExtension,targetExtension}){
  this.assertOpen();
  if(this.state!=='registered'||this.#connecting||this.#call||this.#incomingSession?.available||![callerExtension,targetExtension].every(value=>typeof value==='string'&&/^[1-9][0-9]{5}$/.test(value))||callerExtension===targetExtension||typeof this.#device?.connect!=='function')throw Error('Voice call unavailable');
  this.#current();this.#connecting=true;
  try{
   const call=await this.#device.connect({params:{CallerExtension:callerExtension,TargetExtension:targetExtension}});
   // A call may arrive after logout already destroyed the Device.
   if(this.closed||this.currentScope()!==this.#scope){try{call.disconnect();}finally{this.close();}throw Error('Voice call unavailable');}
   if(!call||typeof call.disconnect!=='function'||typeof call.on!=='function'||typeof call.off!=='function')throw Error('Voice call unavailable');
   this.#call=call;
   const release=()=>{for(const event of ['disconnect','cancel'])call.off(event,release);call.off('error',failed);if(this.#call===call)this.#call=null;if(this.callCleanup===cleanup)this.callCleanup=null;};
   const failed=()=>{release();try{call.disconnect();}catch{try{this.close();}catch{/* Device cleanup has run; contain display callback failures. */}}};
   const cleanup=()=>{release();call.disconnect();};
   for(const event of ['disconnect','cancel'])call.on(event,release);call.on('error',failed);
   // Resource owns at most one call; released calls remove their own listeners.
   this.callCleanup=cleanup;
   return call;
  }catch{this.close();throw Error('Voice call unavailable');}finally{this.#connecting=false;}
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
 afterClose(){try{this.#incomingSession?.close();}catch{}this.#incomingSession=undefined;try{this.callCleanup?.();}catch{}this.callCleanup=null;clearTimeout(this.#timer);this.#device=undefined;this.#identity=undefined;this.#state('closed');}
}
