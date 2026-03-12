import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';

import { Bindings, Variables } from '../../../../bindings';
import { logAudit } from '../../../../_shared/utils/audit';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';
import { rrulestr } from 'rrule';

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
    recurrenceRuleString: z.string().optional(),
    recurrenceEndDate: z.string().datetime().nullable().optional(),
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

    if (data.recurrenceRuleString) {
        // Expand the series
        const start = new Date(data.requestedStartAt);
        const endLimit = data.recurrenceEndDate ? new Date(data.recurrenceEndDate) : new Date(start.getTime() + 90 * 24 * 60 * 60 * 1000);
        
        const rule = rrulestr(data.recurrenceRuleString, { dtstart: start });
        let occurrences = rule.between(start, endLimit, true);
        
        // Safety cap: max 90 shifts at once per request to avoid payload bloat
        occurrences = occurrences.slice(0, 90);

        const visitsToCreate = occurrences.map(date => ({
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: date,
            durationMinutes: data.durationMinutes,
            assignedPswId: data.assignedPswId,
            status: status,
            clientNotes: data.clientNotes,
            tenantId: payload.tenantId,
            priority: data.priority || 'normal',
            requiredSkills: data.requiredSkills || [],
            recurrenceRuleString: data.recurrenceRuleString,
            recurrenceEndDate: data.recurrenceEndDate ? new Date(data.recurrenceEndDate) : null,
        }));

        await prisma.visit.createMany({ data: visitsToCreate });

        const firstVisit = await prisma.visit.findFirst({
            where: { clientId: data.clientId, tenantId: payload.tenantId, requestedStartAt: start },
        });

        await logAudit(prisma, payload.sub, 'CREATE_VISIT_SERIES', 'VISIT', firstVisit?.id || 'batch', {
            assignedPswId: data.assignedPswId,
            status: status,
            count: visitsToCreate.length
        });
        
        return c.json(firstVisit || { message: 'Series created' }, 201);
    } else {
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




