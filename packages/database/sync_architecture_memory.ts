import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
    console.log('Seeding PrimeCare Enterprise Entities...');

    // 1. Domains
    const domainClinical = await prisma.systemDomain.create({
        data: { name: 'Clinical Core', description: 'Core clinical systems and EHR features' }
    });
    
    // 2. Systems
    const sysVerification = await prisma.softwareSystem.create({
        data: { 
            name: 'Verification Service', 
            domainId: domainClinical.id,
            description: 'Cloudflare edge worker governing architectural metadata'
        }
    });

    const sysFlutter = await prisma.softwareSystem.create({
        data: {
            name: 'PrimeCare Admin UI',
            domainId: domainClinical.id,
            description: 'The primary dashboard consumed by CTOs and Providers'
        }
    });

    // 3. Components
    const compEdgeApi = await prisma.sysComponent.create({
        data: {
            name: 'Verification Edge APIs',
            systemId: sysVerification.id,
            type: 'service',
            language: 'typescript'
        }
    });

    const compPlannerClient = await prisma.sysComponent.create({
        data: {
            name: 'Architecture Planning Provider',
            systemId: sysFlutter.id,
            type: 'library',
            language: 'dart'
        }
    });

    // 4. API Contracts
    await prisma.apiContract.create({
        data: {
            name: 'GET /v1/verifications/purpose-report',
            type: 'openapi',
            providerId: compEdgeApi.id,
            consumerId: compPlannerClient.id,
            description: 'Edge endpoint that serves architectural mismatches to UI.'
        }
    });

    // 5. Data Resources
    await prisma.dataResource.create({
        data: {
            name: 'PrimeCare PostgreSQL DB',
            componentId: compEdgeApi.id,
            type: 'postgres',
            description: 'Primary relational datastore for governance tables.'
        }
    });

    console.log('Seeding Complete! Dumping topology for AI Memory Sync...');

    // Now format and dump as MCP-friendly JSON
    const dump = {
        entities: [
            { name: domainClinical.name, entityType: 'domain', observations: [domainClinical.description!] },
            { name: sysVerification.name, entityType: 'system', observations: [sysVerification.description!] },
            { name: sysFlutter.name, entityType: 'system', observations: [sysFlutter.description!] },
            { name: compEdgeApi.name, entityType: 'component', observations: ['Language: typescript', 'Type: service'] },
            { name: compPlannerClient.name, entityType: 'component', observations: ['Language: dart', 'Type: library'] },
            { name: 'PrimeCare PostgreSQL DB', entityType: 'resource', observations: ['Type: postgres'] },
            { name: 'GET /v1/verifications/purpose-report', entityType: 'api', observations: ['Type: openapi'] },
        ],
        relations: [
            { from: sysVerification.name, to: domainClinical.name, relationType: 'belongs_to' },
            { from: sysFlutter.name, to: domainClinical.name, relationType: 'belongs_to' },
            { from: compEdgeApi.name, to: sysVerification.name, relationType: 'part_of' },
            { from: compPlannerClient.name, to: sysFlutter.name, relationType: 'part_of' },
            { from: compPlannerClient.name, to: 'GET /v1/verifications/purpose-report', relationType: 'consumes' },
            { from: compEdgeApi.name, to: 'GET /v1/verifications/purpose-report', relationType: 'provides' },
            { from: compEdgeApi.name, to: 'PrimeCare PostgreSQL DB', relationType: 'uses_data' }
        ]
    };

    console.log("=== MCP PAYLOAD START ===");
    console.log(JSON.stringify(dump, null, 2));
    console.log("=== MCP PAYLOAD END ===");
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
