import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const family = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /members — List family members for a client
const listRoute = createRoute({
    method: 'get', path: '/members',
    summary: 'Client Family Members', tags: ['Family'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), name: z.string(), relationship: z.string(),
                        email: z.string().nullable(), accessLevel: z.string(),
                        isEmergency: z.boolean(),
                    }))
                }
            }, description: 'Members'
        },
    },
});

family.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;

    const clientProfile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!clientProfile) return c.json([], 200);

    const members = await prisma.familyMember.findMany({
        where: { tenantId, clientId: clientProfile.id },
    });
    return c.json(members, 200);
});

// POST /members — Add family member
const addRoute = createRoute({
    method: 'post', path: '/members',
    summary: 'Add Family Member', tags: ['Family'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), name: z.string(),
                        email: z.string().optional(), phone: z.string().optional(),
                        relationship: z.string(),
                        accessLevel: z.enum(['view_only', 'care_updates', 'full']).optional(),
                        isEmergency: z.boolean().optional(),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Added' } },
});

family.openapi(addRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const member = await prisma.familyMember.create({
        data: { ...body, tenantId },
    });
    return c.json(member, 200);
});

// GET /feed/:clientId — View-only care feed
const feedRoute = createRoute({
    method: 'get', path: '/feed/{clientId}',
    summary: 'Family Care Feed', tags: ['Family'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        recentVisits: z.array(z.object({ id: z.string(), status: z.string(), requestedStartAt: z.string().nullable() })),
                        carePlan: z.object({ diagnoses: z.array(z.string()), status: z.string() }).nullable(),
                        recentEntries: z.array(z.object({ id: z.string(), activities: z.string().nullable() })),
                    })
                }
            }, description: 'Feed'
        },
    },
});

family.openapi(feedRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const [recentVisits, carePlan, recentEntries] = await Promise.all([
        prisma.visit.findMany({
            where: { clientId, status: { in: ['completed', 'in_progress', 'scheduled'] } },
            orderBy: { requestedStartAt: 'desc' }, take: 10,
            select: { id: true, status: true, requestedStartAt: true },
        }),
        prisma.carePlan.findFirst({
            where: { clientId, tenantId, status: 'active' },
            select: { diagnoses: true, status: true, clinicalGoals: true },
        }),
        prisma.dailyEntry.findMany({
            where: { tenantId },
            orderBy: { createdAt: 'desc' }, take: 5,
            select: { id: true, activities: true },
        }),
    ]);

    return c.json({ recentVisits, carePlan, recentEntries }, 200);
});

// POST /message — Family sends message
const messageRoute = createRoute({
    method: 'post', path: '/message',
    summary: 'Family Message to Coordinator', tags: ['Family'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), subject: z.string(), body: z.string(),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ sent: z.boolean() }) } }, description: 'Sent' } },
});

family.openapi(messageRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    await prisma.auditLog.create({
        data: {
            actorUserId: userId, action: 'FAMILY_MESSAGE', resourceType: 'CLIENT',
            resourceId: body.clientId,
            metadataJson: { subject: body.subject, body: body.body },
            tenantId,
        },
    });
    return c.json({ sent: true }, 200);
});

export default family;
