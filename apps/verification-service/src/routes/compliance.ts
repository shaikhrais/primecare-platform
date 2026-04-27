import { ComplianceController } from '../controllers/compliance.controller';

export function registerComplianceRoutes(app: any) {
  app.get('/compliance/training/summary', (c: any) => ComplianceController.getTrainingSummary(c));
  app.post('/compliance/training/verify-certificate', (c: any) => ComplianceController.verifyCertificate(c));
  app.get('/compliance/training/activity', (c: any) => ComplianceController.getRecentActivity(c));
  app.get('/compliance/reports/audit', (c: any) => ComplianceController.getAuditReport(c));
  app.get('/compliance/reports/clinical', (c: any) => ComplianceController.getClinicalReport(c));
  app.get('/compliance/reports/staff-activity', (c: any) => ComplianceController.getStaffActivityReport(c));
  app.get('/compliance/training/curricula', (c: any) => ComplianceController.getCurricula(c));
  app.get('/compliance/training/certifications', (c: any) => ComplianceController.getCertifications(c));
  app.post('/compliance/training/modules', (c: any) => ComplianceController.createModule(c));
  app.put('/compliance/training/modules/:id', (c: any) => ComplianceController.updateModule(c));
}
