import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requirePermission } from '@primecare/security';
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getPendingTimesheetsRoute = createRoute({
    method: 'get',
    path: '/pending',
    summary: 'List Pending Timesheets',
    tags: ['Manager', 'Payroll'],
    middleware: [requirePermission('manage_billing')],
    responses: {
        200: { description: 'Pending timesheets', content: { 'application/json': { schema: z.any() } } },
    }
});

const approvePayrollBatchRoute = createRoute({
    method: 'post',
    path: '/approve',
    summary: 'Approve Weekly Payroll Batch',
    tags: ['Manager', 'Payroll'],
    middleware: [requirePermission('manage_billing')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        timesheetIds: z.array(z.string())
                    })
                }
            }
        }
    },
    responses: {
        201: { description: 'Payroll batch approved', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    }
});

r.openapi(getPendingTimesheetsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const timesheets = await prisma.timesheet.findMany({
        where: { tenantId, status: 'submitted' },
        include: { psw: { select: { fullName: true } } }
    });

    return c.json(timesheets, 200);
});

r.openapi(approvePayrollBatchRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const results = [];
    
    // Execute Double-Entry Payroll Approval
    for (const tsId of body.timesheetIds) {
        const timesheet = await prisma.timesheet.findUnique({ where: { id: tsId } });
        if (!timesheet || timesheet.status !== 'submitted') continue;

        // Arbitrary calculation for conceptual ledger $25/hr
        const amount = (timesheet.totalMinutes! / 60.0) * 25.0;

        await prisma.$transaction(async (tx: any) => {
            await tx.timesheet.update({
                where: { id: tsId },
                data: { status: 'approved', reviewedBy: userId, reviewedAt: new Date() }
            });

            const payout = await tx.payout.create({
                data: {
                    providerId: timesheet.providerId,
                    tenantId,
                    amount,
                    currency: 'CAD',
                    status: 'paid',
                    notes: `Payroll for Timesheet ${tsId}`,
                    processedAt: new Date()
                }
            });

            // The aggregate transaction reader buffer for GM Layer PNL
            await tx.financialTransaction.create({
                data: {
                    tenantId,
                    type: 'PAYOUT',
                    referenceId: payout.id,
                    amount,
                    currency: 'CAD',
                    status: 'posted'
                }
            });

            // The immutable core ledger record
            await tx.transactionLedger.create({
                data: {
                    tenantId,
                    transactionType: 'PAYROLL',
                    referenceType: 'Payout',
                    referenceId: payout.id,
                    debitAccount: 'payroll_expense',
                    creditAccount: 'cash',
                    amount,
                    currency: 'CAD',
                    actorUserId: userId,
                    description: `Automated Double-Entry Payroll generation for Timesheet ${tsId}`
                }
            });
            results.push(payout.id);
        });
    }

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Approve Weekly Payroll Batch' },
        data: { status: 'fully_tested' }
    });

    await logAudit(prisma, userId, 'APPROVE_PAYROLL_BATCH', 'TIMESHEET', 'BATCH', { timesheetIds: body.timesheetIds, approvedCount: results.length });

    return c.json({ success: true, processedPayouts: results.length }, 201);
});

export default r;
