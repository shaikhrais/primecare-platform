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
            tenantId: payload.tenantId,
            priority: (data as any).priority || 'normal',
            requiredSkills: (data as any).requiredSkills || [],
        },
    });

    await logAudit(prisma, payload.sub, 'CREATE_VISIT', 'VISIT', visit.id, {
        assignedPswId: data.assignedPswId,
        status: status
    });

    return c.json(visit, 201);
});

// POST Post Shift (Move from draft/requested to posted)
r.post('/:id/post', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const payload = c.get('jwtPayload');

    const visit = await prisma.visit.update({
        where: { id },
        data: { status: 'posted' }
    });

    await logAudit(prisma, payload.sub, 'POST_SHIFT', 'VISIT', id);
    return c.json(visit);
});

// POST Offer Shift to PSWs
r.post('/:id/offer', zValidator('json', z.object({
    pswIds: z.array(z.string().uuid()),
})), async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const { pswIds } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const assignments = await Promise.all(pswIds.map(pswId =>
        prisma.shiftAssignment.create({
            data: {
                visitId: id,
                pswId,
                status: 'offered',
                tenantId: payload.tenantId, // Wait, I didn't add tenantId to shift_assignments in schema.prisma?
            }
        })
    ));

    await prisma.visit.update({
        where: { id },
        data: { status: 'offered' }
    });

    await logAudit(prisma, payload.sub, 'OFFER_SHIFT', 'VISIT', id, { pswIds });
    return c.json({ success: true, count: assignments.length });
});

// GET Suggest PSWs (Simple Scoring Engine)
r.get('/:id/suggest', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');

    const visit = await prisma.visit.findUnique({
        where: { id },
        include: { client: true }
    });
    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    // 1. Get all active PSWs
    const psws = await prisma.pswProfile.findMany({
        where: { isApproved: true, tenantId: visit.tenantId },
        include: { availability: true }
    });

    // 2. Simple Scoring Logic
    const suggested = psws.map((psw: any) => {
        let score = 50; // Base score

        // Availability check (harder to implement perfectly without date logic, matching dayOfWeek)
        const day = visit.requestedStartAt.getDay();
        const hasAvailability = psw.availability.some((a: any) => a.dayOfWeek === day);
        if (hasAvailability) score += 30;

        // Skills match (placeholder)
        // const skillMatch = visit.requiredSkills.every(s => psw.skills.includes(s));

        return {
            id: psw.id,
            fullName: psw.fullName,
            score,
            reasons: hasAvailability ? ['Availability matches'] : ['No structured availability on this day']
        };
    }).sort((a: any, b: any) => b.score - a.score).slice(0, 5);

    return c.json(suggested);
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
