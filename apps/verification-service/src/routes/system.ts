import { SystemController } from '../controllers/system.controller';

export function registerSystemRoutes(app: any) {
  app.get('/verifications/missing-plans', (c: any) => SystemController.getMissingPlans(c));
  app.get('/verifications/cross-validate', (c: any) => SystemController.crossValidate(c));
  app.get('/database/report', (c: any) => SystemController.getDatabaseReport(c));
  app.post('/implementations', (c: any) => SystemController.recordImplementation(c));
  app.post('/verifications/pre-flight', (c: any) => SystemController.preFlightCheck(c));
  app.get('/verifications/purpose-report', (c: any) => SystemController.getPurposeReport(c));
  app.post('/verifications/audit-purpose', (c: any) => SystemController.auditPurpose(c));
}
