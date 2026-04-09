import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { IncidentService } from './incidents.service';
import { UpdateIncidentSchema } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'incident-uuid',
    }),
});

// List Incidents
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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listIncidentsRoute, async (c) => {
    const service = new IncidentService(c.get('prisma'));
    const incidents = await service.list();
    return c.json(incidents, 200);
});

// Update Incident
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
                    schema: UpdateIncidentSchema,
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

r.openapi(updateIncidentRoute, async (c) => {
    const service = new IncidentService(c.get('prisma'));
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');
    const incident = await service.update(id, data);
    return c.json(incident, 200);
});

export default r;
