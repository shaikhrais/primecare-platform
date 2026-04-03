import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * Report an incident during/after visit
 */
const reportIncidentRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.INCIDENTS_REPORT,
    method: 'post',
    path: '/',
    summary: 'Report Incident',
    tags: ['PSW', 'Incidents'],
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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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
