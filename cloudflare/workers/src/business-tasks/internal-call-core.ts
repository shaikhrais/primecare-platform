import type {AccessPolicy,Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import {PostgresAtomicStore} from './store.ts';
import {PostgresCommunicationAccessPolicy} from './access-policy.ts';
import {PostgresVoiceDirectory,VoiceExtensionService} from './voice-directory.ts';
import {InternalExtensionCallService,InternalExtensionCallChannel,type InternalCallRequest} from './internal-extension-calls.ts';
import {InternalCallMediaService,type AppCallRelayPorts} from './internal-call-media.ts';
import type {ConversationCallLimits} from './call-service.ts';
type Pool=ConstructorParameters<typeof PostgresVoiceDirectory>[0];
/** Call-first composition. Requires only native PostgreSQL, registered current
 * permissions and call limits. No Twilio, AI, SMS, email or image capability.
 * The HTTP host must supply its current signed-in actor and exact endpoint grant.
 * Construction does not mount an unregistered extension-dial operation. */
export class InternalAppCallCore {
 readonly directory:PostgresVoiceDirectory;readonly extensions:VoiceExtensionService;readonly calls:InternalExtensionCallService;readonly channel:InternalExtensionCallChannel;readonly media:InternalCallMediaService|null;
 constructor(options:{pool:Pool;limits:ConversationCallLimits;policy?:AccessPolicy;relay?:AppCallRelayPorts}){
  const store=new PostgresAtomicStore(options.pool),policy=options.policy??new PostgresCommunicationAccessPolicy(options.pool);
  this.directory=new PostgresVoiceDirectory(options.pool);this.extensions=new VoiceExtensionService(store,policy,this.directory);
  this.calls=new InternalExtensionCallService(store,policy,this.directory,options.limits);this.channel=new InternalExtensionCallChannel(this.calls);this.media=options.relay?new InternalCallMediaService(store,policy,options.limits,options.relay):null;
 }
 execute(actor:Actor,request:InternalCallRequest){return this.channel.execute(actor,request);}
}
