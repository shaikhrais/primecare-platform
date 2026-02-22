import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const BookingSchema = z.object({
    serviceId: z.string().uuid().optional(),
    serviceType: z.string(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    priority: z.enum(['normal', 'urgent']).default('normal'),
    notes: z.string().optional(),
    recurrenceRule: z.any().optional(),
});

// GET Bookings
r.get('/', requireRole(['client', 'admin', 'rn']), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const bookings = await prisma.booking.findMany({
        where: { clientId: profile.id },
        orderBy: { startAt: 'desc' },
        include: {
            visits: {
                include: { service: true, psw: { select: { fullName: true } } }
            }
        },
    });

    return c.json(bookings);
});

// POST Booking
r.post('/', requireRole(['client']), zValidator('json', BookingSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const booking = await prisma.booking.create({
        data: {
            clientId: profile.id,
            startAt: new Date(data.requestedStartAt),
            endAt: new Date(new Date(data.requestedStartAt).getTime() + data.durationMinutes * 60000),
            serviceType: data.serviceType,
            priority: data.priority,
            notes: data.notes,
            recurrenceRule: data.recurrenceRule,
            tenantId: tenantId
        },
    });

    // If not recurring, create the initial Visit immediately
    if (!data.recurrenceRule) {
        await prisma.visit.create({
            data: {
                bookingId: booking.id,
                clientId: profile.id,
                serviceId: data.serviceId || '',
                requestedStartAt: new Date(data.requestedStartAt),
                durationMinutes: data.durationMinutes,
                status: 'requested',
                clientNotes: data.notes,
                priority: data.priority,
                tenantId: tenantId
            }
        });
    }

    await logAudit(prisma, userId, 'BOOK_SERVICE', 'BOOKING', booking.id, { serviceType: data.serviceType });

    return c.json(booking, 201);
});

// PATCH Booking
r.patch('/:id', requireRole(['client', 'admin']), zValidator('json', BookingSchema.partial()), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const booking = await prisma.booking.update({
        where: { id },
        data: {
            ...data,
            startAt: data.requestedStartAt ? new Date(data.requestedStartAt) : undefined,
        }
    });

    await logAudit(prisma, userId, 'UPDATE_BOOKING', 'BOOKING', id, data);
    return c.json(booking);
});

export default r;
