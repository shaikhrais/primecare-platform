import {OpenAiRelayModel,type OpenAiRelayModelOptions} from '../../../../packages/shared/src/communications/openai-relay-model.mjs';
import {TwilioRelaySocketAdapter,type TwilioRelayOptions} from '../../../../packages/shared/src/communications/twilio-relay-session.mjs';
import {createVerifiedAgentCallGuard} from '../../../../packages/shared/src/communications/twilio-agent-start.mjs';
import {PostgresRelaySessionClaims} from './relay-session-claims.ts';
import {TwilioVerifiedAgentAdapter,type TwilioVerifiedAgentOptions} from '../../../../packages/shared/src/communications/twilio-agent-start.mjs';
import {TwilioOtpPairingAdapter} from '../../../../packages/shared/src/communications/twilio-otp-pairing.mjs';
import {VoiceOtpService,PostgresVoiceOtpRepository,PostgresVoiceOtpContactDirectory} from './voice-otp.ts';
import {createTwilioVoiceOtpClient} from '../../../../packages/shared/src/communications/twilio-verify.mjs';
import {createReceptionAppointmentTasks,type ReceptionAppointmentPorts} from './voice-reception-tasks.ts';
import {PostgresVoiceTaskConfirmationService} from './voice-confirmations.ts';
import {VoiceTaskService,PostgresVoiceTaskRepository,type VoiceTaskTrust,type VoiceTaskBase} from './voice-tasks.ts';
import {VoicemailService,PostgresVoicemailRepository,BusinessMailVoicemailNotifier,type VoicemailPorts} from './voicemail.ts';
import {TwilioVoicemailAdapter,TwilioVoicemailAudioAdapter,createTwilioRecordingVerifier} from '../../../../packages/shared/src/communications/twilio-voicemail.mjs';
import {TwilioExtensionConnectService} from './twilio-connect.ts';
import {TwilioExtensionConnectAdapter,createTwilioVoiceCallVerifier} from '../../../../packages/shared/src/communications/twilio-connect.mjs';
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
 configuration:{accountSid:string;authToken:string;apiKeySid:string;apiKeySecret:string;applicationSid:string;messagingServiceSid:string;sharedNumber:string;numberVerified:true;receptionExtension?:string;incomingUrl:string;gatherUrl:string;statusCallback:string;maxWebhookBytes:number;maxTextBytes:number;tokenTtlSeconds:number};
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
 const voice=new TwilioVoiceExtensionAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,numberVerified:c.numberVerified,receptionExtension:c.receptionExtension,incomingUrl:c.incomingUrl,gatherUrl:c.gatherUrl,directory:dependencies.voiceDirectory,maxWebhookBytes:c.maxWebhookBytes});
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

/** Separate opt-in composition for the registered TwiML App URL. Never mounted here. */
export function createPostgresTwilioExtensionConnectHandler(dependencies:Pick<Parameters<typeof createTwilioCommunicationServices>[0],'pool'|'policy'|'configuration'|'httpClient'> & {outgoingUrl:string;voicemail?:VoicemailService;dialCompleteUrl?:string}){
 const c=dependencies.configuration;
 if((dependencies.voicemail===undefined)!==(dependencies.dialCompleteUrl===undefined))throw Error('Voicemail composition required');
 const urls=[c.incomingUrl,c.gatherUrl,c.statusCallback,dependencies.outgoingUrl].map(value=>new URL(value));
 if(new Set(urls.map(value=>value.href)).size!==4||new Set(urls.map(value=>value.origin)).size!==1)throw Error('Distinct same-origin provider handlers required');
 const verifier=createTwilioVoiceCallVerifier({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient});
 const service=new TwilioExtensionConnectService(new PostgresAtomicStore(dependencies.pool,'business_sms'),dependencies.policy,new PostgresVoiceDirectory(dependencies.pool),verifier,c.accountSid,dependencies.voicemail);
 return new TwilioExtensionConnectAdapter({accountSid:c.accountSid,authToken:c.authToken,webhookUrl:dependencies.outgoingUrl,maxWebhookBytes:c.maxWebhookBytes,sharedNumber:c.sharedNumber,service,dialCompleteUrl:dependencies.dialCompleteUrl});
}

/** Candidate voicemail composition. All mailbox, mail, credential and route
 * bindings are server-owned. Constructing it performs no grants or route mounts.
 */
