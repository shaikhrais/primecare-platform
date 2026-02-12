import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requirePermission } from '../../_shared/middleware/rbac';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * RN review/sign-off
 */
r.post('/:id/review', requirePermission('DAILY_ENTRY_REVIEW'), zValidator('json', z.object({
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
            status: status === 'APPROVED' ? 'SUBMITTED' : 'DRAFT'
        }
    });

    await logAudit(prisma, userId, 'REVIEW_DAILY_ENTRY', 'DAILY_ENTRY', id, { status, notes });

    return c.json(entry);
});

export default r;
