import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoEnterpriseOverview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoFranchiseOverview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRegionPerformance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoRevenueSummary,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoStrategicKpis,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoGrowthPipeline,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoLeadershipReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoAlertsAndRisks,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoOrganizationMap,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoApprovals,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ceoReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooOperationsOverview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchOperations,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooStaffingEfficiency,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooSchedulingHealth,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooServiceDelivery,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooIssueEscalations,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooComplianceView,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooWorkflowPerformance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooBranchComparison,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cooReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFinancialOverview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoRevenue,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoExpenses,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoFranchiseFinancials,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoPayroll,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsReceivable,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoAccountsPayable,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoInvoices,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoProfitability,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoTaxAndRemittance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.cfoReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoSystemHealth,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoPlatformUsage,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoFeatureAdoption,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoApiMonitoring,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIntegrations,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAuditLogs,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoAccessControl,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReleaseManagement,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoIssueTracking,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoInfrastructure,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerComplianceCases,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerPolicies,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerAudits,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerIncidentReview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCredentialTracking,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDocumentExpiry,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerRiskRegister,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerCorrectiveActions,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerTrainingCompliance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainingPrograms,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorComplianceTraining,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCourseLibrary,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorAssessments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorCertifications,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorTrainerAssignments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.trainingDirectorReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorCertifications,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: SupportRoutes.trainingCoordinatorReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
