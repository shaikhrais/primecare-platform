import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
export class TwilioOtpPairingAdapter extends TwilioSignedFormAdapter {
 constructor(options:{accountSid:string;authToken:string;sharedNumber:string;pairingUrl:string;waitUrl:string;agentUrl:string;receptionUrl:string;maxWebhookBytes:number;service:{issue(callSid:string):Promise<{pairingCode:string;expiresAt:number}>;current(callSid:string):Promise<unknown>;pending(callSid:string):Promise<boolean>}});
 respond(request:Request):Promise<Response>;
}
