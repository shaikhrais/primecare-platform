import {PostgresAtomicStore} from './store.ts';
import type {AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {SmsNotificationService,type SmsRecipientPolicy} from './sms.ts';
import {PostgresSmsObservationStore} from './sms-observations.ts';
import {TwilioVoiceTokenService,type VoiceTokenDirectory} from './twilio-token.ts';
import {TwilioVoiceExtensionAdapter,type TwilioExtensionDirectory} from '../../../../packages/shared/src/communications/twilio-voice.mjs';
import {TwilioSmsTransport,TwilioSmsStatusAdapter} from '../../../../packages/shared/src/communications/twilio-sms.mjs';
import {createTwilioSmsClient} from '../../../../packages/shared/src/communications/twilio-sms-client.mjs';
import {PostgresVoiceDirectory,VoiceExtensionService} from './voice-directory.ts';

/** Server-only composition. Requires registered production contracts, schema,
 * policies, secure bindings and trusted directory adapters. Exposes no new route.
 * The host must mount only independently registered webhook/token contracts.
 */
export function createTwilioCommunicationServices(dependencies:{
 pool:any;policy:AccessPolicy;recipients:SmsRecipientPolicy;
 voiceDirectory:TwilioExtensionDirectory;tokenDirectory:VoiceTokenDirectory;
 providerPrincipal:string;
 configuration:{accountSid:string;authToken:string;apiKeySid:string;apiKeySecret:string;applicationSid:string;messagingServiceSid:string;sharedNumber:string;numberVerified:true;incomingUrl:string;gatherUrl:string;statusCallback:string;maxWebhookBytes:number;maxTextBytes:number;tokenTtlSeconds:number};
 httpClient?:Parameters<typeof createTwilioSmsClient>[0]['httpClient'];
}){
 const {configuration:c}=dependencies;
 const urls=[c.incomingUrl,c.gatherUrl,c.statusCallback].map(value=>new URL(value));
 if(new Set(urls.map(value=>value.href)).size!==3||new Set(urls.map(value=>value.origin)).size!==1)throw Error('Distinct same-origin provider handlers required');
 const store=new PostgresAtomicStore(dependencies.pool,'business_sms');
 const client=createTwilioSmsClient({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient});
 const transport=new TwilioSmsTransport({client,accountSid:c.accountSid,messagingServiceSid:c.messagingServiceSid,sender:c.sharedNumber,statusCallback:c.statusCallback,maxTextBytes:c.maxTextBytes});
 const sms=new SmsNotificationService(store,dependencies.policy,dependencies.recipients,transport,{sender:c.sharedNumber,accountSid:c.accountSid,messagingServiceSid:c.messagingServiceSid,maxTextBytes:c.maxTextBytes});
 const observations=new PostgresSmsObservationStore(dependencies.pool,sms,dependencies.providerPrincipal);
 const smsStatus=new TwilioSmsStatusAdapter({accountSid:c.accountSid,authToken:c.authToken,webhookUrl:c.statusCallback,maxWebhookBytes:c.maxWebhookBytes,store:observations,messagingServiceSid:c.messagingServiceSid,sender:c.sharedNumber});
 const voice=new TwilioVoiceExtensionAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,numberVerified:c.numberVerified,incomingUrl:c.incomingUrl,gatherUrl:c.gatherUrl,directory:dependencies.voiceDirectory,maxWebhookBytes:c.maxWebhookBytes});
 const voiceTokens=new TwilioVoiceTokenService(store,dependencies.policy,dependencies.tokenDirectory,{accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,applicationSid:c.applicationSid,ttlSeconds:c.tokenTtlSeconds});
 return Object.freeze({sms,smsStatus,observations,voice,voiceTokens});
}
/** Native directory composition, still unmounted and subject to registration. */
export function createPostgresTwilioCommunicationServices(dependencies:Omit<Parameters<typeof createTwilioCommunicationServices>[0],'voiceDirectory'|'tokenDirectory'>){
 const directory=new PostgresVoiceDirectory(dependencies.pool);
 const services=createTwilioCommunicationServices({...dependencies,voiceDirectory:directory,tokenDirectory:directory});
 const extensions=new VoiceExtensionService(new PostgresAtomicStore(dependencies.pool,'business_sms'),dependencies.policy,directory);
 return Object.freeze({...services,extensions});
}
