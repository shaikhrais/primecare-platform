import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import carePlanRoutes from '../carePlans/carePlans.routes';
// import scribeRoutes removed
import { submitAssessmentRoute, syncMedicationReconRoute, recordSupervisionRoute, dailyAuditSignOffRoute, listDailyAuditRoute, reconciliationPendingRoute, reconciliationApproveRoute, getAssignedPatientsRoute,
    handleSubmitAssessment, handleSyncMedicationRecon, handleRecordSupervision, handleDailyAuditSignOff, handleListDailyAudit, handleReconciliationPending, handleReconciliationApprove, handleGetAssignedPatients
} from './clinical-route-defs';

const clinical = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

clinical.route('/care-plans', carePlanRoutes);
// clinical.route('/scribe-parse', scribeRoutes);

clinical.openapi(submitAssessmentRoute, handleSubmitAssessment);
clinical.openapi(syncMedicationReconRoute, handleSyncMedicationRecon);
clinical.openapi(recordSupervisionRoute, handleRecordSupervision);
clinical.openapi(dailyAuditSignOffRoute, handleDailyAuditSignOff);
clinical.openapi(listDailyAuditRoute, handleListDailyAudit);
clinical.openapi(reconciliationPendingRoute, handleReconciliationPending);
clinical.openapi(reconciliationApproveRoute, handleReconciliationApprove);
clinical.openapi(getAssignedPatientsRoute, handleGetAssignedPatients);

// Mock OCR Vision Pipeline (Decoupled from Frontend)
clinical.post('/ocr-vision', async (c) => {
    return c.json([
        {"name": "Lisinopril", "dosage": "10mg", "route": "PO", "frequency": "Daily"},
        {"name": "Metformin", "dosage": "500mg", "route": "PO", "frequency": "BID"}
    ], 200);
});

export default clinical;
