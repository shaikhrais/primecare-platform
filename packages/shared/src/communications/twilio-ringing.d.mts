import {CommunicationResourceBase} from './adapter-base.mjs';
export interface RingingCallPort {on(event:string,listener:()=>void):unknown;off(event:string,listener:()=>void):unknown;accept():unknown;reject():unknown;disconnect():unknown;mute(value:boolean):unknown}
export type RingingOptions={call:RingingCallPort;currentScope:()=>string|null;authorizeAnswer:()=>Promise<boolean>;onChange?:(value:{state:string;muted:boolean})=>void};
export class TwilioRingingCall extends CommunicationResourceBase {constructor(options:RingingOptions);readonly state:string;readonly muted:boolean;answer():Promise<void>;decline():void;hangup():void;mute(value:boolean):void}
export function mountTwilioCallPanel(options:Omit<RingingOptions,'onChange'>&{element:HTMLElement}):TwilioRingingCall;
