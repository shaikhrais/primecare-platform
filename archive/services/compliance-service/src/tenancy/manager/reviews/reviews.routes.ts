import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const reviews = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET / — List reviews
const listRoute = createRoute({
    method: 'get', path: '/', summary: 'List Performance Reviews', tags: ['Reviews'],
    request: { query: z.object({ status: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), providerId: z.string(), overallRating: z.number().nullable(),
                        status: z.string(), periodStart: z.string(), periodEnd: z.string(),
                    }))
                }
            }, description: 'Reviews'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

reviews.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { status } = c.req.valid('query');

    const where: any = { tenantId };
    if (status) where.status = status;

    const list = await prisma.performanceReview.findMany({
        where, orderBy: { periodEnd: 'desc' },
        include: { psw: { select: { fullName: true } }, reviewer: { select: { email: true } } },
    });
    return c.json(list, 200);
});

// POST / — Create review
const createRoute2 = createRoute({
    method: 'post', path: '/', summary: 'Create Performance Review', tags: ['Reviews'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        providerId: z.string(), periodStart: z.string(), periodEnd: z.string(),
                        overallRating: z.number().min(1).max(5).optional(),
                        strengths: z.string().optional(), improvements: z.string().optional(),
                        notes: z.string().optional(),
                        goals: z.array(z.object({ description: z.string(), dueDate: z.string().optional() })).optional(),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

reviews.openapi(createRoute2, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const reviewerId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const review = await prisma.performanceReview.create({
        data: {
            providerId: body.providerId, reviewerId,
            periodStart: new Date(body.periodStart), periodEnd: new Date(body.periodEnd),
            overallRating: body.overallRating, strengths: body.strengths,
            improvements: body.improvements, notes: body.notes,
            goals: body.goals || [], tenantId,
        },
    });
    return c.json(review, 200);
});

// GET /kpi/:providerId — PSW KPIs
const kpiRoute = createRoute({
    method: 'get', path: '/kpi/{providerId}', summary: 'PSW KPI Home', tags: ['Reviews'],
    request: { params: z.object({ providerId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        onTimeRate: z.number(), avgSatisfaction: z.number(),
                        incidentRate: z.number(), completionRate: z.number(), totalVisits: z.number(),
                    })
                }
            }, description: 'KPIs'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

reviews.openapi(kpiRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { providerId } = c.req.valid('param');

    const [visits, incidents, feedbacks, checkEvents] = await Promise.all([
        prisma.visit.count({ where: { assignedProviderId: providerId } }),
        prisma.incident.count({ where: { reporterUserId: providerId, tenantId } }),
        prisma.feedback.findMany({ where: { tenantId } }),
        prisma.visitCheckEvent.findMany({ where: { providerId, eventType: 'check_in' } }),
    ]);

    const completedVisits = await prisma.visit.count({ where: { assignedProviderId: providerId, status: 'completed' } });
    const avgSatisfaction = feedbacks.length > 0 ? feedbacks.reduce((s: number, f: any) => s + f.rating, 0) / feedbacks.length : 0;

    // On-time: check-in within 15 min of scheduled time
    let onTimeCount = 0;
    for (const ev of checkEvents) {
        const visit = await prisma.visit.findUnique({ where: { id: ev.visitId }, select: { requestedStartAt: true } });
        if (visit?.requestedStartAt) {
            const diff = Math.abs(new Date(ev.capturedAt || ev.createdAt).getTime() - new Date(visit.requestedStartAt).getTime());
            if (diff <= 15 * 60 * 1000) onTimeCount++;
        }
    }

    return c.json({
        totalVisits: visits, completionRate: visits > 0 ? Math.round((completedVisits / visits) * 100) : 0,
        onTimeRate: checkEvents.length > 0 ? Math.round((onTimeCount / checkEvents.length) * 100) : 0,
        avgSatisfaction: Math.round(avgSatisfaction * 10) / 10,
        incidentRate: visits > 0 ? Math.round((incidents / visits) * 10000) / 100 : 0,
    }, 200);
});

// PATCH /:id — Update review
const updateRoute = createRoute({
    method: 'patch', path: '/{id}', summary: 'Update Review', tags: ['Reviews'],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        overallRating: z.number().optional(), strengths: z.string().optional(),
                        improvements: z.string().optional(), notes: z.string().optional(),
                        status: z.string().optional(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

reviews.openapi(updateRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');

    const existing = await prisma.performanceReview.findFirst({ where: { id, tenantId } });
    if (!existing) return c.json({ error: 'Not found' }, 404);

    await prisma.performanceReview.update({ where: { id }, data: body });
    return c.json({ success: true }, 200);
});

export default reviews;
