import {CommunicationResourceBase} from './adapter-base.mjs';
export interface VoiceSdkDevicePort {
 on(event:string,listener:(...args:any[])=>void):unknown;
 off(event:string,listener:(...args:any[])=>void):unknown;
 register():Promise<void>;
 connect?(options:{params:{CallerExtension:string;TargetExtension:string}}):Promise<VoiceSdkCallPort>;
 updateToken(token:string):unknown;
 disconnectAll():unknown;
 destroy():unknown;
}
export interface VoiceSdkCallPort {disconnect():unknown;on(event:string,listener:()=>void):unknown;off(event:string,listener:()=>void):unknown}
export type VoiceDeviceOptions={
 createDevice:(token:string)=>VoiceSdkDevicePort;
 fetchToken:(options:{signal:AbortSignal})=>Promise<{token:string;identity:string;ttlSeconds:number}>;
 /** Host session generation changes on logout, tenant switch and session replacement. */
 currentScope:()=>string|null;
 /** Default rejects. Never automatically answer; host owns authorized call UI. */
 onIncoming?:(call:{reject():unknown})=>unknown;
 onState?:(state:'idle'|'registering'|'registered'|'closed')=>void;
 registrationTimeoutMs?:number;
};
export class TwilioVoiceDevice extends CommunicationResourceBase {
 constructor(options:VoiceDeviceOptions);
 readonly state:'idle'|'registering'|'registered'|'closed';
 start():Promise<void>;
 refresh():Promise<void>;
 connect(options:{callerExtension:string;targetExtension:string}):Promise<VoiceSdkCallPort>;
}
