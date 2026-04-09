import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requireAnyPermission } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getProfileRoute = createRoute({
    method: 'get',
    path: '/profile',
    summary: 'Get Profile',
    tags: ['Client'],
    middleware: [requireAnyPermission(['view_own_medical', 'clinical_oversight', 'view_users'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Client profile',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getProfileRoute, async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload') as any;

    const profile = await prisma.clientProfile.findUnique({
        where: { userId: payload.sub }
    });

    if (!profile) return c.json({} as any, 200);

    return c.json(profile, 200);
});

export default r;
