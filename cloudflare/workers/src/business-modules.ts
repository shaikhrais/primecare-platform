import {tenantDashboard} from './tenant-dashboard/service';
import {careDelivery} from './care/service';
import {lookReview} from './look/service';
import {growth} from './growth/service';
import {platformAdministration} from './platform-administration';
import {reporting} from './reporting';
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
    {name: 'tenant-dashboard', handle: tenantDashboard},
    {name: 'client-booking-lifecycle', handle: clientBookingLifecycle},
    {name: 'provider-timesheet-items', handle: providerTimesheetItems},
    {name: 'provider-records', handle: providerRecords},
    {name: 'provider-self', handle: providerSelf},
    {name: 'client-self', handle: clientSelf},
    {name: 'governance', handle: governanceApi},
    {name: 'care-delivery', handle: careDelivery},
    {name: 'growth', handle: growth},
    {name: 'look-review', handle: lookReview},
    {name: 'workspace', handle: workspace},
    {name: 'reporting', handle: reporting},
    {name: 'platform-administration', handle: platformAdministration},
  ].map(module => Object.freeze(module)));
