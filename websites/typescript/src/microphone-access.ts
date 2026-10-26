import {CommunicationResourceBase} from '../../../packages/shared/src/communications/adapter-base.mjs';
/** Permission probe only. Tracks are always stopped; the call SDK owns call audio. */
export class MicrophoneAccess extends CommunicationResourceBase {
 private stream:MediaStream|null=null;
 constructor(){super();this.registerCleanup(()=>this.stop());}
 private stop(){const stream=this.stream;this.stream=null;for(const track of stream?.getTracks()??[])track.stop();}
 async request():Promise<void>{
  this.assertOpen();
  if(!window.isSecureContext||!navigator.mediaDevices?.getUserMedia)throw new DOMException('Secure microphone API unavailable','NotSupportedError');
  const stream=await navigator.mediaDevices.getUserMedia({audio:true,video:false});
  try{this.stream=stream;this.assertOpen();if(!stream.getAudioTracks().length)throw new DOMException('No microphone','NotFoundError');}
  finally{this.stop();}
 }
}
export function microphoneHelp(error:unknown):string|null{
 const name=error&&typeof error==='object'&&'name' in error?String(error.name):'';
 if(['NotAllowedError','PermissionDeniedError','SecurityError'].includes(name))return 'Microphone blocked. In Chrome, open the site controls beside the address → Permissions → Microphone → Allow. Also allow Chrome microphone access in Android settings, then try again.';
 if(name==='NotFoundError')return 'No microphone found. Connect a microphone and try again.';
 if(['NotReadableError','AbortError'].includes(name))return 'The microphone is unavailable or in use. Close other audio apps and try again.';
 if(name==='NotSupportedError')return 'Microphone access needs a supported browser and a secure HTTPS page. Open this portal directly in Chrome.';
 return null;
}
