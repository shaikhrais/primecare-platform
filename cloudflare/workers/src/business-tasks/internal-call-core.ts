import type {AccessPolicy,Actor,AtomicStore} from '../../../../packages/shared/src/communications/service-base.ts';
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
 constructor(options:{pool:Pool;limits:ConversationCallLimits;policy?:AccessPolicy;relay?:AppCallRelayPorts;transactionPool?:Pool;store?:AtomicStore}){
  // Advisory-lock transactions stay on native PostgreSQL. Fresh reads may use
  // the cache-disabled Hyperdrive transport; both target the same pinned DB.
  const transactionPool=options.transactionPool??options.pool,routed={query:options.pool.query.bind(options.pool),connect:transactionPool.connect.bind(transactionPool)};
  const store=options.store??new PostgresAtomicStore(routed),policy=options.policy??new PostgresCommunicationAccessPolicy(options.pool);
  this.directory=new PostgresVoiceDirectory(routed);this.extensions=new VoiceExtensionService(store,policy,this.directory);
  this.calls=new InternalExtensionCallService(store,policy,this.directory,options.limits);this.channel=new InternalExtensionCallChannel(this.calls);this.media=options.relay?new InternalCallMediaService(store,policy,options.limits,options.relay):null;
 }
 execute(actor:Actor,request:InternalCallRequest){return this.channel.execute(actor,request);}
}
