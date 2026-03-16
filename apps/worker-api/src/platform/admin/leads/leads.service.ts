/**
 * LeadService — Business logic for admin lead management.
 *
 * Extracted from leads.routes.ts to decouple Prisma queries
 * from Hono route handlers. Includes the lead-to-client conversion
 * pipeline which provisions auth user + clinical profile in a transaction.
 */
export class LeadService {
    constructor(private prisma: any) {}

    /** List all leads ordered by creation date (newest first). */
    async list() {
        return this.prisma.lead.findMany({
            orderBy: { createdAt: 'desc' },
        });
    }

    /** Update lead status (e.g., new → contacted → qualified). */
    async updateStatus(id: string, status: string) {
        return this.prisma.lead.update({
            where: { id },
            data: { status },
        });
    }

    /**
     * Convert a lead into a full client.
     * Atomically creates a User + ClientProfile and marks the lead as 'converted'.
     *
     * @returns { user, client } on success
     * @throws Error with 'NOT_FOUND' or 'ALREADY_CONVERTED' message on failure
     */
    async convertToClient(id: string) {
        const lead = await this.prisma.lead.findUnique({ where: { id } });
        if (!lead) throw new Error('NOT_FOUND');
        if (lead.status === 'converted') throw new Error('ALREADY_CONVERTED');

        return this.prisma.$transaction(async (tx: any) => {
            // 1. Provision Auth User Profile
            const user = await tx.user.create({
                data: {
                    email: lead.email,
                    role: 'client',
                    firstName: lead.firstName,
                    lastName: lead.lastName,
                    tenantId: lead.tenantId,
                },
            });

            // 2. Provision Clinical Profile
            const client = await tx.clientProfile.create({
                data: {
                    userId: user.id,
                    fullName: `${lead.firstName} ${lead.lastName}`,
                    riskLevel: 'medium',
                },
            });

            // 3. Update Lead mapping
            await tx.lead.update({
                where: { id },
                data: { status: 'converted' },
            });

            return { user, client };
        });
    }
}
