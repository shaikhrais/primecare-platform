import metadata from '../catalogs/application-modules.registration.json';
import {PrimeWorkModule,WorkModuleSession,WorkFailure} from './work-modules';
export {WorkModuleSession,WorkFailure};export {ApplicationSettingsPort} from '../../shared/src/application-modules/settings-port';export {ApplicationProfilePort,applicationPreferenceTransport} from '../../shared/src/application-modules/transport';
/** Approved read/settings adapters or honest unavailable slots; no provider, purchase or sensitive-account shortcuts. */
export class PrimeApplicationModule extends PrimeWorkModule {constructor(root:HTMLElement,session:WorkModuleSession,options:{locale:'en'|'fr'|'es';year:number;month:number;firstWeekday:number}){if(!['academy','commerce','ai-images','profile','settings','help'].includes(session.module)||session.scope.dataset!=='live')throw new WorkFailure('unavailable');super(root,session,{...options,metadata});}}
