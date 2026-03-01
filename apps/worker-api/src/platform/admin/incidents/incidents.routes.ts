import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'incident-uuid',
    }),
});

/ List Incidents
const listIncidentsRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'List All Incidents',
    description: 'Retrieve a list of all incidents with reporter and visit details.',
    tags: ['Admin Incidents'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of incidents',
        },
    },
});

r.openapi(listIncidentsRoute, async (c) => {
    const prisma = c.get('prisma');
    const incidents = await prisma.incident.findMany({
        include: {
            reporter: { select: { email: true } },
            visit: { select: { id: true, status: true } }
        },
        orderBy: { createdAt: 'desc' }
    });
    return c.json(incidents, 200);
});

/ Update Incident
const updateIncidentRoute = createRoute({
    method: 'patch',
    path: '/{id}',
    summary: 'Update Incident',
    description: 'Update the status and resolution notes of an incident.',
    tags: ['Admin Incidents'],
    request: {
        params: IncidentParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string(),
                        resolutionNotes: z.string().optional()
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
            description: 'Incident updated successfully',
        },
    },
});

r.openapi(updateIncidentRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');
    const incident = await prisma.incident.update({
        where: { id },
        data: {
            status: data.status as any,
            resolutionNotes: data.resolutionNotes
        }
    });
    return c.json(incident, 200);
});

export default r;
