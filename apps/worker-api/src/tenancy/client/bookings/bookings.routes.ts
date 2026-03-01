import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const BookingSchema = z.object({
    serviceId: z.string().uuid().optional(),
    serviceType: z.string(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    priority: z.enum(['normal', 'urgent']).default('normal'),
    notes: z.string().optional(),
    recurrenceRule: z.any().optional(),
});

const BookingParamsSchema = z.object({
    id: z.string().openapi({ param: { name: 'id', in: 'path' } }),
});

// GET Bookings
const listBookingsRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.LIST_BOOKINGS,
    method: 'get',
    path: '/',
    middleware: [requireRole(['client', 'admin', 'rn'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of bookings',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listBookingsRoute, async (c) => {
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

    return c.json(bookings, 200);
});

// POST Booking
const createBookingRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.CREATE_BOOKING,
    method: 'post',
    path: '/',
    middleware: [requireRole(['client'])],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: BookingSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Booking created successfully',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(createBookingRoute, async (c) => {
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
const updateBookingRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.UPDATE_BOOKING,
    method: 'patch',
    path: '/{id}',
    middleware: [requireRole(['client', 'admin'])],
    request: {
        params: BookingParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: BookingSchema.partial(),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Booking updated successfully',
        },
    },
});

r.openapi(updateBookingRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
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
    return c.json(booking, 200);
});

export default r;
