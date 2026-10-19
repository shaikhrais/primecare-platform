import {workerHandler} from './core/base-worker';
import {ServiceApplication} from './service-application';
import type {Env} from './auth';

/** Compatibility class: all lifecycle and dispatch behavior is inherited. */
export class ServiceWorker extends ServiceApplication {}

export default workerHandler(new ServiceWorker()) satisfies ExportedHandler<Env>;
