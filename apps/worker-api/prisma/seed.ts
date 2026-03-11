import { PrismaClient } from '../generated/client';
import { FinancialService } from '../src/_shared/services/financial.service';


const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding database...');
    const financialService = new FinancialService(prisma as any);

    // 1. Create Tenants
    const tenantA = await prisma.tenant.upsert({
        where: { slug: 'prime-toronto' },
        update: {},
        create: { name: 'PrimeCare Toronto', slug: 'prime-toronto', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' }
    });

    const tenantHQ = await prisma.tenant.upsert({
        where: { slug: 'primecare-admin' },
        update: {},
        create: { name: 'PrimeCare Admin', slug: 'primecare-admin', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' }
    });

    const tenantB = await prisma.tenant.upsert({
        where: { slug: 'prime-vancouver' },
        update: {},
        create: { name: 'PrimeCare Vancouver', slug: 'prime-vancouver', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' }
    });

    // 2. Initialize Chart of Accounts for Tenant A
    await financialService.initializeChartOfAccounts(tenantA.id);

    const dbAccounts = await prisma.chartOfAccount.findMany({ where: { tenantId: tenantA.id } });
    const acctMap: Record<string, string> = {};
    for (const a of dbAccounts) {
        acctMap[a.code] = a.id;
    }

    // 3. Create Users & Profiles
    const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'scrum_master', 'finance_director'];

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const targetTenantId = ['admin', 'scrum_master', 'finance_director'].includes(role) ? tenantHQ.id : tenantA.id;

        const user = await prisma.user.upsert({
            where: { email },
            update: {},
            create: {
                email,
                passwordHash: '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
                roles: role,
                tenantId: targetTenantId,
                status: 'active'
            }
        });

        if (role === 'client') {
            await prisma.clientProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'John Client A'
                }
            });
        } else if (role === 'psw') {
            await prisma.pswProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'Walker PSW A',
                    languages: '',
                    serviceAreas: '',
                    skills: ''
                }
            });
        }
    }

    // 4. Create sample financial data for Tenant A
    console.log('📊 Creating financial transactions...');

    const tx1 = await prisma.financialTransaction.create({
        data: {
            tenantId: tenantA.id,
            type: 'INVOICE',
            amount: 1130.00,
            currency: 'CAD',
            status: 'posted'
        }
    });

    await prisma.journalEntry.createMany({
        data: [
            { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['1100'], debit: 1130.00, currency: 'CAD' }, // AR
            { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['4000'], paidOutAmount: 1000.00, currency: 'CAD' }, // Revenue
            { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['2100'], paidOutAmount: 130.00, currency: 'CAD' },  // Tax
        ]
    });

    const tx2 = await prisma.financialTransaction.create({
        data: {
            tenantId: tenantA.id,
            type: 'EXPENSE',
            amount: 500.00,
            currency: 'CAD',
            status: 'posted'
        }
    });

    await prisma.journalEntry.createMany({
        data: [
            { tenantId: tenantA.id, transactionId: tx2.id, accountId: acctMap['5200'], debit: 500.00, currency: 'CAD' }, // Rent
            { tenantId: tenantA.id, transactionId: tx2.id, accountId: acctMap['1000'], paidOutAmount: 500.00, currency: 'CAD' }, // Cash
        ]
    });

    // 5. Create an unreconciled Bank Transaction for Banner Testing
    await prisma.bankTransaction.create({
        data: {
            tenantId: tenantA.id,
            amount: 1130.00,
            currency: 'CAD',
            description: 'DEP: INVOICE #1001',
            bankDate: new Date(),
            status: 'unreconciled',
            externalRef: 'BANK_TX_001'
        }
    });

    // 6. Create basic services
    await prisma.service.upsert({
        where: { slug: 'personal-care' },
        update: {},
        create: {
            name: 'Personal Care',
            slug: 'personal-care',
            baseRateHourly: 35.0,
            tenantId: tenantA.id,
            isActive: true
        }
    });

    // 7. Inject Phase 15-18 Advanced Domain Entities
    console.log('🧬 Seeding complex domain domains (Telehealth, EVV, Care Plans)...');

    // Telehealth Session
    await prisma.telehealthSession.create({
        data: {
            tenantId: tenantA.id,
            patientId: await getClientId(),
            providerId: await getRnUserId(),
            startTime: new Date(Date.now() + 86400000), // tomorrow
            endTime: new Date(Date.now() + 90000000),
            status: 'scheduled',
            meetingLink: 'https://telehealth.primecare.ca/room/c5b2a-test-991'
        }
    });

    // EVV Exception Record
    await prisma.eVVRecord.create({
        data: {
            visitId: await getVisitId(),
            pswId: await getPswId(),
            checkType: 'check_in',
            verificationMethod: 'gps',
            status: 'exception',
            rawData: JSON.stringify({ accuracy_m: 852.1, computed_distance: 955.0 }), // Way outside geofence
            tenantId: tenantA.id
        }
    });

    // Advanced Care Plan (RN Authoring)
    await prisma.carePlan.create({
        data: {
            clientId: await getClientId(),
            tenantId: tenantA.id,
            authorId: await getRnId(),
            diagnoses: 'Type II Diabetes (E11.9), Mild Cognitive Impairment (G31.84)',
            clinicalGoals: JSON.stringify([{ id: 1, text: 'Maintain fasting glucose < 7.0 mmol/L', status: 'active' }]),
            interventions: JSON.stringify([{ type: 'medication_assist', frequency: 'daily' }]),
            status: 'active',
            reviewDate: new Date(Date.now() + 30 * 86400000)
        }
    });

    // Client Medical Summary (Clinical Record FHIR)
    await prisma.clinicalRecord.create({
        data: {
            clientId: await getClientId(),
            tenantId: tenantA.id,
            type: 'AllergyIntolerance',
            data: JSON.stringify({
                resourceType: "AllergyIntolerance",
                clinicalStatus: { coding: [{ code: "active" }] },
                code: { text: "Penicillin" },
                reaction: [{ manifestation: [{ text: "Hives" }] }]
            })
        }
    });

    // Coordinator Waitlist Entry
    const firstService = await prisma.service.findFirst({ where: { tenantId: tenantA.id } });
    if (firstService) {
        await prisma.waitlistEntry.create({
            data: {
                clientId: await getClientId(),
                tenantId: tenantA.id,
                serviceId: firstService.id,
                priority: 85,
                status: 'active',
                requestedStartAt: new Date(Date.now() + 7 * 86400000),
                notes: 'Requires Mandarin speaking PSW. Urgent post-op care needed.'
            }
        });
    }


    // 8. Injecting Logistics Data (Visits, Shift Assignments, and Waitlist Heatmap Data)
    console.log('🗓 Seeding global logistics arrays...');
    const service1 = await prisma.service.findFirst({ where: { slug: 'personal-care' } }) || { id: 'srv-1', tenantId: tenantA.id };
    
    // Create multiple upcoming and past Visits
    const baseDate = new Date();
    const visitsToCreate = [
        { clientId: await getClientId(), assignedPswId: await getPswId(), serviceId: service1.id, tenantId: tenantA.id, status: 'completed', durationMinutes: 120, requestedStartAt: new Date(baseDate.getTime() - 86400000) },
        { clientId: await getClientId(), assignedPswId: await getPswId(), serviceId: service1.id, tenantId: tenantA.id, status: 'in_progress', durationMinutes: 240, requestedStartAt: baseDate },
        { clientId: await getClientId(), assignedPswId: null, serviceId: service1.id, tenantId: tenantA.id, status: 'requested', priority: 'high', crisisMode: true, durationMinutes: 60, requestedStartAt: new Date(baseDate.getTime() + 7200000) },
        { clientId: await getClientId(), assignedPswId: null, serviceId: service1.id, tenantId: tenantA.id, status: 'requested', durationMinutes: 120, requestedStartAt: new Date(baseDate.getTime() + 86400000) },
    ];

    for (const vData of visitsToCreate) {
        const v = await prisma.visit.create({
            data: { ...vData, requiredSkills: 'Dementia Care, Hoyer Lift' }
        });

        // If it's requested, create shift assignments for the auction house board
        if (v.status === 'requested') {
            await prisma.shiftAssignment.createMany({
                data: [
                    { visitId: v.id, pswId: await getPswId(), tenantId: tenantA.id, status: 'offered', score: 0.95 },
                    { visitId: v.id, pswId: await getPswId(), tenantId: tenantA.id, status: 'rejected', score: 0.82 }
                ]
            });
        }
    }

    // 9. Seeding Platform Audit Logs
    console.log('🛡 Seeding Global Security & Audit Timeline...');
    const hqAdmin = await prisma.user.findFirst({ where: { roles: 'admin' } });
    await prisma.auditLog.createMany({
        data: [
            { tenantId: tenantHQ.id, actorUserId: hqAdmin?.id, action: 'SYSTEM_HARDENING_PASSED', resourceType: 'Platform', metadataString: '{"sweep": "Auth JWT Rotation"}', ipAddress: '192.168.1.10' },
            { tenantId: tenantA.id, actorUserId: await getRnId(), action: 'CARE_PLAN_SIGNED', resourceType: 'CarePlan', ipAddress: '10.0.0.45' },
            { tenantId: tenantA.id, actorUserId: await getPswId(), action: 'VISIT_CLOCK_IN', resourceType: 'VisitCheckEvent', ipAddress: '172.68.90.10' },
            { tenantId: tenantA.id, actorUserId: hqAdmin?.id, action: 'FIREWALL_RULE_UPDATED', resourceType: 'Network', metadataString: '{"policy": "Block Russian IPs"}', ipAddress: '192.168.1.10' },
            { tenantId: tenantHQ.id, actorUserId: null, action: 'DATABASE_BACKUP_COMPLETED', resourceType: 'Infrastructure', ipAddress: '127.0.0.1' }
        ]
    });

    console.log('✅ Seeding complete.');
}

async function getClientId() {
    const p = await prisma.clientProfile.findFirst();
    return p ? p.id : '';
}
async function getPswId() {
    const p = await prisma.pswProfile.findFirst();
    return p ? p.id : '';
}
async function getRnId() {
    const u = await prisma.user.findFirst({ where: { roles: 'rn' } });
    return u ? u.id : '';
}
async function getRnUserId() {
    const u = await prisma.user.findFirst({ where: { roles: 'rn' } });
    return u ? u.id : '';
}
async function getVisitId() {
    let v = await prisma.visit.findFirst();
    if (!v) {
        const client = await getClientId();
        const psw = await getPswId();
        const service = await prisma.service.findFirst();
        v = await prisma.visit.create({
            data: {
                clientId: client,
                assignedPswId: psw,
                serviceId: service?.id || '',
                tenantId: service?.tenantId || '',
                requestedStartAt: new Date(),
                durationMinutes: 60,
                requiredSkills: ''
            }
        });
    }
    return v.id;
}

main()
    .catch((e) => {
        console.error('❌ Seeding error:');
        console.error(e.message || e);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
