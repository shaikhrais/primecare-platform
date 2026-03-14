import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function getIds() {
    try {
        const client = await prisma.clientProfile.findFirst();
        const service = await prisma.service.findFirst({ where: { isActive: true } });
        const psw = await prisma.pswProfile.findFirst({ where: { isApproved: true } });

        console.log('--- FOUND IDS ---');
        console.log(`CLIENT_ID: ${client?.id}`);
        console.log(`SERVICE_ID: ${service?.id}`);
        console.log(`PSW_ID: ${psw?.id}`);
        console.log('-----------------');
    } catch (err) {
        console.error(err);
    } finally {
        await prisma.$disconnect();
    }
}

getIds();
