/**
 * Coordinator Route Definitions
 * Extracted from coordinator.routes.ts for modularity
 */
import { createRoute, z } from '@hono/zod-openapi';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { requirePermission } from '../../_shared/middleware/rbac';

export const CoordinatorStatsSchema = z.object({
    livePsw: z.number(),
    sosActive: z.number(),
    pendingMatches: z.number(),
    waitlistCount: z.number(),
});

export const SosIncidentSchema = z.object({
    id: z.string(),
    type: z.string(),
    status: z.string(),
    description: z.string(),
    createdAt: z.string(),
    reporter: z.object({ id: z.string(), email: z.string() }).nullable(),
    visit: z.object({
        client: z.object({ id: z.string(), fullName: z.string(), addressLine1: z.string() }),
        psw: z.object({ id: z.string(), fullName: z.string() }),
    }).nullable(),
});

export const matchOverrideRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.MATCH_OVERRIDE,
    method: 'post', path: '/match/override', summary: 'Match Override', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ visitId: z.string(), pswId: z.string(), reason: z.string().optional() }) } } } },
    responses: { 200: { description: 'Match overridden successfully', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const waitlistSyncRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.WAITLIST_SYNC,
    method: 'post', path: '/waitlist/sync', summary: 'Waitlist Sync', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ updates: z.array(z.object({ id: z.string(), priority: z.number() })) }) } } } },
    responses: { 200: { description: 'Waitlist synchronized', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const sosAckRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.SOS_ACK,
    method: 'post', path: '/incident/ack', summary: 'Sos Ack', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ incidentId: z.string(), notes: z.string().optional() }) } } } },
    responses: { 200: { description: 'SOS acknowledged', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const homeStatsRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.DASHBOARD_STATS,
    method: 'get', path: '/home/stats', summary: 'Home Stats', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    responses: { 200: { description: 'Coordinator home stats retrieved', content: { 'application/json': { schema: CoordinatorStatsSchema } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const dispatchMapRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.DISPATCH_MAP,
    method: 'get', path: '/dispatch-map', summary: 'Dispatch Map', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    responses: { 200: { description: 'Live dispatch map data retrieved', content: { 'application/json': { schema: z.object({ caregivers: z.array(z.any()), clients: z.array(z.any()), activeVisits: z.array(z.any()), recentEvents: z.array(z.any()) }) } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const matchingEngineRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.MATCHING_ENGINE,
    method: 'post', path: '/matching/run', summary: 'Matching Engine', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ visitId: z.string().optional() }) } } } },
    responses: { 200: { description: 'AI Matching sweep completed', content: { 'application/json': { schema: z.array(z.any()) } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const listSosRoute = createRoute({
    summary: 'List SOS Incidents', tags: ['Coordinator'],
    description: 'Retrieve a list of active SOS emergency alerts.',
    method: 'get', path: '/incidents',
    middleware: [requirePermission('manage_dispatch')],
    responses: { 200: { description: 'SOS incident list retrieved', content: { 'application/json': { schema: z.array(SosIncidentSchema) } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const sosDispatchRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.SOS_DISPATCH,
    method: 'post', path: '/sos-dispatch', summary: 'Sos Dispatch', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ incidentId: z.string(), pswId: z.string(), notes: z.string().optional() }) } } } },
    responses: { 200: { description: 'Emergency replacement dispatched', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const masterScheduleRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.MASTER_SCHEDULE,
    method: 'get', path: '/schedule/master', summary: 'Master Schedule', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    responses: { 200: { description: 'Master schedule retrieved', content: { 'application/json': { schema: z.array(z.any()) } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const shiftBroadcastRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.SHIFT_BROADCAST,
    method: 'post', path: '/shifts/broadcast', summary: 'Shift Broadcast', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    request: { body: { content: { 'application/json': { schema: z.object({ visitId: z.string(), pswIds: z.array(z.string()) }) } } } },
    responses: { 200: { description: 'Shift broadcasted successfully', content: { 'application/json': { schema: z.object({ success: z.boolean(), count: z.number() }) } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export const fleetPingRoute = createRoute({
    method: 'post', path: '/fleet/ping', summary: 'Ping Active Fleet', tags: ['Coordinator'],
    middleware: [requirePermission('manage_dispatch')],
    responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});
