import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';

import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { VisitService } from '../visits.service';
import { CreateVisitSchema } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VisitParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});



// POST /
const createVisitRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.CREATE,
    method: 'post',
    path: '/',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: CreateVisitSchema,
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
            description: 'Visit created successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(createVisitRoute, async (c) => {
    const service = new VisitService(c.get('prisma'));
    const data = c.req.valid('json');
    const payload = c.get('jwtPayload');

    if (data.recurrenceRuleString) {
        const result = await service.createSeries(
            data as any,
            payload.tenantId,
            payload.sub,
        );
        return c.json(result, 201);
    } else {
        const visit = await service.create(data, payload.tenantId, payload.sub);
        return c.json(visit, 201);
    }
});

// PATCH /{id}
const updateVisitRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.UPDATE,
    method: 'patch',
    path: '/{id}',
    request: {
        params: VisitParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string().optional(),
                        requestedStartAt: z.string().datetime().optional(),
                        durationMinutes: z.number().optional(),
                    }),
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
            description: 'Visit updated successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateVisitRoute, async (c) => {
    const service = new VisitService(c.get('prisma'));
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');
    const visit = await service.update(id, data);
    return c.json(visit, 200);
});

// DELETE /{id}
const deleteVisitRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.DELETE,
    method: 'delete',
    path: '/{id}',
    request: {
        params: VisitParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                    }),
                },
            },
            description: 'Visit deleted successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(deleteVisitRoute, async (c) => {
    const service = new VisitService(c.get('prisma'));
    const { id } = c.req.valid('param');
    const result = await service.delete(id);
    return c.json(result, 200);
});

export default r;
