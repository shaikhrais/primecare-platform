import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const feedback = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /feedback — Submit visit feedback
const submitRoute = createRoute({
    method: 'post', path: '/',
    summary: 'Submit feedback for a visit', tags: ['Client Feedback'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string(), rating: z.number().min(1).max(5),
                        comment: z.string().optional(), category: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Feedback submitted' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

feedback.openapi(submitRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const client = await prisma.clientProfile.findFirst({ where: { userId } });

    const fb = await prisma.careFeedback.create({
        data: {
            tenantId, clientId: client?.id || '', visitId: body.visitId,
            rating: body.rating, comment: body.comment || '',
            category: body.category || 'general', status: 'submitted',
        },
    });

    // Feature 46: Care Feedback Resolution (1-Star Escalation)
    if (body.rating === 1 && client?.id) {
        // Look up the visit to find the Supervising RN and Family Member
        const visit = await prisma.visit.findUnique({
             where: { id: body.visitId }, include: { psw: { include: { user: true } } }
        });
        const rnUser = await prisma.user.findFirst({ where: { tenantId, roles: { contains: 'rn' } } });
        
        if (visit && rnUser) {
             const thread = await prisma.messageThread.create({
                 data: {
                     tenantId, threadType: 'escalation',
                     clientId: client?.id,
                 }
             });
             await prisma.message.create({
                 data: {
                     threadId: thread.id, senderUserId: 'system',
                     bodyText: `CRITICAL ESCALATION: A 1-star feedback was received for Visit ${visit.id} (PSW: ${visit.psw?.user?.fullName || 'Unknown'}). Please contact the family regarding: "${body.comment}"`
                 }
             });
             console.log(`[Worker] Feature 46 Fired: 1-Star feedback generated emergency MessageThread ${thread.id} between Family ${userId} and RN ${rnUser.id}.`);
        }
    }

    return c.json({ id: fb.id }, 200);
});

// GET /feedback/surveys — Pending surveys
const surveysRoute = createRoute({
    method: 'get', path: '/surveys',
    summary: 'List pending satisfaction surveys for client', tags: ['Client Feedback'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        visitId: z.string(), visitDate: z.string(), serviceName: z.string(),
                        pswName: z.string(), hasRated: z.boolean(),
                    }))
                }
            }, description: 'Pending surveys'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

feedback.openapi(surveysRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json([], 200);

    // Get recent completed visits that haven't been rated
    const visits = await prisma.visit.findMany({
        where: { clientId: client.id, status: 'completed' },
        include: {
            service: { select: { name: true } },
            assignedPsw: { select: { fullName: true } },
        },
        orderBy: { requestedStartAt: 'desc' }, take: 20,
    });

    const feedbacks = await prisma.careFeedback.findMany({
        where: { clientId: client.id }, select: { visitId: true },
    });
    const ratedVisitIds = new Set(feedbacks.map((f: any) => f.visitId));

    return c.json(visits.map((v: any) => ({
        visitId: v.id, visitDate: v.requestedStartAt,
        serviceName: v.service?.name || '', pswName: v.assignedPsw?.fullName || '',
        hasRated: ratedVisitIds.has(v.id),
    })), 200);
});

// GET /feedback/analytics — Admin analytics (satisfaction)
const analyticsRoute = createRoute({
    method: 'get', path: '/analytics',
    summary: 'Satisfaction analytics across all clients', tags: ['Client Feedback'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        averageRating: z.number(), totalFeedback: z.number(),
                        ratingDistribution: z.record(z.number()),
                    })
                }
            }, description: 'Analytics'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

feedback.openapi(analyticsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const feedbacks = await prisma.careFeedback.findMany({ where: { tenantId } });
    const distribution: Record<string, number> = { '1': 0, '2': 0, '3': 0, '4': 0, '5': 0 };
    let sum = 0;

    for (const fb of feedbacks) {
        sum += fb.rating || 0;
        const key = String(fb.rating || 0);
        if (distribution[key] !== undefined) distribution[key]++;
    }

    return c.json({
        averageRating: feedbacks.length > 0 ? Math.round((sum / feedbacks.length) * 10) / 10 : 0,
        totalFeedback: feedbacks.length, ratingDistribution: distribution,
    }, 200);
});

export default feedback;
