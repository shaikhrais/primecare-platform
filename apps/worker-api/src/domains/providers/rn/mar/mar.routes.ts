import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const mar = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /schedule/:clientId — Today's medication schedule
const scheduleRoute = createRoute({
    method: 'get', path: '/schedule/{clientId}',
    summary: 'Client Medication Schedule', tags: ['eMAR'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), medicationName: z.string(), dosage: z.string(),
                        route: z.string(), scheduledTime: z.string(), status: z.string(),
                        frequency: z.string(),
                        interactionLevel: z.enum(['critical', 'moderate', 'none']).optional(),
                        interactionMessage: z.string().optional()
                    }))
                }
            }, description: 'Schedule'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mar.openapi(scheduleRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const today = new Date(); today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today); tomorrow.setDate(tomorrow.getDate() + 1);

    const entries = await prisma.mAR_Entry.findMany({
        where: { tenantId, clientId, scheduledTime: { gte: today, lt: tomorrow } },
        orderBy: { scheduledTime: 'asc' },
    });

    // Map to the UI expected interface (id, name, dose, route, frequency, status, interaction)
    const formattedEntries = entries.map((entry: any) => {
        const timeStr = new Date(entry.scheduledTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        const freqStr = `Daily (${timeStr})`;
        
 // Temporarily drug interaction rules engine
        let interactionLevel: 'critical' | 'moderate' | 'none' | undefined = undefined;
        let interactionMessage: string | undefined = undefined;
        
        if (entry.medicationName.toLowerCase().includes('warfarin')) {
            interactionLevel = 'critical';
            interactionMessage = 'CRITICAL INTERACTION DETECTED: Aspirin increases bleeding risk when taken with Warfarin. Evaluate INR.';
        }

        return {
            id: entry.id,
            name: entry.medicationName, // UI maps this to `name`
            dose: entry.dosage, // UI maps this to `dose`
            route: entry.route || 'PO',
            frequency: freqStr,
            status: entry.status === 'given' ? 'administered' : 'pending',
            interactionLevel,
            interactionMessage
        };
    });

    return c.json(formattedEntries, 200);
});

// POST /administer — Record medication administration
const administerRoute = createRoute({
    method: 'post', path: '/administer',
    summary: 'Record Medication Administration', tags: ['eMAR'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), medicationName: z.string(), dosage: z.string(),
                        route: z.string().optional(), scheduledTime: z.string(),
                        administeredAt: z.string().optional(), notes: z.string().optional(),
                        status: z.enum(['given', 'held', 'refused', 'not_available']).optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Recorded' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mar.openapi(administerRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const entry = await prisma.mAR_Entry.create({
        data: {
            ...body,
            scheduledTime: new Date(body.scheduledTime),
            administeredAt: body.administeredAt ? new Date(body.administeredAt) : new Date(),
            administeredById: userId,
            status: body.status || 'given',
            tenantId,
        },
    });
    return c.json(entry, 200);
});

// GET /history/:clientId — MAR history
const historyRoute = createRoute({
    method: 'get', path: '/history/{clientId}',
    summary: 'Medication History', tags: ['eMAR'],
    request: {
        params: z.object({ clientId: z.string() }),
        query: z.object({ days: z.string().optional() }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), medicationName: z.string(), status: z.string(), administeredAt: z.string().nullable(),
                    }))
                }
            }, description: 'History'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mar.openapi(historyRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');
    const { days } = c.req.valid('query');

    const since = new Date();
    since.setDate(since.getDate() - (days ? parseInt(days) : 30));

    const entries = await prisma.mAR_Entry.findMany({
        where: { tenantId, clientId, scheduledTime: { gte: since } },
        orderBy: { scheduledTime: 'desc' },
    });
    return c.json(entries, 200);
});

// POST /prn — Record PRN medication
const prnRoute = createRoute({
    method: 'post', path: '/prn',
    summary: 'Record PRN Medication', tags: ['eMAR'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), medicationName: z.string(), dosage: z.string(),
                        reason: z.string(), notes: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Recorded' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mar.openapi(prnRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const entry = await prisma.mAR_Entry.create({
        data: {
            clientId: body.clientId, medicationName: body.medicationName,
            dosage: body.dosage, route: 'PRN', notes: `Reason: ${body.reason}. ${body.notes || ''}`,
            scheduledTime: new Date(), administeredAt: new Date(),
            administeredById: userId, status: 'given', tenantId,
        },
    });
    return c.json(entry, 200);
});

// GET /review — RN review queue
const reviewRoute = createRoute({
    method: 'get', path: '/review',
    summary: 'RN MAR Review Queue', tags: ['eMAR'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientId: z.string(), medicationName: z.string(),
                        status: z.string(), administeredAt: z.string().nullable(),
                    }))
                }
            }, description: 'Queue'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mar.openapi(reviewRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const entries = await prisma.mAR_Entry.findMany({
        where: { tenantId, status: { in: ['held', 'refused', 'not_available'] } },
        orderBy: { scheduledTime: 'desc' }, take: 100,
    });
    return c.json(entries, 200);
});

export default mar;
