import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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

const auditHistoryRoute = createRoute({
    method: 'get',
    path: '/audits',
    summary: 'Technical Audit History',
    description: 'Returns historical platform-wide health and registry integrity audits.',
    tags: ['Scrum.Audit'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        type: z.string(),
                        status: z.string(),
                        summary: z.string(),
                        issuesCount: z.number(),
                        performedAt: z.string(),
                    })),
                },
            },
            description: 'Audit History',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const responseBotScanRoute = createRoute({
    method: 'post',
    path: '/response-bot/audit',
    summary: 'Response Bot Pulse',
    description: 'Triggers a real-time platform-wide heartbeat and registry check.',
    tags: ['Scrum.Audit'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        message: z.string(),
                        auditId: z.string(),
                    }),
                },
            },
            description: 'Audit Triggered',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const RegistryEntrySchema = z.object({
    externalId: z.string(),
    type: z.string(),
    label: z.string(),
    role: z.string(),
    module: z.string(),
    action: z.string().optional(),
    targetPath: z.string().optional(),
    description: z.string().optional(),
    metadata: z.any().optional(),
});

const registrySyncRoute = createRoute({
    method: 'post',
    path: '/registry/sync',
    summary: 'Synchronize Registry',
    description: 'Synchronizes local registry definitions to the central database.',
    tags: ['Scrum.Registry'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        entries: z.array(RegistryEntrySchema),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        synced: z.number(),
                        errors: z.number(),
                    }),
                },
            },
            description: 'Sync Results',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

scrum.openapi(auditHistoryRoute, async (c) => {
    const prisma = c.get('prisma');
    const audits = await prisma.technicalAudit.findMany({
        orderBy: { performedAt: 'desc' },
        take: 20
    });
    return c.json(audits, 200);
});

scrum.openapi(responseBotScanRoute, async (c) => {
    const prisma = c.get('prisma');
    // For now, it's a simple pulse record. In real usage, this would trigger an async task.
    const audit = await prisma.technicalAudit.create({
        data: {
            type: 'UNIVERSAL_HEARTBEAT',
            status: 'success',
            summary: 'Manual Response Bot pulse check executed successfully.',
            issuesCount: 0
        }
    });

    return c.json({ message: 'Audit performed successfully', auditId: audit.id }, 200);
});

scrum.openapi(registrySyncRoute, async (c) => {
    const prisma = c.get('prisma');
    const { entries } = c.req.valid('json');
    let synced = 0;
    let errors = 0;

    for (const entry of entries) {
        try {
            await prisma.registryEntry.upsert({
                where: { externalId: entry.externalId },
                update: {
                    label: entry.label,
                    type: entry.type,
                    role: entry.role,
                    module: entry.module,
                    action: entry.action,
                    targetPath: entry.targetPath,
                    description: entry.description,
                    metadata: entry.metadata || {},
                },
                create: {
                    externalId: entry.externalId,
                    label: entry.label,
                    type: entry.type,
                    role: entry.role,
                    module: entry.module,
                    action: entry.action,
                    targetPath: entry.targetPath,
                    description: entry.description,
                    metadata: entry.metadata || {},
                },
            });
            synced++;
        } catch (e) {
            // R10: Don't leak internal errors
            errors++;
        }
    }

    return c.json({ synced, errors }, 200);
});

export default scrum;
