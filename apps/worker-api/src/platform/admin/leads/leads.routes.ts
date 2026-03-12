import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

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

// Convert Lead to Client
const convertLeadRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_EXTRA.LEADS_UPDATE, // Assuming metadata covers this path pattern
    method: 'post',
    path: '/{id}/convert',
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
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    const lead = await prisma.lead.findUnique({ where: { id } });
    if (!lead) return c.json({ error: 'Lead not found' }, 404);
    if (lead.status === 'converted') return c.json({ error: 'Lead already converted' }, 400);

    const result = await prisma.$transaction(async (tx: any) => {
        // 1. Provision Auth User Profile
        const user = await tx.user.create({
            data: {
                email: lead.email,
                role: 'client',
                firstName: lead.firstName,
                lastName: lead.lastName,
                tenantId: lead.tenantId, // Ensure it scopes properly
            },
        });

        // 2. Provision Clinical Profile
        const client = await tx.clientProfile.create({
            data: {
                userId: user.id,
                fullName: `${lead.firstName} ${lead.lastName}`,
                riskLevel: 'medium', // Default
            },
        });

        // 3. Update Lead mapping
        await tx.lead.update({
            where: { id },
            data: { status: 'converted' },
        });

        return { user, client };
    });

    return c.json(result, 200);
});

export default r;
