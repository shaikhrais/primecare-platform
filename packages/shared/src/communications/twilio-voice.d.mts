import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
export type PublishedVoiceDestination={extension:string;tenantId:string;userId:string;published:boolean;active:boolean;tenantActive:boolean;userActive:boolean};
export interface TwilioExtensionDirectory {
 /** Return up to two current matches; duplicates must never resolve to the first row. */
 lookup(extension:string,limit:2):Promise<ReadonlyArray<PublishedVoiceDestination>>;
}
export type TwilioVoiceOptions={accountSid:string;authToken:string;sharedNumber:string;numberVerified:true;incomingUrl:string;gatherUrl:string;directory:TwilioExtensionDirectory;maxWebhookBytes:number;receptionExtension?:string;aiPairingUrl?:string;dialCompleteUrl?:string;voicemail?:{prepare(input:{callSid:string;destination:PublishedVoiceDestination}):Promise<void>}};
export function twilioVoiceIdentity(scope:{tenantId:string;userId:string}):Promise<string>;
export class TwilioVoiceExtensionAdapter extends TwilioSignedFormAdapter {
 constructor(options:TwilioVoiceOptions);
 respond(request:Request):Promise<Response>;
}
