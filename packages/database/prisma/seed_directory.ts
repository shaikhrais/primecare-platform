// Governance - Category: service | Purpose: Get Tenants SHA-256 legacy hash for 'password123' (auto-upgrades to PBKDF2 on first login via the backend auth interc...
import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding PrimeCare Directory Roles...');

    // Get Tenants
    const tenantHQ = await prisma.tenant.findFirst({ where: { slug: 'primecare-admin' } });
    let tenantA = await prisma.tenant.findFirst({ where: { slug: 'prime-toronto' } });
    if (!tenantA) {
        tenantA = await prisma.tenant.findFirst({ where: { slug: 'prime-hamilton' } });
    }
    
    if (!tenantHQ || !tenantA) {
        throw new Error('Tenants not found. Please run baseline seed.ts first.');
    }

    // SHA-256 legacy hash for 'password123' (auto-upgrades to PBKDF2 on first login via the backend auth interceptor)
    const passwordHash = 'ef92b778bafe771e89245b89ecbc08a44a4e166c066199fa3f01846b4081efb3';

    const directory = [
        // 1. Corporate / Head Office
        { name: 'Founder / CEO', email: 'ceo@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'COO (Operations Head)', email: 'operations@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'CFO (Finance Head)', email: 'finance@primecare.com', roles: 'finance_director', tenantId: tenantHQ.id },
        { name: 'CTO (Tech Head)', email: 'tech@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'Compliance Manager', email: 'compliance@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'Head of Business Development', email: 'growth@primecare.com', roles: 'gm', tenantId: tenantHQ.id },
        { name: 'Head of Marketing', email: 'marketing@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'Training Director', email: 'training@primecare.com', roles: 'admin', tenantId: tenantHQ.id },

        // 2. Business Development Team
        { name: 'Regional Business Development Manager (Ontario)', email: 'bd.ontario@primecare.com', roles: 'gm', tenantId: tenantHQ.id },
        { name: 'Regional Business Development Manager (USA)', email: 'bd.usa@primecare.com', roles: 'gm', tenantId: tenantHQ.id },
        { name: 'Franchise Sales Manager', email: 'franchise@primecare.com', roles: 'manager', tenantId: tenantHQ.id },
        { name: 'Partnership Manager', email: 'partnerships@primecare.com', roles: 'manager', tenantId: tenantHQ.id },
        { name: 'Territory Expansion Manager', email: 'expansion@primecare.com', roles: 'gm', tenantId: tenantHQ.id },

        // 3. Franchise Level (Hamilton -> mapped to tenantA/Toronto mock for DB)
        { name: 'Franchise Owner', email: 'owner@hamilton.primecare.com', roles: 'superuser', tenantId: tenantA.id },
        { name: 'Operations Manager', email: 'ops@hamilton.primecare.com', roles: 'manager', tenantId: tenantA.id },
        { name: 'Scheduler / Coordinator', email: 'schedule@hamilton.primecare.com', roles: 'coordinator', tenantId: tenantA.id },
        { name: 'Billing / Admin', email: 'billing@hamilton.primecare.com', roles: 'admin', tenantId: tenantA.id },
        { name: 'HR / Hiring', email: 'hr@hamilton.primecare.com', roles: 'manager', tenantId: tenantA.id },

        // 4. Clinical Team
        { name: 'RN (Registered Nurse)', email: 'rn1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'RPN', email: 'rpn1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'RMT', email: 'rmt1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'PSW', email: 'psw1@hamilton.primecare.com', roles: 'psw', tenantId: tenantA.id },
        { name: 'Physiotherapist', email: 'physio1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'Chiropractor', email: 'chiro1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'Occupational Therapist', email: 'ot1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },
        { name: 'Speech Pathologist', email: 'slp1@hamilton.primecare.com', roles: 'rn', tenantId: tenantA.id },

        // 5. Support Team
        { name: 'Customer Support', email: 'support@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'Intake Coordinator', email: 'intake@primecare.com', roles: 'coordinator', tenantId: tenantHQ.id },
        { name: 'Quality Assurance', email: 'qa@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
        { name: 'Training Coordinator', email: 'training.support@primecare.com', roles: 'admin', tenantId: tenantHQ.id },

        // 6. Marketing and Local Growth
        { name: 'Local Marketing Manager', email: 'marketing@hamilton.primecare.com', roles: 'manager', tenantId: tenantA.id },
        { name: 'Community Outreach', email: 'outreach@hamilton.primecare.com', roles: 'coordinator', tenantId: tenantA.id },
        { name: 'Territory Sales Manager', email: 'sales@hamilton.primecare.com', roles: 'manager', tenantId: tenantA.id },

        // 7. Client Side
        { name: 'Client', email: 'client1@gmail.com', roles: 'client', tenantId: tenantA.id },
        { name: 'Family Member', email: 'family1@gmail.com', roles: 'client', tenantId: tenantA.id },

        // 8. System / Technical
        { name: 'Scrum Master (Tech Auditor)', email: 'scrum@primecare.com', roles: 'admin', tenantId: tenantHQ.id },
    ];

    let count = 0;
    for (const entry of directory) {
        await prisma.user.upsert({
            where: { email: entry.email },
            update: { passwordHash, roles: entry.roles, status: 'active' },
            create: {
                email: entry.email,
                passwordHash,
                roles: entry.roles,
                tenantId: entry.tenantId,
                status: 'active'
            }
        });
        count++;
    }

    console.log(`✅ Upserted ${count} directory roles successfully!`);
}

main()
    .catch((e) => {
        console.error('❌ Error seeding directory:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
