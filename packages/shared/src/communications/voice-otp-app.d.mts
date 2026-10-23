import {CommunicationResourceBase} from './adapter-base.mjs';
export type VoiceOtpAppState='pairing'|'sending'|'code'|'checking'|'verified'|'unavailable'|'closed';
export type VoiceOtpAppOptions={callSid:string;currentScope:()=>string|null;transport:{start(input:{callSid:string;pairingCode:string}):Promise<{verificationRequested:true}>;check(input:{callSid:string;code:string}):Promise<{verified:boolean}>};onChange?:(value:{state:VoiceOtpAppState})=>void};
export class VoiceOtpAppSession extends CommunicationResourceBase {constructor(options:VoiceOtpAppOptions);readonly state:VoiceOtpAppState;readonly callSid:string;start(pairingCode:string):Promise<void>;check(code:string):Promise<boolean>}
export function mountVoiceOtpPanel(options:Omit<VoiceOtpAppOptions,'onChange'>&{element:HTMLElement}):VoiceOtpAppSession;
