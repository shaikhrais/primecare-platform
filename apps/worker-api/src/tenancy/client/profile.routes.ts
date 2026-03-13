import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getProfileRoute = createRoute({
    method: 'get',
    path: '/profile',
    summary: 'Get Profile',
    tags: ['Client'],
    middleware: [requireRole(['client', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Client profile',
        },
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
