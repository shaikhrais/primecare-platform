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
   this.peer.onicecandidate=event=>{if(event.candidate)this.sendSignal({type:'candidate',candidate:event.candidate.toJSON()}).catch(()=>this.close());};
   this.peer.ontrack=event=>this.onTrack(event.streams[0]);
   this.peer.onconnectionstatechange=()=>this.onState(this.peer?.connectionState??'closed');
   for(const track of this.stream.getTracks())this.peer.addTrack(track,this.stream);
  } catch(error) {this.close();throw error;} finally {this.starting=false;}
 }
 async offer() {
  if(!this.peer || this.closed)throw Error('Call not started');
  try {
   const offer=await this.peer.createOffer();await this.peer.setLocalDescription(offer);
   await this.sendSignal({type:'offer',description:this.peer.localDescription.toJSON()});
  } catch(error) {this.close();throw error;}
 }
 async receive(signal) {
  if(!this.peer || this.closed)throw Error('Call not started');
  if(!signal || !['offer','answer','candidate'].includes(signal.type))throw Error('Invalid signal');
  if(signal.type==='candidate') {
   if(!this.peer.remoteDescription) {if(this.pending.length>=128)throw Error('Candidate limit');this.pending.push(signal.candidate);}
   else await this.peer.addIceCandidate(signal.candidate);
   return;
  }
  if(signal.description?.type!==signal.type)throw Error('Invalid description');
  await this.peer.setRemoteDescription(signal.description);
  for(const candidate of this.pending)await this.peer.addIceCandidate(candidate);this.pending=[];
  if(signal.type==='offer') {
   const answer=await this.peer.createAnswer();await this.peer.setLocalDescription(answer);
   await this.sendSignal({type:'answer',description:this.peer.localDescription.toJSON()});
  }
 }
 mute(muted) {if(typeof muted!=='boolean')throw Error('Invalid mute state');this.stream?.getAudioTracks().forEach(track=>{track.enabled=!muted;});}
 afterClose() {
  this.pending=[];
  this.onState('closed');
 }
}
