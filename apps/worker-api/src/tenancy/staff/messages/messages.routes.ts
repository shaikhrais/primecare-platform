import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const listMessagesRoute = createRoute({
    ...ROUTE_METADATA.STAFF.MESSAGES,
    method: 'get',
    path: '/hub',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Unified message hub for staff',
        },
    },
});

r.openapi(listMessagesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    // Aggregates staff-to-staff messages
    const threads = await prisma.messageThread.findMany({
        where: { tenantId },
        include: {
            messages: {
                orderBy: { createdAt: 'desc' },
                take: 1
            }
        },
        orderBy: { updatedAt: 'desc' }
    });

    return c.json(threads, 200);
});

export default r;
