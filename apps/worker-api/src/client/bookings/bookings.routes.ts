import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';
import { logAudit } from '../../utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const BookingSchema = z.object({
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(60),
    notes: z.string().optional(),
});

// GET Bookings
r.get('/', requireRole(['client', 'admin', 'rn']), async (c) => {
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

// POST Booking
r.post('/', requireRole(['client']), zValidator('json', BookingSchema), async (c) => {
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

export default r;
