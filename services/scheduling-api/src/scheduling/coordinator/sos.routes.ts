import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const sos = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// ─── G20: SOS Alert System ───

// POST /psw/sos/trigger — PSW sends SOS
const triggerRoute = createRoute({
    method: 'post', path: '/trigger',
    summary: 'PSW triggers an SOS alert', tags: ['SOS'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        lat: z.number().optional(), lng: z.number().optional(),
                        message: z.string().optional(), visitId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ alertId: z.string() }) } }, description: 'SOS triggered' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

sos.openapi(triggerRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const psw = await prisma.providerProfile.findUnique({ where: { userId } });

    const alert = await prisma.patientAlert.create({
        data: {
            tenantId, type: 'SOS',
            severity: 'CRITICAL',
            message: body.message || `SOS from ${psw?.fullName || userId}`,
            status: 'open',
            patientId: body.visitId || '',
        },
    });

    return c.json({ alertId: alert.id }, 200);
});

// GET /coordinator/sos/active — Active SOS alerts
const activeRoute = createRoute({
    method: 'get', path: '/active',
    summary: 'List active SOS alerts for coordinator', tags: ['SOS'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), pswMessage: z.string(), severity: z.string(),
                        status: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Active SOS'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

sos.openapi(activeRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const alerts = await prisma.patientAlert.findMany({
        where: { tenantId, type: 'SOS', status: 'open' },
        orderBy: { createdAt: 'desc' },
    });

    return c.json(alerts.map((a: any) => ({
        id: a.id, pswMessage: a.message, severity: a.severity,
        status: a.status, createdAt: a.createdAt,
    })), 200);
});

// POST /coordinator/sos/:id/acknowledge — Acknowledge SOS
const ackRoute = createRoute({
    method: 'post', path: '/{id}/acknowledge',
    summary: 'Acknowledge an SOS alert', tags: ['SOS'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Acknowledged' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

sos.openapi(ackRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    try {
        await prisma.patientAlert.update({
            where: { id }, data: { status: 'acknowledged' },
        });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Alert not found' }, 404); }
});

export default sos;
