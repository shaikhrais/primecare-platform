import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const mileage = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const calculateDistance = (lat1: number, lon1: number, lat2: number, lon2: number) => {
    const R = 6371; // Earth radius in km
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) ** 2 + Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * Math.sin(dLon / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
};

// GET / — PSW's mileage log
const listRoute = createRoute({
    method: 'get', path: '/', summary: 'My Mileage Log', tags: ['Mileage'],
    request: { query: z.object({ month: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), date: z.string(), distanceKm: z.number(),
                        reimbursementAmount: z.number().nullable(), status: z.string(),
                    }))
                }
            }, description: 'Log'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mileage.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json([], 200);

    const logs = await prisma.mileageLog.findMany({
        where: { tenantId, pswId: profile.id },
        orderBy: { date: 'desc' }, take: 200,
    });
    return c.json(logs, 200);
});

// POST /calculate — Auto-calculate between visits
const calculateRoute = createRoute({
    method: 'post', path: '/calculate', summary: 'Calculate Mileage Between Visits', tags: ['Mileage'],
    request: { body: { content: { 'application/json': { schema: z.object({ date: z.string() }) } } } },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        entries: z.number(), totalKm: z.number(), totalReimbursement: z.number(),
                    })
                }
            }, description: 'Calculated'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mileage.openapi(calculateRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const { date } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ entries: 0, totalKm: 0, totalReimbursement: 0 }, 200);

    const dayStart = new Date(date); dayStart.setHours(0, 0, 0, 0);
    const dayEnd = new Date(date); dayEnd.setHours(23, 59, 59, 999);

    const visits = await prisma.visit.findMany({
        where: { assignedPswId: profile.id, requestedStartAt: { gte: dayStart, lte: dayEnd } },
        include: { client: { select: { lat: true, lng: true, addressLine1: true } } },
        orderBy: { requestedStartAt: 'asc' },
    });

    let totalKm = 0;
    const CRA_RATE = 0.70;
    const entries: any[] = [];

    for (let i = 1; i < visits.length; i++) {
        const prev = visits[i - 1];
        const curr = visits[i];
        if (prev.client?.lat && prev.client?.lng && curr.client?.lat && curr.client?.lng) {
            const km = calculateDistance(prev.client.lat, prev.client.lng, curr.client.lat, curr.client.lng);
            const roundedKm = Math.round(km * 10) / 10;
            totalKm += roundedKm;
            entries.push({
                pswId: profile.id, date: dayStart,
                fromVisitId: prev.id, toVisitId: curr.id,
                fromAddress: prev.client.addressLine1, toAddress: curr.client.addressLine1,
                distanceKm: roundedKm, reimbursementRate: CRA_RATE,
                reimbursementAmount: Math.round(roundedKm * CRA_RATE * 100) / 100,
                tenantId,
            });
        }
    }

    if (entries.length > 0) {
        await prisma.mileageLog.createMany({ data: entries });
    }

    return c.json({ entries: entries.length, totalKm: Math.round(totalKm * 10) / 10, totalReimbursement: Math.round(totalKm * CRA_RATE * 100) / 100 }, 200);
});

// GET /summary — Period summary
const summaryRoute = createRoute({
    method: 'get', path: '/summary', summary: 'Mileage Summary', tags: ['Mileage'],
    request: { query: z.object({ startDate: z.string().optional(), endDate: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalKm: z.number(), totalReimbursement: z.number(), tripCount: z.number(),
                    })
                }
            }, description: 'Summary'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mileage.openapi(summaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ totalKm: 0, totalReimbursement: 0, tripCount: 0 }, 200);

    const logs = await prisma.mileageLog.findMany({
        where: { tenantId, pswId: profile.id },
    });

    const totalKm = logs.reduce((sum: number, l: any) => sum + l.distanceKm, 0);
    const totalReimbursement = logs.reduce((sum: number, l: any) => sum + (l.reimbursementAmount || 0), 0);

    return c.json({ totalKm: Math.round(totalKm * 10) / 10, totalReimbursement: Math.round(totalReimbursement * 100) / 100, tripCount: logs.length }, 200);
});

// POST /submit-override — Feature 14: Manual Mileage Validation
const submitOverrideRoute = createRoute({
    method: 'post', path: '/submit-override', summary: 'Manually Submit Override Mileage', tags: ['Mileage'],
    request: { 
        body: { 
            content: { 
                'application/json': { 
                    schema: z.object({ 
                        date: z.string(),
                        claimedDistanceKm: z.number(),
                        heuristicDistanceKm: z.number(),
                        reason: z.string().optional()
                    }) 
                } 
            } 
        } 
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.any() } }, description: 'Logged'
        },
        404: {
            description: 'Profile not found'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

mileage.openapi(submitOverrideRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const { date, claimedDistanceKm, heuristicDistanceKm, reason } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Feature 14 Logic: Flag if claimed is > 1.5x the Google Maps/Haversine heuristic estimate
    const isFraudulentSized = claimedDistanceKm > (heuristicDistanceKm * 1.5);
    const status = isFraudulentSized ? 'flagged' : 'approved';
    const CRA_RATE = 0.70;

    const log = await prisma.mileageLog.create({
        data: {
            pswId: profile.id,
            date: new Date(date),
            distanceKm: claimedDistanceKm,
            reimbursementRate: CRA_RATE,
            reimbursementAmount: claimedDistanceKm * CRA_RATE,
            status: status,
            tenantId,
            // Assuming there isn't a native reason field, we might normally add an Audit log.
            // But we will insert it into status or rely on the audit entry
        }
    });

    if (isFraudulentSized) {
        console.log(`[Worker] Feature 14 Fired: Mileage claim (${claimedDistanceKm}km) flagged for exceeding 1.5x heuristic (${heuristicDistanceKm}km)`);
    }

    return c.json(log, 200);
});

export default mileage;
