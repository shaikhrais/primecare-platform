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
                pswProfile: { select: { fullName: true, isApproved: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }

    async verifyUser(id: string) {
        return await this.prisma.user.update({
            where: { id },
            data: { status: 'verified' },
        });
    }

    async createUser(data: any) {
        return await this.prisma.user.create({
            data: {
                email: data.email,
                roles: data.roles || ['staff'],
                status: data.status || 'active',
                tenantId: data.tenantId || 'system',
                // We would typically create a profile here too
                pswProfile: data.roles.includes('psw') ? {
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
            }
        });
    }

    async updateRoles(id: string, roles: string[]) {
        return await this.prisma.user.update({
            where: { id },
            data: { roles: roles as any },
        });
    }
}
