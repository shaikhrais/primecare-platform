import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { logAudit } from '../../../_shared/utils/audit';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * Create a new Visit (Open Shift)
 */
const createStaffVisitRoute = createRoute({
    ...ROUTE_METADATA.STAFF.SCHEDULING_CREATE,
    method: 'post',
    path: '/visits',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string().uuid(),
                        serviceId: z.string().uuid(),
                        requestedStartAt: z.string().datetime(),
                        durationMinutes: z.number().int().positive(),
                        notes: z.string().optional()
                    }),
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
        404: {
            description: 'Client not found',
        },
    },
});

r.openapi(createStaffVisitRoute, async (c) => {
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
