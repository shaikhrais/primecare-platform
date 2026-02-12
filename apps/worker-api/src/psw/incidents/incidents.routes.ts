import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * Report an incident during/after visit
 */
r.post('/', zValidator('json', z.object({
    visitId: z.string().uuid().optional(),
    type: z.string(),
    description: z.string()
})), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { visitId, type, description } = c.req.valid('json');

    const incident = await prisma.incident.create({
        data: {
            visitId,
            reporterUserId: userId,
            type: type as any,
            description,
            status: 'open',
            tenantId: c.get('jwtPayload').tenantId
        }
    });

    return c.json(incident, 201);
});

export default r;
