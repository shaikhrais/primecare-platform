import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function syncHashes() {
    try {
        const working = await prisma.user.findUnique({
            where: { email: 'manager.test@primecare.ca' },
            select: { passwordHash: true }
        });

        if (!working) {
            console.error('Working user manager.test@primecare.ca not found');
            return;
        }

        const hash = working.passwordHash;
        console.log(`Syncing hash: ${hash}`);

        const others = [
            'admin.a@primecare.ca',
            'manager.a@primecare.ca',
            'staff.a@primecare.ca',
            'psw.a@primecare.ca',
            'client.a@primecare.ca',
            'rn.a@primecare.ca'
        ];

        for (const email of others) {
            try {
                await prisma.user.update({
                    where: { email },
                    data: { passwordHash: hash, status: 'active' }
                });
                console.log(`SUCCESS: Updated ${email}`);
            } catch (e) {
                console.error(`FAILED: ${email} - ${e.message}`);
            }
        }
    } catch (err) {
        console.error('Overall Error:', err);
    } finally {
        await prisma.$disconnect();
    }
}

syncHashes();
