import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
export interface VoiceConnectPort {connect(input:{callSid:string;from:string;callerExtension:string;targetExtension:string}):Promise<{identity:string}>}
export function createTwilioVoiceCallVerifier(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;httpClient?:{request(options:unknown):Promise<unknown>}}):{fetch(callSid:string):Promise<{sid:string;accountSid:string;from:string;direction:string;status:string}>};
export class TwilioExtensionConnectAdapter extends TwilioSignedFormAdapter {
 constructor(options:{accountSid:string;authToken:string;webhookUrl:string;maxWebhookBytes:number;sharedNumber:string;service:VoiceConnectPort});
 respond(request:Request):Promise<Response>;
}
