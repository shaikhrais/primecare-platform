import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
export function createTwilioRecordingVerifier(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;httpClient?:{request(options:unknown):Promise<unknown>}}):{fetch(sid:string):Promise<{sid:string;accountSid:string;callSid:string;status:string;source:string;duration:number}>};
export class TwilioVoicemailAdapter extends TwilioSignedFormAdapter {
 constructor(options:{accountSid:string;authToken:string;dialCompleteUrl:string;recordActionUrl:string;recordingStatusUrl:string;maxWebhookBytes:number;service:{fallback(callSid:string,status:string):Promise<boolean>;completed(input:{callSid:string;recordingSid:string;duration:number}):Promise<void>}});
 respond(request:Request):Promise<Response>;
}

export class TwilioVoicemailAudioAdapter extends BoundedBinaryAdapterBase {
 constructor(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;maxAudioBytes:number;fetch:typeof fetch});
 download(recordingSid:string):Promise<{bytes:Uint8Array;contentType:string}>;
}
