import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware, requirePermission } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());

// Allow managers, PSWs, RNs, and admins to create/view entries
app.use('*', rbacMiddleware(['manager', 'psw', 'admin', 'rn']));

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

/**
 * @openapi
 * /v1/daily-entry:
 *   post:
 *     summary: Create or Update Daily Care Entry
 */
app.post('/', zValidator('json', DailyEntrySchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const entry = await prisma.dailyEntry.create({
        data: {
            clientId: data.clientId,
            staffId: userId,
            visitId: data.visitId,
            adlData: data.adlData,
            medication: data.medication,
            mood: data.mood,
            vitals: data.vitals,
            notes: data.notes,
            signature: data.signature,
            status: data.status as any,
            tenantId: c.get('jwtPayload').tenantId
        },
    });

    await logAudit(prisma, userId, 'CREATE_DAILY_ENTRY', 'DAILY_ENTRY', entry.id, { clientId: data.clientId });

    return c.json(entry, 201);
});

/**
 * @openapi
 * /v1/daily-entry/:id/review:
 *   post:
 *     summary: RN review/sign-off
 */
app.post('/:id/review', requirePermission('DAILY_ENTRY_REVIEW'), zValidator('json', z.object({
    notes: z.string().optional(),
    status: z.enum(['APPROVED', 'REJECTED'])
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { notes, status } = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const entry = await prisma.dailyEntry.update({
        where: { id },
        data: {
            notes: notes ? `RN Review: ${notes}` : undefined,
            status: status === 'APPROVED' ? 'SUBMITTED' : 'DRAFT' // Adjust based on business logic
        }
    });

    await logAudit(prisma, userId, 'REVIEW_DAILY_ENTRY', 'DAILY_ENTRY', id, { status, notes });

    return c.json(entry);
});

/**
 * @openapi
 * /v1/daily-entry/draft:
 *   post:
 *     summary: Quick Save Draft
 */
app.post('/draft', zValidator('json', DailyEntrySchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const entry = await prisma.dailyEntry.create({
        data: {
            clientId: data.clientId,
            staffId: userId,
            visitId: data.visitId,
            adlData: data.adlData,
            medication: data.medication,
            mood: data.mood,
            vitals: data.vitals,
            notes: data.notes,
            signature: data.signature,
            status: 'DRAFT',
            tenantId: c.get('jwtPayload').tenantId
        },
    });

    return c.json(entry, 201);
});

/**
 * @openapi
 * /v1/daily-entry/history:
 *   get:
 *     summary: Get history of entries
 */
app.get('/history', async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.query('clientId');

    const where: any = {
        tenantId: c.get('jwtPayload').tenantId
    };
    if (clientId) where.clientId = clientId;

    const entries = await prisma.dailyEntry.findMany({
        where,
        take: 50,
        orderBy: { createdAt: 'desc' },
        include: {
            client: { select: { fullName: true } },
            staff: { select: { email: true } }
        }
    });

    return c.json(entries);
});

export default app;
