import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const DailyEntryParamsSchema = z.object({
    id: z.string().openapi({ param: { name: 'id', in: 'path' } }),
});

/**
 * RN review/sign-off
 */
const reviewDailyEntryRoute = createRoute({
    ...ROUTE_METADATA.RN.DAILY_REVIEW,
    method: 'post',
    path: '/{id}/review',
    middleware: [requirePermission('DAILY_ENTRY_REVIEW')],
    request: {
        params: DailyEntryParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        notes: z.string().optional(),
                        status: z.enum(['APPROVED', 'REJECTED'])
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
            description: 'Daily entry reviewed successfully',
        },
    },
});

r.openapi(reviewDailyEntryRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { notes, status } = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const entry = await prisma.dailyEntry.update({
        where: { id },
        data: {
            notes: notes ? `RN Review: ${notes}` : undefined,
            status: status === 'APPROVED' ? 'SUBMITTED' : 'DRAFT'
        }
    });

    await logAudit(prisma, userId, 'REVIEW_DAILY_ENTRY', 'DAILY_ENTRY', id, { status, notes });

    return c.json(entry, 200);
});

export default r;
