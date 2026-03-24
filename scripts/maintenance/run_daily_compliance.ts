import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function runComplianceJob() {
    console.log('🚀 Starting Daily Compliance Job...');
    const now = new Date();
    const threshold = new Date(now.getTime() - 30 * 60 * 1000); // 30 minutes ago

    // 1. Find Missed Shifts (Scheduled but no check-in)
    const missedShifts = await prisma.visit.findMany({
        where: {
            status: 'scheduled',
            requestedStartAt: { lt: threshold },
            checkEvents: {
                none: { eventType: 'check_in' }
            }
        }
    });

    console.log(`🔍 Found ${missedShifts.length} potentially missed shifts.`);

    for (const shift of missedShifts) {
        await prisma.$transaction([
            prisma.visit.update({
                where: { id: shift.id },
                data: { status: 'no_show' }
            }),
            prisma.auditLog.create({
                data: {
                    action: 'COMPLIANCE_AUTO_MISSED',
                    resourceType: 'VISIT',
                    resourceId: shift.id,
                    tenantId: shift.tenantId,
                    metadataJson: { originalStatus: 'scheduled', reason: 'No check-in after 30 mins' }
                }
            })
        ]);
        console.log(`✅ Marked ${shift.id} as no_show.`);
    }

    // 2. Identify Late Shifts (Check-in exists but late)
    // (Lateness is usually calculated on the fly in the home, but we can log it)
    const lateThreshold = 5 * 60 * 1000; // 5 minutes
    const visitsWithCheckIn = await prisma.visit.findMany({
        where: {
            status: { in: ['in_progress', 'completed'] },
            requestedStartAt: { lt: now }
        },
        include: {
            checkEvents: {
                where: { eventType: 'check_in' },
                orderBy: { serverTime: 'asc' },
                take: 1
            }
        }
    });

    let lateCount = 0;
    for (const visit of visitsWithCheckIn) {
        const checkIn = visit.checkEvents[0];
        if (checkIn && checkIn.serverTime) {
            const delay = checkIn.serverTime.getTime() - visit.requestedStartAt.getTime();
            if (delay > lateThreshold) {
                lateCount++;
                // We don't change status to 'late' (not in enum), but we verify it's flagged in logic
            }
        }
    }

    console.log(`📊 Compliance Summary: ${missedShifts.length} Missed, ${lateCount} Late.`);
    console.log('🏁 Compliance Job Finished.');
}

runComplianceJob()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
