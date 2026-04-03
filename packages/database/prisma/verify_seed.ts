import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
    console.log('--- QA SEED VERIFICATION ---');
    const visitCount = await prisma.visit.count();
    const userCount = await prisma.user.count();
    const pswCount = await prisma.pswProfile.count();
    const clientCount = await prisma.clientProfile.count();
    const serviceCount = await prisma.service.count();
    const assignmentCount = await prisma.shiftAssignment.count();
    const checkEventCount = await prisma.visitCheckEvent.count();

    console.log(`Visits: ${visitCount}`);
    console.log(`Users: ${userCount}`);
    console.log(`PSWs: ${pswCount}`);
    console.log(`Clients: ${clientCount}`);
    console.log(`Services: ${serviceCount}`);
    console.log(`Assignments: ${assignmentCount}`);
    console.log(`VisitCheckEvents: ${checkEventCount}`);

    if (visitCount >= 147) {
        console.log('✅ SEED VERIFICATION SUCCESSFUL');
    } else {
        console.warn('⚠️ SEED VERIFICATION INCOMPLETE');
    }
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
