// Governance - Category: service | Purpose: 1. IoTEvent
import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Running Phase 10 Seeder...');

  const tenant = await prisma.tenant.findFirst();
  const user = await prisma.user.findFirst();

  if (!tenant || !user) {
    console.error('No tenant or user found in DB. Please run main seeder first.');
    return;
  }

  // 1. IoTEvent
  await prisma.ioTEvent.createMany({
    data: [
      {
        deviceId: 'smartpill_dispenser_1',
        deviceType: 'smartpill',
        payload: JSON.stringify({ event: 'dispensed', time: new Date() }),
        status: 'processed',
        tenantId: tenant.id,
        userId: user.id,
      },
      {
        deviceId: 'yale_lock_1',
        deviceType: 'smartlock',
        payload: JSON.stringify({ action: 'temp_key_generated', validity: '1h' }),
        status: 'processed',
        tenantId: tenant.id,
      },
      {
        deviceId: 'ble_cuff_v2',
        deviceType: 'blood_pressure',
        payload: JSON.stringify({ sys: 120, dia: 80, hr: 72 }),
        status: 'processed',
        tenantId: tenant.id,
        userId: user.id
      }
    ]
  });

  // 2. AppNotification
  await prisma.appNotification.createMany({
    data: [
      {
        title: 'New Shift Available',
        message: 'A priority shift is available in your area.',
        type: 'info',
        tenantId: tenant.id,
        userId: user.id
      },
      {
        title: 'Document Expirations',
        message: 'Your CPR certification expires in 30 days.',
        type: 'warning',
        tenantId: tenant.id,
        userId: user.id
      }
    ]
  });

  // 3. GamificationProfile
  await prisma.gamificationProfile.upsert({
    where: { userId: user.id },
    update: {},
    create: {
      userId: user.id,
      careCoins: 1250,
      currentTier: 'Silver',
      lifetimePoints: 4500,
      tenantId: tenant.id,
    }
  });

  // 4. AIInference
  await prisma.aIInference.createMany({
    data: [
      {
        modelName: 'no_show_predictor',
        targetId: user.id,
        targetType: 'user',
        confidenceScore: 0.88,
        predictionData: JSON.stringify({ probability: 0.12, riskFactors: ['weather', 'history'] }),
        tenantId: tenant.id
      },
      {
        modelName: 'lead_scorer',
        targetId: 'dummy-lead-id',
        targetType: 'lead',
        confidenceScore: 0.95,
        predictionData: JSON.stringify({ score: 85, reason: 'high geographic desirability' }),
        tenantId: tenant.id
      }
    ]
  });

  // 5. CommunicationLog
  await prisma.communicationLog.createMany({
    data: [
      {
        direction: 'outbound',
        channel: 'sms',
        recipient: '+15550001111',
        sender: 'system',
        subject: null,
        bodyText: 'Reply YES to confirm your shift.',
        status: 'delivered',
        externalId: 'SM12345twil',
        tenantId: tenant.id
      },
      {
        direction: 'outbound',
        channel: 'social',
        recipient: 'twitter',
        sender: 'system',
        subject: 'Weekly Tip',
        bodyText: 'Drink more water!',
        status: 'sent',
        externalId: 'TWT12345',
        tenantId: tenant.id
      }
    ]
  });

  console.log('Phase 10 Seeding Complete.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
