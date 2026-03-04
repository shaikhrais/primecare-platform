import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const scrum = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const envAuditRoute = createRoute({
    method: 'get',
    path: '/env-audit',
    summary: 'Environment Variable Audit',
    description: 'Returns sanitized environment variable status for technical auditing.',
    tags: ['Scrum.Audit'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        variables: z.array(z.object({
                            key: z.string(),
                            status: z.enum(['set', 'missing']),
                            security: z.enum(['public', 'system', 'sensitive']),
                        })),
                    }),
                },
            },
            description: 'Audit Results',
        },
    },
});

scrum.openapi(envAuditRoute, async (c) => {
    const env = c.env;

    const auditVars: Array<{ key: string; status: 'set' | 'missing'; security: 'public' | 'system' | 'sensitive' }> = [
        { key: 'ENVIRONMENT', status: env.ENVIRONMENT ? 'set' : 'missing', security: 'public' },
        { key: 'DATABASE_URL', status: env.DATABASE_URL ? 'set' : 'missing', security: 'sensitive' },
        { key: 'JWT_SECRET', status: env.JWT_SECRET ? 'set' : 'missing', security: 'sensitive' },
        { key: 'STRIPE_SECRET_KEY', status: env.STRIPE_SECRET_KEY ? 'set' : 'missing', security: 'sensitive' },
    ];

    return c.json({ variables: auditVars }, 200);
});

export default scrum;
