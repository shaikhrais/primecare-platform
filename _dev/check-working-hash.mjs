import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function checkWorkingHash() {
    try {
        const user = await prisma.user.findUnique({
            where: { email: 'manager.test@primecare.ca' },
            select: { email: true, passwordHash: true }
        });
        console.log('--- WORKING USER HASH ---');
        console.log(`Email: ${user.email}`);
        console.log(`Hash:  ${user.passwordHash}`);
        console.log(`Len:   ${user.passwordHash.length}`);
        console.log('--------------------------');
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await prisma.$disconnect();
    }
}

checkWorkingHash();
