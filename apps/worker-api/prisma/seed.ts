import { PrismaClient, Role } from '../generated/client';

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding database...');

    // 1. Create Tenants
    const tenantA = await prisma.tenant.upsert({
        where: { slug: 'prime-toronto' },
        update: {},
        create: { name: 'PrimeCare Toronto', slug: 'prime-toronto', status: 'active' }
    });

    const tenantHQ = await prisma.tenant.upsert({
        where: { slug: 'primecare-admin' },
        update: {},
        create: { name: 'PrimeCare Admin', slug: 'primecare-admin', status: 'active' }
    });

    const tenantB = await prisma.tenant.upsert({
        where: { slug: 'prime-vancouver' },
        update: {},
        create: { name: 'PrimeCare Vancouver', slug: 'prime-vancouver', status: 'active' }
    });

    // 3. Create Users & Profiles for Tenant A
    const roles: Role[] = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'scrum_master'];

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const targetTenantId = role === 'admin' || role === 'scrum_master' ? tenantHQ.id : tenantA.id;

        const user = await prisma.user.upsert({
            where: { email },
            update: {},
            create: {
                email,
                passwordHash: '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
                roles: [role],
                tenantId: targetTenantId,
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
                    fullName: 'John Client A'
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
        console.error('❌ Seeding error:');
        console.error(e.message || e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
