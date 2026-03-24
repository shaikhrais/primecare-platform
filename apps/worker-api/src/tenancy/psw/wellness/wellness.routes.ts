import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const WellnessPulseSchema = z.object({
    status: z.enum(['great', 'okay', 'struggling', 'burnout']),
    note: z.string().optional(),
});

// POST Wellness Pulse
const submitWellnessPulseRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.WELLNESS_PULSE,
    method: 'post',
    path: '/pulse',
    summary: 'Submit Wellness Pulse',
    tags: ['PSW', 'Wellness'],
    middleware: [requirePermission('view_home')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: WellnessPulseSchema,
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
            description: 'Wellness pulse submitted successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(submitWellnessPulseRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    const pulse = await prisma.wellnessPulse.create({
        data: {
            userId,
            tenantId,
            status: data.status,
            note: data.note,
        },
    });

    await logAudit(prisma, userId, 'WELLNESS_PULSE', 'USER', userId, { status: data.status });

    return c.json(pulse, 201);
});

export default r;
