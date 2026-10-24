import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export class TwilioVerifyFetchClient extends BoundedBinaryAdapterBase {
 constructor(options:{serviceSid:string;apiKeySid:string;apiKeySecret:string;fetch?:typeof fetch});
 request(options:unknown):Promise<{statusCode:number;headers:Record<string,string>;body:string}>;
}
