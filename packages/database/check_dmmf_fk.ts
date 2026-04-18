import { PrismaClient, Prisma } from './generated/client';
const prisma = new PrismaClient();

const targets = [
  'Claim', 'FinancialReconciliation', 'Franchise', 'InfectionControlChecklist', 'JournalEntry',
  'Message', 'MobilityLog', 'NarrativeProgressNote', 'NutritionRecord', 'PlatformScreen',
  'ProtocolResolution', 'ProviderShiftLog', 'ProviderVitalSign', 'ReferralPipeline',
  'ResellerAgreement', 'RoleScreenAccess', 'ScreenFunctionality', 'StaffGroupMember',
  'StaffTask', 'TelehealthSession', 'TrainingAssignment', 'WebhookDelivery'
];

async function main() {
  for (const m of Prisma.dmmf.datamodel.models) {
    if (targets.includes(m.name)) {
      console.log(`\nTable: ${m.name}`);
      for (const f of m.fields) {
        if (f.isRequired && !f.hasDefaultValue && f.name !== 'id') {
           console.log(`  - REQUIRED: ${f.name} (${f.type})`);
        }
      }
    }
  }
}
main().finally(() => prisma.$disconnect());
