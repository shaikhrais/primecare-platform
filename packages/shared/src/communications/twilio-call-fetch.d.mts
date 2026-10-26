import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export class TwilioCallFetch extends BoundedBinaryAdapterBase{
 constructor(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;fetch?:typeof fetch});
 call(sid:string,cancel?:boolean):Promise<{sid:string;accountSid:string;from:string;direction:string;status:string}>;
}
