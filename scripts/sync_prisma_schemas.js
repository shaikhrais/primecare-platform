const fs = require('fs');
const path = require('path');

const SCHEMA_DIR = path.join(__dirname, '..', 'packages', 'database', 'prisma', 'schema');

// 1. Corporate Portal (KPIs)
const corporateFile = path.join(SCHEMA_DIR, '14_corporate_portal.prisma');
const kpiModel = `
model KpiMetric {
  id          String   @id @default(cuid())
  label       String
  value       String
  category    String
  measuredAt  DateTime @default(now())
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
`;
if (fs.existsSync(corporateFile) && !fs.readFileSync(corporateFile, 'utf8').includes('model KpiMetric')) {
    fs.appendFileSync(corporateFile, kpiModel);
    console.log('Injected KpiMetric into 14_corporate_portal.prisma');
}

// 2. Clinical / Intake (Assessments)
const clinicalFile = path.join(SCHEMA_DIR, '04_clinical.prisma');
const intakeModel = `
model IntakeAssessment {
  id             String   @id @default(cuid())
  patientId      String
  providerId     String
  assessmentData Json
  status         String   @default("PENDING")
  createdAt      DateTime @default(now())
  updatedAt      DateTime @updatedAt
}
`;
if (fs.existsSync(clinicalFile) && !fs.readFileSync(clinicalFile, 'utf8').includes('model IntakeAssessment')) {
    fs.appendFileSync(clinicalFile, intakeModel);
    console.log('Injected IntakeAssessment into 04_clinical.prisma');
}

// 3. Support (Tickets)
const supportFile = path.join(SCHEMA_DIR, 'd_support.prisma');
const ticketModel = `
model SupportTicket {
  id          String   @id @default(cuid())
  title       String
  description String
  status      String   @default("OPEN")
  priority    String   @default("NORMAL")
  assigneeId  String?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
`;
if (fs.existsSync(supportFile) && !fs.readFileSync(supportFile, 'utf8').includes('model SupportTicket')) {
    fs.appendFileSync(supportFile, ticketModel);
    console.log('Injected SupportTicket into d_support.prisma');
}

console.log('Prisma schema injection complete.');
