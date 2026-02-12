import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware, requirePermission } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';
import { policyMiddleware } from '../middleware/policy';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

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

// Care Plan Schema
const CarePlanSchema = z.object({
    goals: z.array(z.string()),
    precautions: z.array(z.string()),
    interventions: z.array(z.string()),
    riskLevel: z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']).optional()
});

// Middleware for all client routes
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());
app.use('*', policyMiddleware());

/**
 * @openapi
 * /v1/client/profile:
 *   get:
 *     summary: Get Client Profile
 */
app.get('/profile', rbacMiddleware(['client', 'rn', 'admin']), async (c) => {
    const prisma = c.get('prisma');
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
 * /v1/client/:clientId/care-plan:
 *   post:
 *     summary: Create Care Plan (RN/Admin)
 */
app.post('/:clientId/care-plan', requirePermission('CARE_PLAN_CREATE'), zValidator('json', CarePlanSchema), async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.param('clientId');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    // In a real app, this would update a CarePlan model or JSON field on ClientProfile
    // For now, let's assume we log it and return success
    await logAudit(prisma, userId, 'CREATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan created', data });
});

/**
 * @openapi
 * /v1/client/:clientId/care-plan:
 *   patch:
 *     summary: Update Care Plan (RN/Admin)
 */
app.patch('/:clientId/care-plan', requirePermission('CARE_PLAN_UPDATE'), zValidator('json', CarePlanSchema.partial()), async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.param('clientId');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await logAudit(prisma, userId, 'UPDATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan updated', data });
});

/**
 * @openapi
 * /v1/client/profile:
 *   put:
 *     summary: Update Client Profile
 */
app.put('/profile', rbacMiddleware(['client']), zValidator('json', ProfileUpdateSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const can = c.get('can');
    const profileExists = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profileExists) return c.json({ error: 'Profile not found' }, 404);

    if (!(await can('update', 'ClientProfile', profileExists.id))) {
        return c.json({ error: 'Forbidden' }, 403);
    }

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
 */
app.get('/bookings', rbacMiddleware(['client', 'admin', 'rn']), async (c) => {
    const prisma = c.get('prisma');
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
 */
app.post('/bookings', rbacMiddleware(['client']), zValidator('json', BookingSchema), async (c) => {
    const prisma = c.get('prisma');
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
            tenantId: c.get('jwtPayload').tenantId
        },
    });

    await logAudit(prisma, userId, 'BOOK_SERVICE', 'VISIT', visit.id, { serviceId: data.serviceId });

    return c.json(visit, 201);
});

/**
 * @openapi
 * /v1/client/invoices:
 *   get:
 *     summary: List Client Invoices
 */
app.get('/invoices', rbacMiddleware(['client']), async (c) => {
    const prisma = c.get('prisma');
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

/**
 * @openapi
 * /v1/client/services:
 *   get:
 *     summary: List Available Services
 */
app.get('/services', async (c) => {
    const prisma = c.get('prisma');
    const services = await prisma.service.findMany({
        where: { tenantId: c.get('jwtPayload').tenantId }
    });
    return c.json(services);
});

export default app;
