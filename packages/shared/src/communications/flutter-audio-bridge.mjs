import {BrowserAudioSession} from './audio-session.mjs';
import {CommunicationResourceBase} from './adapter-base.mjs';

/** Small JSON-only bridge. Flutter reuses the tested browser session unchanged. */
export class FlutterBrowserAudioSession extends CommunicationResourceBase {
 constructor(execute,onState,options,{document=globalThis.document,navigator=globalThis.navigator,createPeer=configuration=>new RTCPeerConnection(configuration),events=globalThis}={}) {
  super();
  const {userId,tenantId,threadId,callId,configuration}=options??{};
  if(typeof execute!=='function'||typeof onState!=='function'||[userId,tenantId,threadId,callId].some(v=>typeof v!=='string'||!v.trim())||!configuration||!Array.isArray(configuration.iceServers)||configuration.iceServers.length>8||!navigator?.mediaDevices?.getUserMedia||!document?.createElement)throw Error('Configured browser media required');
  const audio=document.createElement('audio');audio.autoplay=true;audio.hidden=true;document.body.appendChild(audio);
  this.registerCleanup(()=>{audio.pause();audio.srcObject=null;audio.remove();});
  const pagehide=()=>this.close();events.addEventListener('pagehide',pagehide);this.registerCleanup(()=>events.removeEventListener('pagehide',pagehide));
  this.onState=onState;
  const transport={execute:async(channel,input)=>{
   this.assertOpen();
   const envelope=JSON.parse(await execute(channel,JSON.stringify(input)));
   this.assertOpen();
   if(envelope?.ok!==true)throw Object.assign(Error('Communication unavailable'),{status:Number.isSafeInteger(envelope?.status)?envelope.status:undefined});
   const value=envelope.value;
   if(channel==='message'&&(value?.tenantId!==tenantId||value?.id!==threadId))throw Error('Communication scope unavailable');
   return value;
  }};
  this.session=new BrowserAudioSession({transport,userId,threadId,callId,onError:()=>{this.close();onState('failed');},media:{configuration:structuredClone(configuration),getUserMedia:constraints=>navigator.mediaDevices.getUserMedia(constraints),createPeer,onTrack:stream=>{
   if(this.closed)return;
   audio.srcObject=stream;
   Promise.resolve(audio.play()).catch(()=>{if(!this.closed){this.close();onState('failed');}});
  },onState:state=>{if(state==='closed')this.close();else if(!this.closed)onState(state);}}});
  this.registerCleanup(()=>this.session.close());
 }
 async start(){this.assertOpen();try{await this.session.start();this.assertOpen();}catch(error){this.close();throw error;}}
 mute(value){this.assertOpen();this.session.mute(value);}
 afterClose(){this.onState?.('closed');}
}
export function create(execute,onState,optionsJSON){return new FlutterBrowserAudioSession(execute,onState,JSON.parse(optionsJSON));}
// A bundled same-origin asset; no eval, inline scripts, remote imports or secrets.
globalThis.PrimecareCommunicationMedia=Object.freeze({version:1,create});
