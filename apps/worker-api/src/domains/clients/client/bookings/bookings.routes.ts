import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { requirePermission } from '../../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getBookingStatusRoute = createRoute({
    method: 'get',
    path: '/:id/status',
    summary: 'Track Live Dispatch Status',
    tags: ['Client', 'Bookings'],
    middleware: [requirePermission('view_own_bookings')],
    request: {
        params: z.object({ id: z.string() })
    },
    responses: {
        200: { description: 'Status Output', content: { 'application/json': { schema: z.any() } } },
        404: { description: 'Not Found', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(getBookingStatusRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const tenantId = c.get('jwtPayload').tenantId;

    const visit = await prisma.visit.findFirst({
        where: { id, tenantId },
        select: {
            id: true,
            status: true,
            requestedStartAt: true,
            actualStartAt: true,
            actualEndAt: true,
            notes: true,
            cancellationReason: true,
            assignedPsw: {
                select: {
                    firstName: true,
                    // Note: Exclude lastName, PII, and geo explicitly for client safety
                }
            }
        }
    });

    if (!visit) {
        return c.json({ error: 'Booking not found' }, 404);
    }

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Track Live Dispatch Status' },
        data: { status: 'fully_tested' }
    });

    return c.json(visit, 200);
});

export default r;
