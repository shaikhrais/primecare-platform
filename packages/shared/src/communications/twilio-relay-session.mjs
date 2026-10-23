import {validateRequest} from 'twilio/lib/webhooks/webhooks.js';
import {BoundedBinaryAdapterBase,CommunicationResourceBase} from './adapter-base.mjs';
import {twilioSid,twilioPublicUrl} from './twilio-webhook.mjs';
import {sameAgentIdentity,verifiedAgentIdentity} from './twilio-agent-start.mjs';
const capability=Symbol('validated relay upgrade'),bytes=value=>new TextEncoder().encode(value).length;
const intentId=value=>typeof value==='string'&&value.length===36&&/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value);
const taskId=value=>typeof value==='string'&&value.length<=80&&value.trim()===value&&/^[a-z][a-z0-9_.]+$/.test(value);
/** Owns a provider socket, turn cancellation, bounded text and call-bound tools.
 * Created only by the signed upgrade adapter. No model can approve an action. */
export class TwilioRelaySession extends CommunicationResourceBase {
 #socket;#options;#state='setup';#binding;#callSid;#text='';#turn;#turns=0;#setupTimer;#expiryTimer;#auditTimer;#auditing=null;#intents=new Set();#model;#executing=new Set();
 constructor(key,socket,options){
  super();if(key!==capability)throw Error('Signed upgrade required');
  this.#socket=socket;this.#options=options;
  const message=event=>{void this.receive(event.data).catch(()=>{});},ended=()=>this.close();
  for(const [event,listener]of [['message',message],['close',ended],['error',ended]]){socket.addEventListener(event,listener);this.registerCleanup(()=>socket.removeEventListener(event,listener));}
  this.registerCleanup(()=>{this.#abortTurn();clearTimeout(this.#setupTimer);clearTimeout(this.#expiryTimer);clearTimeout(this.#auditTimer);this.#text='';this.#binding=null;this.#intents.clear();this.#executing.clear();socket.close(1000,'Session ended');});
  this.#setupTimer=setTimeout(()=>this.#end(),5000);this.#setupTimer.unref?.();
 }
 get state(){return this.#state;}
 #send(value){this.assertOpen();if(Number(this.#socket.bufferedAmount??0)>16384)throw Error('Output unavailable');this.#socket.send(JSON.stringify(value));}
 #abortTurn(){if(this.#turn){clearTimeout(this.#turn.timer);this.#turn.controller.abort();this.#turn=null;}}
 #end(){if(this.closed)return;try{this.#send({type:'end',handoffData:'{"reasonCode":"reception"}'});}catch{}this.close();}
 async #current(){this.assertOpen();const binding=verifiedAgentIdentity(await this.#options.guard.current(this.#callSid));this.assertOpen();if(!sameAgentIdentity(binding,this.#binding))throw Error('Session changed');return binding;}
 #active(turn){this.assertOpen();if(this.#turn!==turn||turn.controller.signal.aborted)throw Error('Turn ended');}
 #audit(){if(this.closed)return;this.#auditTimer=setTimeout(()=>{this.#auditTimer=null;void this.refresh().then(()=>this.#audit()).catch(()=>{});},5000);this.#auditTimer.unref?.();}
 /** Host may invoke on native logout/revocation notifications, or close immediately. */
 refresh(){if(this.#auditing)return this.#auditing;this.#auditing=this.#current().catch(()=>{this.#end();throw Error('Voice session unavailable');}).finally(()=>{this.#auditing=null;});return this.#auditing;}
 async #setup(event){
  if(this.#state!=='setup'||event.accountSid!==this.#options.accountSid||!twilioSid('CA',event.callSid)||!twilioSid('VX',event.sessionId)||event.to!==this.#options.sharedNumber||event.direction!=='inbound')throw Error('Invalid setup');
  this.#state='binding';const callSid=event.callSid,binding=verifiedAgentIdentity(await this.#options.guard.current(callSid));this.assertOpen();
  const expiresAt=Math.min(Date.now()+120000,binding.expiresAt),claimId=await this.#options.claims.claim({callSid,providerSessionId:event.sessionId,identity:binding,expiresAt});
  if(!intentId(claimId))throw Error('Call already bound');this.registerCleanup(()=>{void this.#options.claims.finish(claimId).catch(()=>{});});this.assertOpen();
  const current=verifiedAgentIdentity(await this.#options.guard.current(callSid));this.assertOpen();if(!sameAgentIdentity(binding,current))throw Error('Session changed');
  const model=await this.#options.createModel(Object.freeze({callSid,userId:binding.actor.id,tenantId:binding.actor.tenantId}));
  if(typeof model?.respond!=='function'||typeof model?.close!=='function')throw Error('Model ports required');this.registerCleanup(()=>model.close());this.assertOpen();const final=verifiedAgentIdentity(await this.#options.guard.current(callSid));this.assertOpen();if(!sameAgentIdentity(binding,final))throw Error('Session changed');this.#model=model;
  this.#callSid=callSid;this.#binding=binding;this.#state='ready';clearTimeout(this.#setupTimer);
  this.#expiryTimer=setTimeout(()=>this.#end(),Math.min(120000,Math.max(0,binding.expiresAt-Date.now())));this.#expiryTimer.unref?.();this.#audit();
 }
 async #prompt(event){
  if(this.#state!=='ready'||typeof event.voicePrompt!=='string'||typeof event.last!=='boolean'||/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(event.voicePrompt)||bytes(this.#text+event.voicePrompt)>4000)throw Error('Invalid prompt');
  this.#text+=event.voicePrompt;if(!event.last)return;if(!this.#text.trim())throw Error('Empty prompt');if(++this.#turns>50)throw Error('Turn limit');
  const text=this.#text;this.#text='';this.#state='thinking';const turn={controller:new AbortController(),tools:0};this.#turn=turn;turn.timer=setTimeout(()=>{if(this.#turn===turn)this.#end();},15000);turn.timer.unref?.();
  const invoke=async(method,...args)=>{
   this.#active(turn);if(++turn.tools>4)throw Error('Tool limit');await this.#current();this.#active(turn);
   try{const result=await this.#options.tasks[method](this.#callSid,...args);this.#active(turn);return result;}catch(error){if(error?.code==='VOICE_TASK_CONFIRMATION_REQUIRED')throw Object.assign(Error('App confirmation required'),{code:'VOICE_TASK_CONFIRMATION_REQUIRED'});throw Error('Task unavailable; check status in the app');}
  };
  const tools=Object.freeze({propose:async(id,args)=>{
   if(!this.#options.taskIds.includes(id)||this.#intents.size>=50)throw Error('Task not allowed');
   const result=await invoke('propose',id,args);
   if(!intentId(result?.intentId)||typeof result.summary!=='string'||result.summary.length>1000||typeof result.digest!=='string'||result.digest.length!==64||!/^[a-f0-9]{64}$/.test(result.digest)||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<=Date.now())throw Error('Task unavailable');
   this.#intents.add(result.intentId);return Object.freeze({intentId:result.intentId,summary:result.summary,digest:result.digest,expiresAt:result.expiresAt,requiresConfirmation:true});
  },execute:async id=>{
   this.#active(turn);if(!intentId(id)||!this.#intents.has(id)||this.#executing.has(id))throw Error('Task not allowed');
   this.#executing.add(id);
   try{const result=await invoke('execute',id);this.#intents.delete(id);if(result?.status!=='completed')throw Error('Task outcome unavailable');return Object.freeze({status:'completed'});}
   catch(error){if(error?.code==='VOICE_TASK_CONFIRMATION_REQUIRED')return Object.freeze({status:'awaiting_confirmation'});this.#intents.delete(id);throw error;}finally{this.#executing.delete(id);}
  }});
  try{
   await this.#current();this.#active(turn);
   const answer=await this.#model.respond({text,tools,signal:turn.controller.signal});this.#active(turn);await this.#current();this.#active(turn);
   if(typeof answer!=='string'||!answer.trim()||answer.length>8000||bytes(answer)>8000||/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f<>]/.test(answer))throw Error('Invalid model output');
   this.#send({type:'text',token:answer.replace(/[\r\n\t]/g,' '),last:true,interruptible:true,preemptible:true});this.#state='ready';
  }catch{if(this.#turn===turn&&!this.closed)this.#end();}
  finally{clearTimeout(turn.timer);if(this.#turn===turn)this.#turn=null;}
 }
 async receive(raw){
  try{
   this.assertOpen();if(typeof raw!=='string'||raw.length>16384||bytes(raw)>16384)throw Error('Frame unavailable');const event=JSON.parse(raw);if(!event||typeof event!=='object'||Array.isArray(event))throw Error('Frame unavailable');
   if(event.type==='setup'){await this.#setup(event);return;}
   if(!this.#binding)throw Error('Setup required');
   if(event.type==='interrupt'){this.#abortTurn();this.#text='';this.#state='ready';return;}
   if(event.type==='dtmf'){if(typeof event.digit!=='string'||!/^[0-9*#]$/.test(event.digit))throw Error('Invalid digit');if(event.digit==='0')this.#end();return;}
   if(event.type==='error'){this.#end();return;}
   if(event.type!=='prompt')throw Error('Frame unavailable');await this.#prompt(event);
  }catch{this.#end();throw Error('Voice session unavailable');}
 }
 afterClose(){this.#state='closed';}
}
/** Exact configured signature URL; never reconstruct it from forwarding headers.
 * signatureUrl must be pinned to the provider's deployed signing convention.
 * No URL variants, trailing-slash guesses or unsigned upgrade fallback. */
export class TwilioRelaySocketAdapter extends BoundedBinaryAdapterBase {
 #options;#token;#requestUrl;#signatureUrl;
 constructor({accountSid,authToken,sharedNumber,socketUrl,signatureUrl,guard,tasks,taskIds,claims,createModel}){
  super(16384);const socket=new URL(socketUrl),requestUrl=new URL(socketUrl);requestUrl.protocol='https:';
  if(socket.protocol!=='wss:'||socket.href!==socketUrl||socket.username||socket.password||socket.search||socket.hash||!twilioSid('AC',accountSid)||typeof authToken!=='string'||! /^[a-fA-F0-9]{32}$/.test(authToken)||typeof sharedNumber!=='string'||!/^\+[1-9][0-9]{1,14}$/.test(sharedNumber)||![socketUrl,requestUrl.href].includes(signatureUrl)||typeof guard?.current!=='function'||['propose','execute'].some(k=>typeof tasks?.[k]!=='function')||typeof createModel!=='function'||['claim','finish'].some(k=>typeof claims?.[k]!=='function')||!Array.isArray(taskIds)||!taskIds.length||taskIds.length>20||taskIds.some(id=>!taskId(id))||new Set(taskIds).size!==taskIds.length)throw Error('Relay configuration required');
  twilioPublicUrl(requestUrl.href);this.#token=authToken;this.#requestUrl=requestUrl.href;this.#signatureUrl=signatureUrl;
  this.#options=Object.freeze({accountSid,sharedNumber,guard:Object.freeze({current:guard.current.bind(guard)}),tasks:Object.freeze({propose:tasks.propose.bind(tasks),execute:tasks.execute.bind(tasks)}),taskIds:Object.freeze([...taskIds]),claims:Object.freeze({claim:claims.claim.bind(claims),finish:claims.finish.bind(claims)}),createModel});
 }
 open(request,socket){
  const signature=request.headers.get('x-twilio-signature');
  if(request.method!=='GET'||request.url!==this.#requestUrl||request.body!==null||request.headers.get('upgrade')?.toLowerCase()!=='websocket'||typeof signature!=='string'||signature.length>100||!validateRequest(this.#token,signature,this.#signatureUrl,{}))throw Error('Relay upgrade denied');
  if(!socket||['send','close','addEventListener','removeEventListener'].some(k=>typeof socket[k]!=='function'))throw Error('Relay socket required');
  const session=new TwilioRelaySession(capability,socket,this.#options);try{socket.accept?.();return session;}catch{session.close();throw Error('Relay socket unavailable');}
 }
}
