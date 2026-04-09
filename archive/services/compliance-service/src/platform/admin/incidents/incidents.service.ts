/**
 * IncidentService — Business logic for admin incident management.
 *
 * Extracted from incidents.routes.ts to decouple Prisma queries
 * from Hono route handlers.
 */
export class IncidentService {
    constructor(private prisma: any) {}

    /** List all incidents with reporter email and associated visit details. */
    async list() {
        return this.prisma.incident.findMany({
            include: {
                reporter: { select: { email: true } },
                visit: { select: { id: true, status: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }

    /** Update incident status and optional resolution notes. */
    async update(id: string, data: { status: string; resolutionNotes?: string }) {
        return this.prisma.incident.update({
            where: { id },
            data: {
                status: data.status as any,
                resolutionNotes: data.resolutionNotes,
            },
        });
    }
}
