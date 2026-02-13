import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client'];
const correctHash = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'; // SHA-256 of admin123

async function fixHashes() {
    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        console.log(`Updating hash for ${email}...`);
        try {
            const user = await prisma.user.update({
                where: { email },
                data: { passwordHash: correctHash }
            });
            console.log(`SUCCESS: ${email} updated.`);
        } catch (err) {
            console.error(`FAILED: ${email} - ${err.message}`);
        }
    }
    await prisma.$disconnect();
}

fixHashes();
