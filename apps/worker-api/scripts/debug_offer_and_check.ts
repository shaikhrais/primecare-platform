import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    console.log('--- DEBUG OFFER AND CHECK ---');
    console.log('DATABASE_URL starts with:', process.env.DATABASE_URL?.substring(0, 20));

    // 1. Find a posted visit
    const visit = await prisma.visit.findFirst({
        where: { status: 'posted' }
    });

    if (!visit) {
        console.log('No posted visits found.');
    } else {
        console.log('Target Visit:', visit.id);

        // 2. Find a PSW
        const psw = await prisma.pswProfile.findFirst({
            where: { email: { contains: 'qa.psw' } } // Use a seeded psw
        });

        if (!psw) {
            console.log('PSW not found.');
        } else {
            console.log('Target PSW:', psw.id, psw.fullName);

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
    }

    // 5. Final check
    const counts = await prisma.visit.groupBy({
        by: ['status'],
        _count: { id: true }
    });
    console.log('Final Visit Counts:', JSON.stringify(counts, null, 2));

    const totalAssignments = await prisma.shiftAssignment.count();
    console.log('Total Assignments after creation:', totalAssignments);
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
