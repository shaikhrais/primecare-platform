import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const evv = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET / — List EVV records
const listRoute = createRoute({
    method: 'get', path: '/',
    summary: 'List EVV Records',
    tags: ['EVV'],
    request: {
        query: z.object({
            startDate: z.string().optional(),
            endDate: z.string().optional(),
            pswId: z.string().optional(),
            status: z.string().optional(),
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), visitId: z.string(), pswId: z.string(),
                        checkType: z.string(), verificationMethod: z.string(),
                        status: z.string(), capturedAt: z.string(),
                    }))
                }
            }, description: 'EVV records'
        },
    },
});

evv.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const query = c.req.valid('query');

    const where: any = { tenantId };
    if (query.pswId) where.pswId = query.pswId;
    if (query.status) where.status = query.status;
    if (query.startDate || query.endDate) {
        where.capturedAt = {};
        if (query.startDate) where.capturedAt.gte = new Date(query.startDate);
        if (query.endDate) where.capturedAt.lte = new Date(query.endDate);
    }

    const records = await prisma.eVVRecord.findMany({
        where, orderBy: { capturedAt: 'desc' }, take: 500,
    });
    return c.json(records, 200);
});

// GET /exceptions — Records needing review
const exceptionsRoute = createRoute({
    method: 'get', path: '/exceptions',
    summary: 'List EVV Exceptions',
    tags: ['EVV'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), visitId: z.string(), status: z.string(),
                    }))
                }
            }, description: 'Exception records'
        },
    },
});

evv.openapi(exceptionsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const records = await prisma.eVVRecord.findMany({
        where: { tenantId, status: 'exception' },
        orderBy: { capturedAt: 'desc' },
    });
    return c.json(records, 200);
});

// POST /exceptions/:id/approve — Supervisor override
const approveExceptionRoute = createRoute({
    method: 'post', path: '/exceptions/{id}/approve',
    summary: 'Approve EVV Exception',
    tags: ['EVV'],
    request: {
        params: z.object({ id: z.string() }),
        body: { content: { 'application/json': { schema: z.object({ reason: z.string() }) } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Approved' },
        404: { description: 'Not found' },
    },
});

evv.openapi(approveExceptionRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const userId = (c.get('jwtPayload') as any).sub;
    const { id } = c.req.valid('param');
    const { reason } = c.req.valid('json');

    const record = await prisma.eVVRecord.findFirst({ where: { id, tenantId } });
    if (!record) return c.json({ error: 'Not found' }, 404);

    await prisma.eVVRecord.update({
        where: { id },
        data: { status: 'overridden', overrideById: userId, overrideReason: reason },
    });
    return c.json({ success: true }, 200);
});

// GET /compliance-summary — Dashboard stats
const complianceSummaryRoute = createRoute({
    method: 'get', path: '/compliance-summary',
    summary: 'EVV Compliance Summary',
    tags: ['EVV'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalRecords: z.number(), validCount: z.number(),
                        exceptionCount: z.number(), overriddenCount: z.number(),
                        complianceRate: z.number(),
                    })
                }
            }, description: 'Summary'
        },
    },
});

evv.openapi(complianceSummaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const [total, valid, exceptions, overridden] = await Promise.all([
        prisma.eVVRecord.count({ where: { tenantId } }),
        prisma.eVVRecord.count({ where: { tenantId, status: 'valid' } }),
        prisma.eVVRecord.count({ where: { tenantId, status: 'exception' } }),
        prisma.eVVRecord.count({ where: { tenantId, status: 'overridden' } }),
    ]);

    return c.json({
        totalRecords: total, validCount: valid,
        exceptionCount: exceptions, overriddenCount: overridden,
        complianceRate: total > 0 ? Math.round(((valid + overridden) / total) * 10000) / 100 : 100,
    }, 200);
});

// GET /export — CSV/JSON export
const exportRoute = createRoute({
    method: 'get', path: '/export',
    summary: 'Export EVV Records',
    tags: ['EVV'],
    request: {
        query: z.object({
            format: z.enum(['json', 'csv']).optional(),
            startDate: z.string(), endDate: z.string(),
        }),
    },
    responses: { 200: { description: 'Export data' } },
});

evv.openapi(exportRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { startDate, endDate, format } = c.req.valid('query');

    const records = await prisma.eVVRecord.findMany({
        where: {
            tenantId,
            capturedAt: { gte: new Date(startDate), lte: new Date(endDate) },
        },
        orderBy: { capturedAt: 'asc' },
    });

    if (format === 'csv') {
        const header = 'id,visitId,pswId,checkType,lat,lng,verificationMethod,status,capturedAt\n';
        const rows = records.map((r: any) =>
            `${r.id},${r.visitId},${r.pswId},${r.checkType},${r.lat},${r.lng},${r.verificationMethod},${r.status},${r.capturedAt.toISOString()}`
        ).join('\n');
        return new Response(header + rows, {
            headers: { 'Content-Type': 'text/csv', 'Content-Disposition': 'attachment; filename=evv-export.csv' },
        });
    }
    return c.json(records, 200);
});

export default evv;
