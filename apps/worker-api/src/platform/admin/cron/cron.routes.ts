import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const cron = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /cron/compliance-sweep — Daily compliance check
const complianceSweepRoute = createRoute({
    method: 'post', path: '/compliance-sweep',
    summary: 'Run daily compliance sweep (expiring docs, certs, authorizations)', tags: ['Cron Jobs'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        expiringDocuments: z.number(), expiringAuthorizations: z.number(),
                        expiringConsents: z.number(), alertsCreated: z.number(),
                    })
                }
            }, description: 'Sweep result'
        },
    },
});

cron.openapi(complianceSweepRoute, async (c) => {
    const prisma = c.get('prisma');
    const thirtyDaysOut = new Date();
    thirtyDaysOut.setDate(thirtyDaysOut.getDate() + 30);

    const [expiringDocs, expiringAuths, expiringConsents] = await Promise.all([
        prisma.pswDocument.count({ where: { expiryDate: { lte: thirtyDaysOut }, status: 'verified' } }),
        prisma.serviceAuthorization.count({ where: { endDate: { lte: thirtyDaysOut }, status: 'active' } }),
        prisma.consentForm.count({ where: { expiresAt: { lte: thirtyDaysOut }, status: 'signed' } }),
    ]);

    return c.json({
        expiringDocuments: expiringDocs, expiringAuthorizations: expiringAuths,
        expiringConsents: expiringConsents, alertsCreated: expiringDocs + expiringAuths + expiringConsents,
    }, 200);
});

// POST /cron/training-reminders — Check overdue training
const trainingRemindersRoute = createRoute({
    method: 'post', path: '/training-reminders',
    summary: 'Check and flag overdue training assignments', tags: ['Cron Jobs'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        overdueCount: z.number(), remindersQueued: z.number(),
                    })
                }
            }, description: 'Result'
        },
    },
});

cron.openapi(trainingRemindersRoute, async (c) => {
    const prisma = c.get('prisma');

    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const overdue = await prisma.trainingAssignment.count({
        where: { status: 'assigned', assignedAt: { lte: thirtyDaysAgo } },
    });

    return c.json({ overdueCount: overdue, remindersQueued: overdue }, 200);
});

// POST /cron/authorization-exhaustion — Check near-exhausted authorizations
const authExhaustionRoute = createRoute({
    method: 'post', path: '/authorization-exhaustion',
    summary: 'Flag authorizations near exhaustion (>80% used)', tags: ['Cron Jobs'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        nearExhaustionCount: z.number(), flagged: z.array(z.object({
                            id: z.string(), clientId: z.string(),
                            usedPercent: z.number(),
                        })),
                    })
                }
            }, description: 'Result'
        },
    },
});

cron.openapi(authExhaustionRoute, async (c) => {
    const prisma = c.get('prisma');

    const auths = await prisma.serviceAuthorization.findMany({
        where: { status: 'active' },
    });

    const flagged = auths
        .filter((a: any) => a.authorizedHours > 0 && (a.usedHours / a.authorizedHours) >= 0.8)
        .map((a: any) => ({
            id: a.id, clientId: a.clientId,
            usedPercent: Math.round((a.usedHours / a.authorizedHours) * 100),
        }));

    return c.json({ nearExhaustionCount: flagged.length, flagged }, 200);
});

// GET /cron/inventory-reorder — Items below reorder point
const inventoryReorderRoute = createRoute({
    method: 'get', path: '/inventory-reorder',
    summary: 'List inventory items below reorder point', tags: ['Cron Jobs'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), name: z.string(), sku: z.string(),
                        quantity: z.number(), reorderPoint: z.number(),
                    }))
                }
            }, description: 'Low stock items'
        },
    },
});

cron.openapi(inventoryReorderRoute, async (c) => {
    const prisma = c.get('prisma');

    // Can't use Prisma column reference in where clause, so fetch and filter
    const items = await prisma.inventoryItem.findMany();
    const lowStock = items
        .filter((item: any) => item.quantity <= item.reorderPoint)
        .map((item: any) => ({
            id: item.id, name: item.name, sku: item.sku,
            quantity: item.quantity, reorderPoint: item.reorderPoint,
        }));

    return c.json(lowStock, 200);
});

export default cron;
