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
                clientProfile: { select: { fullName: true, riskLevel: true, carePlan: true } },
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

    async updateRoles(id: string, roles: string[]) {
        return await this.prisma.user.update({
            where: { id },
            data: { roles: roles as any },
        });
    }
}
