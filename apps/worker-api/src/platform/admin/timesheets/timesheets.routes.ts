import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { logAudit } from '../../../utils/audit';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const TimesheetParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'timesheet-uuid',
    }),
});

// List Timesheets
const listTimesheetsRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.TIMESHEETS_LIST,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of timesheets',
        },
    },
});

r.openapi(listTimesheetsRoute, async (c) => {
    const prisma = c.get('prisma');
    const timesheets = await prisma.timesheet.findMany({
        include: {
            psw: { select: { fullName: true } },
            items: { include: { visit: true } }
        },
        orderBy: { createdAt: 'desc' }
    });
    return c.json(timesheets, 200);
});

// Update Timesheet Status
const updateTimesheetStatusRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.TIMESHEETS_UPDATE,
    method: 'patch',
    path: '/{id}',
    request: {
        params: TimesheetParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string()
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
            description: 'Timesheet updated successfully',
        },
    },
});

r.openapi(updateTimesheetStatusRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { status } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const [timesheet] = await prisma.$transaction([
        prisma.timesheet.update({
            where: { id },
            data: {
                status: status as any,
                reviewedBy: payload.sub,
                reviewedAt: new Date()
            }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: payload.sub,
                action: 'REVIEW_TIMESHEET',
                resourceType: 'TIMESHEET',
                resourceId: id,
                metadataJson: { status },
                tenantId: payload.tenantId
            }
        })
    ]);

    return c.json(timesheet, 200);
});

export default r;
