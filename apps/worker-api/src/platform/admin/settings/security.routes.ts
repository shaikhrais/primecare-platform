import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const securityConfigSchema = z.object({
    enforceVpn: z.boolean(),
    allowedVpnRanges: z.array(z.string()),
    requireDeviceApproval: z.boolean(),
    maxDevicesPerUser: z.number(),
});

// GET /security - Get tenant security config
const getSecurityRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'Get Tenant Security Config',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: { 'application/json': { schema: securityConfigSchema } },
            description: 'Success',
        },
    },
});

r.openapi(getSecurityRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const tenant = await prisma.tenant.findUnique({
        where: { id: tenantId },
        select: {
            enforceVpn: true,
            allowedVpnRanges: true,
            requireDeviceApproval: true,
            maxDevicesPerUser: true,
        },
    });
    return c.json(tenant || {
        enforceVpn: false,
        allowedVpnRanges: [],
        requireDeviceApproval: false,
        maxDevicesPerUser: 5,
    }, 200);
});

// PATCH /security - Update tenant security config
const updateSecurityRoute = createRoute({
    method: 'patch',
    path: '/',
    summary: 'Update Tenant Security Config',
    tags: ['Admin Security'],
    request: {
        body: {
            content: { 'application/json': { schema: securityConfigSchema.partial() } },
        },
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ success: z.boolean() }) } },
            description: 'Success',
        },
    },
});

r.openapi(updateSecurityRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const body = c.req.valid('json');

    await prisma.tenant.update({
        where: { id: tenantId },
        data: body,
    });
    return c.json({ success: true }, 200);
});

// GET /devices - List all devices for the tenant
const listDevicesRoute = createRoute({
    method: 'get',
    path: '/devices',
    summary: 'List All Tenant Devices',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        userId: z.string(),
                        deviceId: z.string(),
                        deviceName: z.string().nullable(),
                        deviceType: z.string().nullable(),
                        lastIp: z.string().nullable(),
                        status: z.string(),
                        isAuthorized: z.boolean(),
                        isTemporary: z.boolean(),
                        expiresAt: z.string().nullable(),
                        lastActiveAt: z.string(),
                        user: z.object({
                            firstName: z.string().nullable(),
                            lastName: z.string().nullable(),
                            email: z.string(),
                        }),
                    })),
                },
            },
            description: 'Success',
        },
    },
});

r.openapi(listDevicesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const devices = await prisma.userDevice.findMany({
        where: { user: { tenantId } },
        include: {
            user: {
                select: { firstName: true, lastName: true, email: true }
            }
        },
        orderBy: { lastActiveAt: 'desc' }
    });

    return c.json(devices as any, 200);
});

// POST /devices/:id/authorize - Authorize a device
const authorizeDeviceRoute = createRoute({
    method: 'post',
    path: '/devices/:id/authorize',
    summary: 'Authorize a Device',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ success: z.boolean() }) } },
            description: 'Success',
        },
        404: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Device not found',
        },
    },
});

r.openapi(authorizeDeviceRoute, async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const tenantId = c.get('jwtPayload').tenantId;

    const device = await prisma.userDevice.findUnique({
        where: { id },
        include: { user: true }
    });

    if (!device || device.user.tenantId !== tenantId) {
        return c.json({ error: 'Device not found' }, 404);
    }

    await prisma.userDevice.update({
        where: { id },
        data: {
            isAuthorized: true,
            authorizedAt: new Date(),
            status: 'active'
        }
    });

    return c.json({ success: true }, 200);
});

// POST /devices/:id/revoke - Revoke a device
const revokeDeviceRoute = createRoute({
    method: 'post',
    path: '/devices/:id/revoke',
    summary: 'Revoke a Device',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ success: z.boolean() }) } },
            description: 'Success',
        },
        404: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Device not found',
        },
    },
});

r.openapi(revokeDeviceRoute, async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const tenantId = c.get('jwtPayload').tenantId;

    const device = await prisma.userDevice.findUnique({
        where: { id },
        include: { user: true }
    });

    if (!device || device.user.tenantId !== tenantId) {
        return c.json({ error: 'Device not found' }, 404);
    }

    await prisma.userDevice.update({
        where: { id },
        data: {
            status: 'revoked',
            isAuthorized: false
        }
    });

    return c.json({ success: true }, 200);
});

