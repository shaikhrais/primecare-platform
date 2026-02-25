import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { requirePermission } from '../../_shared/middleware/rbac';
import { requireClientAssignedToPSW } from '../../_shared/middleware/ownership';
import { logAudit } from '../../_shared/utils/audit';
import { DailyEntryService } from './dailyEntry.service';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const DailyEntrySchema = z.object({
    clientId: z.string().uuid(),
    visitId: z.string().uuid().optional(),
    adlData: z.any(),
    medication: z.any().optional(),
    mood: z.number().min(1).max(5).optional(),
    vitals: z.any().optional(),
    notes: z.string().optional(),
    signature: z.string().optional(),
    status: z.enum(['DRAFT', 'SUBMITTED']).default('DRAFT'),
});

// Create/Submit Entry
const createEntryRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.DAILY_ENTRY_CREATE,
    method: 'post',
    path: '/',
    middleware: [
        requirePermission('DAILY_ENTRY_CREATE'),
        requireClientAssignedToPSW
    ],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: DailyEntrySchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Entry created successfully',
        },
    },
});

r.openapi(createEntryRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const data = c.req.valid('json');
    const service = new DailyEntryService(prisma);

    const entry = await service.createEntry(user.id, c.get('jwtPayload').tenantId, data);
    await logAudit(prisma, user.id, 'CREATE_DAILY_ENTRY', 'DAILY_ENTRY', entry.id, { clientId: data.clientId });

    return c.json(entry, 201);
});

// History
const getHistoryRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.DAILY_ENTRY_HISTORY,
    method: 'get',
    path: '/history',
    request: {
        query: z.object({
            clientId: z.string().optional()
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of historical entries',
        },
    },
});

r.openapi(getHistoryRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('query');
    const tenantId = c.get('jwtPayload').tenantId;
    const service = new DailyEntryService(prisma);

    const entries = await service.getHistory(tenantId, clientId);
    return c.json(entries, 200);
});

export default r;
