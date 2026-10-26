/** Browser media adapter. Signaling must validate live membership and accepted call ID. */
import {CommunicationResourceBase} from './adapter-base.mjs';
export class BrowserAudioCall extends CommunicationResourceBase {
 constructor({sendSignal, getUserMedia, createPeer, configuration, onTrack = () => {}, onState = () => {},onTiming=()=>{}}) {
  super();
  if(typeof sendSignal !== 'function' || typeof getUserMedia !== 'function' || typeof createPeer !== 'function' || !configuration || !Array.isArray(configuration.iceServers)) throw Error('Configured media adapters required');
  this.sendSignal=sendSignal;this.getUserMedia=getUserMedia;this.createPeer=createPeer;
  this.onTiming=onTiming;this.configuration=configuration;this.onTrack=onTrack;this.onState=onState;this.pending=[];
 }
 configure(configuration){
  this.assertOpen();if(!configuration||!Array.isArray(configuration.iceServers))throw Error('Configured media adapters required');
  const next=structuredClone(configuration);if(this.peer)this.peer.setConfiguration(next);this.configuration=next;
 }
 mark(stage){try{this.onTiming(stage,performance.now());}catch{}}
 prepare(){
  this.assertOpen();if(this.peer)throw Error('Peer already prepared');
  this.peer=this.createPeer(this.configuration);
  const peer=this.peer;this.registerCleanup(()=>{peer.onicecandidate=null;peer.ontrack=null;peer.onconnectionstatechange=null;peer.close();});
  this.peer.onicecandidate=event=>{
   if(this.closed||!this.stream||!event.candidate)return;
   // Event callbacks must contain both synchronous and asynchronous port errors.
   Promise.resolve().then(()=>{this.assertOpen();return this.sendSignal({type:'candidate',candidate:event.candidate.toJSON()});}).catch(()=>this.close());
  };
  this.peer.ontrack=event=>{if(this.closed)return;this.remoteStream=event.streams?.[0]??new MediaStream([event.track]);if(this.activated)this.onTrack(this.remoteStream);};
  this.peer.onconnectionstatechange=()=>{if(this.closed)return;const state=peer.connectionState;this.mark('peer_'+state);try{this.onState(state);}finally{if(state==='failed'||state==='closed')this.close();}};
  this.mark('peer_prepared');
 }
 prepareTransport(){this.assertOpen();if(!this.peer)this.prepare();if(this.transceiver)throw Error('Transport already prepared');this.transceiver=this.peer.addTransceiver('audio',{direction:'sendrecv'});}
 activate(){this.assertOpen();this.activated=true;this.stream?.getAudioTracks().forEach(track=>{track.enabled=true;});if(this.remoteStream)this.onTrack(this.remoteStream);}
 async start(deferActivation=false) {
  if(this.closed || this.starting || this.stream) throw Error('Call already started or closed');
  this.starting=true;
  try {
   this.mark('microphone_request');this.stream=await this.getUserMedia({audio:true,video:false});
   this.mark('microphone_acquired');const stream=this.stream;this.registerCleanup(()=>stream.getTracks().forEach(track=>track.stop()));
   this.assertOpen();
   if(!this.peer)this.prepare();
   for(const track of this.stream.getTracks()){
    if(track.readyState==='ended')throw Error('Microphone ended');
    if(typeof track.addEventListener==='function'&&typeof track.removeEventListener==='function'){
     const ended=()=>this.close();track.addEventListener('ended',ended);
     this.registerCleanup(()=>track.removeEventListener('ended',ended));
    }
    if(deferActivation)track.enabled=false;
    if(this.transceiver)await this.transceiver.sender.replaceTrack(track);else this.peer.addTrack(track,this.stream);
    this.assertOpen();
   }
   if(!deferActivation)this.activate();
  } catch(error) {this.close();throw error;} finally {this.starting=false;}
 }
 async offer() {
  if(!this.peer || this.closed)throw Error('Call not started');
  try {
   this.mark('offer_start');const offer=await this.peer.createOffer();this.assertOpen();
   this.mark('offer_gather_start');await this.peer.setLocalDescription(offer);this.assertOpen();
   this.mark('offer_ice_ready');await this.sendSignal({type:'offer',description:this.peer.localDescription.toJSON()});
   this.assertOpen();this.mark('offer_committed');
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
   this.mark('answer_start');const answer=await this.peer.createAnswer();this.assertOpen();
   this.mark('answer_gather_start');await this.peer.setLocalDescription(answer);this.assertOpen();
   this.mark('answer_ice_ready');await this.sendSignal({type:'answer',description:this.peer.localDescription.toJSON()});
   this.assertOpen();this.mark('answer_committed');
  }
  } catch(error) {this.close();throw error;}
 }
 mute(muted) {if(typeof muted!=='boolean')throw Error('Invalid mute state');this.stream?.getAudioTracks().forEach(track=>{track.enabled=!muted;});}
 afterClose() {
  this.pending=[];
  this.onState('closed');
 }
}
