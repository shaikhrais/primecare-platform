import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';

import { Bindings, Variables } from '../../../../bindings';
import { logAudit } from '../../../../_shared/utils/audit';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VisitParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

const CreateVisitSchema = z.object({
    clientId: z.string().uuid(),
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    assignedPswId: z.string().uuid().optional(),
    clientNotes: z.string().optional(),
    priority: z.string().optional().default('normal'),
    requiredSkills: z.array(z.string()).optional().default([]),
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
    },
});

r.openapi(createVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const status: string = data.assignedPswId ? 'scheduled' : 'requested';

    const visit = await prisma.visit.create({
        data: {
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: new Date(data.requestedStartAt),
            durationMinutes: data.durationMinutes,
            assignedPswId: data.assignedPswId,
            status: status,
            clientNotes: data.clientNotes,
            tenantId: payload.tenantId,
            priority: data.priority || 'normal',
            requiredSkills: data.requiredSkills || [],
        },
    });

    await logAudit(prisma, payload.sub, 'CREATE_VISIT', 'VISIT', visit.id, {
        assignedPswId: data.assignedPswId,
        status: status
    });

    return c.json(visit, 201);
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
    },
});

r.openapi(updateVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');

    const updateData: any = { ...data };
    if (data.status) {
        updateData.status = data.status;
    }

    const visit = await prisma.visit.update({
        where: { id },
        data: updateData,
    });
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
    },
});

r.openapi(deleteVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    await prisma.visit.delete({ where: { id } });
    return c.json({ success: true }, 200);
});

export default r;




