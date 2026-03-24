import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const allied = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /home/stats — Allied health home
const homeRoute = createRoute({
    method: 'get', path: '/home/stats',
    summary: 'Allied health professional home stats', tags: ['Allied Health'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        assignedClients: z.number(), todayVisits: z.number(),
                        completedThisWeek: z.number(), pendingNotes: z.number(),
                    })
                }
            }, description: 'Stats'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

allied.openapi(homeRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const psw = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!psw) return c.json({ assignedClients: 0, todayVisits: 0, completedThisWeek: 0, pendingNotes: 0 }, 200);

    const today = new Date(); today.setHours(0, 0, 0, 0);
    const weekAgo = new Date(); weekAgo.setDate(weekAgo.getDate() - 7);

    const [assigned, todayCount, weekCount] = await Promise.all([
        prisma.visit.count({ where: { assignedPswId: psw.id, status: { in: ['assigned', 'in_progress'] } } }),
        prisma.visit.count({ where: { assignedPswId: psw.id, requestedStartAt: { gte: today } } }),
        prisma.visit.count({ where: { assignedPswId: psw.id, status: 'completed', requestedStartAt: { gte: weekAgo } } }),
    ]);

    return c.json({
        assignedClients: assigned, todayVisits: todayCount,
        completedThisWeek: weekCount, pendingNotes: 0,
    }, 200);
});

// GET /treatments — Assigned treatments
const treatmentsRoute = createRoute({
    method: 'get', path: '/treatments',
    summary: 'List assigned treatments for allied health professional', tags: ['Allied Health'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        visitId: z.string(), clientName: z.string(),
                        serviceType: z.string(), scheduledAt: z.string(), status: z.string(),
                    }))
                }
            }, description: 'Treatments'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

allied.openapi(treatmentsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const psw = await prisma.pswProfile.findUnique({ where: { userId } });

    const visits = await prisma.visit.findMany({
        where: { assignedPswId: psw?.id, status: { in: ['assigned', 'in_progress', 'completed'] } },
        include: { client: { select: { fullName: true } }, service: { select: { name: true } } },
        orderBy: { requestedStartAt: 'desc' }, take: 50,
    });

    return c.json(visits.map((v: any) => ({
        visitId: v.id, clientName: v.client?.fullName || '',
        serviceType: v.service?.name || '', scheduledAt: v.requestedStartAt, status: v.status,
    })), 200);
});

// POST /treatments/:id/sign-off — Sign off on a treatment
const signOffRoute = createRoute({
    method: 'post', path: '/treatments/{visitId}/sign-off',
    summary: 'Sign off on a completed treatment', tags: ['Allied Health'],
    request: {
        params: z.object({ visitId: z.string() }),
        body: { content: { 'application/json': { schema: z.object({ notes: z.string().optional() }) } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Signed off' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

allied.openapi(signOffRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId } = c.req.valid('param');
    const { notes } = c.req.valid('json');

    try {
        await prisma.visit.update({ where: { id: visitId }, data: { status: 'completed' } });
        if (notes) {
            const userId = (c.get('jwtPayload') as any).sub;
            const psw = await prisma.pswProfile.findUnique({ where: { userId } });
            if (psw) await prisma.visitNote.create({ data: { visitId, pswId: psw.id, noteText: notes } });
        }
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Visit not found' }, 404); }
});

export default allied;
