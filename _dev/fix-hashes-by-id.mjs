import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function fixTestUsers() {
    try {
        const users = await prisma.user.findMany({
            where: {
                email: {
                    contains: '@primecare.ca'
                }
            }
        });

        console.log(`Found ${users.length} matching users.`);

        // The correct hash from a working registration (manager.test@primecare.ca)
        const correctHash = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9';

        for (const u of users) {
            console.log(`Updating ${u.email} (ID: ${u.id})...`);
            await prisma.user.update({
                where: { id: u.id },
                data: {
                    passwordHash: correctHash,
                    status: 'active'
                }
            });
            console.log(`  v Done.`);
        }
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await prisma.$disconnect();
    }
}

fixTestUsers();
