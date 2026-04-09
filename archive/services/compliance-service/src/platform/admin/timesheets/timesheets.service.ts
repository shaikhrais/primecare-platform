/**
 * TimesheetService — Business logic for admin timesheet management.
 *
 * Extracted from timesheets.routes.ts to decouple Prisma queries
 * from Hono route handlers.
 */
export class TimesheetService {
    constructor(private prisma: any) {}

    /** List all timesheets with PSW profile and line items (visits). */
    async list() {
        return this.prisma.timesheet.findMany({
            include: {
                psw: { select: { fullName: true } },
                items: { include: { visit: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }

    /**
     * Update timesheet status (approve/reject) with audit trail.
     * Uses a Prisma transaction to atomically update status + create audit log.
     */
    async updateStatus(id: string, status: string, reviewerId: string, tenantId: string) {
        const [timesheet] = await this.prisma.$transaction([
            this.prisma.timesheet.update({
                where: { id },
                data: {
                    status: status as any,
                    reviewedBy: reviewerId,
                    reviewedAt: new Date(),
                },
            }),
            this.prisma.auditLog.create({
                data: {
                    actorUserId: reviewerId,
                    action: 'REVIEW_TIMESHEET',
                    resourceType: 'TIMESHEET',
                    resourceId: id,
                    metadata: JSON.stringify({ status }),
                    tenantId,
                },
            }),
        ]);

        return timesheet;
    }
}
