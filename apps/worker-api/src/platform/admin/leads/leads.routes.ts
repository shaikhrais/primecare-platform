import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { ROUTE_METADATA } from '../../../constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const LeadParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'lead-uuid',
    }),
});

// List Leads
const listLeadsRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.LEADS_LIST,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of leads',
        },
    },
});

r.openapi(listLeadsRoute, async (c) => {
    const prisma = c.get('prisma');
    const leads = await prisma.lead.findMany({
        orderBy: { createdAt: 'desc' },
    });
    return c.json(leads, 200);
});

// Update Lead Status
const updateLeadStatusRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.LEADS_UPDATE,
    method: 'patch',
    path: '/{id}',
    request: {
        params: LeadParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({ status: z.string() }),
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
            description: 'Lead status updated successfully',
        },
    },
});

r.openapi(updateLeadStatusRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { status } = c.req.valid('json');

    const lead = await prisma.lead.update({
        where: { id },
        data: { status },
    });

    return c.json(lead, 200);
});

export default r;
