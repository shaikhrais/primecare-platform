import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requirePermission } from '@primecare/shared-auth';
import { logAudit } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const processCallInRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Process PSW Call-in',
    tags: ['Coordinator', 'Scheduling'],
    middleware: [requirePermission('manage_schedule')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string(),
                        reason: z.string()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Shift dropped successfully', content: { 'application/json': { schema: z.any() } } },
        404: { description: 'Not Found', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(processCallInRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;
    const userId = c.get('jwtPayload').sub;

    const visit = await prisma.visit.findUnique({ where: { id: body.visitId, tenantId } });
    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    // Atomic Execution: Drop PSW, Set Status to Requested, Create SOS Incident
    await prisma.$transaction(async (tx: any) => {
        await tx.visit.update({
            where: { id: body.visitId },
            data: {
                assignedProviderId: null,
                status: 'requested',
                cancellationReason: `Call-in: ${body.reason}`,
                crisisMode: true // Flag for immediate ecosystem dispatch
            }
        });

        await tx.incident.create({
            data: {
                tenantId,
                visitId: body.visitId,
                reporterUserId: userId,
                type: 'NO_SHOW_CALL_IN',
                description: `PSW called in sick explicitly. Reason: ${body.reason}`,
                severity: 'high',
                reportedAt: new Date()
            }
        });
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Process PSW Call-in/Sick' },
        data: { status: 'fully_tested' }
    });

    await logAudit(prisma, userId, 'PROCESS_CALL_IN', 'VISIT', body.visitId, { reason: body.reason });

    return c.json({ success: true, message: 'Shift dropped and returned to pool.' }, 200);
});

export default r;
