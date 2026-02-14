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

const CreateVisitSchema = z.object({
    clientId: z.string().uuid(),
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    assignedPswId: z.string().uuid().optional(),
    clientNotes: z.string().optional(),
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

// Create Visit
r.post('/', zValidator('json', CreateVisitSchema), async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const status: VisitStatus = data.assignedPswId ? 'scheduled' : 'requested';

    const visit = await prisma.visit.create({
        data: {
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: new Date(data.requestedStartAt),
            durationMinutes: data.durationMinutes,
            assignedPswId: data.assignedPswId,
            status: status,
            clientNotes: data.clientNotes,
            tenantId: payload.tenantId
        },
    });

    await logAudit(prisma, payload.sub, 'CREATE_VISIT', 'VISIT', visit.id, {
        assignedPswId: data.assignedPswId,
        status: status
    });

    return c.json(visit, 201);
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
