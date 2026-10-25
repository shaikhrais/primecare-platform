import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
type Common={accountSid:string;authToken:string;sharedNumber:string;receptionUrl:string;resumeUrl:string;maxWebhookBytes:number;calls:{fetch(callSid:string):Promise<{sid:string;accountSid:string;to?:string;direction:string;status:string}>}};
export class TwilioPrivateCallAdapterBase extends TwilioSignedFormAdapter {
 constructor(options:Common,webhookUrls:string[]);
 live(params:Record<string,unknown>):Promise<void>;
 redirect(url:string):Response;
 reception():Response;
}
export class TwilioPhoneAuthorizationAdapter extends TwilioPrivateCallAdapterBase {
 constructor(options:Common&{startUrl:string;checkUrl:string;authorization:{start(callSid:string,reference:string):Promise<{verificationRequested:boolean}>;check(callSid:string,code:string):Promise<{verified:boolean}>}});
 respond(request:Request):Promise<Response>;
}
export class TwilioSpokenConfirmationAdapter extends TwilioPrivateCallAdapterBase {
 constructor(options:Common&{readbackUrl:string;decisionUrl:string;pendingIntent(callSid:string):Promise<string>;confirmations:{prepare(callSid:string,intentId:string):Promise<{challengeId:string;summary:string;expiresAt:number}>;accept(callSid:string,challengeId:string,input:{speech?:string;digits?:string}):Promise<{approved:boolean}>}});
 respond(request:Request):Promise<Response>;
}
