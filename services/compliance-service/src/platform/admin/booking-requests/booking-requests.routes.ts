import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const bookingApproval = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /booking-requests — Pending booking requests queue
const listRoute = createRoute({
    method: 'get', path: '/',
    summary: 'List pending client booking requests', tags: ['Booking Approval'],
    request: { query: z.object({ status: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientId: z.string(), clientName: z.string(),
                        serviceType: z.string(), preferredDate: z.string(),
                        preferredTime: z.string().nullable(), notes: z.string().nullable(),
                        status: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Booking requests'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

bookingApproval.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const status = c.req.query('status') || 'pending';

    const requests = await prisma.bookingRequest.findMany({
        where: { tenantId, status },
        include: { client: { select: { fullName: true } } },
        orderBy: { createdAt: 'desc' },
    });

    return c.json(requests.map((r: any) => ({
        id: r.id, clientId: r.clientId, clientName: r.client?.fullName || '',
        serviceType: r.serviceType, preferredDate: r.preferredDate,
        preferredTime: r.preferredTime, notes: r.notes,
        status: r.status, createdAt: r.createdAt,
    })), 200);
});

// POST /booking-requests/:id/approve — Approve and create visit
const approveRoute = createRoute({
    method: 'post', path: '/{id}/approve',
    summary: 'Approve a booking request and create a visit', tags: ['Booking Approval'],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        serviceId: z.string(), durationMinutes: z.number().optional(),
                        assignedProviderId: z.string().optional(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ requestId: z.string(), visitId: z.string() }) } }, description: 'Approved' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

bookingApproval.openapi(approveRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');

    const request = await prisma.bookingRequest.findUnique({ where: { id } });
    if (!request) return c.json({ error: 'Booking request not found' }, 404);

    // Create a visit from the approved booking request
    const visit = await prisma.visit.create({
        data: {
            clientId: request.clientId, serviceId: body.serviceId, tenantId,
            requestedStartAt: request.preferredDate,
            durationMinutes: body.durationMinutes || 60,
            status: body.assignedProviderId ? 'assigned' : 'requested',
            assignedProviderId: body.assignedProviderId || null,
            clientNotes: request.notes || '',
        },
    });

    // Update booking request status
    await prisma.bookingRequest.update({ where: { id }, data: { status: 'approved' } });

    return c.json({ requestId: id, visitId: visit.id }, 200);
});

// POST /booking-requests/:id/reject — Reject a booking request
const rejectRoute = createRoute({
    method: 'post', path: '/{id}/reject',
    summary: 'Reject a booking request', tags: ['Booking Approval'],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        reason: z.string().optional(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Rejected' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

bookingApproval.openapi(rejectRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    try {
        await prisma.bookingRequest.update({ where: { id }, data: { status: 'rejected' } });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Booking request not found' }, 404); }
});

export default bookingApproval;