// GET /devices/:deviceId/activity - Get activity for a specific device
const getDeviceActivityRoute = createRoute({
    method: 'get',
    path: '/devices/:deviceId/activity',
    summary: 'Get Device Activity Logs',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        action: z.string(),
                        resourceType: z.string(),
                        createdAt: z.string(),
                        ipAddress: z.string().nullable(),
                        metadataJson: z.any().nullable(),
                    })),
                },
            },
            description: 'Success',
        },
    },
});

r.openapi(getDeviceActivityRoute, async (c) => {
    const prisma = c.get('prisma');
    const deviceId = c.req.param('deviceId');
    const tenantId = c.get('jwtPayload').tenantId;

    const logs = await prisma.auditLog.findMany({
        where: { deviceId, tenantId },
        orderBy: { createdAt: 'desc' },
        take: 100
    });

    return c.json(logs as any, 200);
});

// GET /forensic-trails - Get all system events for the tenant
const getForensicTrailsRoute = createRoute({
    method: 'get',
    path: '/forensic-trails',
    summary: 'Get Forensic System Events',
    tags: ['Admin Security'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        tenantId: z.string(),
                        operation: z.string(),
                        modelName: z.string(),
                        entityId: z.string().nullable(),
                        payload: z.any().nullable(),
                        previousData: z.any().nullable(),
                        actorUserId: z.string().nullable(),
                        deviceId: z.string().nullable(),
                        ipAddress: z.string().nullable(),
                        createdAt: z.string(),
                        actor: z.object({
                            email: z.string()
                        }).nullable().optional()
                    })),
                },
            },
            description: 'Success',
        },
    },
});

r.openapi(getForensicTrailsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const events = await prisma.systemEvent.findMany({
        where: { tenantId },
        include: {
            actor: { select: { email: true } }
        },
        orderBy: { createdAt: 'desc' },
        take: 100
    });

    return c.json(events as any, 200);
});

// GET /daily-summary - Aggregated daily system activity
const getDailySummaryRoute = createRoute({
    method: 'get',
    path: '/daily-summary',
    summary: 'Get Daily Activity Summary',
    tags: ['Admin Security'],
    request: {
        query: z.object({
            date: z.string().optional(), // YYYY-MM-DD
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        date: z.string(),
                        totalEvents: z.number(),
                        byUser: z.array(z.object({
                            actorUserId: z.string().nullable(),
                            email: z.string().optional(),
                            count: z.number(),
                            operations: z.record(z.number()),
                        })),
                        byModel: z.record(z.number()),
                    }),
                },
            },
            description: 'Success',
        },
    },
});

r.openapi(getDailySummaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const dateStr = c.req.query('date') || new Date().toISOString().split('T')[0];

    const startOfDay = new Date(dateStr);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(dateStr);
    endOfDay.setHours(23, 59, 59, 999);

    const events = await prisma.systemEvent.findMany({
        where: {
            tenantId,
            createdAt: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
        include: {
            actor: { select: { email: true } }
        }
    });

    const summary = {
        date: dateStr,
        totalEvents: events.length,
        byUser: [] as any[],
        byModel: {} as Record<string, number>,
    };

    const userMap = new Map<string | null, any>();

    for (const event of events) {
        // Aggregate by Model
        summary.byModel[event.modelName] = (summary.byModel[event.modelName] || 0) + 1;

        // Aggregate by User
        let userStats = userMap.get(event.actorUserId);
        if (!userStats) {
            userStats = {
                actorUserId: event.actorUserId,
                email: event.actor?.email || 'System/Unknown',
                count: 0,
                operations: {} as Record<string, number>,
            };
            userMap.set(event.actorUserId, userStats);
        }
        userStats.count++;
        userStats.operations[event.operation] = (userStats.operations[event.operation] || 0) + 1;
    }

    summary.byUser = Array.from(userMap.values());

    return c.json(summary as any, 200);
});

export default r;
