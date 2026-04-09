import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';






































































final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooDashboard,
    builder: (context, state) => const CooDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoDashboard,
    builder: (context, state) => const CfoDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoDashboard,
    builder: (context, state) => const CtoDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDashboard,
    builder: (context, state) => const ComplianceManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorDashboard,
    builder: (context, state) => const TrainingDirectorDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoEnterpriseOverview,
    builder: (context, state) => const CeoEnterpriseOverviewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoFranchiseOverview,
    builder: (context, state) => const CeoFranchiseOverviewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRegionPerformance,
    builder: (context, state) => const CeoRegionPerformanceScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRevenueSummary,
    builder: (context, state) => const CeoRevenueSummaryScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoStrategicKpis,
    builder: (context, state) => const CeoStrategicKpisScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoGrowthPipeline,
    builder: (context, state) => const CeoGrowthPipelineScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoLeadershipReports,
    builder: (context, state) => const CeoLeadershipReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoAlertsAndRisks,
    builder: (context, state) => const CeoAlertsAndRisksScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoOrganizationMap,
    builder: (context, state) => const CeoOrganizationMapScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoApprovals,
    builder: (context, state) => const CeoApprovalsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoReports,
    builder: (context, state) => const CeoReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooOperationsOverview,
    builder: (context, state) => const CooOperationsOverviewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchOperations,
    builder: (context, state) => const CooBranchOperationsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooStaffingEfficiency,
    builder: (context, state) => const CooStaffingEfficiencyScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooSchedulingHealth,
    builder: (context, state) => const CooSchedulingHealthScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooServiceDelivery,
    builder: (context, state) => const CooServiceDeliveryScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooIssueEscalations,
    builder: (context, state) => const CooIssueEscalationsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooComplianceView,
    builder: (context, state) => const CooComplianceViewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooWorkflowPerformance,
    builder: (context, state) => const CooWorkflowPerformanceScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchComparison,
    builder: (context, state) => const CooBranchComparisonScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cooReports,
    builder: (context, state) => const CooReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFinancialOverview,
    builder: (context, state) => const CfoFinancialOverviewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoRevenue,
    builder: (context, state) => const CfoRevenueScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoExpenses,
    builder: (context, state) => const CfoExpensesScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFranchiseFinancials,
    builder: (context, state) => const CfoFranchiseFinancialsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoPayroll,
    builder: (context, state) => const CfoPayrollScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsReceivable,
    builder: (context, state) => const CfoAccountsReceivableScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsPayable,
    builder: (context, state) => const CfoAccountsPayableScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoInvoices,
    builder: (context, state) => const CfoInvoicesScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoProfitability,
    builder: (context, state) => const CfoProfitabilityScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoTaxAndRemittance,
    builder: (context, state) => const CfoTaxAndRemittanceScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoReports,
    builder: (context, state) => const CfoReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoSystemHealth,
    builder: (context, state) => const CtoSystemHealthScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoPlatformUsage,
    builder: (context, state) => const CtoPlatformUsageScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoFeatureAdoption,
    builder: (context, state) => const CtoFeatureAdoptionScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoApiMonitoring,
    builder: (context, state) => const CtoApiMonitoringScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIntegrations,
    builder: (context, state) => const CtoIntegrationsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAuditLogs,
    builder: (context, state) => const CtoAuditLogsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAccessControl,
    builder: (context, state) => const CtoAccessControlScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReleaseManagement,
    builder: (context, state) => const CtoReleaseManagementScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIssueTracking,
    builder: (context, state) => const CtoIssueTrackingScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoInfrastructure,
    builder: (context, state) => const CtoInfrastructureScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReports,
    builder: (context, state) => const CtoReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerComplianceCases,
    builder: (context, state) => const ComplianceManagerComplianceCasesScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerPolicies,
    builder: (context, state) => const ComplianceManagerPoliciesScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerAudits,
    builder: (context, state) => const ComplianceManagerAuditsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerIncidentReview,
    builder: (context, state) => const ComplianceManagerIncidentReviewScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCredentialTracking,
    builder: (context, state) => const ComplianceManagerCredentialTrackingScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDocumentExpiry,
    builder: (context, state) => const ComplianceManagerDocumentExpiryScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerRiskRegister,
    builder: (context, state) => const ComplianceManagerRiskRegisterScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCorrectiveActions,
    builder: (context, state) => const ComplianceManagerCorrectiveActionsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerTrainingCompliance,
    builder: (context, state) => const ComplianceManagerTrainingComplianceScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerReports,
    builder: (context, state) => const ComplianceManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainingPrograms,
    builder: (context, state) => const TrainingDirectorTrainingProgramsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
    builder: (context, state) => const TrainingDirectorStaffTrainingMatrixScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorComplianceTraining,
    builder: (context, state) => const TrainingDirectorComplianceTrainingScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCourseLibrary,
    builder: (context, state) => const TrainingDirectorCourseLibraryScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorAssessments,
    builder: (context, state) => const TrainingDirectorAssessmentsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCertifications,
    builder: (context, state) => const TrainingDirectorCertificationsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainerAssignments,
    builder: (context, state) => const TrainingDirectorTrainerAssignmentsScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorReports,
    builder: (context, state) => const TrainingDirectorReportsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorReports,
    builder: (context, state) => const SchedulerCoordinatorReportsScreenStitch(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorReports,
    builder: (context, state) => const IntakeCoordinatorReportsScreenStitch(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorCertifications,
    builder: (context, state) => const TrainingCoordinatorCertificationsScreenStitch(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorReports,
    builder: (context, state) => const TrainingCoordinatorReportsScreenStitch(),
  ),
];

