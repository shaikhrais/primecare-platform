import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { branchHealthRoute, statsRoute, complianceSyncRoute, feedbackTriageRoute, waitlistRoute, logisticsBoardRoute, getIncidentsRoute, getLocationsRoute, getApprovalsRoute, approveItemRoute, rejectItemRoute, authorizeCrisisPayRoute } from './manager-ops-route-defs';
import { handleStats, handleComplianceSync, handleFeedbackTriage, handleBranchHealth, handleWaitlist, handleLogisticsBoard, handleGetIncidents, handleGetLocations, handleGetApprovals, handleApproveItem, handleRejectItem, handleAuthorizeCrisisPay } from './manager-ops-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.openapi(statsRoute, handleStats);
r.openapi(complianceSyncRoute, handleComplianceSync);
r.openapi(feedbackTriageRoute, handleFeedbackTriage);
r.openapi(branchHealthRoute, handleBranchHealth);
r.openapi(waitlistRoute, handleWaitlist);
r.openapi(logisticsBoardRoute, handleLogisticsBoard);
r.openapi(getIncidentsRoute, handleGetIncidents);
r.openapi(getLocationsRoute, handleGetLocations);
r.openapi(getApprovalsRoute, handleGetApprovals);
r.openapi(approveItemRoute, handleApproveItem);
r.openapi(rejectItemRoute, handleRejectItem);
r.openapi(authorizeCrisisPayRoute, handleAuthorizeCrisisPay);

export default r;
