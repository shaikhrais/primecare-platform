/** Gather candidates into the authenticated SDP write. This preserves the
 * shared media/session lifecycle while avoiding one database RPC per candidate. */
export class BatchedIcePeerConnection extends RTCPeerConnection {
 private pendingGather:(()=>void)|null=null;
 private readonly suppressTrickle=(event:Event)=>event.stopImmediatePropagation();
 constructor(configuration:RTCConfiguration,readonly gatherMilliseconds=10000){
  super(configuration);
  if(!Number.isSafeInteger(gatherMilliseconds)||gatherMilliseconds<100||gatherMilliseconds>20000){super.close();throw Error('Invalid ICE gathering timeout');}
  this.addEventListener('icecandidate',this.suppressTrickle);
 }
 override async setLocalDescription(description?:Parameters<RTCPeerConnection['setLocalDescription']>[0]){
  await super.setLocalDescription(description);
  if(this.iceGatheringState==='complete')return;
  if(this.signalingState==='closed')throw Error('Peer closed');
  await new Promise<void>((resolve,reject)=>{
   let settled=false;
   const finish=(error?:Error)=>{if(settled)return;settled=true;clearTimeout(timer);this.removeEventListener('icegatheringstatechange',changed);this.pendingGather=null;error?reject(error):resolve();};
   const changed=()=>{if(this.iceGatheringState==='complete')finish();else if(this.signalingState==='closed')finish(Error('Peer closed'));};
   const timer=setTimeout(()=>finish(Error('ICE gathering timed out')),this.gatherMilliseconds);
   this.pendingGather=()=>finish(Error('Peer closed'));this.addEventListener('icegatheringstatechange',changed);changed();
  });
 }
 override close(){this.pendingGather?.();this.removeEventListener('icecandidate',this.suppressTrickle);super.close();}
}
