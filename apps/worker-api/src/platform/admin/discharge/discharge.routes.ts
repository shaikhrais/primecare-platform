import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const discharge = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /clients/:id/discharge — Discharge a client
const dischargeRoute = createRoute({
    method: 'post', path: '/{clientId}/discharge',
    summary: 'Discharge a client from active care', tags: ['Client Discharge'],
    request: {
        params: z.object({ clientId: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        reason: z.string(), dischargeSummary: z.string().optional(),
                        followUpProvider: z.string().optional(), effectiveDate: z.string().optional(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean(), status: z.string() }) } }, description: 'Discharged' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

discharge.openapi(dischargeRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('param');
    const body = c.req.valid('json');

    const client = await prisma.clientProfile.findUnique({ where: { id: clientId } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    // Cancel all future visits
    await prisma.visit.updateMany({
        where: { clientId, status: { in: ['requested', 'scheduled', 'assigned'] } },
        data: { status: 'cancelled', cancellationReason: `Discharged: ${body.reason}` },
    });

    // Mark client profile status
    await prisma.clientProfile.update({
        where: { id: clientId },
        data: {
            medicalNotes: JSON.stringify({
                ...(client.medicalNotes ? JSON.parse(client.medicalNotes as string || '{}') : {}),
                dischargedAt: body.effectiveDate || new Date().toISOString(),
                dischargeReason: body.reason,
                dischargeSummary: body.dischargeSummary || '',
                followUpProvider: body.followUpProvider || '',
            }),
        },
    });

    return c.json({ success: true, status: 'discharged' }, 200);
});

// POST /clients/:id/readmit — Readmit a previously discharged client
const readmitRoute = createRoute({
    method: 'post', path: '/{clientId}/readmit',
    summary: 'Readmit a previously discharged client', tags: ['Client Discharge'],
    request: {
        params: z.object({ clientId: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        readmitReason: z.string(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean(), status: z.string() }) } }, description: 'Readmitted' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

discharge.openapi(readmitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('param');
    const { readmitReason } = c.req.valid('json');

    const client = await prisma.clientProfile.findUnique({ where: { id: clientId } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    await prisma.clientProfile.update({
        where: { id: clientId },
        data: {
            medicalNotes: JSON.stringify({
                ...(client.medicalNotes ? JSON.parse(client.medicalNotes as string || '{}') : {}),
                readmittedAt: new Date().toISOString(),
                readmitReason,
            }),
        },
    });

    return c.json({ success: true, status: 'active' }, 200);
});

// GET /clients/:id/discharge-summary — Get discharge details
const summaryRoute = createRoute({
    method: 'get', path: '/{clientId}/discharge-summary',
    summary: 'Get client discharge summary', tags: ['Client Discharge'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), discharge: z.any(),
                    })
                }
            }, description: 'Discharge summary'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

discharge.openapi(summaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('param');

    const client = await prisma.clientProfile.findUnique({ where: { id: clientId }, select: { id: true, medicalNotes: true } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    let discharge = {};
    try { discharge = JSON.parse(client.medicalNotes as string || '{}'); } catch { /* empty */ }

    return c.json({ clientId, discharge }, 200);
});

export default discharge;
