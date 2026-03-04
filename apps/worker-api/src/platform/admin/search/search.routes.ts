import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const search = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const globalSearchRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'Global Platform Search',
    description: 'Search across users, patients, leads, and incidents.',
    tags: ['Admin.Search'],
    request: {
        query: z.object({
            q: z.string().min(2).openapi({ example: 'smith' }),
            limit: z.string().optional().default('10'),
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        results: z.object({
                            users: z.array(z.any()),
                            clients: z.array(z.any()),
                            leads: z.array(z.any()),
                            incidents: z.array(z.any()),
                        }),
                        total: z.number(),
                    }),
                },
            },
            description: 'Success',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({
                        error: z.string(),
                    }),
                },
            },
            description: 'Internal Server Error',
        },
    },
});

search.openapi(globalSearchRoute, async (c) => {
    const prisma = c.get('prisma');
    const { q, limit } = c.req.valid('query');
    const limitNum = parseInt(limit);

    try {
        const [users, clients, leads, incidents] = await Promise.all([
            prisma.user.findMany({
                where: { email: { contains: q, mode: 'insensitive' } },
                take: limitNum,
                select: { id: true, email: true, roles: true, status: true }
            }),
            prisma.clientProfile.findMany({
                where: { fullName: { contains: q, mode: 'insensitive' } },
                take: limitNum,
                select: { id: true, fullName: true, city: true, user: { select: { email: true } } }
            }),
            prisma.lead.findMany({
                where: { OR: [{ fullName: { contains: q, mode: 'insensitive' } }, { email: { contains: q, mode: 'insensitive' } }] },
                take: limitNum,
            }),
            prisma.incident.findMany({
                where: { description: { contains: q, mode: 'insensitive' } },
                take: limitNum,
            })
        ]);

        return c.json({
            results: { users, clients, leads, incidents },
            total: users.length + clients.length + leads.length + incidents.length
        }, 200);
    } catch (error: any) {
        return c.json({ error: error.message }, 500);
    }
});

export default search;
