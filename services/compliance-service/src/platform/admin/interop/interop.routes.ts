import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const fhir = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /interop/fhir/export — Export a FHIR bundle
const exportRoute = createRoute({
    method: 'post', path: '/fhir/export',
    summary: 'Export clinical records as a FHIR R4 bundle', tags: ['FHIR Interop'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string().optional(), resourceTypes: z.array(z.string()).optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        resourceType: z.string(), type: z.string(),
                        total: z.number(), entry: z.array(z.any()),
                    })
                }
            }, description: 'FHIR Bundle'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

fhir.openapi(exportRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const where: any = { tenantId };
    if (body.clientId) where.clientId = body.clientId;
    if (body.resourceTypes?.length) where.type = { in: body.resourceTypes };

    const records = await prisma.clinicalRecord.findMany({ where, take: 500 });

    const bundle = {
        resourceType: 'Bundle', type: 'collection', total: records.length,
        entry: records.map((r: any) => ({
            resource: { ...(typeof r.data === 'object' ? r.data : {}), id: r.id, meta: { lastUpdated: r.updatedAt } },
        })),
    };

    // Log sync
    await prisma.fhirSyncLog.create({
        data: { tenantId, direction: 'OUTBOUND', resourceType: body.resourceTypes?.[0] || 'Bundle', status: 'SUCCESS' },
    });

    return c.json(bundle, 200);
});

// POST /interop/fhir/import — Import and validate a FHIR bundle
const importRoute = createRoute({
    method: 'post', path: '/fhir/import',
    summary: 'Import and validate a FHIR R4 bundle', tags: ['FHIR Interop'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        resourceType: z.string(), type: z.string(), entry: z.array(z.any()),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        imported: z.number(), errors: z.array(z.string()),
                    })
                }
            }, description: 'Import result'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

fhir.openapi(importRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const bundle = c.req.valid('json');
    const errors: string[] = [];
    let imported = 0;

    for (const entry of (bundle.entry || [])) {
        try {
            const resource = entry.resource;
            if (!resource?.resourceType) { errors.push('Missing resourceType'); continue; }

            await prisma.clinicalRecord.create({
                data: {
                    tenantId, clientId: resource.subject?.reference || '',
                    type: resource.resourceType, data: resource,
                },
            });
            imported++;
        } catch (e: any /* Audit 63 Notice: Should be unknown */) { errors.push(e.message || 'Unknown error'); }
    }

    await prisma.fhirSyncLog.create({
        data: {
            tenantId, direction: 'INBOUND', resourceType: 'Bundle',
            status: errors.length > 0 ? 'FAILURE' : 'SUCCESS', error: errors.join('; ') || null
        },
    });

    return c.json({ imported, errors }, 200);
});

// GET /interop/fhir/sync-log — Sync history
const syncLogRoute = createRoute({
    method: 'get', path: '/fhir/sync-log',
    summary: 'FHIR sync log history', tags: ['FHIR Interop'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), direction: z.string(), resourceType: z.string(),
                        status: z.string(), error: z.string().nullable(), timestamp: z.string(),
                    }))
                }
            }, description: 'Sync log'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

fhir.openapi(syncLogRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const logs = await prisma.fhirSyncLog.findMany({
        where: { tenantId }, orderBy: { timestamp: 'desc' }, take: 100,
    });
    return c.json(logs.map((l: any) => ({
        id: l.id, direction: l.direction, resourceType: l.resourceType,
        status: l.status, error: l.error, timestamp: l.timestamp,
    })), 200);
});

export default fhir;
