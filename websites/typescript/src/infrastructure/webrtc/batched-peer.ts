/** Put usable ICE candidates into the authenticated SDP write without per-
 * candidate database RPCs. Other transport paths may keep gathering locally. */
export class BatchedIcePeerConnection extends RTCPeerConnection {
 private pendingGather:(()=>void)|null=null;private candidateReady:(()=>void)|null=null;
 readonly iceErrors:number[]=[];candidateCount=0;gatherOutcome='pending';
 private readonly suppressTrickle=(event:Event)=>{
  const candidate=(event as RTCPeerConnectionIceEvent).candidate;
  if(candidate&&(this.getConfiguration().iceTransportPolicy!=='relay'||candidate.type==='relay')){this.candidateCount++;this.candidateReady?.();}
  event.stopImmediatePropagation();
 };
 private readonly recordIceError=(event:Event)=>{const code=(event as Event&{errorCode?:number}).errorCode;if(Number.isSafeInteger(code)&&code!>=300&&code!<=799&&this.iceErrors.length<16)this.iceErrors.push(code!);};
 constructor(configuration:RTCConfiguration,readonly gatherMilliseconds=20000){
  super(configuration);
  if(!Number.isSafeInteger(gatherMilliseconds)||gatherMilliseconds<100||gatherMilliseconds>20000){super.close();throw Error('Invalid ICE gathering timeout');}
  this.addEventListener('icecandidate',this.suppressTrickle);this.addEventListener('icecandidateerror',this.recordIceError);
 }
 override async setLocalDescription(description?:Parameters<RTCPeerConnection['setLocalDescription']>[0]){
  try{await super.setLocalDescription(description);}catch(error){this.gatherOutcome='native_failure';throw error;}
  if(this.iceGatheringState==='complete'){this.gatherOutcome='complete';return;}
  if(this.signalingState==='closed')throw Error('Peer closed');
  await new Promise<void>((resolve,reject)=>{
   let settled=false,settleTimer:ReturnType<typeof setTimeout>|undefined;
   const finish=(error?:Error)=>{if(settled)return;settled=true;clearTimeout(timer);clearTimeout(settleTimer);this.removeEventListener('icegatheringstatechange',changed);this.pendingGather=null;this.candidateReady=null;error?reject(error):resolve();};
   const ready=()=>{if(settled||settleTimer)return;settleTimer=setTimeout(()=>{this.gatherOutcome='usable';finish();},250);};
   const changed=()=>{if(this.iceGatheringState==='complete'){this.gatherOutcome='complete';finish();}else if(this.signalingState==='closed')finish(Error('Peer closed'));};
   const timer=setTimeout(()=>{this.gatherOutcome=this.candidateCount?'usable':'timeout';finish(this.candidateCount?undefined:Error('ICE gathering timed out'));},this.gatherMilliseconds);
   this.pendingGather=()=>{this.gatherOutcome='closed';finish(Error('Peer closed'));};this.candidateReady=ready;this.addEventListener('icegatheringstatechange',changed);if(this.candidateCount)ready();changed();
  });
 }
 override close(){this.pendingGather?.();this.removeEventListener('icecandidate',this.suppressTrickle);this.removeEventListener('icecandidateerror',this.recordIceError);super.close();}
}
