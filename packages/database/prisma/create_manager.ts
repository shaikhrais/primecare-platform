import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
    const tenant = await prisma.tenant.findUnique({ where: { slug: 'prime-qa' } });
    if (!tenant) throw new Error('Tenant prime-qa not found');

    const email = 'qa.manager01@primecare.test';
    await prisma.user.upsert({
        where: { email },
        update: {},
        create: {
            email,
            passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', // Qa@12345!
            roles: ['manager', 'admin'],
            tenantId: tenant.id
        }
    });

    console.log(`✅ Manager ${email} created/verified for tenant ${tenant.id}`);
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
