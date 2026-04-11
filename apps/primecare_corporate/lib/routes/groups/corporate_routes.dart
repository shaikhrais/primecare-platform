import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooDashboard,
    builder: (context, state) => const CooDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoDashboard,
    builder: (context, state) => const CfoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoDashboard,
    builder: (context, state) => const CtoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDashboard,
    builder: (context, state) => const ComplianceManagerDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorDashboard,
    builder: (context, state) => const TrainingDirectorDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoEnterpriseOverview,
    builder: (context, state) => const CeoEnterpriseOverviewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoFranchiseOverview,
    builder: (context, state) => const CeoFranchiseOverviewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRegionPerformance,
    builder: (context, state) => const CeoRegionPerformanceScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRevenueSummary,
    builder: (context, state) => const CeoRevenueSummaryScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoStrategicKpis,
    builder: (context, state) => const CeoStrategicKpisScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoGrowthPipeline,
    builder: (context, state) => const CeoGrowthPipelineScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoLeadershipReports,
    builder: (context, state) => const CeoLeadershipReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoAlertsAndRisks,
    builder: (context, state) => const CeoAlertsAndRisksScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoOrganizationMap,
    builder: (context, state) => const CeoOrganizationMapScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoApprovals,
    builder: (context, state) => const CeoApprovalsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoReports,
    builder: (context, state) => const CeoReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooOperationsOverview,
    builder: (context, state) => const CooOperationsOverviewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchOperations,
    builder: (context, state) => const CooBranchOperationsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooStaffingEfficiency,
    builder: (context, state) => const CooStaffingEfficiencyScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooSchedulingHealth,
    builder: (context, state) => const CooSchedulingHealthScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooServiceDelivery,
    builder: (context, state) => const CooServiceDeliveryScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooIssueEscalations,
    builder: (context, state) => const CooIssueEscalationsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooComplianceView,
    builder: (context, state) => const CooComplianceViewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooWorkflowPerformance,
    builder: (context, state) => const CooWorkflowPerformanceScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchComparison,
    builder: (context, state) => const CooBranchComparisonScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooReports,
    builder: (context, state) => const CooReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFinancialOverview,
    builder: (context, state) => const CfoFinancialOverviewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoRevenue,
    builder: (context, state) => const CfoRevenueScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoExpenses,
    builder: (context, state) => const CfoExpensesScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFranchiseFinancials,
    builder: (context, state) => const CfoFranchiseFinancialsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoPayroll,
    builder: (context, state) => const CfoPayrollScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsReceivable,
    builder: (context, state) => const CfoAccountsReceivableScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsPayable,
    builder: (context, state) => const CfoAccountsPayableScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoInvoices,
    builder: (context, state) => const CfoInvoicesScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoProfitability,
    builder: (context, state) => const CfoProfitabilityScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoTaxAndRemittance,
    builder: (context, state) => const CfoTaxAndRemittanceScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoReports,
    builder: (context, state) => const CfoReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoSystemHealth,
    builder: (context, state) => const CtoSystemHealthScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoPlatformUsage,
    builder: (context, state) => const CtoPlatformUsageScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoFeatureAdoption,
    builder: (context, state) => const CtoFeatureAdoptionScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoApiMonitoring,
    builder: (context, state) => const CtoApiMonitoringScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIntegrations,
    builder: (context, state) => const CtoIntegrationsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAuditLogs,
    builder: (context, state) => const CtoAuditLogsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAccessControl,
    builder: (context, state) => const CtoAccessControlScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReleaseManagement,
    builder: (context, state) => const CtoReleaseManagementScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIssueTracking,
    builder: (context, state) => const CtoIssueTrackingScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoInfrastructure,
    builder: (context, state) => const CtoInfrastructureScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReports,
    builder: (context, state) => const CtoReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerComplianceCases,
    builder: (context, state) =>
        const ComplianceManagerComplianceCasesScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerPolicies,
    builder: (context, state) => const ComplianceManagerPoliciesScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerAudits,
    builder: (context, state) => const ComplianceManagerAuditsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerIncidentReview,
    builder: (context, state) =>
        const ComplianceManagerIncidentReviewScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCredentialTracking,
    builder: (context, state) =>
        const ComplianceManagerCredentialTrackingScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDocumentExpiry,
    builder: (context, state) =>
        const ComplianceManagerDocumentExpiryScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerRiskRegister,
    builder: (context, state) =>
        const ComplianceManagerRiskRegisterScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCorrectiveActions,
    builder: (context, state) =>
        const ComplianceManagerCorrectiveActionsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerTrainingCompliance,
    builder: (context, state) =>
        const ComplianceManagerTrainingComplianceScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerReports,
    builder: (context, state) => const ComplianceManagerReportsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainingPrograms,
    builder: (context, state) =>
        const TrainingDirectorTrainingProgramsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
    builder: (context, state) =>
        const TrainingDirectorStaffTrainingMatrixScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorComplianceTraining,
    builder: (context, state) =>
        const TrainingDirectorComplianceTrainingScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCourseLibrary,
    builder: (context, state) =>
        const TrainingDirectorCourseLibraryScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorAssessments,
    builder: (context, state) =>
        const TrainingDirectorAssessmentsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCertifications,
    builder: (context, state) =>
        const TrainingDirectorCertificationsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainerAssignments,
    builder: (context, state) =>
        const TrainingDirectorTrainerAssignmentsScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorReports,
    builder: (context, state) => const TrainingDirectorReportsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorReports,
    builder: (context, state) =>
        const SchedulerCoordinatorReportsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorReports,
    builder: (context, state) => const IntakeCoordinatorReportsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorCertifications,
    builder: (context, state) =>
        const TrainingCoordinatorCertificationsScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorReports,
    builder: (context, state) => const TrainingCoordinatorReportsScreen(),
  ),
];
