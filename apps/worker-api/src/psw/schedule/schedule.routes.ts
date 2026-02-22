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

// GET Offered Shifts
r.get('/offers', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const offers = await prisma.shiftAssignment.findMany({
        where: { pswId: profile.id, status: 'offered' },
        include: {
            visit: {
                include: {
                    client: { select: { fullName: true, addressLine1: true, city: true } },
                    service: true,
                }
            }
        }
    });

    return c.json(offers);
});

// POST Accept Offer
r.post('/offers/:id/accept', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const assignmentId = c.req.param('id');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const assignment = await prisma.shiftAssignment.findUnique({
        where: { id: assignmentId },
        include: { visit: true }
    });

    if (!assignment || assignment.pswId !== profile.id) {
        return c.json({ error: 'Offer not found' }, 404);
    }

    await prisma.$transaction([
        prisma.shiftAssignment.update({
            where: { id: assignmentId },
            data: { status: 'accepted' }
        }),
        prisma.visit.update({
            where: { id: assignment.visitId },
            data: {
                status: 'accepted',
                assignedPswId: profile.id // Also set this to move to assigned soon
            }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'ACCEPT_OFFER',
                resourceType: 'VISIT',
                resourceId: assignment.visitId,
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json({ success: true });
});

// POST Decline Offer
r.post('/offers/:id/decline', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const assignmentId = c.req.param('id');

    await prisma.shiftAssignment.update({
        where: { id: assignmentId },
        data: { status: 'declined' }
    });

    return c.json({ success: true });
});

// POST Update Availability
r.post('/availability', zValidator('json', z.array(z.object({
    dayOfWeek: z.number().min(0).max(6),
    startTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
    endTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
}))), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const availabilityData = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    await prisma.$transaction([
        prisma.availability.deleteMany({ where: { pswId: profile.id } }),
        ...availabilityData.map(data => prisma.availability.create({
            data: {
                pswId: profile.id,
                ...data,
                tenantId: profile.tenantId
            }
        }))
    ]);

    return c.json({ success: true });
});

export default r;
