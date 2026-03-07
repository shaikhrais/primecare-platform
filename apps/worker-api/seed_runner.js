
const { PrismaClient } = require('./generated/client');
const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding database from runner...');

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

    console.log('Tenants created.');

    const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'scrum_master'];
    const passwordHash = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'; // admin123

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const targetTenantId = (role === 'admin' || role === 'scrum_master') ? tenantHQ.id : tenantA.id;

        await prisma.user.upsert({
            where: { email },
            update: { tenantId: targetTenantId, roles: [role], passwordHash },
            create: {
                email,
                passwordHash,
                roles: [role],
                tenantId: targetTenantId,
                status: 'active'
            }
        });
        console.log(`User ${email} created for tenant ${targetTenantId}`);
    }

    console.log('✅ Seeding successful.');
}

main()
    .catch((e) => { console.error(e); process.exit(1); })
    .finally(() => prisma.$disconnect());
