import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// List Services
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const services = await prisma.service.findMany();
    return c.json(services);
});

// Create Service
r.post('/', zValidator('json', z.object({
    name: z.string(),
    description: z.string().optional(),
    hourlyRate: z.number(),
    category: z.string().optional(),
    isActive: z.boolean().optional(),
})), async (c) => {
    const prisma = c.get('prisma');
    const { hourlyRate, ...rest } = c.req.valid('json');
    const slug = rest.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');

    const service = await prisma.service.create({
        data: {
            ...rest,
            baseRateHourly: hourlyRate,
            slug,
            tenantId: c.get('jwtPayload').tenantId
        }
    });
    return c.json(service, 201);
});

// Update Service
r.put('/:id', zValidator('json', z.object({
    name: z.string().optional(),
    description: z.string().optional(),
    hourlyRate: z.number().optional(),
    category: z.string().optional(),
    isActive: z.boolean().optional(),
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { hourlyRate, ...data } = c.req.valid('json');

    const updateData: any = { ...data };
    if (hourlyRate !== undefined) {
        updateData.baseRateHourly = hourlyRate;
    }

    const service = await prisma.service.update({
        where: { id },
        data: updateData,
    });
    return c.json(service);
});

export default r;
