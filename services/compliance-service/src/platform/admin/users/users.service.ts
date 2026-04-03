export class AdminUserService {
    constructor(private prisma: any) { }

    async listUsers() {
        return await this.prisma.user.findMany({
            select: {
                id: true,
                email: true,
                roles: true,
                status: true,
                createdAt: true,
                clientProfile: { select: { fullName: true } },
                providerProfile: { select: { fullName: true, isApproved: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }

    async verifyUser(id: string) {
        const user = await this.prisma.user.update({
            where: { id },
            data: { status: 'verified' },
            include: { providerProfile: true },
        });

        // Feature 25: Universal Onboarding Assignment
        if (user.roles?.includes('psw') && user.providerProfile) {
            await this.prisma.providerProfile.update({
                where: { id: user.providerProfile.id },
                data: { isApproved: true }
            });

            const defaultModules = ['HIPAA & PHI Compliance', 'Infection Control', 'Emergency Procedures', 'Safe Patient Handling', 'Documentation Standards'];
            for (const title of defaultModules) {
                let moduleRecord = await this.prisma.trainingModule.findFirst({
                    where: { title, tenantId: user.tenantId || 'system' }
                });
                
                if (!moduleRecord) {
                    moduleRecord = await this.prisma.trainingModule.create({
                        data: {
                            title,
                            durationMinutes: 45,
                            tenantId: user.tenantId || 'system'
                        }
                    });
                }
                
                await this.prisma.trainingAssignment.create({
                    data: {
                        providerId: user.providerProfile.id,
                        moduleId: moduleRecord.id,
                        status: 'assigned',
                        dueDate: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000)
                    }
                });
            }
            console.log(`[UsersService] Feature 25 Fired: Seeded 5 Training Modules for newly verified PSW ${user.providerProfile.id}`);
        }

        return {
            id: user.id, email: user.email, roles: user.roles, status: user.status, createdAt: user.createdAt
        };
    }

    async createUser(data: any) {
        return await this.prisma.user.create({
            data: {
                email: data.email,
                roles: data.roles || ['staff'],
                status: data.status || 'active',
                tenantId: data.tenantId || 'system',
                providerProfile: data.roles.includes('psw') ? {
                    create: {
                        fullName: data.fullName,
                        tenantId: data.tenantId || 'system'
                    }
                } : undefined,
                clientProfile: data.roles.includes('client') ? {
                    create: {
                        fullName: data.fullName,
                        tenantId: data.tenantId || 'system'
                    }
                } : undefined
            },
            // R16: Don't return passwordHash
            select: { id: true, email: true, roles: true, status: true, createdAt: true },
        });
    }

    async updateRoles(id: string, roles: string[]) {
        return await this.prisma.user.update({
            where: { id },
            data: { roles: roles as any },
            // R16: Don't return passwordHash
            select: { id: true, email: true, roles: true, status: true, createdAt: true },
        });
    }
}
