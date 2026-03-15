
const { PrismaClient } = require('./generated/client');
const prisma = new PrismaClient();

async function main() {
    const email = 'admin.a@primecare.ca';
    const hash = '240be518fabd2724ddb6f04eeb1da5967448d7e831c8c08c8fa822809f74c720a9';

    console.log(`Updating ${email} password hash...`);
    const user = await prisma.user.update({
        where: { email },
        data: { passwordHash: hash }
    });
    console.log(`✅ Updated ${user.email} successfully.`);
}

main()
    .catch(e => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
