import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    console.log('--- DEBUG OFFER CREATION ---');

    // 1. Find a posted visit
    const visit = await prisma.visit.findFirst({
        where: { status: 'posted' }
    });

    if (!visit) {
        console.log('No posted visits found.');
        return;
    }
    console.log('Target Visit:', visit.id);

    // 2. Find a PSW
    const psw = await prisma.pswProfile.findFirst({
        where: { email: 'psw.a@primecare.ca' }
    });

    if (!psw) {
        console.log('PSW not found.');
        return;
    }
    console.log('Target PSW:', psw.id, psw.email);

    // 3. Create Offer
    const assignment = await prisma.shiftAssignment.create({
        data: {
            visitId: visit.id,
            pswId: psw.id,
            status: 'offered',
            tenantId: visit.tenantId
        }
    });

    // 4. Update Visit Status
    await prisma.visit.update({
        where: { id: visit.id },
        data: { status: 'offered' }
    });

    console.log('✅ Offer Created Successfully:', assignment.id);
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
