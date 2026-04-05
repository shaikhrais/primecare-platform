import { PrismaClient } from '@prisma/client';
import { hashPassword } from '@primecare/shared-utils';;

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
        // 1. Create User
        // R18: Generate a random temporary password hash instead of hardcoded string
        const tempHash = await hashPassword(crypto.randomUUID());
        const user = await this.prisma.user.create({
            data: {
                email: data.email,
                phone: data.phone,
                passwordHash: tempHash,
                roles: ['client'],
                tenantId: data.tenantId,
                status: 'pending'
            },
            // R18: Don't return passwordHash
            select: { id: true, email: true, phone: true, roles: true, status: true, tenantId: true, createdAt: true },
        });

        // 2. Create Profile
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
            // R18: Don't return passwordHash via user relation
            include: {
                user: {
                    select: { id: true, email: true, status: true, phone: true, roles: true }
                }
            }
        });
    }
}
