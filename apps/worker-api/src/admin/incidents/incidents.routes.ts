import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// List Incidents
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const incidents = await prisma.incident.findMany({
        include: {
            reporter: { select: { email: true } },
            visit: { select: { id: true, status: true } }
        },
        orderBy: { createdAt: 'desc' }
    });
    return c.json(incidents);
});

// Update Incident
r.patch('/:id', zValidator('json', z.object({
    status: z.string(),
    resolutionNotes: z.string().optional()
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const data = c.req.valid('json');
    const incident = await prisma.incident.update({
        where: { id },
        data: {
            status: data.status as any,
            resolutionNotes: data.resolutionNotes
        }
    });
    return c.json(incident);
});

export default r;
