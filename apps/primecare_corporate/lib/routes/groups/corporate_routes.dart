// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';


class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
  });
}

final List<ScreenConfig> corporateScreenRegistry = [
  ScreenConfig(
    routePath: CorporateRoutes.ceoDashboard,
    titleKey: 'CEO Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooDashboard,
    titleKey: 'COO Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoDashboard,
    titleKey: 'CFO Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoDashboard,
    titleKey: 'CTO Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerDashboard,
    titleKey: 'Compliance Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorDashboard,
    titleKey: 'Training Director Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorDashboard',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoEnterpriseOverview,
    titleKey: 'Ceo Enterprise Overview',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoEnterpriseOverview',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoFranchiseOverview,
    titleKey: 'Ceo Franchise Overview',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoFranchiseOverview',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoRegionPerformance,
    titleKey: 'Ceo Region Performance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoRegionPerformance',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoRevenueSummary,
    titleKey: 'Ceo Revenue Summary',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoRevenueSummary',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoStrategicKpis,
    titleKey: 'Ceo Strategic Kpis',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoStrategicKpis',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoGrowthPipeline,
    titleKey: 'Ceo Growth Pipeline',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoGrowthPipeline',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoLeadershipReports,
    titleKey: 'Ceo Leadership Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoLeadershipReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoAlertsAndRisks,
    titleKey: 'Ceo Alerts And Risks',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoAlertsAndRisks',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoOrganizationMap,
    titleKey: 'Ceo Organization Map',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoOrganizationMap',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoApprovals,
    titleKey: 'Ceo Approvals',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoApprovals',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ceoReports,
    titleKey: 'Ceo Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ceoReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooOperationsOverview,
    titleKey: 'Coo Operations Overview',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooOperationsOverview',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooBranchOperations,
    titleKey: 'Coo Branch Operations',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooBranchOperations',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooStaffingEfficiency,
    titleKey: 'Coo Staffing Efficiency',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooStaffingEfficiency',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooSchedulingHealth,
    titleKey: 'Coo Scheduling Health',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooSchedulingHealth',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooServiceDelivery,
    titleKey: 'Coo Service Delivery',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooServiceDelivery',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooIssueEscalations,
    titleKey: 'Coo Issue Escalations',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooIssueEscalations',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooComplianceView,
    titleKey: 'Coo Compliance View',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooComplianceView',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooWorkflowPerformance,
    titleKey: 'Coo Workflow Performance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooWorkflowPerformance',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooBranchComparison,
    titleKey: 'Coo Branch Comparison',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooBranchComparison',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cooReports,
    titleKey: 'Coo Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cooReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoFinancialOverview,
    titleKey: 'Cfo Financial Overview',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoFinancialOverview',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoRevenue,
    titleKey: 'Cfo Revenue',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoRevenue',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoExpenses,
    titleKey: 'Cfo Expenses',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoExpenses',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoFranchiseFinancials,
    titleKey: 'Cfo Franchise Financials',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoFranchiseFinancials',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoPayroll,
    titleKey: 'Cfo Payroll',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoPayroll',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoAccountsReceivable,
    titleKey: 'Cfo Accounts Receivable',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoAccountsReceivable',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoAccountsPayable,
    titleKey: 'Cfo Accounts Payable',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoAccountsPayable',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoInvoices,
    titleKey: 'Cfo Invoices',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoInvoices',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoProfitability,
    titleKey: 'Cfo Profitability',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoProfitability',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoTaxAndRemittance,
    titleKey: 'Cfo Tax And Remittance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoTaxAndRemittance',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.cfoReports,
    titleKey: 'Cfo Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'cfoReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoSystemHealth,
    titleKey: 'Cto System Health',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoSystemHealth',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoPlatformUsage,
    titleKey: 'Cto Platform Usage',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoPlatformUsage',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoFeatureAdoption,
    titleKey: 'Cto Feature Adoption',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoFeatureAdoption',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoApiMonitoring,
    titleKey: 'Cto Api Monitoring',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoApiMonitoring',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoIntegrations,
    titleKey: 'Cto Integrations',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoIntegrations',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoAuditLogs,
    titleKey: 'Cto Audit Logs',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoAuditLogs',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoAccessControl,
    titleKey: 'Cto Access Control',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoAccessControl',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoReleaseManagement,
    titleKey: 'Cto Release Management',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoReleaseManagement',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoIssueTracking,
    titleKey: 'Cto Issue Tracking',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoIssueTracking',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoInfrastructure,
    titleKey: 'Cto Infrastructure',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoInfrastructure',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.ctoReports,
    titleKey: 'Cto Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'ctoReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerComplianceCases,
    titleKey: 'Compliance Manager Compliance Cases',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerComplianceCases',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerPolicies,
    titleKey: 'Compliance Manager Policies',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerPolicies',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerAudits,
    titleKey: 'Compliance Manager Audits',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerAudits',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerIncidentReview,
    titleKey: 'Compliance Manager Incident Review',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerIncidentReview',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerCredentialTracking,
    titleKey: 'Compliance Manager Credential Tracking',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerCredentialTracking',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerDocumentExpiry,
    titleKey: 'Compliance Manager Document Expiry',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerDocumentExpiry',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerRiskRegister,
    titleKey: 'Compliance Manager Risk Register',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerRiskRegister',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerCorrectiveActions,
    titleKey: 'Compliance Manager Corrective Actions',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerCorrectiveActions',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerTrainingCompliance,
    titleKey: 'Compliance Manager Training Compliance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerTrainingCompliance',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.complianceManagerReports,
    titleKey: 'Compliance Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'complianceManagerReports',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorTrainingPrograms,
    titleKey: 'Training Director Training Programs',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorTrainingPrograms',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
    titleKey: 'Training Director Staff Training Matrix',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorStaffTrainingMatrix',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorComplianceTraining,
    titleKey: 'Training Director Compliance Training',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorComplianceTraining',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorCourseLibrary,
    titleKey: 'Training Director Course Library',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorCourseLibrary',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorAssessments,
    titleKey: 'Training Director Assessments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorAssessments',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorCertifications,
    titleKey: 'Training Director Certifications',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorCertifications',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorTrainerAssignments,
    titleKey: 'Training Director Trainer Assignments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorTrainerAssignments',
  ),
  ScreenConfig(
    routePath: CorporateRoutes.trainingDirectorReports,
    titleKey: 'Training Director Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingDirectorReports',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorReports,
    titleKey: 'Scheduler Coordinator Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorReports',
  ),
  ScreenConfig(
    routePath: SupportRoutes.intakeCoordinatorReports,
    titleKey: 'Intake Coordinator Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'intakeCoordinatorReports',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorCertifications,
    titleKey: 'Training Coordinator Certifications',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorCertifications',
  ),
  ScreenConfig(
    routePath: SupportRoutes.trainingCoordinatorReports,
    titleKey: 'Training Coordinator Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'trainingCoordinatorReports',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.generalManagerDashboard,
    titleKey: 'General Manager Dashboard',
    subtitleKey: 'Resilient operational oversight with AI forecasting.',
    providerId: 'generalManagerDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
    titleKey: 'Regional Manager (USA)',
    subtitleKey: 'International market analytics and predictive forecasting.',
    providerId: 'regionalManagerUSADashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
    titleKey: 'Regional Manager (Ontario)',
    subtitleKey: 'Provincial performance metrics and resource forecasting.',
    providerId: 'regionalManagerOntarioDashboard',
  ),
];

