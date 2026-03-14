import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import carePlanRoutes from '../carePlans/carePlans.routes';
import scribeRoutes from '../../../platform/rn/clinical/scribe.routes';
import { submitAssessmentRoute, syncMedicationReconRoute, recordSupervisionRoute, dailyAuditSignOffRoute, listDailyAuditRoute, reconciliationPendingRoute, reconciliationApproveRoute,
    handleSubmitAssessment, handleSyncMedicationRecon, handleRecordSupervision, handleDailyAuditSignOff, handleListDailyAudit, handleReconciliationPending, handleReconciliationApprove
} from './clinical-route-defs';

const clinical = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

clinical.route('/care-plans', carePlanRoutes);
clinical.route('/scribe-parse', scribeRoutes);

clinical.openapi(submitAssessmentRoute, handleSubmitAssessment);
clinical.openapi(syncMedicationReconRoute, handleSyncMedicationRecon);
clinical.openapi(recordSupervisionRoute, handleRecordSupervision);
clinical.openapi(dailyAuditSignOffRoute, handleDailyAuditSignOff);
clinical.openapi(listDailyAuditRoute, handleListDailyAudit);
clinical.openapi(reconciliationPendingRoute, handleReconciliationPending);
clinical.openapi(reconciliationApproveRoute, handleReconciliationApprove);

export default clinical;
