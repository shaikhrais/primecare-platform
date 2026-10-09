import {ServiceApplication} from './service-application';
import type {Env} from './auth';

export default new ServiceApplication() satisfies ExportedHandler<Env>;
