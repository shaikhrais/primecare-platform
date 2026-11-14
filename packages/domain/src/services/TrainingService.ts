// Governance - Category: service | Purpose: TrainingService Centralized business logic for staff training, module management, and compliance assignments. Lists a...
import { PrismaClient } from '@primecare/database';
import { Result } from '../utils/Result';

/**
 * TrainingService
 * Centralized business logic for staff training, module management, and compliance assignments.
 */
export class TrainingService {
    /**
     * Lists all available training modules for a tenant.
     */
    static async listModules(prisma: PrismaClient, tenantId: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            return prisma.trainingModule.findMany({
                where: { tenantId },
                orderBy: { title: 'asc' }
            });
        });
    }

    /**
     * Assigns a training module to a staff member or provider.
     */
    static async assignModule(
        prisma: PrismaClient,
        tenantId: string,
        data: {
            moduleId: string;
            staffId?: string;
            providerId?: string;
            dueDate?: string;
        }
    ): Promise<Result<any>> {
        return Result.guard(async () => {
            // Verify module exists and belongs to tenant
            const module = await prisma.trainingModule.findFirst({
                where: { id: data.moduleId, tenantId }
            });

            if (!module) {
                throw new Error('Training module not found or access denied.');
            }

            return prisma.trainingAssignment.create({
                data: {
                    moduleId: data.moduleId,
                    staffId: data.staffId,
                    providerId: data.providerId,
                    dueDate: data.dueDate ? new Date(data.dueDate) : null,
                    status: 'assigned'
                }
            });
        });
    }

    /**
     * Marks a training assignment as completed.
     */
    static async completeAssignment(prisma: PrismaClient, assignmentId: string): Promise<Result<any>> {
        return Result.guard(async () => {
            return prisma.trainingAssignment.update({
                where: { id: assignmentId },
                data: {
                    status: 'completed',
                    completedAt: new Date()
                }
            });
        });
    }

    /**
     * Aggregates training compliance metrics for the dashboard.
     * Incorporates both module assignments and personnel certifications.
     */
    static async getTrainingComplianceSummary(prisma: PrismaClient, tenantId: string): Promise<Result<any>> {
        return Result.guard(async () => {
            const [assignments, certifications] = await Promise.all([
                prisma.trainingAssignment.findMany({
                    where: { module: { tenantId } },
                    select: { status: true, dueDate: true }
                }),
                prisma.certificationNode.findMany({
                    where: { tenantId },
                    select: { status: true, expiresAt: true }
                })
            ]);

            // Assignment Metrics
            const totalAssignments = assignments.length;
            const completedAssignments = assignments.filter(a => a.status === 'completed').length;
            const overdueAssignments = assignments.filter(a =>
                a.status !== 'completed' && a.dueDate && new Date(a.dueDate) < new Date()
            ).length;

            // Certification Metrics
            const totalCerts = certifications.length;
            const expiredCerts = certifications.filter(c => c.status === 'Expired' || new Date(c.expiresAt) < new Date()).length;
            const expiringCerts = certifications.filter(c => c.status === 'Expiring').length;

            return {
                totalActiveAssignments: totalAssignments,
                completionRate: totalAssignments > 0 ? (completedAssignments / totalAssignments) * 100 : 100,
                overdueCount: overdueAssignments,
                complianceStatus: totalCerts > 0 ? ((totalCerts - expiredCerts) / totalCerts) * 100 : 100,
                expiringCertifications: expiringCerts,
                recentCompletions: completedAssignments
            };
        });
    }

    /**
     * Verifies a certificate against the internal certification registry.
     */
    static async verifyCertificate(
        prisma: PrismaClient, 
        tenantId: string, 
        data: { staffName: string; certName: string }
    ): Promise<Result<any>> {
        return Result.guard(async () => {
            const cert = await prisma.certificationNode.findFirst({
                where: {
                    tenantId,
                    staffName: { contains: data.staffName, mode: 'insensitive' },
                    certName: { contains: data.certName, mode: 'insensitive' }
                }
            });

            if (!cert) {
                return {
                    verified: false,
                    message: `No active certification found for ${data.staffName} matching "${data.certName}".`
                };
            }

            const isExpired = new Date(cert.expiresAt) < new Date();

            return {
                verified: !isExpired,
                status: cert.status,
                expiresAt: cert.expiresAt,
                staffName: cert.staffName,
                certName: cert.certName,
                message: isExpired
                    ? `Certification found but expired on ${cert.expiresAt.toDateString()}.`
                    : `Valid certification confirmed for ${cert.staffName}.`
            };
        });
    }

    /**
     * Fetches the most recent training activities (completions and certifications).
     */
    static async getRecentActivity(prisma: PrismaClient, tenantId: string, limit: number = 10): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const [assignments, certifications] = await Promise.all([
                prisma.trainingAssignment.findMany({
                    where: {
                        module: { tenantId },
                        status: 'completed'
                    },
                    include: { module: true },
                    orderBy: { completedAt: 'desc' },
                    take: limit
                }),
                prisma.certificationNode.findMany({
                    where: { tenantId },
                    orderBy: { createdAt: 'desc' },
                    take: limit
                })
            ]);

            const activities = [
                ...assignments.map(a => ({
                    id: a.id,
                    type: 'assignment',
                    title: a.module.title,
                    subtitle: `Completed by ${a.staffId || a.providerId || 'Staff'}`,
                    date: a.completedAt || a.assignedAt,
                    status: 'Completed'
                })),
                ...certifications.map(c => ({
                    id: c.id,
                    type: 'certification',
                    title: c.certName,
                    subtitle: `Issued to ${c.staffName}`,
                    date: c.createdAt,
                    status: c.status
                }))
            ];

            return activities
                .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
                .slice(0, limit);
        });
    }

    /**
     * Lists all curricula for a tenant.
     */
    static async getCurricula(prisma: PrismaClient, tenantId: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            return prisma.curriculumNode.findMany({
                where: { tenantId },
                orderBy: { programName: 'asc' }
            });
        });
    }

    /**
     * Lists all certifications for a tenant.
     */
    static async getCertifications(prisma: PrismaClient, tenantId: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            return prisma.certificationNode.findMany({
                where: { tenantId },
                orderBy: { expiresAt: 'asc' }
            });
        });
    }


    /**
     * Creates a new training module.
     */
    static async createModule(
        prisma: PrismaClient, 
        tenantId: string, 
        data: { title: string; description?: string; category?: string; videoUrl?: string }
    ): Promise<Result<any>> {
        return Result.guard(async () => {
            return prisma.trainingModule.create({
                data: {
                    ...data,
                    tenantId
                }
            });
        });
    }

    /**
     * Updates an existing training module.
     */
    static async updateModule(
        prisma: PrismaClient, 
        tenantId: string, 
        id: string, 
        data: { title?: string; description?: string; category?: string; videoUrl?: string }
    ): Promise<Result<any>> {
        return Result.guard(async () => {
            // Verify ownership
            const existing = await prisma.trainingModule.findFirst({
                where: { id, tenantId }
            });

            if (!existing) {
                throw new Error('Module not found or access denied.');
            }

            return prisma.trainingModule.update({
                where: { id },
                data
            });
        });
    }
}