export function createPostgresTwilioVoicemailServices(dependencies:Pick<Parameters<typeof createTwilioCommunicationServices>[0],'pool'|'policy'|'configuration'|'httpClient'|'providerPrincipal'> & {
 mail:ConstructorParameters<typeof BusinessMailVoicemailNotifier>[0];mailboxes:VoicemailPorts['mailboxes'];fetch:typeof fetch;
 dialCompleteUrl:string;recordActionUrl:string;recordingStatusUrl:string;playbackBaseUrl:string;maxAudioBytes:number;
}){
 const c=dependencies.configuration;
 const callbacks={dialCompleteUrl:dependencies.dialCompleteUrl,recordActionUrl:dependencies.recordActionUrl,recordingStatusUrl:dependencies.recordingStatusUrl};
 const urls=[c.incomingUrl,c.gatherUrl,c.statusCallback,...Object.values(callbacks)].map(value=>new URL(value));
 if(new Set(urls.map(u=>u.href)).size!==6||new Set(urls.map(u=>u.origin)).size!==1)throw Error('Distinct same-origin provider handlers required');
 const directory=new PostgresVoiceDirectory(dependencies.pool),repository=new PostgresVoicemailRepository(dependencies.pool);
 const voicemail=new VoicemailService(new PostgresAtomicStore(dependencies.pool,'business_sms'),dependencies.policy,repository,{directory,recordings:createTwilioRecordingVerifier({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient}),mailboxes:dependencies.mailboxes,notifications:new BusinessMailVoicemailNotifier(dependencies.mail)},{accountSid:c.accountSid,providerPrincipal:dependencies.providerPrincipal,playbackBaseUrl:dependencies.playbackBaseUrl});
 const voice=new TwilioVoiceExtensionAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,numberVerified:c.numberVerified,receptionExtension:c.receptionExtension,incomingUrl:c.incomingUrl,gatherUrl:c.gatherUrl,directory,maxWebhookBytes:c.maxWebhookBytes,voicemail,dialCompleteUrl:dependencies.dialCompleteUrl});
 const callbacksAdapter=new TwilioVoicemailAdapter({accountSid:c.accountSid,authToken:c.authToken,maxWebhookBytes:c.maxWebhookBytes,...callbacks,service:voicemail});
 const audio=new TwilioVoicemailAudioAdapter({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,maxAudioBytes:dependencies.maxAudioBytes,fetch:dependencies.fetch});
 return Object.freeze({voice,voicemail,callbacks:callbacksAdapter,audio});
}

/** Provider-neutral Vapi/ConversationRelay tool boundary. Default task list is
 * deliberately supplied by the host; this factory does not publish any tool.
 */
export function createPostgresVoiceTaskService(dependencies:{pool:any;policy:AccessPolicy;trust:VoiceTaskTrust;tasks:readonly VoiceTaskBase[]}){
 return new VoiceTaskService(new PostgresAtomicStore(dependencies.pool,'business_sms'),dependencies.policy,new PostgresVoiceTaskRepository(dependencies.pool),dependencies.trust,dependencies.tasks);
}

/** Native app approval plus task execution. identities must be a real server-side
 * OTP/passkey broker; never derive verification from provider/LLM arguments.
 */
export function createPostgresConfirmedVoiceTaskServices(dependencies:{pool:any;policy:AccessPolicy;identities:ConstructorParameters<typeof PostgresVoiceTaskConfirmationService>[3];tasks:readonly VoiceTaskBase[]}){
 const store=new PostgresAtomicStore(dependencies.pool,'business_sms'),repository=new PostgresVoiceTaskRepository(dependencies.pool);
 const confirmations=new PostgresVoiceTaskConfirmationService(store,dependencies.policy,dependencies.pool,dependencies.identities,repository);
 const tasks=new VoiceTaskService(store,dependencies.policy,repository,confirmations,dependencies.tasks);
 return Object.freeze({tasks,confirmations});
}

/** User-selected initial scope: callbacks and appointment requests. Business write
 * adapters and the verified identity broker are mandatory; nothing is mounted.
 */
export function createPostgresReceptionAppointmentVoiceServices(dependencies:Omit<Parameters<typeof createPostgresConfirmedVoiceTaskServices>[0],'tasks'> & {requests:ReceptionAppointmentPorts}){
 return createPostgresConfirmedVoiceTaskServices({...dependencies,tasks:createReceptionAppointmentTasks(dependencies.requests)});
}

/** App-linked OTP identity + explicit confirmation + selected request tasks.
 * Pairing provider handlers, native app auth/CSRF, verified-contact onboarding and
 * approved request API adapters must be registered before exposing any method.
 */
