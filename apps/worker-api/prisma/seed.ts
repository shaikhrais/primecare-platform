import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding database...');

    // 1. Create Tenants
    const tenantA = await prisma.tenant.upsert({
        where: { slug: 'prime-toronto' },
        update: {},
        create: { name: 'PrimeCare Toronto', slug: 'prime-toronto', status: 'active' }
    });

    const tenantB = await prisma.tenant.upsert({
        where: { slug: 'prime-vancouver' },
        update: {},
        create: { name: 'PrimeCare Vancouver', slug: 'prime-vancouver', status: 'active' }
    });

    // 2. Clear existing data (optional, but good for clean seeds)
    // Be careful with this in shared environments

    // 3. Create Users & Profiles for Tenant A
    const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client'];

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const user = await prisma.user.upsert({
            where: { email },
            update: {},
            create: {
                email,
                passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', // 'admin123'
                roles: [role] as any,
                tenantId: tenantA.id,
                status: 'active'
            }
        });

        if (role === 'client') {
            await prisma.clientProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'John Client A',
                    riskLevel: 'MEDIUM',
                    carePlan: {
                        goals: ['Maintain mobility'],
                        interventions: ['Daily walking assistance']
                    }
                }
            });
        } else if (role === 'psw') {
            await prisma.pswProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'Walker PSW A',
                    isApproved: true
                }
            });
        }
    }

    // 4. Create Cross-Tenant User (for IDOR testing)
    await prisma.user.upsert({
        where: { email: 'client.b@primecare.ca' },
        update: {},
        create: {
            email: 'client.b@primecare.ca',
            passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
            roles: ['client'],
            tenantId: tenantB.id,
            status: 'active'
        }
    });

    // 5. Create basic services
    await prisma.service.upsert({
        where: { slug: 'personal-care' },
        update: {},
        create: {
            name: 'Personal Care',
            slug: 'personal-care',
            baseRateHourly: 35.0,
            tenantId: tenantA.id,
            isActive: true
        }
    });

    console.log('✅ Seeding complete.');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
