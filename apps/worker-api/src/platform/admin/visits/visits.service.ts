import { rrulestr } from 'rrule';
import { logAudit } from '../../../_shared/utils/audit';

/**
 * VisitService — Business logic for admin visit management.
 *
 * Extracted from routes/list.ts and routes/manage.ts to decouple
 * Prisma queries from Hono route handlers.
 */
export class VisitService {
    constructor(private prisma: any) {}

    /** List all visits with client/PSW/service details, ordered by most recent first. */
    async list() {
        return this.prisma.visit.findMany({
            include: {
                client: { select: { fullName: true, addressLine1: true } },
                psw: { select: { fullName: true } },
                service: true,
            },
            orderBy: { requestedStartAt: 'desc' },
        });
    }

    /** Create a single visit. */
    async create(data: {
        clientId: string;
        serviceId: string;
        requestedStartAt: string;
        durationMinutes: number;
        assignedPswId?: string;
        clientNotes?: string;
        priority?: string;
        requiredSkills?: string[];
    }, tenantId: string, actorUserId: string) {
        const status = data.assignedPswId ? 'scheduled' : 'requested';

        const visit = await this.prisma.visit.create({
            data: {
                clientId: data.clientId,
                serviceId: data.serviceId,
                requestedStartAt: new Date(data.requestedStartAt),
                durationMinutes: data.durationMinutes,
                assignedPswId: data.assignedPswId,
                status,
                clientNotes: data.clientNotes,
                tenantId,
                priority: data.priority || 'normal',
                requiredSkills: data.requiredSkills || [],
            },
        });

        await logAudit(this.prisma, actorUserId, 'CREATE_VISIT', 'VISIT', visit.id, {
            assignedPswId: data.assignedPswId,
            status,
        });

        return visit;
    }

    /** Create a recurring series of visits using an RRULE string (max 90 occurrences). */
    async createSeries(data: {
        clientId: string;
        serviceId: string;
        requestedStartAt: string;
        durationMinutes: number;
        assignedPswId?: string;
        clientNotes?: string;
        priority?: string;
        requiredSkills?: string[];
        recurrenceRuleString: string;
        recurrenceEndDate?: string | null;
    }, tenantId: string, actorUserId: string) {
        const status = data.assignedPswId ? 'scheduled' : 'requested';
        const start = new Date(data.requestedStartAt);
        const endLimit = data.recurrenceEndDate
            ? new Date(data.recurrenceEndDate)
            : new Date(start.getTime() + 90 * 24 * 60 * 60 * 1000);

        const rule = rrulestr(data.recurrenceRuleString, { dtstart: start });
        let occurrences = rule.between(start, endLimit, true);

        // Safety cap: max 90 shifts at once per request
        occurrences = occurrences.slice(0, 90);

        const visitsToCreate = occurrences.map(date => ({
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: date,
            durationMinutes: data.durationMinutes,
            assignedPswId: data.assignedPswId,
            status,
            clientNotes: data.clientNotes,
            tenantId,
            priority: data.priority || 'normal',
            requiredSkills: data.requiredSkills || [],
            recurrenceRuleString: data.recurrenceRuleString,
            recurrenceEndDate: data.recurrenceEndDate ? new Date(data.recurrenceEndDate) : null,
        }));

        await this.prisma.visit.createMany({ data: visitsToCreate });

        const firstVisit = await this.prisma.visit.findFirst({
            where: { clientId: data.clientId, tenantId, requestedStartAt: start },
        });

        await logAudit(this.prisma, actorUserId, 'CREATE_VISIT_SERIES', 'VISIT', firstVisit?.id || 'batch', {
            assignedPswId: data.assignedPswId,
            status,
            count: visitsToCreate.length,
        });

        return firstVisit || { message: 'Series created' };
    }

    /** Update a visit (status, time, duration). */
    async update(id: string, data: { status?: string; requestedStartAt?: string; durationMinutes?: number }) {
        const updateData: any = { ...data };
        return this.prisma.visit.update({
            where: { id },
            data: updateData,
        });
    }

    /** Hard-delete a visit. */
    async delete(id: string) {
        await this.prisma.visit.delete({ where: { id } });
        return { success: true };
    }
}
