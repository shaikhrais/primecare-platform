import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';
import { Result } from '../utils/Result';

const prisma = new PrismaClient();

export class ComplianceService {
    /**
     * Aggregates audit logs and associated meta-data for institutional reporting
     */
    static async getAuditReportData(tenantId: string, startDate?: string, endDate?: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const filters: any = { limit: 5000 };
            if (startDate) filters.startDate = startDate;
            if (endDate) filters.endDate = endDate;

            const result = await AuditService.listLogs(tenantId, filters);

            return result.data.logs.map((log: any) => ({
                timestamp: log.createdAt.toISOString(),
                actor: log.actor ? `${log.actor.firstName} ${log.actor.lastName}` : 'System',
                actorEmail: log.actor?.email || 'N/A',
                action: log.action,
                resource: log.resourceType,
                resourceId: log.resourceId || 'N/A',
                details: typeof log.metadata === 'string' ? log.metadata : JSON.stringify(log.metadata)
            }));
        });
    }

    /**
     * Aggregates clinical metrics (vitals) for compliance oversight
     */
    static async getClinicalComplianceData(tenantId: string, startDate?: string, endDate?: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const where: any = { 
                patient: { tenantId } 
            };

            if (startDate || endDate) {
                where.recordedAt = {};
                if (startDate) where.recordedAt.gte = new Date(startDate);
                if (endDate) where.recordedAt.lte = new Date(endDate);
            }

            const vitals = await prisma.vitalSign.findMany({
                where,
                include: {
                    patient: {
                        select: {
                            id: true,
                            fullName: true
                        }
                    }
                },
                orderBy: { recordedAt: 'desc' },
                take: 5000
            });

            return vitals.map(v => ({
                timestamp: v.recordedAt.toISOString(),
                patient: (v.patient as any).fullName,
                patientId: v.patientId,
                metricType: v.type,
                value: v.value,
                unit: v.unit,
                source: v.source
            }));
        });
    }

    /**
     * Aggregates staff provisioning and role activity for HR compliance
     */
    static async getStaffActivityReport(tenantId: string, startDate?: string, endDate?: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const where: any = {
                tenantId,
                action: { in: ['PROVISION_STAFF', 'UPDATE_ROLE', 'REVOKE_ACCESS'] }
            };

            if (startDate || endDate) {
                where.createdAt = {};
                if (startDate) where.createdAt.gte = new Date(startDate);
                if (endDate) where.createdAt.lte = new Date(endDate);
            }

            const logs = await prisma.auditLog.findMany({
                where,
                include: {
                    actor: {
                        select: {
                            id: true,
                            firstName: true,
                            lastName: true
                        }
                    }
                },
                orderBy: { createdAt: 'desc' },
                take: 5000
            });

            return logs.map(log => ({
                timestamp: log.createdAt.toISOString(),
                admin: log.actor ? `${log.actor.firstName} ${log.actor.lastName}` : 'System',
                action: log.action,
                targetStaffId: log.resourceId,
                metadata: typeof log.metadata === 'string' ? log.metadata : JSON.stringify(log.metadata)
            }));
        });
    }
}
