import {TwilioSignedFormAdapter,type TwilioWebhookOptions} from './twilio-webhook.mjs';
export type InboundSmsEvent=Readonly<{provider:'twilio';channel:'sms';accountSid:string;messageSid:string;messagingServiceSid:string;from:string;to:string;text:string;mediaCount:number;control:'STOP'|'START'|'HELP'|null}>;
export interface SmsInboundStore {
 /** Atomically persist and deduplicate provider account + MessageSid. Unknown
  * account links must never be resolved just by matching a phone number.
  * Control messages and unsupported media must not enter AI processing.
  */
 accept(event:InboundSmsEvent):Promise<'recorded'|'duplicate'|'quarantined'>;
}
export class TwilioSmsInboundAdapter extends TwilioSignedFormAdapter {
 constructor(options:TwilioWebhookOptions&{store:SmsInboundStore;sender:string;messagingServiceSid:string});
 respond(request:Request):Promise<Response>;
}
