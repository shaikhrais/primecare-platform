import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ServiceParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'service-uuid',
    }),
});

const ServiceSchema = z.object({
    name: z.string(),
    description: z.string().optional(),
    hourlyRate: z.number(),
    category: z.string().optional(),
    isActive: z.boolean().optional(),
});

// List Services
const listServicesRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'List All Services',
    description: 'Retrieve a list of all care services offered.',
    tags: ['Admin Services'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of services',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listServicesRoute, async (c) => {
    const prisma = c.get('prisma');
    const services = await prisma.service.findMany();
    return c.json(services, 200);
});

// Create Service
const createServiceRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Create Service',
    description: 'Register a new care service.',
    tags: ['Admin Services'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: ServiceSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Service created successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(createServiceRoute, async (c) => {
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
const updateServiceRoute = createRoute({
    method: 'put',
    path: '/{id}',
    summary: 'Update Service',
    description: 'Update the details of an existing care service.',
    tags: ['Admin Services'],
    request: {
        params: ServiceParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: ServiceSchema.partial(),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Service updated successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateServiceRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { hourlyRate, ...data } = c.req.valid('json');

    const updateData: any = { ...data };
    if (hourlyRate !== undefined) {
        updateData.baseRateHourly = hourlyRate;
    }

    const service = await prisma.service.update({
        where: { id },
        data: updateData,
    });
    return c.json(service, 200);
});

export default r;
