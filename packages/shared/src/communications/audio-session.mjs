import {CommunicationResourceBase} from './adapter-base.mjs';
import {BrowserAudioCall} from './audio-call.mjs';

/** Connects accepted server calls to browser media through an authenticated channel transport.
 * IDs select records; the transport/server still owns identity and authorization.
 * No routes, credentials, role grants or timers survive close().
 */
export class BrowserAudioSession extends CommunicationResourceBase {
 constructor({transport,userId,threadId,callId,media,intervalMilliseconds=1000,onError=()=>{},key=()=>crypto.randomUUID()}) {
  super();
  if(typeof transport?.execute!=='function'||[userId,threadId,callId].some(value=>typeof value!=='string'||!value.trim())||!Number.isSafeInteger(intervalMilliseconds)||intervalMilliseconds<100||typeof key!=='function'||typeof onError!=='function')throw Error('Audio session adapters required');
  this.transport=transport;this.userId=userId;this.threadId=threadId;this.callId=callId;
  this.intervalMilliseconds=intervalMilliseconds;this.onError=onError;this.key=key;
  this.lastSequence=0;this.writes=Promise.resolve();this.refreshing=null;this.started=false;this.starting=false;
  this.audio=new BrowserAudioCall({...media,sendSignal:signal=>this.sendSignal(signal),onState:state=>{
   try{media?.onState?.(state);}finally{if(state==='closed')this.close();}
  }});
  this.registerCleanup(()=>this.audio.close());
 }
 async current() {
  this.assertOpen();
  const record=await this.transport.execute('message',{action:'read',id:this.threadId});
  this.assertOpen();
  return this.validateCurrent(record);
 }
 validateCurrent(record) {
  const call=Array.isArray(record?.calls)?record.calls.find(value=>value.id===this.callId):null;
  if(record?.id!==this.threadId||record.kind!=='conversation'||!Array.isArray(record.members)||!record.members.includes(this.userId)||!Number.isSafeInteger(record.version)||record.version<1||!call||![call.callerId,call.recipientId].includes(this.userId))throw Error('Call unavailable');
  return {record,call};
 }
 async start() {
  this.assertOpen();if(this.started||this.starting)throw Error('Audio session already started');
  this.starting=true;
  try {
   const before=await this.current();if(before.call.status!=='accepted')throw Error('Call not accepted');
   // A reloaded caller cannot replay an offer whose original peer was lost.
   if(before.call.callerId===this.userId&&before.call.offered||before.call.recipientId===this.userId&&before.call.answered)throw Error('Call media already negotiated');
   await this.audio.start();
   const after=await this.current();if(after.call.status!=='accepted')throw Error('Call not accepted');
   this.started=true;
   if(after.call.callerId===this.userId)await this.audio.offer();
   await this.refresh();this.schedule();
  }catch(error){this.close();throw error;}finally{this.starting=false;}
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
   if(entry.actorId!==this.userId)await this.audio.receive(entry.signal);
   this.lastSequence=entry.sequence;
  }
  if(previous<this.lastSequence)throw Error('Call signaling regressed');
 }
 enqueue(operation) {
  const result=this.writes.then(()=>{this.assertOpen();return operation();});
  // Retain ordering without hiding rejection from the caller.
  this.writes=result.catch(()=>{});return result;
 }
 sendSignal(signal) {
  return this.enqueue(async()=>{
   for(let attempt=0;attempt<3;attempt++){
    const {record,call}=await this.current();if(call.status!=='accepted')throw Error('Call not accepted');
    try{
     return await this.transport.execute('audio',{action:'signal',id:this.threadId,key:this.key(),version:record.version,callId:this.callId,signal});
    }catch(error){
     // Only an explicit transactional conflict may be retried. Network failures
     // and ambiguous success never trigger another command.
     if(error?.status!==409||attempt===2)throw error;
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
 afterClose() {clearTimeout(this.timer);this.timer=null;}
}
