import {CommunicationResourceBase} from './adapter-base.mjs';
import {BrowserAudioCall} from './audio-call.mjs';

/** Connects accepted server calls to browser media through an authenticated channel transport.
 * IDs select records; the transport/server still owns identity and authorization.
 * No routes, credentials, role grants or timers survive close().
 */
export class BrowserAudioSession extends CommunicationResourceBase {
 constructor({transport,userId,threadId,callId,media,configurationProvider,preparationProvider,preparationReader,onTiming=()=>{},intervalMilliseconds=1000,onError=()=>{},key=()=>crypto.randomUUID()}) {
  super();
  if(typeof transport?.execute!=='function'||[userId,threadId,callId].some(value=>typeof value!=='string'||!value.trim())||!Number.isSafeInteger(intervalMilliseconds)||intervalMilliseconds<100||typeof key!=='function'||typeof onError!=='function')throw Error('Audio session adapters required');
  if(configurationProvider!==undefined&&typeof configurationProvider!=='function')throw Error('Media configuration provider required');
  this.preparationReader=preparationReader;this.onTiming=onTiming;this.preparationProvider=preparationProvider;this.preparedUntil=0;this.preparing=null;
  this.configurationProvider=configurationProvider;this.configurationTimer=null;
  this.transport=transport;this.userId=userId;this.threadId=threadId;this.callId=callId;
  this.intervalMilliseconds=intervalMilliseconds;this.onError=onError;this.key=key;
  this.conflictWait=null;this.signalVersion=0;this.lastSequence=0;this.writes=Promise.resolve();this.refreshing=null;this.started=false;this.starting=false;
  this.audio=new BrowserAudioCall({...media,onTiming:(stage,at)=>this.onTiming(stage,at),sendSignal:signal=>this.sendSignal(signal),onState:state=>{
   try{media?.onState?.(state);}finally{if(state==='closed')this.close();}
  }});
  this.registerCleanup(()=>this.audio.close());
 }
 async current() {
  this.assertOpen();
  const record=this.preparedUntil&&this.preparationReader?await this.preparationReader():await this.transport.execute('message',{action:'read',id:this.threadId});
  this.assertOpen();
  const current=this.validateCurrent(record);this.signalVersion=Math.max(this.signalVersion,current.record.version);return current;
 }
 validateCurrent(record) {
  const call=Array.isArray(record?.calls)?record.calls.find(value=>value.id===this.callId):null;
  if(record?.id!==this.threadId||record.kind!=='conversation'||!Array.isArray(record.members)||!record.members.includes(this.userId)||!Number.isSafeInteger(record.version)||record.version<1||!call||![call.callerId,call.recipientId].includes(this.userId))throw Error('Call unavailable');
  return {record,call};
 }
 mark(stage){try{this.onTiming(stage,performance.now());}catch{}}
 async prepare(){
  this.assertOpen();if(this.started||this.starting||this.preparing||typeof this.preparationProvider!=='function'||typeof this.preparationReader!=='function')throw Error('Preparation unavailable');
  this.preparing=(async()=>{this.mark('prepare_start');const before=await this.current();if(!['ringing','accepted'].includes(before.call.status))throw Error('Call not accepted');
   const configuration=structuredClone(await this.preparationProvider());this.assertOpen();
   if(!Array.isArray(configuration?.iceServers)||!configuration.iceServers.length||!Number.isSafeInteger(configuration.expiresAt)||configuration.expiresAt<Date.now()+30000||configuration.expiresAt>Date.now()+1800000)throw Error('Media preparation unavailable');
   const after=await this.current();if(!['ringing','accepted'].includes(after.call.status)||after.call.callerId!==before.call.callerId||after.call.recipientId!==before.call.recipientId)throw Error('Call not accepted');
   this.audio.configure({...this.audio.configuration,iceServers:configuration.iceServers,iceCandidatePoolSize:1});this.audio.prepare();this.preparedUntil=configuration.expiresAt;this.mark('prepare_ready');
  })();try{await this.preparing;}catch(error){this.close();throw error;}finally{this.preparing=null;}
 }
 async start() {
  this.assertOpen();if(this.started||this.starting)throw Error('Audio session already started');
  this.starting=true;
  try {
   this.mark('start');if(this.preparing)await this.preparing;
   const before=await this.current();this.mark('acceptance_checked');if(before.call.status!=='accepted')throw Error('Call not accepted');
   // A reloaded caller cannot replay an offer whose original peer was lost.
   if(before.call.callerId===this.userId&&before.call.offered||before.call.recipientId===this.userId&&before.call.answered)throw Error('Call media already negotiated');
   // Reuse the check just completed, with no intervening await. The provider
   // result is still followed by a fresh accepted-call read before microphone.
   if(!this.preparedUntil||this.preparedUntil<Date.now()+60000)await this.#applyConfiguration(before);
   else {clearTimeout(this.configurationTimer);this.configurationTimer=setTimeout(()=>{this.refreshConfiguration().catch(error=>{if(!this.closed)this.fail(error);});},Math.max(1000,this.preparedUntil-Date.now()-60000));}
   await this.audio.start();
   const after=await this.current();this.mark('microphone_acceptance_checked');if(after.call.status!=='accepted')throw Error('Call not accepted');
   this.started=true;
   if(after.call.callerId===this.userId)await this.audio.offer();
   await this.refresh();this.schedule();
  }catch(error){this.close();throw error;}finally{this.starting=false;}
 }
 async refreshConfiguration(){
  if(!this.configurationProvider)return;this.assertOpen();
  const before=await this.current();return this.#applyConfiguration(before);
 }
 async #applyConfiguration(before){
  if(!this.configurationProvider)return;this.assertOpen();
  if(before.call.status!=='accepted')throw Error('Call not accepted');
  const result=structuredClone(await this.configurationProvider());this.assertOpen();
  if(!Array.isArray(result?.iceServers)||!result.iceServers.length||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<Date.now()+30000||result.expiresAt>Date.now()+3600000)throw Error('Media configuration unavailable');
  const after=await this.current();if(after.call.status!=='accepted'||before.call.callerId!==after.call.callerId||before.call.recipientId!==after.call.recipientId)throw Error('Call not accepted');
  this.audio.configure({...this.audio.configuration,iceServers:result.iceServers});
  clearTimeout(this.configurationTimer);this.configurationTimer=setTimeout(()=>{this.configurationTimer=null;this.refreshConfiguration().catch(error=>{if(!this.closed)this.fail(error);});},Math.max(1000,result.expiresAt-Date.now()-60000));
 }
 schedule() {
  if(this.closed||this.timer)return;
  this.timer=setTimeout(async()=>{
   this.timer=null;
   try{await this.refresh();this.schedule();}catch{ /* refresh reports failures before cleanup */ }
  },this.intervalMilliseconds);
 }
 fail(error) {this.close();this.onError(error);}
 /** Call explicitly for push notifications; concurrent refreshes share one operation. */
 refresh() {
  if(this.refreshing)return this.refreshing;
  this.refreshing=this.refreshOnce().catch(error=>{if(!this.closed)this.fail(error);throw error;}).finally(()=>{this.refreshing=null;});
  return this.refreshing;
 }
 async refreshOnce() {
  const {call}=await this.current();
  if(call.status!=='accepted'){this.close();return;}
  if(!this.started)return;
  const signals=call.signals??[];
  if(!Array.isArray(signals))throw Error('Invalid call signaling');
  let previous=0;
  for(const entry of signals){
   if(!Number.isSafeInteger(entry.sequence)||entry.sequence!==previous+1||![call.callerId,call.recipientId].includes(entry.actorId))throw Error('Invalid call signaling');
   previous=entry.sequence;
   if(entry.sequence<=this.lastSequence)continue;
   this.assertOpen();
   if(entry.actorId!==this.userId){
    // The registered channel uses `ice`; the browser adapter uses native
    // candidate terminology. Keep the conversion at this shared boundary.
    const signal=entry.signal;
    if(!signal||!['offer','answer','ice'].includes(signal.type))throw Error('Invalid call signaling');
    await this.audio.receive(signal.type==='ice'?{...signal,type:'candidate'}:signal);
   }
   this.lastSequence=entry.sequence;
  }
  if(previous<this.lastSequence)throw Error('Call signaling regressed');
 }
 enqueue(operation) {
  const result=this.writes.then(()=>{this.assertOpen();return operation();});
  // Retain ordering without hiding rejection from the caller.
  this.writes=result.catch(()=>{});return result;
 }
 /** Yield to the other peer's candidate burst before re-reading a conflicted
  * aggregate. At most two waits; closure cancels the pending timer immediately. */
 waitForConflict(attempt) {
  this.assertOpen();
  return new Promise((resolve,reject)=>{
   const timer=setTimeout(()=>{this.conflictWait=null;resolve();},25*(attempt+1)+Math.floor(Math.random()*25));
   this.conflictWait=()=>{clearTimeout(timer);reject(Error('Communication resource closed'));};
  });
 }
 sendSignal(signal) {
  return this.enqueue(async()=>{
   for(let attempt=0;attempt<3;attempt++){
    // The version is only a concurrency hint. The server still checks the
    // current session, permissions and accepted call on every write.
    if(!this.signalVersion||attempt>0){const {call}=await this.current();if(call.status!=='accepted')throw Error('Call not accepted');}
    const version=this.signalVersion;
    try{
     const result=await this.transport.execute('audio',{action:'signal',id:this.threadId,key:this.key(),version,callId:this.callId,signal:signal?.type==='candidate'?{...signal,type:'ice'}:signal});
     if(result?.id!==this.threadId||!Number.isSafeInteger(result.version)||result.version!==version+1)throw Error('Invalid signal acknowledgement');
     this.signalVersion=Math.max(this.signalVersion,result.version);return result;
    }catch(error){
     // Only an explicit transactional conflict may be retried. Network failures
     // and ambiguous success never trigger another command.
     if(error?.status!==409||attempt===2)throw error;
     await this.waitForConflict(attempt);
    }
   }
  }).catch(error=>{if(!this.closed)this.fail(error);throw error;});
 }
 /** Release local media immediately, then attempt one explicit server hang-up. */
 async hangUp() {
  if(this.closed)return;
  this.close();await this.writes;
  const {record,call}=this.validateCurrent(await this.transport.execute('message',{action:'read',id:this.threadId}));
  if(['ringing','accepted'].includes(call.status))await this.transport.execute('audio',{action:'end',id:this.threadId,key:this.key(),version:record.version,callId:this.callId});
 }
 mute(muted) {this.assertOpen();this.audio.mute(muted);}
 afterClose() {clearTimeout(this.configurationTimer);this.configurationTimer=null;clearTimeout(this.timer);this.timer=null;this.conflictWait?.();this.conflictWait=null;}
}
