import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const waitlist = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /waitlist — Waitlist entries by priority
const listRoute = createRoute({
    method: 'get', path: '/',
    summary: 'List waitlist entries ordered by priority', tags: ['Waitlist'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientName: z.string(), serviceType: z.string(),
                        priority: z.number(), status: z.string(), notes: z.string().nullable(),
                        createdAt: z.string(),
                    }))
                }
            }, description: 'Waitlist'
        },
    },
});

waitlist.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const entries = await prisma.waitlistEntry.findMany({
        where: { tenantId },
        include: { client: { select: { fullName: true } } },
        orderBy: { priority: 'desc' },
    });

    return c.json(entries.map((e: any) => ({
        id: e.id, clientName: e.client?.fullName || '', serviceType: e.serviceType,
        priority: e.priority, status: e.status, notes: e.notes, createdAt: e.createdAt,
    })), 200);
});

// POST /waitlist — Add entry
const addRoute = createRoute({
    method: 'post', path: '/',
    summary: 'Add a client to the waitlist', tags: ['Waitlist'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), serviceType: z.string(),
                        priority: z.number().optional(), notes: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Added' },
    },
});

waitlist.openapi(addRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const entry = await prisma.waitlistEntry.create({
        data: {
            tenantId, clientId: body.clientId, serviceType: body.serviceType,
            priority: body.priority || 1, notes: body.notes, status: 'waiting',
        },
    });

    return c.json({ id: entry.id }, 200);
});

// PATCH /waitlist/:id/prioritize — Update priority
const prioritizeRoute = createRoute({
    method: 'patch', path: '/{id}/prioritize',
    summary: 'Update waitlist entry priority', tags: ['Waitlist'],
    request: {
        params: z.object({ id: z.string() }),
        body: { content: { 'application/json': { schema: z.object({ priority: z.number() }) } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

waitlist.openapi(prioritizeRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { priority } = c.req.valid('json');

    try {
        await prisma.waitlistEntry.update({ where: { id }, data: { priority } });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Entry not found' }, 404); }
});

// DELETE /waitlist/:id — Remove from waitlist
const removeRoute = createRoute({
    method: 'delete', path: '/{id}',
    summary: 'Remove entry from waitlist', tags: ['Waitlist'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Removed' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

waitlist.openapi(removeRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    try {
        await prisma.waitlistEntry.delete({ where: { id } });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Entry not found' }, 404); }
});

export default waitlist;
