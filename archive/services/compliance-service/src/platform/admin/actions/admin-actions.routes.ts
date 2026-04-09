import { OpenAPIHono } from '@hono/zod-openapi';
import { commitOverridesRoute, exportRoute, triggerAutomationRoute, optimizeRoute, backupRoute, publishContentRoute, reindexSearchRoute, suspendResellerRoute, createShiftRoute, deleteLocationRoute, deleteRoleRoute, deleteTemplateRoute, createRegionRoute, createSurveyRoute, createTrainingModuleRoute, emergencyTriggerRoute, verifyChainRoute, entityHistoryRoute, auditStatsRoute,
    handleCommitOverrides, handleExport, handleTriggerAutomation, handleOptimize, handleBackup, handlePublishContent, handleReindexSearch, handleSuspendReseller, handleCreateShift, handleDeleteLocation, handleDeleteRole, handleDeleteTemplate, handleCreateRegion, handleCreateSurvey, handleCreateTrainingModule, handleEmergencyTrigger, handleVerifyChain, handleEntityHistory, handleAuditStats
} from './admin-actions-defs';

type Env = { Bindings: any; Variables: any };
const adminActions = new OpenAPIHono<Env>();

adminActions.openapi(commitOverridesRoute, handleCommitOverrides);
adminActions.openapi(exportRoute, handleExport);
adminActions.openapi(triggerAutomationRoute, handleTriggerAutomation);
adminActions.openapi(optimizeRoute, handleOptimize);
adminActions.openapi(backupRoute, handleBackup);
adminActions.openapi(publishContentRoute, handlePublishContent);
adminActions.openapi(reindexSearchRoute, handleReindexSearch);
adminActions.openapi(suspendResellerRoute, handleSuspendReseller);
adminActions.openapi(createShiftRoute, handleCreateShift);
adminActions.openapi(deleteLocationRoute, handleDeleteLocation);
adminActions.openapi(deleteRoleRoute, handleDeleteRole);
adminActions.openapi(deleteTemplateRoute, handleDeleteTemplate);
adminActions.openapi(createRegionRoute, handleCreateRegion);
adminActions.openapi(createSurveyRoute, handleCreateSurvey);
adminActions.openapi(createTrainingModuleRoute, handleCreateTrainingModule);
adminActions.openapi(emergencyTriggerRoute, handleEmergencyTrigger);
adminActions.openapi(verifyChainRoute, handleVerifyChain);
adminActions.openapi(entityHistoryRoute, handleEntityHistory);
adminActions.openapi(auditStatsRoute, handleAuditStats);

export default adminActions;
