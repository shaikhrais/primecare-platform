import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

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
    const prisma = getPrisma(c.env.DATABASE_URL);
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
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

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
    const prisma = getPrisma(c.env.DATABASE_URL);
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
/**
 * @openapi
 * /v1/psw/visits/{id}/check-in:
 *   post:
 *     summary: GPS Check-in
 *     security:
 *       - bearerAuth: []
 */
app.post('/visits/:id/check-in', zValidator('json', CheckEventSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Verify visit assignment
    const visit = await prisma.visit.findUnique({ where: { id: visitId } });
    if (!visit || visit.assignedPswId !== profile.id) {
        return c.json({ error: 'Visit not found or not assigned to you' }, 404);
    }

    // TODO: Verify distance from client location (Geofencing)
    const result = 'success';

    const event = await prisma.visitCheckEvent.create({
        data: {
            visitId,
            pswId: profile.id,
            eventType: 'check_in',
            lat,
            lng,
            accuracyM: accuracy,
            result,
        },
    });

    await prisma.visit.update({
        where: { id: visitId },
        data: { status: 'in_progress' },
    });

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
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;
    const visitId = c.req.param('id');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const event = await prisma.visitCheckEvent.create({
        data: {
            visitId,
            pswId: profile.id,
            eventType: 'check_out',
            lat,
            lng,
            accuracyM: accuracy,
            result: 'success',
        },
    });

    await prisma.visit.update({
        where: { id: visitId },
        data: { status: 'completed' },
    });

    return c.json(event);
});

export default app;
