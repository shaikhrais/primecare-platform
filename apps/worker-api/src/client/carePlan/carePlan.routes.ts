import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requirePermission } from '../../_shared/middleware/rbac';
import { logAudit } from '../../utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const CarePlanSchema = z.object({
    goals: z.array(z.string()),
    precautions: z.array(z.string()),
    interventions: z.array(z.string()),
    riskLevel: z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']).optional()
});

// POST Care Plan
r.post('/:clientId', requirePermission('CARE_PLAN_CREATE'), zValidator('json', CarePlanSchema), async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.param('clientId');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await logAudit(prisma, userId, 'CREATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan created', data });
});

// PATCH Care Plan
r.patch('/:clientId', requirePermission('CARE_PLAN_UPDATE'), zValidator('json', CarePlanSchema.partial()), async (c) => {
    const prisma = c.get('prisma');
    const clientId = c.req.param('clientId');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await logAudit(prisma, userId, 'UPDATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan updated', data });
});

export default r;
