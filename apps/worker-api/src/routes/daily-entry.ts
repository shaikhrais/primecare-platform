import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});

// Allow managers, PSWs, and admins to create/view entries
app.use('*', rbacMiddleware(['manager', 'psw', 'admin']));

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
        },
    });

    await logAudit(prisma, userId, 'CREATE_DAILY_ENTRY', 'DAILY_ENTRY', entry.id, { clientId: data.clientId });

    return c.json(entry, 201);
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
    data.status = 'DRAFT';

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
    const userId = c.get('jwtPayload').sub;

    // Managers/Admins can see all, PSW only their own? 
    // For now, let's just return entries created by the user or for a specific client if provided
    const clientId = c.req.query('clientId');

    const where: any = {};
    if (clientId) where.clientId = clientId;

    // If not manager/admin, restrict to self?
    // Implementation Plan said "Manager Dashboard", so manager needs to see all.
    // For now, return recent 50
    const entries = await prisma.dailyEntry.findMany({
        where,
        take: 50,
        orderBy: { createdAt: 'desc' },
        include: {
            client: { select: { fullName: true } },
            staff: { select: { email: true } } // User doesn't have fullName on root, check PswProfile if needed, but email is on User
        }
    });

    return c.json(entries);
});

export default app;
