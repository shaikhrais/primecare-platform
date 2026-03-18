import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const routes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /bookings/request — Client submits a booking request
const requestRoute = createRoute({
    method: 'post', path: '/request',
    summary: 'Submit a new booking request', tags: ['Client Bookings'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        serviceType: z.string(), preferredDate: z.string(),
                        preferredTime: z.string().optional(), notes: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string(), status: z.string() }) } }, description: 'Request created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(requestRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json({ id: '', status: 'error' }, 200);

    const req = await prisma.bookingRequest.create({
        data: {
            tenantId, clientId: client.id,
            serviceType: body.serviceType, preferredDate: body.preferredDate,
            preferredTime: body.preferredTime, notes: body.notes, status: 'pending',
        },
    });

    return c.json({ id: req.id, status: 'pending' }, 200);
});

// GET /bookings/requests — Client's pending requests
const listRoute = createRoute({
    method: 'get', path: '/requests',
    summary: 'List my booking requests', tags: ['Client Bookings'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), serviceType: z.string(), preferredDate: z.string(),
                        status: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Requests'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json([], 200);

    const requests = await prisma.bookingRequest.findMany({
        where: { clientId: client.id }, orderBy: { createdAt: 'desc' },
    });

    return c.json(requests.map((r: any) => ({
        id: r.id, serviceType: r.serviceType, preferredDate: r.preferredDate,
        status: r.status, createdAt: r.createdAt,
    })), 200);
});

// GET /team — Assigned care team
const teamRoute = createRoute({
    method: 'get', path: '/team',
    summary: 'View assigned care team members', tags: ['Client'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), name: z.string(), role: z.string(),
                        phone: z.string().nullable(), email: z.string().nullable(),
                    }))
                }
            }, description: 'Care team'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(teamRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json([], 200);

    // Get unique PSWs assigned to this client's visits
    const visits = await prisma.visit.findMany({
        where: { clientId: client.id, assignedPswId: { not: null } },
        include: { assignedPsw: { include: { user: { select: { email: true } } } } },
        distinct: ['assignedPswId'],
    });

    return c.json(visits
        .filter((v: any) => v.assignedPsw)
        .map((v: any) => ({
            id: v.assignedPsw.id, name: v.assignedPsw.fullName,
            role: v.assignedPsw.designation || 'PSW',
            phone: v.assignedPsw.phone || null,
            email: v.assignedPsw.user?.email || null,
        })), 200);
});

// GET /profile/medical-summary — Client medical summary
const medicalRoute = createRoute({
    method: 'get', path: '/profile/medical-summary',
    summary: 'Get client medical summary', tags: ['Client'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), medicalNotes: z.any(),
                        allergies: z.string().nullable(), conditions: z.string().nullable(),
                    })
                }
            }, description: 'Medical summary'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(medicalRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json({ error: 'Client profile not found' }, 404);

    let notes = {};
    try { notes = JSON.parse(client.medicalNotes as string || '{}'); } catch { /* */ }

    return c.json({
        clientId: client.id, medicalNotes: notes,
        allergies: (client as any).allergies || null,
        conditions: (client as any).conditions || null,
    }, 200);
});

export default routes;
