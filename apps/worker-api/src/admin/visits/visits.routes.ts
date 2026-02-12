import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { VisitStatus } from '../../../generated/client/edge';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const AssignPswSchema = z.object({
    visitId: z.string().uuid(),
    pswId: z.string().uuid(),
});

// List All Visits
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const visits = await prisma.visit.findMany({
        include: {
            client: { select: { fullName: true, addressLine1: true } },
            psw: { select: { fullName: true } },
            service: true,
        },
        orderBy: { requestedStartAt: 'desc' },
    });
    return c.json(visits);
});

// Assign PSW
r.post('/assign', zValidator('json', AssignPswSchema), async (c) => {
    const prisma = c.get('prisma');
    const { visitId, pswId } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const psw = await prisma.pswProfile.findUnique({ where: { id: pswId } });
    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const [visit] = await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: {
                assignedPswId: pswId,
                status: 'scheduled',
            },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: payload.sub,
                action: 'ASSIGN_PSW',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { pswId },
                tenantId: payload.tenantId
            }
        })
    ]);

    return c.json(visit);
});

// Update Visit
r.patch('/:id', zValidator('json', z.object({
    status: z.string().optional(),
    requestedStartAt: z.string().datetime().optional(),
    durationMinutes: z.number().optional(),
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const data = c.req.valid('json');

    const updateData: any = { ...data };
    if (data.status) {
        updateData.status = data.status as VisitStatus;
    }

    const visit = await prisma.visit.update({
        where: { id },
        data: updateData,
    });
    return c.json(visit);
});

// Delete Visit
r.delete('/:id', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    await prisma.visit.delete({ where: { id } });
    return c.json({ success: true });
});

export default r;
