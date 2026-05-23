// Governance - Category: service | Purpose: 1. Strategic Layer 2. Infrastructure Layer
import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding Architectural Layers...');

  // 1. Strategic Layer
  const strategic = await prisma.architecturalLayer.upsert({
    where: { name: 'Strategic' },
    update: {
      description: 'The highest abstraction level mapping core business goals, role definitions matrices, and top-level domain outcomes (e.g. Primary Care, Double-Entry Logistics).'
    },
    create: {
      name: 'Strategic',
      description: 'The highest abstraction level mapping core business goals, role definitions matrices, and top-level domain outcomes (e.g. Primary Care, Double-Entry Logistics).',
      orderIndex: 0,
    },
  });

  // 2. Infrastructure Layer
  const infrastructure = await prisma.architecturalLayer.upsert({
    where: { name: 'Infrastructure' },
    update: {
      description: 'The backend structural backbone connecting Data Models, API Endpoints, Edge Workers, and Telemetry Registries.'
    },
    create: {
      name: 'Infrastructure',
      description: 'The backend structural backbone connecting Data Models, API Endpoints, Edge Workers, and Telemetry Registries.',
      orderIndex: 1,
    },
  });

  // 3. Topographical Layer
  const topographical = await prisma.architecturalLayer.upsert({
    where: { name: 'Topographical' },
    update: {
      description: 'The absolute edge of the user experience. Dedicated screen layouts, discrete UI forms, and front-front specific routing mechanisms binding directly to users.'
    },
    create: {
      name: 'Topographical',
      description: 'The absolute edge of the user experience. Dedicated screen layouts, discrete UI forms, and front-front specific routing mechanisms binding directly to users.',
      orderIndex: 2,
    },
  });

  console.log('--- Layers Seeded Succesfully ---');
  console.log(`Strategic: ${strategic.id}`);
  console.log(`Infrastructure: ${infrastructure.id}`);
  console.log(`Topographical: ${topographical.id}`);
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
  });
