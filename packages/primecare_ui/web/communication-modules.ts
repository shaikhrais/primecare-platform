import metadata from '../catalogs/communication-modules.registration.json';
import {PrimeWorkModule,WorkModuleSession,WorkFailure} from './work-modules';
export {WorkModuleSession,WorkFailure};
export {CommunicationModulePort} from '../../shared/src/communications/module-port';
export {RegisteredModuleTransport} from '../../shared/src/communications/module-transport';
/** Four optional registered templates sharing the actor-bound collection/editor engine. */
export class PrimeCommunicationModule extends PrimeWorkModule {
 constructor(root:HTMLElement,session:WorkModuleSession,options:{locale:'en'|'fr'|'es';year:number;month:number;firstWeekday:number}){if(!['mailbox','messenger','notifications','files'].includes(session.module)||session.scope.dataset!=='live')throw new WorkFailure('unavailable');super(root,session,{...options,metadata});}
}
