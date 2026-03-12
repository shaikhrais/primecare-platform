import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Starting Open Shift payload generation...');

    // 1. Get ANY first valid user's tenant ID
    const adminUser = await prisma.user.findFirst({
        select: { tenantId: true }
    });

    if (!adminUser) {
        console.error('❌ Could not find ANY user in the database to anchor the shifts to a tenant.');
        process.exit(1);
    }
    const tenantId = adminUser.tenantId;

    // 2. Fetch one Client and one Service to anchor the shifts, or create them if missing
    let client = await prisma.clientProfile.findFirst({ where: { tenantId } });
    if (!client) {
        console.log('... No Client found. Creating Mock Client...');
        
        const mockUser = await prisma.user.upsert({
            where: { email: 'mock.client@example.com' },
            create: {
                tenantId,
                email: 'mock.client@example.com',
                passwordHash: 'dummy'
            },
            update: {}
        });

        client = await prisma.clientProfile.create({
            data: {
                tenantId,
                userId: mockUser.id,
                fullName: 'Mock Seeded Client',
            }
        });
    }

    let service = await prisma.service.findFirst({ where: { tenantId } });
    if (!service) {
        console.log('... No Service found. Creating Mock Service...');
        service = await prisma.service.create({
            data: {
                tenantId,
                name: 'Mock Seeded Service (RN/RPN)',
                slug: 'mock-seeded-service',
                baseRateHourly: 50.00,
            }
        });
    }

    // 3. Generate 50 Shifts
    console.log(`Generating 50 Open Shifts for Client: ${client.fullName} | Service: ${service.name}...`);
    
    let createdCount = 0;
    const now = new Date();

    for (let i = 0; i < 50; i++) {
        // Randomize dates over the next 30 days
        const randomDays = Math.floor(Math.random() * 30);
        const randomHours = Math.floor(Math.random() * 8) + 8; // 8 AM to 4 PM
        
        const shiftStart = new Date(now);
        shiftStart.setDate(now.getDate() + randomDays);
        shiftStart.setHours(randomHours, 0, 0, 0);

        await prisma.visit.create({
            data: {
                tenantId,
                clientId: client.id,
                serviceId: service.id,
                requestedStartAt: shiftStart,
                durationMinutes: 60,
                status: 'requested', // Represents an 'Open Swap' or 'Unassigned' shift
                priority: Math.random() > 0.8 ? 'urgent' : 'normal',
                clientNotes: `Auto-generated Shift Request #${i + 1} for ${client.fullName}`,
            }
        });
        createdCount++;
        if (createdCount % 10 === 0) console.log(`... Inserted ${createdCount}/50 shifts.`);
    }

    console.log(`\n✅ Successfully seeded 50 Open Shift Requests into PrimeCare Platform!`);
}

main()
    .catch((e: any) => {
        console.error('PRISMA VALIDATION ERROR >>>\n', e.message || e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
