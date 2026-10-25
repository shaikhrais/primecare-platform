import {CommunicationResourceBase} from './adapter-base.mjs';
export type CallIceConfiguration={iceServers:{urls:string[];username?:string;credential?:string}[];expiresAt:number};
export class CloudflareTurnProvider extends CommunicationResourceBase {
 constructor(options:{keyId:string;apiToken:string;ttlSeconds:number;fetch?:typeof fetch});
 issue():Promise<CallIceConfiguration>;
}
