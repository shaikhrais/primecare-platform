// Governance - Category: service | Purpose: Lists audit logs for a tenant with filtering and pagination
import { PrismaClient } from '@primecare/database';
import { Result } from '../utils/Result';

export interface AuditLogFilters {
    actorUserId?: string;
    action?: string;
    resourceType?: string;
    startDate?: string;
    endDate?: string;
    limit?: number;
    offset?: number;
    searchTerm?: string;
}

export class AuditService {
    /**
     * Lists audit logs for a tenant with filtering and pagination
     */
    static async listLogs(prisma: any, tenantId: string, filters: AuditLogFilters = {}): Promise<Result<{
        logs: any[];
        pagination: { total: number; limit: number; offset: number };
    }>> {
        return Result.guard(async () => {
            const {
                actorUserId,
                action,
                resourceType,
                startDate,
                endDate,
                limit = 50,
                offset = 0
            } = filters;

            const where: any = { tenantId };

            if (actorUserId) where.actorUserId = actorUserId;
            if (action) where.action = action;
            if (resourceType) where.resourceType = resourceType;
            
            if (startDate || endDate) {
                where.createdAt = {};
                if (startDate) where.createdAt.gte = new Date(startDate);
                if (endDate) where.createdAt.lte = new Date(endDate);
            }

            if (filters.searchTerm) {
                where.OR = [
                    { action: { contains: filters.searchTerm, mode: 'insensitive' } },
                    { resourceType: { contains: filters.searchTerm, mode: 'insensitive' } },
                    { resourceId: { contains: filters.searchTerm, mode: 'insensitive' } },
                    { metadata: { path: [], array_contains: filters.searchTerm } }, // Basic JSON search
                ];
            }

            const [logs, total] = await Promise.all([
                prisma.auditLog.findMany({
                    where,
                    take: limit,
                    skip: offset,
                    orderBy: { createdAt: 'desc' },
                    include: {
                        actor: {
                            select: {
                                id: true,
                                firstName: true,
                                lastName: true,
                                email: true
                            }
                        }
                    }
                }),
                prisma.auditLog.count({ where })
            ]);

            return {
                logs,
                pagination: {
                    total,
                    limit,
                    offset
                }
            };
        });
    }

    /**
     * Records a new audit log entry
     */
    static async recordLog(prisma: any, data: {
        tenantId: string;
        actorUserId?: string;
        action: string;
        resourceType: string;
        resourceId?: string;
        metadata?: any;
        ipAddress?: string;
        deviceId?: string;
    }): Promise<Result<any>> {
        return Result.guard(async () => {
            return prisma.auditLog.create({
                data: {
                    tenantId: data.tenantId,
                    actorUserId: data.actorUserId,
                    action: data.action,
                    resourceType: data.resourceType,
                    resourceId: data.resourceId,
                    metadata: data.metadata,
                    ipAddress: data.ipAddress,
                    deviceId: data.deviceId
                }
            });
        });
    }
}
