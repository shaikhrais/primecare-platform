
const { PrismaClient } = require('./generated/client');
const prisma = new PrismaClient();

async function main() {
    const user = await prisma.user.findUnique({
        where: { email: 'admin.a@primecare.ca' },
        include: { tenant: true }
    });
    console.log('User Found:', JSON.stringify(user, null, 2));
}

main().catch(console.error).finally(() => prisma.$disconnect());
