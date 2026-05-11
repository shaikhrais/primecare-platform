import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { sweepRegistryRoute, updateTouchpointRoute, listTouchpointsRoute, syncRegistriesRoute, handleSweepRegistry, handleUpdateTouchpoint, handleListTouchpoints, handleSyncRegistries } from './response-bot-defs';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.openapi(sweepRegistryRoute, handleSweepRegistry);
r.openapi(updateTouchpointRoute, handleUpdateTouchpoint);
r.openapi(listTouchpointsRoute, handleListTouchpoints);
r.openapi(syncRegistriesRoute, handleSyncRegistries);

export default r;
