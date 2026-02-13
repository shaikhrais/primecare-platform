import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function checkUserHash() {
    try {
        const user = await prisma.user.findUnique({
            where: { email: 'manager.a@primecare.ca' },
            select: { email: true, passwordHash: true }
        });
        console.log('--- USER HASH CHECK ---');
        console.log(`Email: ${user.email}`);
        console.log(`Hash:  ${user.passwordHash}`);
        console.log('------------------------');
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await prisma.$disconnect();
    }
}

checkUserHash();
