import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient, Prisma } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Prisma Helper
const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

// Profile Update Schema
const ProfileUpdateSchema = z.object({
    fullName: z.string().min(2).optional(),
    phone: z.string().optional(),
    addressLine1: z.string().optional(),
    city: z.string().optional(),
    province: z.string().optional(),
    postalCode: z.string().optional(),
    emergencyName: z.string().optional(),
    emergencyPhone: z.string().optional(),
});

// Booking Schema
const BookingSchema = z.object({
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(60),
    notes: z.string().optional(),
});

// Middleware for all client routes
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', rbacMiddleware(['client']));

/**
 * @openapi
 * /v1/client/profile:
 *   get:
 *     summary: Get Client Profile
 *     security:
 *       - bearerAuth: []
 */
app.get('/profile', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({
        where: { userId },
        include: { user: { select: { email: true, phone: true } } },
    });

    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    return c.json(profile);
});

/**
 * @openapi
 * /v1/client/profile:
 *   put:
 *     summary: Update Client Profile
 *     security:
 *       - bearerAuth: []
 */
app.put('/profile', zValidator('json', ProfileUpdateSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const profile = await prisma.clientProfile.update({
        where: { userId },
        data: {
            fullName: data.fullName,
            addressLine1: data.addressLine1,
            city: data.city,
            province: data.province,
            postalCode: data.postalCode,
            emergencyName: data.emergencyName,
            emergencyPhone: data.emergencyPhone,
        },
    });

    return c.json(profile);
});

/**
 * @openapi
 * /v1/client/bookings:
 *   get:
 *     summary: List Client Bookings (Visits)
 *     security:
 *       - bearerAuth: []
 */
app.get('/bookings', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visits = await prisma.visit.findMany({
        where: { clientId: profile.id },
        orderBy: { requestedStartAt: 'desc' },
        include: {
            service: true,
            psw: { select: { fullName: true } },
        },
    });

    return c.json(visits);
});

/**
 * @openapi
 * /v1/client/bookings:
 *   post:
 *     summary: Request a new service booking
 *     security:
 *       - bearerAuth: []
 */
app.post('/bookings', zValidator('json', BookingSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.create({
        data: {
            clientId: profile.id,
            serviceId: data.serviceId,
            requestedStartAt: data.requestedStartAt,
            durationMinutes: data.durationMinutes,
            status: 'requested',
            clientNotes: data.notes,
        },
    });

    return c.json(visit, 201);
});

/**
 * @openapi
 * /v1/client/invoices:
 *   get:
 *     summary: List Client Invoices
 *     security:
 *       - bearerAuth: []
 */
app.get('/invoices', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const invoices = await prisma.invoice.findMany({
        where: { clientId: profile.id },
        orderBy: { createdAt: 'desc' },
        include: { payments: true },
    });

    return c.json(invoices);
});

export default app;
