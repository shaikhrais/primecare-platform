import {TwilioSignedFormAdapter} from './twilio-webhook.mjs';
export type VoiceAgentIdentity=Readonly<{actor:Readonly<{id:string;tenantId:string}>;sessionId:string;authentication:'otp'|'passkey';active:true;expiresAt:number}>;
export type TwilioVerifiedAgentOptions={accountSid:string;authToken:string;sharedNumber:string;agentUrl:string;completeUrl:string;receptionUrl:string;socketUrl:string;greeting:string;maxWebhookBytes:number;calls:{fetch(callSid:string):Promise<{sid:string;accountSid:string;to?:string;direction:string;status:string}>};identities:{current(callSid:string):Promise<unknown>};authorize(identity:VoiceAgentIdentity,callSid:string):Promise<boolean>};
export class TwilioVerifiedAgentAdapter extends TwilioSignedFormAdapter {constructor(options:TwilioVerifiedAgentOptions);respond(request:Request):Promise<Response>}

export function verifiedAgentIdentity(value:unknown):VoiceAgentIdentity;
export function sameAgentIdentity(a:VoiceAgentIdentity,b:VoiceAgentIdentity):boolean;
export type VerifiedAgentCallGuard=Readonly<{status(callSid:string):Promise<string>;current(callSid:string):Promise<VoiceAgentIdentity>}>;
export function createVerifiedAgentCallGuard(options:Pick<TwilioVerifiedAgentOptions,'accountSid'|'sharedNumber'|'calls'|'identities'|'authorize'>):VerifiedAgentCallGuard;
