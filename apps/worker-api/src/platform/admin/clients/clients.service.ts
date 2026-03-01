import { PrismaClient } from '@prisma/client';

export class AdminClientService {
    constructor(private prisma: PrismaClient) { }

    async listClients() {
        return this.prisma.clientProfile.findMany({
            include: {
                user: {
                    select: {
                        email: true,
                        status: true
                    }
                }
            }
        });
    }

    async createClient(data: {
        email: string;
        fullName: string;
        phone?: string;
        address: string;
        emergencyContact?: string;
        medicalNotes?: string;
        tenantId: string;
    }) {
        / 1. Create User
        const user = await this.prisma.user.create({
            data: {
                email: data.email,
                phone: data.phone,
                passwordHash: 'temporary_hash_change_me', / Should be handled by invite flow
                roles: ['client'],
                tenantId: data.tenantId,
                status: 'pending'
            }
        });

        / 2. Create Profile
        const profile = await this.prisma.clientProfile.create({
            data: {
                userId: user.id,
                fullName: data.fullName,
                addressLine1: data.address,
                emergencyPhone: data.emergencyContact,
                preferences: data.medicalNotes ? { medicalNotes: data.medicalNotes } : {},
                tenantId: data.tenantId
            }
        });

        return { ...profile, user };
    }

    async getClient(id: string) {
        return this.prisma.clientProfile.findUnique({
            where: { id },
            include: { user: true }
        });
    }
}
