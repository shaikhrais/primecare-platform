import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * Create a new Visit (Open Shift)
 */
r.post('/visits', zValidator('json', z.object({
    clientId: z.string().uuid(),
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().int().positive(),
    notes: z.string().optional()
})), async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const client = await prisma.clientProfile.findUnique({ where: { id: data.clientId } });
    if (!client) return c.json({ error: 'Client not found' }, 404);

    const visit = await prisma.visit.create({
        data: {
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: data.requestedStartAt,
            durationMinutes: data.durationMinutes,
            status: 'requested',
            managementNotes: `Created by Staff/Admin ${payload.sub}: ${data.notes || ''}`,
            tenantId: payload.tenantId
        }
    });

    await logAudit(prisma, payload.sub, 'CREATE_VISIT', 'VISIT', visit.id, { clientId: data.clientId });

    return c.json(visit, 201);
});

export default r;
