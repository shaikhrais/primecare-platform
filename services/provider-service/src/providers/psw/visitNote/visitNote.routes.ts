import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { requirePermission } from '@primecare/shared-auth';
import { VisitNoteService } from './visitNote.service';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const createNoteRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Create Note',
    tags: ['PSW', 'VisitNote'],
    description: 'Create a VisitNote for a specific Visit. Features 4 & 5 active: Supports wound care photos and #CarePlanUpdate tags.',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string().uuid(),
                        noteText: z.string(),
                        photoUrl: z.string().url().optional()
                    })
                }
            }
        }
    },
    responses: {
        201: { 
            description: 'VisitNote created successfully',
            content: { 'application/json': { schema: z.any() } }
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

r.openapi(createNoteRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const data = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;

    const service = new VisitNoteService(prisma);
    const note = await service.createNote(user.id, tenantId, data);

    return c.json(note, 201);
});

export default r;
