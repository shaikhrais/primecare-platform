import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// List Timesheets
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const timesheets = await prisma.timesheet.findMany({
        include: {
            psw: { select: { fullName: true } },
            items: { include: { visit: true } }
        },
        orderBy: { createdAt: 'desc' }
    });
    return c.json(timesheets);
});

// Update Timesheet Status
r.patch('/:id', zValidator('json', z.object({
    status: z.string()
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { status } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const [timesheet] = await prisma.$transaction([
        prisma.timesheet.update({
            where: { id },
            data: {
                status: status as any,
                reviewedBy: payload.sub,
                reviewedAt: new Date()
            }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: payload.sub,
                action: 'REVIEW_TIMESHEET',
                resourceType: 'TIMESHEET',
                resourceId: id,
                metadataJson: { status },
                tenantId: payload.tenantId
            }
        })
    ]);

    return c.json(timesheet);
});

export default r;
