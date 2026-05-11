import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
    console.log('Clearing existing topology...');
    await prisma.sysComponent.deleteMany();
    await prisma.softwareSystem.deleteMany();
    await prisma.systemDomain.deleteMany();

    console.log('Seeding PrimeCare 36-Role Intuitional Matrix...');

    // DOMAIN 1: Carrier & Logistics (Operations)
    const domainOps = await prisma.systemDomain.create({
        data: { name: 'Mobility & Logistics', description: 'Carrier tracking, map routing, and dispatch' }
    });
    const sysCoordinator = await prisma.softwareSystem.create({
        data: { name: 'Coordinator Dispatch Hub', domainId: domainOps.id, description: 'Live tracking & shift allocations' }
    });
    const sysPswApp = await prisma.softwareSystem.create({
        data: { name: 'Caregiver Mobile Gateway', domainId: domainOps.id, description: 'PSW geolocation and clocked visits' }
    });

    // DOMAIN 2: Agency & Franchise Management
    const domainAgency = await prisma.systemDomain.create({
        data: { name: 'Agency Management', description: 'Branch-level coverage, analytics and HR' }
    });
    const sysBranch = await prisma.softwareSystem.create({
        data: { name: 'Branch Master Portal', domainId: domainAgency.id, description: 'Shift coverage and regional analytics' }
    });
    const sysCompliance = await prisma.softwareSystem.create({
        data: { name: 'Payroll & Compliance Monitor', domainId: domainAgency.id, description: 'Overtime and miss tracking' }
    });

    // DOMAIN 3: Finance & Treasury
    const domainFinance = await prisma.systemDomain.create({
        data: { name: 'Finance & Taxation', description: 'Journals, ledgers, and remittances' }
    });
    const sysLedger = await prisma.softwareSystem.create({
        data: { name: 'Double-Entry Ledger', domainId: domainFinance.id, description: 'T-accounts & P&L generation' }
    });
    const sysTax = await prisma.softwareSystem.create({
        data: { name: 'Tax Remittance Hub', domainId: domainFinance.id, description: 'HST/GST calculation pipeline' }
    });

    // DOMAIN 4: Client & Family Relations
    const domainClient = await prisma.systemDomain.create({
        data: { name: 'Client & Family Relations', description: 'Public facing transparency and intake' }
    });
    const sysFamily = await prisma.softwareSystem.create({
        data: { name: 'Family Transparency Portal', domainId: domainClient.id, description: 'Wellness pulses and visit verification' }
    });
    const sysCrm = await prisma.softwareSystem.create({
        data: { name: 'Business Development CRM', domainId: domainClient.id, description: 'Lead tracking and onboarding pipeline' }
    });

    // DOMAIN 5: Technical Governance
    const domainTech = await prisma.systemDomain.create({
        data: { name: 'Technical Governance', description: 'Live monitoring and platform security' }
    });
    const sysScrum = await prisma.softwareSystem.create({
        data: { name: 'Scrum Master Health Center', domainId: domainTech.id, description: 'Technical integrity and drift monitoring' }
    });

    // ==========================================
    // SEED C4 COMPONENTS (Status: implemented/unimplemented)
    // ==========================================
    console.log('Seeding C4 Components...');

    const compDb = await prisma.sysComponent.create({
        data: { name: 'PostgreSQL Database', systemId: sysScrum.id, type: 'database', status: 'implemented', repoPath: 'infrastructure/db' }
    });

    const compWorker = await prisma.sysComponent.create({
        data: { name: 'Worker API', systemId: sysScrum.id, type: 'microservice', status: 'implemented', repoPath: 'apps/worker-api', language: 'typescript' }
    });

    const compGateway = await prisma.sysComponent.create({
        data: { name: 'API Gateway', systemId: sysScrum.id, type: 'gateway', status: 'implemented', repoPath: 'services/api-gateway' }
    });

    const compVerification = await prisma.sysComponent.create({
        data: { name: 'Verification Service', systemId: sysScrum.id, type: 'microservice', status: 'implemented', repoPath: 'apps/verification-service', language: 'typescript' }
    });

    // Add a couple of unimplemented components across systems
    const compAI = await prisma.sysComponent.create({
        data: { name: 'AI Forecast Module', systemId: sysLedger.id, type: 'module', status: 'unimplemented', repoPath: 'apps/ai-forecast', language: 'python' }
    });

    const compSync = await prisma.sysComponent.create({
        data: { name: 'Offline Sync Engine', systemId: sysPswApp.id, type: 'plugin', status: 'unimplemented', repoPath: 'packages/offline-sync', language: 'dart' }
    });

    console.log('Seeding Complete! Dumping topology for AI Memory Sync...');

    const dump = {
        entities: [
            { name: domainOps.name, entityType: 'domain', observations: [domainOps.description!] },
            { name: sysCoordinator.name, entityType: 'system', observations: [sysCoordinator.description!] },
            { name: sysPswApp.name, entityType: 'system', observations: [sysPswApp.description!] },

            { name: domainAgency.name, entityType: 'domain', observations: [domainAgency.description!] },
            { name: sysBranch.name, entityType: 'system', observations: [sysBranch.description!] },
            { name: sysCompliance.name, entityType: 'system', observations: [sysCompliance.description!] },

            { name: domainFinance.name, entityType: 'domain', observations: [domainFinance.description!] },
            { name: sysLedger.name, entityType: 'system', observations: [sysLedger.description!] },
            { name: sysTax.name, entityType: 'system', observations: [sysTax.description!] },

            { name: domainClient.name, entityType: 'domain', observations: [domainClient.description!] },
            { name: sysFamily.name, entityType: 'system', observations: [sysFamily.description!] },
            { name: sysCrm.name, entityType: 'system', observations: [sysCrm.description!] },

            { name: domainTech.name, entityType: 'domain', observations: [domainTech.description!] },
            { name: sysScrum.name, entityType: 'system', observations: [sysScrum.description!] },
        ],
        relations: [
            { from: sysCoordinator.name, to: domainOps.name, relationType: 'belongs_to' },
            { from: sysPswApp.name, to: domainOps.name, relationType: 'belongs_to' },

            { from: sysBranch.name, to: domainAgency.name, relationType: 'belongs_to' },
            { from: sysCompliance.name, to: domainAgency.name, relationType: 'belongs_to' },

            { from: sysLedger.name, to: domainFinance.name, relationType: 'belongs_to' },
            { from: sysTax.name, to: domainFinance.name, relationType: 'belongs_to' },

            { from: sysFamily.name, to: domainClient.name, relationType: 'belongs_to' },
            { from: sysCrm.name, to: domainClient.name, relationType: 'belongs_to' },

            { from: sysScrum.name, to: domainTech.name, relationType: 'belongs_to' },
        ]
    };

    console.log("=== MCP PAYLOAD START ===");
    console.log(JSON.stringify(dump, null, 2));
    console.log("=== MCP PAYLOAD END ===");
}

main()
    .finally(async () => {
        await prisma.$disconnect();
    });
