import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export type TwilioWebhookOptions={accountSid:string;authToken:string;webhookUrl?:string;webhookUrls?:string[];maxWebhookBytes:number};
export function twilioSid(prefix:string,value:unknown):boolean;
export function twilioPublicUrl(value:string):string;
export function twilioFailure(status:number):Response;
export class TwilioSignedFormAdapter extends BoundedBinaryAdapterBase{
 constructor(options:TwilioWebhookOptions);
 validate(request:Request):Promise<{params:Record<string,string|string[]>;response?:undefined}|{response:Response;params?:undefined}>;
}
