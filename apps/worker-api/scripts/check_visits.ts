import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    console.log('--- CHECK VISITS STATUS ---');

    const counts = await prisma.visit.groupBy({
        by: ['status'],
        _count: {
            id: true
        }
    });
    console.log('Visit Counts by Status:', JSON.stringify(counts, null, 2));

    const assignments = await prisma.shiftAssignment.count();
    console.log('Total Assignments:', assignments);

    const sampleAssignment = await prisma.shiftAssignment.findFirst({
        include: { visit: true, psw: true }
    });
    console.log('Sample Assignment:', JSON.stringify(sampleAssignment, null, 2));
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
