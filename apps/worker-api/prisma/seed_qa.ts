import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Generating 7-Week QA Data...');

    // 1. Setup Tenant
    const tenant = await prisma.tenant.upsert({
        where: { slug: 'prime-qa' },
        update: {},
        create: { name: 'PrimeCare QA Corp', slug: 'prime-qa', status: 'active' }
    });

    // 2. Create Clients (3)
    const clients = [
        { email: 'qa.client01@primecare.test', fullName: 'QA Client 01', address: 'QA-11 Main St', skills: [] },
        { email: 'qa.client02@primecare.test', fullName: 'QA Client 02', address: 'QA-22 King St', skills: ['DEMENTIA_CARE'] },
        { email: 'qa.client03@primecare.test', fullName: 'QA Client 03', address: 'QA-33 James St', skills: ['HOYER_LIFT'] },
    ];

    const clientProfiles = [];
    for (const c of clients) {
        const user = await prisma.user.upsert({
            where: { email: c.email },
            update: {},
            create: {
                email: c.email,
                passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
                roles: ['client'],
                tenantId: tenant.id
            }
        });
        const profile = await prisma.clientProfile.upsert({
            where: { userId: user.id },
            update: {},
            create: {
                userId: user.id,
                fullName: c.fullName,
                addressLine1: c.address,
                tenantId: tenant.id
            }
        });
        clientProfiles.push(profile);
    }

    // 3. Create PSWs (6)
    const pswData = [
        { email: 'qa.psw01@primecare.test', name: 'QA PSW 01', skills: ['PERSONAL_CARE'], avail: [{ d: 1, s: '08:00', e: '16:00' }, { d: 2, s: '08:00', e: '16:00' }, { d: 3, s: '08:00', e: '16:00' }, { d: 4, s: '08:00', e: '16:00' }, { d: 5, s: '08:00', e: '16:00' }] },
        { email: 'qa.psw02@primecare.test', name: 'QA PSW 02', skills: ['DEMENTIA_CARE'], avail: [{ d: 1, s: '14:00', e: '22:00' }, { d: 6, s: '10:00', e: '18:00' }] },
        { email: 'qa.psw03@primecare.test', name: 'QA PSW 03', skills: ['HOYER_LIFT', 'PERSONAL_CARE'], avail: [{ d: 0, s: '08:00', e: '14:00' }, { d: 6, s: '08:00', e: '14:00' }] },
        { email: 'qa.psw04@primecare.test', name: 'QA PSW 04', skills: ['MEAL_PREP'], avail: [{ d: 0, s: '12:00', e: '20:00' }] },
        { email: 'qa.psw05@primecare.test', name: 'QA PSW 05', skills: ['NIGHT_CARE'], avail: [{ d: 1, s: '18:00', e: '23:00' }] },
        { email: 'qa.psw06@primecare.test', name: 'QA PSW 06', skills: ['FLOAT'], avail: [] },
    ];

    const pswProfiles = [];
    for (const p of pswData) {
        const user = await prisma.user.upsert({
            where: { email: p.email },
            update: {},
            create: {
                email: p.email,
                passwordHash: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
                roles: ['psw'],
                tenantId: tenant.id
            }
        });
        const profile = await prisma.pswProfile.upsert({
            where: { userId: user.id },
            update: { skills: p.skills },
            create: {
                userId: user.id,
                fullName: p.name,
                skills: p.skills,
                isApproved: true,
                tenantId: tenant.id
            }
        });
        pswProfiles.push(profile);

        // Add availability
        await prisma.pswAvailability.deleteMany({ where: { pswId: profile.id } });
        for (const a of p.avail) {
            await prisma.pswAvailability.create({
                data: {
                    pswId: profile.id,
                    dayOfWeek: a.d,
                    startTime: a.s,
                    endTime: a.e,
                    tenantId: tenant.id
                }
            });
        }
    }

    // 4. Create Service
    const service = await prisma.service.upsert({
        where: { slug: 'qa-care' },
        update: {},
        create: {
            name: 'QA standard Care',
            slug: 'qa-care',
            baseRateHourly: 40.0,
            tenantId: tenant.id
        }
    });

    // 5. Generate Shifts for 7 Weeks
    const startDate = new Date('2026-03-01T09:00:00Z');
    let totalShifts = 0;

    for (let week = 0; week < 7; week++) {
        for (let day = 0; day < 7; day++) {
            const shiftDate = new Date(startDate.getTime() + (week * 7 + day) * 24 * 60 * 60 * 1000);

            // Create 3 shifts per day (one for each client)
            for (let i = 0; i < 3; i++) {
                const client = clientProfiles[i];
                const status = (week < 2) ? 'completed' : (week < 4 ? 'scheduled' : 'posted');

                const visit = await prisma.visit.create({
                    data: {
                        clientId: client.id,
                        serviceId: service.id,
                        requestedStartAt: shiftDate,
                        durationMinutes: 240,
                        status: status as any,
                        tenantId: tenant.id,
                        assignedPswId: (week < 3) ? pswProfiles[i].id : null,
                        priority: i === 1 ? 'urgent' : 'normal',
                        requiredSkills: clients[i].skills
                    }
                });
                totalShifts++;

                // If completed, add check events and notes
                if (status === 'completed') {
                    await prisma.visitCheckEvent.create({
                        data: {
                            visitId: visit.id,
                            pswId: pswProfiles[i].id,
                            eventType: 'check_in',
                            result: 'success',
                            tenantId: tenant.id,
                            serverTime: shiftDate
                        }
                    });
                    await prisma.visitNote.create({
                        data: {
                            visitId: visit.id,
                            pswId: pswProfiles[i].id,
                            noteText: `QA Week ${week + 1} Daily Note`
                        }
                    });
                }
            }
        }
    }

    console.log(`✅ Seed Complete. Created ${totalShifts} shifts across 7 weeks.`);
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
