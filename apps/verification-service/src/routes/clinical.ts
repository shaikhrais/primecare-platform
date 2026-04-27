import { ClinicalController } from '../controllers/clinical.controller';

export function registerClinicalRoutes(app: any) {
  app.post('/v1/clinical/vitals', (c: any) => ClinicalController.captureVitals(c));
  app.post('/v1/clinical/patient-intake', (c: any) => ClinicalController.processPatientIntake(c));
  app.get('/v1/clinical/check-email', (c: any) => ClinicalController.checkEmail(c));
  app.get('/v1/clinical/ai-analytics/q3-extrapolations', (c: any) => ClinicalController.getQ3Extrapolations(c));
}
