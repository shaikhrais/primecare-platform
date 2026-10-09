import {providerTimesheetItems} from './provider-timesheet-items';
import {clientBookingLifecycle} from './client-booking-lifecycle';
import {providerSelf} from './provider-self';
import {providerRecords} from './provider-records';
import {clientSelf} from './client-self';
import {workspace} from './workspace';
import {governanceApi} from './governance-api';
import type {Env} from './auth';

type BusinessHandler = (request: Request, env: Env, path: string,
  headers: HeadersInit) => Response | null | Promise<Response | null>;

/** One ordered registry shared by every service. Handlers retain their authority checks. */
export const businessModules: readonly Readonly<{name: string; handle: BusinessHandler}>[] =
  Object.freeze([
    {name: 'client-booking-lifecycle', handle: clientBookingLifecycle},
    {name: 'provider-timesheet-items', handle: providerTimesheetItems},
    {name: 'provider-records', handle: providerRecords},
    {name: 'provider-self', handle: providerSelf},
    {name: 'client-self', handle: clientSelf},
    {name: 'governance', handle: governanceApi},
    {name: 'workspace', handle: workspace},
  ].map(module => Object.freeze(module)));
