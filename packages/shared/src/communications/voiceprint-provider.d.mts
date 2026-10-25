import {CommunicationResourceBase} from './adapter-base.mjs';
type AudioInput={subject:string;audio:Uint8Array;signal:AbortSignal};
export class VoiceprintProviderBase extends CommunicationResourceBase {
 audio(bytes:Uint8Array):Uint8Array;
 subject(value:string):string;
 enroll(input:AudioInput):Promise<{enrolled:boolean;receipt:string}>;
 verify(input:AudioInput):Promise<{matched:boolean;spoofed:boolean;receipt:string}>;
 remove(input:{subject:string;signal:AbortSignal}):Promise<{deleted:boolean;receipt:string}>;
}
export class AculabVoiceprintProvider extends VoiceprintProviderBase {
 constructor(options:{cloudId:string;username:string;groupKey:string;sensitivity:number;fetch?:typeof fetch});
}
