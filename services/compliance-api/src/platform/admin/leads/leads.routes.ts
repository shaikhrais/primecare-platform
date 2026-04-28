import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { LeadService } from './leads.service';
import { UpdateLeadStatusSchema } from '@primecare/domain';;

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
    summary: 'List Leads',
    tags: ['Admin', 'Leads'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of leads',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listLeadsRoute, async (c) => {
    const service = new LeadService(c.get('prisma'));
    const leads = await service.list();
    return c.json(leads, 200);
});

// Update Lead Status
const updateLeadStatusRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.LEADS_UPDATE,
    method: 'patch',
    path: '/{id}',
    summary: 'Update Lead Status',
    tags: ['Admin', 'Leads'],
    request: {
        params: LeadParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: UpdateLeadStatusSchema,

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateLeadStatusRoute, async (c) => {
    const service = new LeadService(c.get('prisma'));
    const { id } = c.req.valid('param');
    const { status } = c.req.valid('json');
    const lead = await service.updateStatus(id, status);
    return c.json(lead, 200);
});

// Convert Lead to Client
const convertLeadRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.LEADS_UPDATE,
    method: 'post',
    path: '/{id}/convert',
    summary: 'Convert Lead',
    tags: ['Admin', 'Leads'],
    request: {
        params: LeadParamsSchema,
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Lead converted successfully',
        },
        400: { description: 'Lead already converted' },
        404: { description: 'Lead not found' },
    },
});

r.openapi(convertLeadRoute, async (c) => {
    const service = new LeadService(c.get('prisma'));
    const { id } = c.req.valid('param');

    try {
        const result = await service.convertToClient(id);
        return c.json(result, 200);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        if (e.message === 'NOT_FOUND') return c.json({ error: 'Lead not found' }, 404);
        if (e.message === 'ALREADY_CONVERTED') return c.json({ error: 'Lead already converted' }, 400);
        throw e;
    }
});

export default r;
