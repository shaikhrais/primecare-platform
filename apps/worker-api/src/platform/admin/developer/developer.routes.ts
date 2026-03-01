import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const developer = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/admin/developer/keys
developer.get('/keys', async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const keys = await prisma.apiKey.findMany({
        where: { tenantId }
    });

    return c.json(keys);
});

// POST /v1/admin/developer/keys
const createKeyRoute = createRoute({
    method: 'post',
    path: '/keys',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        name: z.string().min(1),
                    }),
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.object({
                        key: z.string(),
                    }),
                },
            },
            description: 'API Key created',
        },
    },
});

developer.openapi(createKeyRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const { name } = c.req.valid('json');

    // Generate a secure random key
    const key = `pk_${crypto.randomUUID().replace(/-/g, '')}`;

    await prisma.apiKey.create({
        data: {
            name,
            key,
            tenantId
        }
    });

    return c.json({ key }, 201);
});

// DELETE /v1/admin/developer/keys/:id
developer.delete('/keys/:id', async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const id = c.req.param('id');

    await prisma.apiKey.deleteMany({
        where: { id, tenantId }
    });

    return c.json({ success: true });
});

export default developer;
