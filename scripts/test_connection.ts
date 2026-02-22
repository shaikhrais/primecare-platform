import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function test() {
    console.log('Testing Standard Prisma Client Connection...');
    try {
        const count = await prisma.user.count();
        console.log('User Count:', count);
        console.log('✅ Connection Successful');
    } catch (err) {
        console.error('❌ Connection Failed:', err);
    } finally {
        await prisma.$disconnect();
    }
}

test();
