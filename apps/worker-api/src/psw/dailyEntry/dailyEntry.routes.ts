import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requirePermission } from '../../_shared/middleware/rbac';
import { requireClientAssignedToPSW } from '../../_shared/middleware/ownership';
import { logAudit } from '../../_shared/utils/audit';
import { DailyEntryService } from './dailyEntry.service';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

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
r.post('/', requirePermission('DAILY_ENTRY_CREATE'), requireClientAssignedToPSW, zValidator('json', DailyEntrySchema), async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const data = c.req.valid('json');
    const service = new DailyEntryService(prisma);

    const entry = await service.createEntry(user.id, c.get('jwtPayload').tenantId, data);

    await logAudit(prisma, user.id, 'CREATE_DAILY_ENTRY', 'DAILY_ENTRY', entry.id, { clientId: data.clientId });

    return c.json(entry, 201);
});

// History
r.get('/history', async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.query('clientId');
    const tenantId = c.get('jwtPayload').tenantId;
    const service = new DailyEntryService(prisma);

    const entries = await service.getHistory(tenantId, clientId);

    return c.json(entries);
});

export default r;
