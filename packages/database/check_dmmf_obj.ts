import { PrismaClient, Prisma } from './generated/client';
const prisma = new PrismaClient();

async function main() {
  const claimModel = Prisma.dmmf.datamodel.models.find(m => m.name === 'Claim')!;
  for (const f of claimModel.fields) {
    if (f.kind === 'object') {
       console.log('Object relation field:', f.name, f.type, f.relationFromFields);
    }
  }
}
main().finally(() => prisma.$disconnect());
