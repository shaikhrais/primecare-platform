import { PrismaClient } from '../../../generated/client/edge';

export class DailyEntryService {
    constructor(private prisma: any) { }

    async createEntry(userId: string, tenantId: string, data: any) {
        return await this.prisma.dailyEntry.create({
            data: {
                ...data,
                staffId: userId,
                tenantId: tenantId,
                status: data.status as any,
            },
        });
    }

    async getHistory(tenantId: string, clientId?: string) {
        const where: any = { tenantId };
        if (clientId) where.clientId = clientId;

        return await this.prisma.dailyEntry.findMany({
            where,
            take: 50,
            orderBy: { createdAt: 'desc' },
            include: {
                client: { select: { fullName: true } },
                staff: { select: { email: true } }
            }
        });
    }
}