final List<RouteBase> corporateRoutes = [
  ...corporateScreenRegistry.map((config) {
    return GoRoute(
      path: config.routePath,
      builder: (context, state) {
        final adapter = resolveAdapterByName(config.providerId);
        if (adapter != null) {
          return PageTemplate.orchestrate(
            title: config.titleKey,
            subtitle: config.subtitleKey,
            provider: adapter,
          );
        }
        return PageTemplate.orchestrate(
          title: config.titleKey,
          subtitle: config.subtitleKey,
          provider: dashboardMetricsProvider(config.providerId),
        );
      },
    );
  }),
  GoRoute(
    path: CommonRoutes.institutionalScheduler,
    builder: (context, state) => const InstitutionalSchedulerScreen(),
  ),
  GoRoute(
    path: CommonRoutes.receptionistDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'receptionist'),
  ),
  GoRoute(
    path: CommonRoutes.clinicalDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'clinical'),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'billing_admin'),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'operations_manager'),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'scheduler'),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'hr_hiring'),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'customer_support'),
  ),
  GoRoute(
    path: SupportRoutes.intakeCoordinatorDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'intake_coordinator'),
  ),
  GoRoute(
    path: SupportRoutes.qualityAssuranceDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildDynamicDashboard(context, 'quality_assurance'),
  ),
  GoRoute(
    path: CorporateRoutes.ctoVerificationHub,
    builder: (context, state) => const VerificationHub(),
  ),
];
