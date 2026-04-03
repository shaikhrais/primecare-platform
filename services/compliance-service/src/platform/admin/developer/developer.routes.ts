import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

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
    summary: 'Create Key',
    tags: ['Admin', 'Developer'],
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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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

// POST /v1/admin/developer/db-push
const dbPushRoute = createRoute({
    method: 'post',
    path: '/db-push',
    summary: 'Db Push',
    tags: ['Admin', 'Developer'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        message: z.string()
                    }),
                },
            },
            description: 'Schema pushed successfully',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        message: z.string()
                    }),
                },
            },
            description: 'Failed to push schema',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

developer.openapi(dbPushRoute, async (c) => {
    const prisma = c.get('prisma');
    
    try {
        // Execute the pending schema changes using raw SQL
        // Note: For a true `db push`, Prisma engine is required, but we can execute specific DDL if provided
        // Since we don't have the Prisma Migration Engine in the edge worker, we'll return a helpful message
        // Or if the user meant to just verify connection:
        await prisma.$executeRawUnsafe(`SELECT 1;`);
        
        return c.json({
            success: true,
            message: "Database connection successful. Note: Full 'prisma db push' requires the CLI/Engine which is not bundled in the Cloudflare Worker. Please run 'npx prisma db push' locally with a valid DATABASE_URL in your .env file."
        }, 200);
    } catch (error: any) {
        return c.json({
            success: false,
            message: error?.message || 'Failed to connect to database'
        }, 500);
    }
});

export default developer;
