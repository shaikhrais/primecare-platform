import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function listUsers() {
    try {
        const users = await prisma.user.findMany({
            select: { email: true, roles: true, status: true }
        });
        console.log('--- DATABASE USERS ---');
        users.forEach(u => {
            console.log(`- ${u.email} [${u.roles.join(', ')}] status: ${u.status}`);
        });
        console.log('----------------------');
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await prisma.$disconnect();
    }
}

listUsers();
