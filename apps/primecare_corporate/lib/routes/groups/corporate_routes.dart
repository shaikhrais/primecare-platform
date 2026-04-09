import 'package:flutter_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';






































































final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: AppRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooDashboard,
    builder: (context, state) => const CooDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoDashboard,
    builder: (context, state) => const CfoDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoDashboard,
    builder: (context, state) => const CtoDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerDashboard,
    builder: (context, state) => const ComplianceManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorDashboard,
    builder: (context, state) => const TrainingDirectorDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoEnterpriseOverview,
    builder: (context, state) => const CeoEnterpriseOverviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoFranchiseOverview,
    builder: (context, state) => const CeoFranchiseOverviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoRegionPerformance,
    builder: (context, state) => const CeoRegionPerformanceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoRevenueSummary,
    builder: (context, state) => const CeoRevenueSummaryScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoStrategicKpis,
    builder: (context, state) => const CeoStrategicKpisScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoGrowthPipeline,
    builder: (context, state) => const CeoGrowthPipelineScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoLeadershipReports,
    builder: (context, state) => const CeoLeadershipReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoAlertsAndRisks,
    builder: (context, state) => const CeoAlertsAndRisksScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoOrganizationMap,
    builder: (context, state) => const CeoOrganizationMapScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoApprovals,
    builder: (context, state) => const CeoApprovalsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ceoReports,
    builder: (context, state) => const CeoReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooOperationsOverview,
    builder: (context, state) => const CooOperationsOverviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooBranchOperations,
    builder: (context, state) => const CooBranchOperationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooStaffingEfficiency,
    builder: (context, state) => const CooStaffingEfficiencyScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooSchedulingHealth,
    builder: (context, state) => const CooSchedulingHealthScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooServiceDelivery,
    builder: (context, state) => const CooServiceDeliveryScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooIssueEscalations,
    builder: (context, state) => const CooIssueEscalationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooComplianceView,
    builder: (context, state) => const CooComplianceViewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooWorkflowPerformance,
    builder: (context, state) => const CooWorkflowPerformanceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooBranchComparison,
    builder: (context, state) => const CooBranchComparisonScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cooReports,
    builder: (context, state) => const CooReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoFinancialOverview,
    builder: (context, state) => const CfoFinancialOverviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoRevenue,
    builder: (context, state) => const CfoRevenueScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoExpenses,
    builder: (context, state) => const CfoExpensesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoFranchiseFinancials,
    builder: (context, state) => const CfoFranchiseFinancialsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoPayroll,
    builder: (context, state) => const CfoPayrollScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoAccountsReceivable,
    builder: (context, state) => const CfoAccountsReceivableScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoAccountsPayable,
    builder: (context, state) => const CfoAccountsPayableScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoInvoices,
    builder: (context, state) => const CfoInvoicesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoProfitability,
    builder: (context, state) => const CfoProfitabilityScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoTaxAndRemittance,
    builder: (context, state) => const CfoTaxAndRemittanceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.cfoReports,
    builder: (context, state) => const CfoReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoSystemHealth,
    builder: (context, state) => const CtoSystemHealthScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoPlatformUsage,
    builder: (context, state) => const CtoPlatformUsageScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoFeatureAdoption,
    builder: (context, state) => const CtoFeatureAdoptionScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoApiMonitoring,
    builder: (context, state) => const CtoApiMonitoringScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoIntegrations,
    builder: (context, state) => const CtoIntegrationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoAuditLogs,
    builder: (context, state) => const CtoAuditLogsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoAccessControl,
    builder: (context, state) => const CtoAccessControlScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoReleaseManagement,
    builder: (context, state) => const CtoReleaseManagementScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoIssueTracking,
    builder: (context, state) => const CtoIssueTrackingScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoInfrastructure,
    builder: (context, state) => const CtoInfrastructureScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.ctoReports,
    builder: (context, state) => const CtoReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerComplianceCases,
    builder: (context, state) => const ComplianceManagerComplianceCasesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerPolicies,
    builder: (context, state) => const ComplianceManagerPoliciesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerAudits,
    builder: (context, state) => const ComplianceManagerAuditsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerIncidentReview,
    builder: (context, state) => const ComplianceManagerIncidentReviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerCredentialTracking,
    builder: (context, state) => const ComplianceManagerCredentialTrackingScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerDocumentExpiry,
    builder: (context, state) => const ComplianceManagerDocumentExpiryScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerRiskRegister,
    builder: (context, state) => const ComplianceManagerRiskRegisterScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerCorrectiveActions,
    builder: (context, state) => const ComplianceManagerCorrectiveActionsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerTrainingCompliance,
    builder: (context, state) => const ComplianceManagerTrainingComplianceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerReports,
    builder: (context, state) => const ComplianceManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorTrainingPrograms,
    builder: (context, state) => const TrainingDirectorTrainingProgramsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorStaffTrainingMatrix,
    builder: (context, state) => const TrainingDirectorStaffTrainingMatrixScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorComplianceTraining,
    builder: (context, state) => const TrainingDirectorComplianceTrainingScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorCourseLibrary,
    builder: (context, state) => const TrainingDirectorCourseLibraryScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorAssessments,
    builder: (context, state) => const TrainingDirectorAssessmentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorCertifications,
    builder: (context, state) => const TrainingDirectorCertificationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorTrainerAssignments,
    builder: (context, state) => const TrainingDirectorTrainerAssignmentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorReports,
    builder: (context, state) => const TrainingDirectorReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorReports,
    builder: (context, state) => const SchedulerCoordinatorReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorReports,
    builder: (context, state) => const IntakeCoordinatorReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorCertifications,
    builder: (context, state) => const TrainingCoordinatorCertificationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorReports,
    builder: (context, state) => const TrainingCoordinatorReportsScreenStitch(),
  ),
];
