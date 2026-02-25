import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * Report an incident during/after visit
 */
const reportIncidentRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Report Incident',
    description: 'Report an incident that occurred during or after a visit.',
    tags: ['PSW Incidents'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string().uuid().optional(),
                        type: z.string(),
                        description: z.string()
                    }),
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Incident report created successfully',
        },
    },
});

r.openapi(reportIncidentRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { visitId, type, description } = c.req.valid('json');

    const incident = await prisma.incident.create({
        data: {
            visitId,
            reporterUserId: userId,
            type: type as any,
            description,
            status: 'open',
            tenantId: c.get('jwtPayload').tenantId
        }
    });

    return c.json(incident, 201);
});

export default r;
