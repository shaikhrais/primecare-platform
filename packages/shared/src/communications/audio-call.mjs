/** Browser media adapter. Signaling must validate live membership and accepted call ID. */
import {CommunicationResourceBase} from './adapter-base.mjs';
export class BrowserAudioCall extends CommunicationResourceBase {
 constructor({sendSignal, getUserMedia, createPeer, configuration, onTrack = () => {}, onState = () => {}}) {
  super();
  if(typeof sendSignal !== 'function' || typeof getUserMedia !== 'function' || typeof createPeer !== 'function' || !configuration || !Array.isArray(configuration.iceServers)) throw Error('Configured media adapters required');
  this.sendSignal=sendSignal;this.getUserMedia=getUserMedia;this.createPeer=createPeer;
  this.configuration=configuration;this.onTrack=onTrack;this.onState=onState;this.pending=[];
 }
 async start() {
  if(this.closed || this.starting || this.peer) throw Error('Call already started or closed');
  this.starting=true;
  try {
   this.stream=await this.getUserMedia({audio:true,video:false});
   const stream=this.stream;this.registerCleanup(()=>stream.getTracks().forEach(track=>track.stop()));
   this.assertOpen();
   this.peer=this.createPeer(this.configuration);
   const peer=this.peer;this.registerCleanup(()=>{peer.onicecandidate=null;peer.ontrack=null;peer.onconnectionstatechange=null;peer.close();});
   this.peer.onicecandidate=event=>{
    if(this.closed||!event.candidate)return;
    // Event callbacks must contain both synchronous and asynchronous port errors.
    Promise.resolve().then(()=>{this.assertOpen();return this.sendSignal({type:'candidate',candidate:event.candidate.toJSON()});}).catch(()=>this.close());
   };
   this.peer.ontrack=event=>{if(!this.closed&&event.streams?.[0])this.onTrack(event.streams[0]);};
   this.peer.onconnectionstatechange=()=>{if(this.closed)return;const state=peer.connectionState;try{this.onState(state);}finally{if(state==='failed'||state==='closed')this.close();}};
   for(const track of this.stream.getTracks()){
    if(track.readyState==='ended')throw Error('Microphone ended');
    if(typeof track.addEventListener==='function'&&typeof track.removeEventListener==='function'){
     const ended=()=>this.close();track.addEventListener('ended',ended);
     this.registerCleanup(()=>track.removeEventListener('ended',ended));
    }
    this.peer.addTrack(track,this.stream);
   }
  } catch(error) {this.close();throw error;} finally {this.starting=false;}
 }
 async offer() {
  if(!this.peer || this.closed)throw Error('Call not started');
  try {
   const offer=await this.peer.createOffer();this.assertOpen();
   await this.peer.setLocalDescription(offer);this.assertOpen();
   await this.sendSignal({type:'offer',description:this.peer.localDescription.toJSON()});
   this.assertOpen();
  } catch(error) {this.close();throw error;}
 }
 async receive(signal) {
  if(!this.peer || this.closed)throw Error('Call not started');
  try {
  if(!signal || !['offer','answer','candidate'].includes(signal.type))throw Error('Invalid signal');
  if(signal.type==='candidate') {
   if(!this.peer.remoteDescription) {if(this.pending.length>=128)throw Error('Candidate limit');this.pending.push(signal.candidate);}
   else {await this.peer.addIceCandidate(signal.candidate);this.assertOpen();}
   return;
  }
  if(signal.description?.type!==signal.type)throw Error('Invalid description');
  await this.peer.setRemoteDescription(signal.description);this.assertOpen();
  for(const candidate of this.pending){await this.peer.addIceCandidate(candidate);this.assertOpen();}this.pending=[];
  if(signal.type==='offer') {
   const answer=await this.peer.createAnswer();this.assertOpen();
   await this.peer.setLocalDescription(answer);this.assertOpen();
   await this.sendSignal({type:'answer',description:this.peer.localDescription.toJSON()});
   this.assertOpen();
  }
  } catch(error) {this.close();throw error;}
 }
 mute(muted) {if(typeof muted!=='boolean')throw Error('Invalid mute state');this.stream?.getAudioTracks().forEach(track=>{track.enabled=!muted;});}
 afterClose() {
  this.pending=[];
  this.onState('closed');
 }
}
