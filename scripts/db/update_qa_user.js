const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function updateRoles() {
    const email = 'manager.a@primecare.ca';
    const user = await prisma.user.update({
        where: { email },
        data: {
            roles: ['manager', 'psw']
        }
    });
    console.log(`Updated user ${email} with roles: ${user.roles}`);

    // Also ensure a psw profile exists for this user
    await prisma.pswProfile.upsert({
        where: { userId: user.id },
        update: {},
        create: {
            userId: user.id,
            tenantId: user.tenantId,
            fullName: 'QA Manager PSW',
            isApproved: true
        }
    });
    console.log('Created/Updated PSW Profile for the test account.');
}

updateRoles()
    .catch(e => console.error(e))
    .finally(() => prisma.$disconnect());
