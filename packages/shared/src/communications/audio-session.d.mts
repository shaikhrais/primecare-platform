import {CommunicationResourceBase} from './adapter-base.mjs';
import type {CallIceConfiguration} from './cloudflare-turn.mjs';
export class BrowserAudioSession extends CommunicationResourceBase {
 constructor(options:{transport:{execute(channel:string,input:any):Promise<any>};userId:string;threadId:string;callId:string;media:{getUserMedia(constraints:MediaStreamConstraints):Promise<MediaStream>;createPeer(configuration:RTCConfiguration):RTCPeerConnection;configuration:RTCConfiguration;onTrack?:(stream:MediaStream)=>void;onState?:(state:string)=>void};configurationProvider?:()=>Promise<CallIceConfiguration>;preparationProvider?:()=>Promise<CallIceConfiguration>;onTiming?:(stage:string,at:number)=>void;intervalMilliseconds?:number;onError?:(error:unknown)=>void;key?:()=>string});
 readonly started:boolean;
 prepare():Promise<void>;
 start():Promise<void>;
 refresh():Promise<void>;
 refreshConfiguration():Promise<void>;
 hangUp():Promise<void>;
 mute(muted:boolean):void;
}
