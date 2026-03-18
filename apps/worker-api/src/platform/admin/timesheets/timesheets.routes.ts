import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { TimesheetService } from './timesheets.service';
import { UpdateTimesheetStatusSchema } from 'prime-care-shared';

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
    summary: 'List Timesheets',
    tags: ['Admin', 'Timesheets'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of timesheets',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listTimesheetsRoute, async (c) => {
    const service = new TimesheetService(c.get('prisma'));
    const timesheets = await service.list();
    return c.json(timesheets, 200);
});

// Update Timesheet Status
const updateTimesheetStatusRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.TIMESHEETS_UPDATE,
    method: 'patch',
    path: '/{id}',
    summary: 'Update Timesheet Status',
    tags: ['Admin', 'Timesheets'],
    request: {
        params: TimesheetParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: UpdateTimesheetStatusSchema,
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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateTimesheetStatusRoute, async (c) => {
    const service = new TimesheetService(c.get('prisma'));
    const { id } = c.req.valid('param');
    const { status } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const timesheet = await service.updateStatus(id, status, payload.sub, payload.tenantId);
    return c.json(timesheet, 200);
});

export default r;
