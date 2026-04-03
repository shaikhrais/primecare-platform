import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { requirePermission } from '@primecare/shared-auth';
import { logAudit } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentSchema = z.object({
    id: z.string().uuid().optional(),
    visitId: z.string().uuid().optional().nullable(),
    type: z.enum(['fall_risk', 'refusal', 'no_show', 'safety', 'medical_emergency', 'sos_alert', 'other']),
    description: z.string(),
    status: z.enum(['open', 'investigating', 'resolved']).default('open'),
    resolutionNotes: z.string().optional().nullable(),
});

const listIncidentsRoute = createRoute({
    summary: 'List Operational Incidents',
    description: 'Retrieve a list of all incidents for the staff team to review and resolve.',
    tags: ['Staff Operations'],
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of incidents',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const incidentSubmitRoute = createRoute({
    ...ROUTE_METADATA.STAFF.INCIDENT_SUBMIT,
    method: 'post',
    path: '/submit',
    summary: 'Incident Submit',
    tags: ['Staff', 'Ops'],
    middleware: [requirePermission('manage_incidents')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: IncidentSchema.omit({ id: true, status: true, resolutionNotes: true }),
                },
            },
        },
    },
    responses: {
        201: {
            description: 'Incident reported successfully',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const updateIncidentRoute = createRoute({
    summary: 'Update Incident Resolution',
    description: 'Update the status or resolution notes for an existing incident.',
    tags: ['Staff Operations'],
    method: 'patch',
    path: '/{id}',
    request: {
        params: z.object({
            id: z.string().uuid().openapi({ param: { name: 'id', in: 'path' } }),
        }),
        body: {
            content: {
                'application/json': {
                    schema: IncidentSchema.partial().omit({ id: true }),
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
            description: 'Incident updated successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listIncidentsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const incidents = await prisma.incident.findMany({
        where: { tenantId },
        include: {
            reporter: { select: { email: true } },
            visit: { include: { client: { select: { fullName: true } } } }
        },
        orderBy: { createdAt: 'desc' },
    });

    return c.json(incidents, 200);
});

r.openapi(incidentSubmitRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    const incident = await prisma.incident.create({
        data: {
            reporterUserId: userId,
            tenantId: tenantId,
            type: data.type,
            description: data.description,
            visitId: data.visitId,
            status: 'open',
        },
    });

    await logAudit(prisma, userId, 'LOG_INCIDENT', 'INCIDENT', incident.id, { type: data.type });

    return c.json(incident, 201);
});

r.openapi(updateIncidentRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');

    const incident = await prisma.incident.update({
        where: { id },
        data,
    });

    await logAudit(prisma, userId, 'UPDATE_INCIDENT', 'INCIDENT', incident.id, { status: incident.status });

    return c.json(incident, 200);
});

export default r;
