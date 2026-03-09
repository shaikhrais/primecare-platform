import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const payroll = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /payroll/pending — Timesheets awaiting approval
const pendingRoute = createRoute({
    method: 'get', path: '/pending',
    summary: 'List timesheets pending approval', tags: ['Payroll'],
    request: { query: z.object({ weekId: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), pswId: z.string(), pswName: z.string(),
                        weekId: z.string(), totalMinutes: z.number(), status: z.string(),
                    }))
                }
            }, description: 'Pending timesheets'
        },
    },
});

payroll.openapi(pendingRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const weekId = c.req.query('weekId');

    const where: any = { tenantId, status: 'submitted' };
    if (weekId) where.weekId = weekId;

    const timesheets = await prisma.timesheet.findMany({
        where, include: { psw: { select: { fullName: true } } },
        orderBy: { submittedAt: 'desc' },
    });

    return c.json(timesheets.map((t: any) => ({
        id: t.id, pswId: t.pswId, pswName: t.psw?.fullName || '',
        weekId: t.weekId, totalMinutes: t.totalMinutes || 0, status: t.status,
    })), 200);
});

// POST /payroll/batch/approve — Bulk approve timesheets
const batchApproveRoute = createRoute({
    method: 'post', path: '/batch/approve',
    summary: 'Bulk approve timesheets', tags: ['Payroll'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        timesheetIds: z.array(z.string()),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        approvedCount: z.number(), failedIds: z.array(z.string()),
                    })
                }
            }, description: 'Batch result'
        },
    },
});

payroll.openapi(batchApproveRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const { timesheetIds } = c.req.valid('json');
    const failedIds: string[] = [];

    for (const id of timesheetIds) {
        try {
            await prisma.timesheet.update({
                where: { id }, data: { status: 'approved', reviewedBy: userId, reviewedAt: new Date() },
            });
        } catch { failedIds.push(id); }
    }

    return c.json({ approvedCount: timesheetIds.length - failedIds.length, failedIds }, 200);
});

// POST /payroll/run — Generate payouts from approved timesheets
const runRoute = createRoute({
    method: 'post', path: '/run',
    summary: 'Generate payouts from approved timesheets for a pay period', tags: ['Payroll'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        weekId: z.string(), hourlyRate: z.number().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        payoutsGenerated: z.number(), totalAmount: z.string(),
                    })
                }
            }, description: 'Payroll run result'
        },
    },
});

payroll.openapi(runRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { weekId, hourlyRate } = c.req.valid('json');
    const rate = hourlyRate || 25.0; // Default PSW rate

    const approved = await prisma.timesheet.findMany({
        where: { tenantId, weekId, status: 'approved' },
    });

    let totalAmount = 0;
    for (const ts of approved) {
        const hours = (ts.totalMinutes || 0) / 60;
        const amount = hours * rate;
        totalAmount += amount;

        await prisma.payout.create({
            data: { pswId: ts.pswId, tenantId, amount, status: 'pending' },
        });
    }

    return c.json({ payoutsGenerated: approved.length, totalAmount: totalAmount.toFixed(2) }, 200);
});

// GET /payroll/summary/:weekId — Payroll summary for a period
const summaryRoute = createRoute({
    method: 'get', path: '/summary/{weekId}',
    summary: 'Payroll summary for a pay period', tags: ['Payroll'],
    request: { params: z.object({ weekId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        weekId: z.string(), totalTimesheets: z.number(),
                        totalMinutes: z.number(), totalPayouts: z.number(),
                        totalPaid: z.string(), statusBreakdown: z.record(z.number()),
                    })
                }
            }, description: 'Summary'
        },
    },
});

payroll.openapi(summaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { weekId } = c.req.valid('param');

    const timesheets = await prisma.timesheet.findMany({ where: { tenantId, weekId } });
    const payouts = await prisma.payout.findMany({ where: { tenantId } });

    const statusBreakdown: Record<string, number> = {};
    let totalMinutes = 0;
    for (const ts of timesheets) {
        const status = ts.status || 'draft';
        statusBreakdown[status] = (statusBreakdown[status] || 0) + 1;
        totalMinutes += ts.totalMinutes || 0;
    }

    const totalPaid = payouts.reduce((sum: number, p: any) => sum + Number(p.amount || 0), 0);

    return c.json({
        weekId, totalTimesheets: timesheets.length, totalMinutes,
        totalPayouts: payouts.length, totalPaid: totalPaid.toFixed(2), statusBreakdown,
    }, 200);
});

export default payroll;
