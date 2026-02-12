import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const CheckEventSchema = z.object({
    lat: z.number(),
    lng: z.number(),
    accuracy: z.number().optional(),
});

const calculateDistance = (lat1: number, lon1: number, lat2: number, lon2: number) => {
    const R = 6371e3; // Earth radius in meters
    const φ1 = lat1 * Math.PI / 180;
    const φ2 = lat2 * Math.PI / 180;
    const Δφ = (lat2 - lat1) * Math.PI / 180;
    const Δλ = (lon2 - lon1) * Math.PI / 180;

    const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
        Math.cos(φ1) * Math.cos(φ2) *
        Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c; // Distance in meters
};

// GET Assigned Visits
r.get('/visits', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visits = await prisma.visit.findMany({
        where: {
            assignedPswId: profile.id,
            status: { in: ['scheduled', 'en_route', 'arrived', 'in_progress'] },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, addressLine1: true, city: true } },
            service: true,
        },
    });

    return c.json(visits);
});

// POST Check-In
r.post('/visits/:id/check-in', zValidator('json', CheckEventSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { client: true },
    });
    if (!visit || visit.assignedPswId !== profile.id) {
        return c.json({ error: 'Visit not found or not assigned to you' }, 404);
    }

    let result: 'success' | 'rejected' = 'success';
    if (visit.client?.lat && visit.client?.lng) {
        const distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng);
        if (distance > 500) {
            return c.json({
                error: 'Too far from client location',
                distance: Math.round(distance),
                threshold: 500
            }, 400);
        }
    }

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId,
                pswId: profile.id,
                eventType: 'check_in',
                lat,
                lng,
                accuracyM: accuracy,
                result,
                tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'in_progress' },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CHECK_IN',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { result, lat, lng },
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event);
});

// POST Check-Out
r.post('/visits/:id/check-out', zValidator('json', CheckEventSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId,
                pswId: profile.id,
                eventType: 'check_out',
                lat,
                lng,
                accuracyM: accuracy,
                result: 'success',
                tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'completed' },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CHECK_OUT',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { lat, lng },
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event);
});

// POST Payout Request
r.post('/payouts/request', async (c) => {
    return c.json({ success: true, message: 'Payout requested successfully. Admin will review.' });
});

export default r;
