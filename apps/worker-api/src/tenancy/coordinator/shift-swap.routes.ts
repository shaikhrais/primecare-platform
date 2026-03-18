import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const shiftSwap = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /shift-swap/request — PSW requests a shift swap
const requestSwapRoute = createRoute({
    method: 'post', path: '/request',
    summary: 'Request a shift swap', tags: ['Shift Swap'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string(), reason: z.string().optional(),
                        preferredPswId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string(), status: z.string() }) } }, description: 'Swap requested' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Visit not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

shiftSwap.openapi(requestSwapRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const psw = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!psw) return c.json({ error: 'PSW profile not found' }, 404);

    const visit = await prisma.visit.findUnique({ where: { id: body.visitId } });
    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    // Use the existing Visit model to track swap requests via coordinatorNotes + status
    await prisma.visit.update({
        where: { id: body.visitId },
        data: {
            coordinatorNotes: JSON.stringify({
                swapRequestedBy: psw.id,
                reason: body.reason || '',
                preferredPswId: body.preferredPswId || null,
                requestedAt: new Date().toISOString(),
                swapStatus: 'pending',
            }),
        },
    });

    return c.json({ id: body.visitId, status: 'pending' }, 200);
});

// GET /shift-swap/requests — Coordinator view of pending swaps
const listSwapsRoute = createRoute({
    method: 'get', path: '/requests',
    summary: 'List pending shift swap requests', tags: ['Shift Swap'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        visitId: z.string(), requestedBy: z.string(), reason: z.string(),
                        preferredPsw: z.string().nullable(), requestedAt: z.string(),
                    }))
                }
            }, description: 'Swap requests'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

shiftSwap.openapi(listSwapsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const visits = await prisma.visit.findMany({
        where: {
            tenantId,
            coordinatorNotes: { not: null },
        },
        select: { id: true, coordinatorNotes: true },
    });

    const swaps = visits
        .filter((v: any) => {
            try { return JSON.parse(v.coordinatorNotes || '{}').swapStatus === 'pending'; } catch { return false; }
        })
        .map((v: any) => {
            const data = JSON.parse(v.coordinatorNotes!);
            return {
                visitId: v.id, requestedBy: data.swapRequestedBy, reason: data.reason,
                preferredPsw: data.preferredPswId, requestedAt: data.requestedAt,
            };
        });

    return c.json(swaps, 200);
});

// POST /shift-swap/requests/:visitId/approve — Coordinator approves swap
const approveSwapRoute = createRoute({
    method: 'post', path: '/requests/{visitId}/approve',
    summary: 'Approve a shift swap', tags: ['Shift Swap'],
    request: {
        params: z.object({ visitId: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        newPswId: z.string(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Approved' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

shiftSwap.openapi(approveSwapRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId } = c.req.valid('param');
    const { newPswId } = c.req.valid('json');

    try {
        await prisma.visit.update({
            where: { id: visitId },
            data: {
                assignedPswId: newPswId,
                coordinatorNotes: JSON.stringify({ swapStatus: 'approved', swapCompletedAt: new Date().toISOString() }),
            },
        });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Visit not found' }, 404); }
});

export default shiftSwap;
