import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// List Leads
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const leads = await prisma.lead.findMany({
        orderBy: { createdAt: 'desc' },
    });
    return c.json(leads);
});

// Update Lead Status
r.patch('/:id', zValidator('json', z.object({ status: z.string() })), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { status } = c.req.valid('json');

    const lead = await prisma.lead.update({
        where: { id },
        data: { status },
    });

    return c.json(lead);
});

export default r;
