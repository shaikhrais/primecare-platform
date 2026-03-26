import { PrismaClient } from './generated/client';

async function fetchDb() {
  const prisma = new PrismaClient();
  try {
    const screens = await prisma.platformScreen.findMany({
        orderBy: { orderIndex: 'asc' },
        select: { name: true, route: true, status: true, role: { select: { name: true } } }
    });
    console.log(JSON.stringify(screens, null, 2));
  } catch (e) {
    console.error('Fetch Failed:', e);
  } finally {
    await prisma.$disconnect();
  }
}

fetchDb();