export function createPostgresOtpReceptionVoiceServices(dependencies:Pick<Parameters<typeof createTwilioCommunicationServices>[0],'pool'|'policy'|'configuration'|'httpClient'> & {verifyServiceSid:string;requests:ReceptionAppointmentPorts}){
 const c=dependencies.configuration,directory=new PostgresVoiceDirectory(dependencies.pool);
 const otp=new VoiceOtpService(new PostgresAtomicStore(dependencies.pool,'business_sms'),dependencies.policy,new PostgresVoiceOtpRepository(dependencies.pool),{sessions:directory,calls:createTwilioVoiceCallVerifier({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient}),contacts:new PostgresVoiceOtpContactDirectory(dependencies.pool),provider:contact=>createTwilioVoiceOtpClient({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,serviceSid:dependencies.verifyServiceSid,contact:{phone:contact.phone,verified:true},httpClient:dependencies.httpClient})},{accountSid:c.accountSid,sharedNumber:c.sharedNumber});
 const services=createPostgresReceptionAppointmentVoiceServices({...dependencies,identities:otp});return Object.freeze({...services,otp});
}

export function createTwilioVoiceOtpPairingHandler(dependencies:{otp:VoiceOtpService;configuration:Parameters<typeof createTwilioCommunicationServices>[0]['configuration'];pairingUrl:string;waitUrl:string;agentUrl:string;receptionUrl:string}){
 const c=dependencies.configuration;
 return new TwilioOtpPairingAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,maxWebhookBytes:c.maxWebhookBytes,pairingUrl:dependencies.pairingUrl,waitUrl:dependencies.waitUrl,agentUrl:dependencies.agentUrl,receptionUrl:dependencies.receptionUrl,service:dependencies.otp});
}

/** Separate signed agent-start/completion handlers. No route is mounted. The
 * socket receiver must independently validate provider signature, canonical call,
 * current broker identity and task authorization; TwiML is not an auth token. */
export function createTwilioVerifiedAgentHandler(dependencies:Pick<Parameters<typeof createTwilioCommunicationServices>[0],'configuration'|'httpClient'> & {
 identities:TwilioVerifiedAgentOptions['identities'];authorize:TwilioVerifiedAgentOptions['authorize'];
 agentUrl:string;completeUrl:string;receptionUrl:string;socketUrl:string;greeting:string;
}){
 const c=dependencies.configuration;
 return new TwilioVerifiedAgentAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,maxWebhookBytes:c.maxWebhookBytes,
  agentUrl:dependencies.agentUrl,completeUrl:dependencies.completeUrl,receptionUrl:dependencies.receptionUrl,socketUrl:dependencies.socketUrl,greeting:dependencies.greeting,
  calls:createTwilioVoiceCallVerifier({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient}),identities:dependencies.identities,authorize:dependencies.authorize});
}

/** Candidate native socket composition. The host owns its registered upgrade
 * route and tenant-scoped model factory. Never mount with a memory claims port. */
export function createPostgresTwilioRelaySocket(dependencies:Pick<Parameters<typeof createTwilioCommunicationServices>[0],'pool'|'configuration'|'httpClient'> & {
 identities:TwilioVerifiedAgentOptions['identities'];authorize:TwilioVerifiedAgentOptions['authorize'];
 socketUrl:string;signatureUrl:string;tasks:VoiceTaskService;taskIds:TwilioRelayOptions['taskIds'];createModel:TwilioRelayOptions['createModel'];
}){
 const c=dependencies.configuration;
 const guard=createVerifiedAgentCallGuard({accountSid:c.accountSid,sharedNumber:c.sharedNumber,calls:createTwilioVoiceCallVerifier({accountSid:c.accountSid,apiKeySid:c.apiKeySid,apiKeySecret:c.apiKeySecret,httpClient:dependencies.httpClient}),identities:dependencies.identities,authorize:dependencies.authorize});
 return new TwilioRelaySocketAdapter({accountSid:c.accountSid,authToken:c.authToken,sharedNumber:c.sharedNumber,socketUrl:dependencies.socketUrl,signatureUrl:dependencies.signatureUrl,guard,
  tasks:dependencies.tasks,taskIds:dependencies.taskIds,claims:new PostgresRelaySessionClaims(dependencies.pool),createModel:dependencies.createModel});
}

/** Configured server-only Responses provider. Each accepted call gets isolated
 * history. No automatic model selection, route mounting or secret provisioning. */
export function createPostgresOpenAiTwilioRelaySocket(dependencies:Omit<Parameters<typeof createPostgresTwilioRelaySocket>[0],'createModel'> & {modelProvider:Omit<OpenAiRelayModelOptions,'taskIds'>}){
 return createPostgresTwilioRelaySocket({...dependencies,createModel:async()=>new OpenAiRelayModel({...dependencies.modelProvider,taskIds:dependencies.taskIds})});
}
