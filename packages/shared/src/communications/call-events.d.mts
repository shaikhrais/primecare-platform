import {CommunicationResourceBase} from './adapter-base.mjs';
export class BrowserCallEvents extends CommunicationResourceBase {
 constructor(options:{gateway:string;userId:string;token:string;isCurrent:()=>boolean;onChange:(type:'ready'|'changed'|'signal')=>void;onStatus?:(connected:boolean)=>void;onDenied?:()=>void;createSocket?:(url:string)=>WebSocket});
 readonly connected:boolean;
 start():void;
}
