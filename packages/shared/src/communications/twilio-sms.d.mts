import {TwilioSignedFormAdapter,type TwilioWebhookOptions} from './twilio-webhook.mjs';
export type SmsProviderStatus='accepted'|'scheduled'|'queued'|'sending'|'sent'|'delivered'|'undelivered'|'failed'|'canceled';
export type SmsDeliveryObservation=Readonly<{accountSid:string;messageSid:string;messagingServiceSid:string;from:string;to:string;status:SmsProviderStatus;errorCode:string|null}>;
export interface SmsObservationStore{
 /** Atomically dedupe known mappings or durably quarantine unmatched/early callbacks.
  * Resolve tenant from persisted outbound mapping, never provider custom fields.
  */
 record(observation:SmsDeliveryObservation):Promise<'recorded'|'duplicate'|'quarantined'>;
}
export interface TwilioSmsClient{
 messages:{create(input:{to:string;body:string;from:string;messagingServiceSid:string;statusCallback:string}):Promise<{sid:string;accountSid:string;messagingServiceSid:string;from:string|null;to:string;status:string}>};
}
export class TwilioSmsTransport{
 constructor(options:{client:TwilioSmsClient;accountSid:string;messagingServiceSid:string;sender:string;statusCallback:string;maxTextBytes:number});
 send(message:{to:string;text:string}):Promise<{messageSid:string;status:SmsProviderStatus}>;
}
export function smsDeliveryProjection(observations:SmsProviderStatus[]):{status:SmsProviderStatus|'unknown'|'reconciliation_required';delivered:boolean};
export class TwilioSmsStatusAdapter extends TwilioSignedFormAdapter{
 constructor(options:TwilioWebhookOptions&{store:SmsObservationStore;messagingServiceSid:string;sender:string});
 respond(request:Request):Promise<Response>;
}
