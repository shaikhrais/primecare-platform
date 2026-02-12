import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';
import { policyMiddleware } from '../middleware/policy';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const CheckEventSchema = z.object({
    lat: z.number(),
    lng: z.number(),
    accuracy: z.number().optional(),
});

const ProfileUpdateSchema = z.object({
    bio: z.string().optional(),
    languages: z.array(z.string()).optional(),
    serviceAreas: z.array(z.string()).optional(),
});

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());
app.use('*', policyMiddleware());
app.use('*', rbacMiddleware(['psw']));

// GET Profile
/**
 * @openapi
 * /v1/psw/profile:
 *   get:
 *     summary: Get PSW Profile
 *     security:
 *       - bearerAuth: []
 */
app.get('/profile', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({
        where: { userId },
        include: { user: { select: { email: true, phone: true } } },
    });

    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    return c.json(profile);
});

// PUT Profile
/**
 * @openapi
 * /v1/psw/profile:
 *   put:
 *     summary: Update PSW Profile (Bio, Languages)
 *     security:
 *       - bearerAuth: []
 */
app.put('/profile', zValidator('json', ProfileUpdateSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const can = c.get('can');
    const profileExists = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profileExists) return c.json({ error: 'Profile not found' }, 404);

    if (!(await can('update', 'PswProfile', profileExists.id))) {
        return c.json({ error: 'Forbidden' }, 403);
    }

    const profile = await prisma.pswProfile.update({
        where: { userId },
        data: {
            bio: data.bio,
            languages: data.languages,
            serviceAreas: data.serviceAreas,
        },
    });

    return c.json(profile);
});

// GET Assigned Visits (Today & Upcoming)
/**
 * @openapi
 * /v1/psw/visits:
 *   get:
 *     summary: List Assigned Visits
 *     security:
 *       - bearerAuth: []
 */
app.get('/visits', async (c) => {
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

// POST Check-In
/**
 * @openapi
 * /v1/psw/visits/{id}/check-in:
 *   post:
 *     summary: GPS Check-in
 *     security:
 *       - bearerAuth: []
 */
app.post('/visits/:id/check-in', zValidator('json', CheckEventSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Verify visit assignment and get client location
    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { client: true },
    });
    if (!visit || visit.assignedPswId !== profile.id) {
        return c.json({ error: 'Visit not found or not assigned to you' }, 404);
    }

    // Verify distance from client location (Geofencing)
    let result: 'success' | 'rejected' = 'success';
    if (visit.client?.lat && visit.client?.lng) {
        const distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng);
        // Allow 500m grace period for urban areas/GPS drift
        if (distance > 500) {
            result = 'rejected';
            // We still log the event but might prevent the status update or alert admin
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
/**
 * @openapi
 * /v1/psw/visits/{id}/check-out:
 *   post:
 *     summary: GPS Check-out
 *     security:
 *       - bearerAuth: []
 */
app.post('/visits/:id/check-out', zValidator('json', CheckEventSchema), async (c) => {
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

/**
 * @openapi
 * /v1/psw/payouts/request:
 *   post:
 *     summary: Request Payout
 *     security:
 *       - bearerAuth: []
 */
app.post('/payouts/request', async (c) => {
    // Mock implementation for V1
    // In a real app, this would check balance, create PayoutRequest record, etc.
    return c.json({ success: true, message: 'Payout requested successfully. Admin will review.' });
});

/**
 * @openapi
 * /v1/psw/visits/:id/note:
 *   post:
 *     summary: Add a clinical or visit note
 */
app.post('/visits/:id/note', zValidator('json', z.object({
    noteText: z.string().min(1)
})), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { noteText } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const note = await prisma.visitNote.create({
        data: {
            visitId,
            pswId: profile.id,
            noteText
        }
    });

    return c.json(note, 201);
});

/**
 * @openapi
 * /v1/psw/visits/:id/checklist:
 *   post:
 *     summary: Submit visit checklist (JSON)
 */
app.post('/visits/:id/checklist', zValidator('json', z.object({
    checklistJson: z.any()
})), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { checklistJson } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const checklist = await prisma.visitChecklist.create({
        data: {
            visitId,
            pswId: profile.id,
            checklistJson
        }
    });

    return c.json(checklist, 201);
});

/**
 * @openapi
 * /v1/psw/incidents:
 *   post:
 *     summary: Report an incident during/after visit
 */
app.post('/incidents', zValidator('json', z.object({
    visitId: z.string().uuid().optional(),
    type: z.string(),
    description: z.string()
})), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { visitId, type, description } = c.req.valid('json');

    const incident = await prisma.incident.create({
        data: {
            visitId,
            reporterUserId: userId,
            type: type as any,
            description,
            status: 'open'
        }
    });

    return c.json(incident, 201);
});

export default app;
