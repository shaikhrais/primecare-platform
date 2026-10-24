import definition from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
import type {NativeVoiceHttpOptions} from '../../../../packages/shared/src/communications/voice-native-http.mjs';
import {
 createPostgresTwilioCommunicationServices,createPostgresTwilioVoicemailServices,
 createPostgresTwilioExtensionConnectHandler,createPostgresOtpReceptionVoiceServices,
 createTwilioVoiceOtpPairingHandler,createTwilioVerifiedAgentHandler,
 createPostgresOpenAiTwilioRelaySocket,createPostgresNativeVoiceHttpAdapter,
} from './twilio-integration.ts';
import {CommunicationVoiceWorker,type VoiceRuntimePorts} from './voice-runtime.ts';
import {PostgresVoiceEndpointPolicy} from './endpoint-policy.ts';

type CommunicationDependencies=Parameters<typeof createPostgresTwilioCommunicationServices>[0];
type VoicemailDependencies=Parameters<typeof createPostgresTwilioVoicemailServices>[0];
type OtpDependencies=Parameters<typeof createPostgresOtpReceptionVoiceServices>[0];
type AgentDependencies=Parameters<typeof createTwilioVerifiedAgentHandler>[0];
type ModelDependencies=Parameters<typeof createPostgresOpenAiTwilioRelaySocket>[0];
export type PostgresVoiceWorkerDependencies=CommunicationDependencies & {
 origin:string;
 verifyServiceSid:string;
 requests:OtpDependencies['requests'];
 mail:VoicemailDependencies['mail'];mailboxes:VoicemailDependencies['mailboxes'];
 playbackBaseUrl:string;maxAudioBytes:number;fetch:typeof fetch;
 /** Optional additional restriction; cannot bypass current registered grants. */
 nativeAuthorize?:NativeVoiceHttpOptions['authorize'];appOrigins:readonly string[];
 agentAuthorize:AgentDependencies['authorize'];greeting:string;
 modelProvider:ModelDependencies['modelProvider'];
 sockets:VoiceRuntimePorts['sockets'];
};

/** Complete composition of the registered native and signed provider adapters.
 * Required current permission, verified contacts, mailbox and real request-API
 * ports remain the host's responsibility; no permissive policy is manufactured.
 * Construction performs no calls, registration, grant or number changes.
 */
export function createPostgresTwilioVoiceWorker<E>(d:PostgresVoiceWorkerDependencies):CommunicationVoiceWorker<E>{
 const origin=new URL(d.origin);
 if(origin.protocol!=='https:'||origin.origin!==d.origin)throw Error('Exact voice origin required');
 const endpoint=(key:string)=>{const rows=definition.operations.filter(op=>op.key===key);if(rows.length!==1)throw Error('Voice contract unavailable');return d.origin+rows[0].path;};
 if(d.configuration.incomingUrl!==endpoint('voice.incoming')||d.configuration.gatherUrl!==endpoint('voice.gather')||d.configuration.statusCallback!==endpoint('sms.status')||d.configuration.aiPairingUrl!==endpoint('voice.pair'))throw Error('Voice configuration must match registered host paths');
 // Snapshot server-owned configuration before creating asynchronous adapters.
 const configuration=Object.freeze({...d.configuration});
 const common={...d,configuration};
 const communications=createPostgresTwilioCommunicationServices(common);
 const voicemail=createPostgresTwilioVoicemailServices({...common,
  dialCompleteUrl:endpoint('voice.dial_complete'),recordActionUrl:endpoint('voice.record_action'),recordingStatusUrl:endpoint('voice.recording_status')});
 const connect=createPostgresTwilioExtensionConnectHandler({...common,outgoingUrl:endpoint('voice.connect'),voicemail:voicemail.voicemail,dialCompleteUrl:endpoint('voice.dial_complete')});
 const reception=createPostgresOtpReceptionVoiceServices(common);
 const pairing=createTwilioVoiceOtpPairingHandler({...common,otp:reception.otp,pairingUrl:endpoint('voice.pair'),waitUrl:endpoint('voice.wait'),agentUrl:endpoint('voice.agent'),receptionUrl:endpoint('voice.gather')});
 const socketUrl=endpoint('voice.relay').replace(/^https:/,'wss:');
 const agent=createTwilioVerifiedAgentHandler({...common,identities:reception.otp,authorize:d.agentAuthorize,
  agentUrl:endpoint('voice.agent'),completeUrl:endpoint('voice.agent_complete'),receptionUrl:endpoint('voice.gather'),socketUrl,greeting:d.greeting});
 const taskIds=['reception.callback.request','appointment.booking.request','appointment.reschedule.request'];
 const relay=createPostgresOpenAiTwilioRelaySocket({...common,identities:reception.otp,authorize:d.agentAuthorize,
  socketUrl,signatureUrl:socketUrl,tasks:reception.tasks,taskIds,modelProvider:d.modelProvider});
 const endpoints=new PostgresVoiceEndpointPolicy(d.pool);
 const native=createPostgresNativeVoiceHttpAdapter({pool:d.pool,origin:d.origin,appOrigins:d.appOrigins,
  maxRequestBytes:configuration.maxWebhookBytes,maxAudioBytes:d.maxAudioBytes,authorize:async(session,key,request)=>{
   await endpoints.authorize(session,key,request);await d.nativeAuthorize?.(session,key,request);
  },
  services:{tokens:communications.voiceTokens,extensions:communications.extensions,
   voicemail:voicemail.voicemail,audio:voicemail.audio,otp:reception.otp,confirmations:reception.confirmations}});
 return new CommunicationVoiceWorker<E>(d.origin,{native,voice:voicemail.voice,connect,
  voicemail:voicemail.callbacks,pairing,agent,smsStatus:communications.smsStatus,relay,sockets:d.sockets});
}
