import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { hashPassword } from '../../_shared/utils/crypto';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const hashRoute = createRoute({
    method: 'get',
    path: '/hash',
    summary: 'Debug Hashing Utility',
    description: 'Generates a hash for a given password string. FOR DEBUGGING ONLY.',
    request: {
        query: z.object({
            password: z.string().min(1)
        })
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        hash: z.string()
                    }),
                },
            },
            description: 'The hashed password',
        },
        400: {
            description: 'Password is required'
        }
    },
});

r.openapi(hashRoute, async (c) => {
    const { password } = c.req.valid('query');
    const hash = await hashPassword(password);
    return c.json({ hash }, 200);
});

export default r;
