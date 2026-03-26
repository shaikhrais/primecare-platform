import { PrismaClient } from './generated/client';

async function checkScreens() {
    const prisma = new PrismaClient();
    try {
        const screens = await prisma.platformScreen.findMany({
            include: { role: true }
        });
        console.log(JSON.stringify(screens, null, 2));
    } catch (e) {
        console.error('Error fetching screens:', e);
    } finally {
        await prisma.$disconnect();
    }
}
checkScreens();
