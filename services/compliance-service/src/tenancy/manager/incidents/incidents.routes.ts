import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requirePermission } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const updateIncidentRoute = createRoute({
    method: 'patch',
    path: '/:id',
    summary: 'Acknowledge and Resolve Incidents',
    tags: ['Manager', 'Incidents'],
    middleware: [requirePermission('manage_incidents')],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.enum(['acknowledged', 'resolved']),
                        resolutionNotes: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Incident updated', content: { 'application/json': { schema: z.any() } } },
        404: { description: 'Not Found', content: { 'application/json': { schema: z.any() } } }
    }
});

const getIncidentsRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'Get Branch Incidents',
    tags: ['Manager', 'Incidents'],
    middleware: [requirePermission('manage_incidents')],
    request: {
        query: z.object({ status: z.enum(['OPEN', 'acknowledged', 'resolved']).optional() })
    },
    responses: {
        200: { description: 'Incidents List', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(getIncidentsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const { status } = c.req.valid('query');
    
    // Fetch critical incidents, optionally filtering by status
    const incidents = await prisma.incident.findMany({
        where: { tenantId, ...(status ? { status } : { status: { not: 'resolved' } }) },
        orderBy: { reportedAt: 'desc' },
        take: 50,
    });
    
    // Map them cleanly for the frontend UX
    const mapped = incidents.map((inc: any) => ({
        id: inc.id,
        type: inc.type,
        severity: inc.severity,
        status: inc.status,
        description: inc.description || 'No description provided',
        reportedAt: inc.reportedAt.toISOString()
    }));
    
    return c.json(mapped, 200);
});

r.openapi(updateIncidentRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;
    const userId = c.get('jwtPayload').sub;

    const incident = await prisma.incident.findUnique({ where: { id, tenantId } });
    if (!incident) return c.json({ error: 'Incident not found' }, 404);

    const updateData: any = { status: body.status };
    if (body.resolutionNotes) {
        updateData.resolutionNotes = body.resolutionNotes;
    }
    
    if (body.status === 'acknowledged' && !incident.acknowledgedAt) {
        updateData.acknowledgedAt = new Date();
        updateData.acknowledgedBy = userId;
    }

    const updated = await prisma.incident.update({
        where: { id },
        data: updateData
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Review Incident Escalations originating from Phase 1' },
        data: { status: 'fully_tested' }
    });

    return c.json(updated, 200);
});

export default r;
