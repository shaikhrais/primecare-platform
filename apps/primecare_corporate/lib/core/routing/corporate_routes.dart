// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart' hide ShareholderDashboardScreen, FinanceDirectorDashboardScreen, VolunteerCoordinatorDashboardScreen, HrManagerDashboardScreen, HrHiringDashboardScreen, HrDirectorDashboardScreen, CxDirectorDashboardScreen, LegalDashboardScreen, CisoDashboardScreen, OwnerDashboardScreen, CooDashboardScreen, CfoDashboardScreen, CtoDashboardScreen, ComplianceManagerDashboardScreen, HeadOfBusDevDashboardScreen, HeadOfMarketingDashboardScreen, TrainingDirectorDashboardScreen, CooOperationsOverviewScreen, CooSchedulingHealthScreen, CooBranchComparisonScreen, CfoRevenueScreen, CfoExpensesScreen, CfoPayrollScreen, CfoInvoicesScreen, CfoProfitabilityScreen, TrainingDirectorAnalyticsScreen;
import '../../features/corporate/presentation/widgets/widgets.dart';

class PrimeCareTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare Corporate';

  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF1E3A8A), // Corporate Navy
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFDBEAFE),
        ),
      ).toThemeData();
}

class CeoModule extends PlatformModule {
  @override
  String get moduleId => 'ceo_module';

  @override
  String get name => 'Ceo Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.ceo];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.ceoDashboard,
      builder: (context) => CeoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Enterprise Overview',
      route: CorporateRoutes.ceoEnterpriseOverview,
      builder: (context) => CeoEnterpriseOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Overview',
      route: CorporateRoutes.ceoFranchiseOverview,
      builder: (context) => CeoFranchiseOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Region Performance',
      route: CorporateRoutes.ceoRegionPerformance,
      builder: (context) => CeoRegionPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Revenue Summary',
      route: CorporateRoutes.ceoRevenueSummary,
      builder: (context) => CeoRevenueSummaryScreen(),
    ),
    PrimeCareScreen(
      title: 'Strategic Kpis',
      route: CorporateRoutes.ceoStrategicKpis,
      builder: (context) => CeoStrategicKpisScreen(),
    ),
    PrimeCareScreen(
      title: 'Growth Pipeline',
      route: CorporateRoutes.ceoGrowthPipeline,
      builder: (context) => CeoGrowthPipelineScreen(),
    ),
    PrimeCareScreen(
      title: 'Leadership Reports',
      route: CorporateRoutes.ceoLeadershipReports,
      builder: (context) => CeoLeadershipReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Alerts And Risks',
      route: CorporateRoutes.ceoAlertsAndRisks,
      builder: (context) => CeoAlertsAndRisksScreen(),
    ),
    PrimeCareScreen(
      title: 'Organization Map',
      route: CorporateRoutes.ceoOrganizationMap,
      builder: (context) => CeoOrganizationMapScreen(),
    ),
    PrimeCareScreen(
      title: 'Approvals',
      route: CorporateRoutes.ceoApprovals,
      builder: (context) => CeoApprovalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.ceoReports,
      builder: (context) => CeoReportsScreen(),
    ),
  ];
}
class OwnerModule extends PlatformModule {
  @override
  String get moduleId => 'owner_module';

  @override
  String get name => 'Owner Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.owner];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.ownerDashboard,
      builder: (context) => OwnerDashboardScreen(),
    ),
  ];
}
class CooModule extends PlatformModule {
  @override
  String get moduleId => 'coo_module';

  @override
  String get name => 'Coo Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.coo];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.cooDashboard,
      builder: (context) => CooDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Operations Overview',
      route: CorporateRoutes.cooOperationsOverview,
      builder: (context) => CooOperationsOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Operations',
      route: CorporateRoutes.cooBranchOperations,
      builder: (context) => CooBranchOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staffing Efficiency',
      route: CorporateRoutes.cooStaffingEfficiency,
      builder: (context) => CooStaffingEfficiencyScreen(),
    ),
    PrimeCareScreen(
      title: 'Scheduling Health',
      route: CorporateRoutes.cooSchedulingHealth,
      builder: (context) => CooSchedulingHealthScreen(),
    ),
    PrimeCareScreen(
      title: 'Service Delivery',
      route: CorporateRoutes.cooServiceDelivery,
      builder: (context) => CooServiceDeliveryScreen(),
    ),
    PrimeCareScreen(
      title: 'Issue Escalations',
      route: CorporateRoutes.cooIssueEscalations,
      builder: (context) => CooIssueEscalationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance View',
      route: CorporateRoutes.cooComplianceView,
      builder: (context) => CooComplianceViewScreen(),
    ),
    PrimeCareScreen(
      title: 'Workflow Performance',
      route: CorporateRoutes.cooWorkflowPerformance,
      builder: (context) => CooWorkflowPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Comparison',
      route: CorporateRoutes.cooBranchComparison,
      builder: (context) => CooBranchComparisonScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.cooReports,
      builder: (context) => CooReportsScreen(),
    ),
  ];
}
class CfoModule extends PlatformModule {
  @override
  String get moduleId => 'cfo_module';

  @override
  String get name => 'Cfo Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.cfo];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.cfoDashboard,
      builder: (context) => CfoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Financial Overview',
      route: CorporateRoutes.cfoFinancialOverview,
      builder: (context) => CfoFinancialOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Revenue',
      route: CorporateRoutes.cfoRevenue,
      builder: (context) => CfoRevenueScreen(),
    ),
    PrimeCareScreen(
      title: 'Expenses',
      route: CorporateRoutes.cfoExpenses,
      builder: (context) => CfoExpensesScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Financials',
      route: CorporateRoutes.cfoFranchiseFinancials,
      builder: (context) => CfoFranchiseFinancialsScreen(),
    ),
    PrimeCareScreen(
      title: 'Payroll',
      route: CorporateRoutes.cfoPayroll,
      builder: (context) => CfoPayrollScreen(),
    ),
    PrimeCareScreen(
      title: 'Accounts Receivable',
      route: CorporateRoutes.cfoAccountsReceivable,
      builder: (context) => CfoAccountsReceivableScreen(),
    ),
    PrimeCareScreen(
      title: 'Accounts Payable',
      route: CorporateRoutes.cfoAccountsPayable,
      builder: (context) => CfoAccountsPayableScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: CorporateRoutes.cfoInvoices,
      builder: (context) => CfoInvoicesScreen(),
    ),
    PrimeCareScreen(
      title: 'Profitability',
      route: CorporateRoutes.cfoProfitability,
      builder: (context) => CfoProfitabilityScreen(),
    ),
    PrimeCareScreen(
      title: 'Tax And Remittance',
      route: CorporateRoutes.cfoTaxAndRemittance,
      builder: (context) => CfoTaxAndRemittanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.cfoReports,
      builder: (context) => CfoReportsScreen(),
    ),
  ];
}
class CtoModule extends PlatformModule {
  @override
  String get moduleId => 'cto_module';

  @override
  String get name => 'Cto Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.cto];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.ctoDashboard,
      builder: (context) => CtoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'System Health',
      route: CorporateRoutes.ctoSystemHealth,
      builder: (context) => CtoSystemHealthScreen(),
    ),
    PrimeCareScreen(
      title: 'Platform Usage',
      route: CorporateRoutes.ctoPlatformUsage,
      builder: (context) => CtoPlatformUsageScreen(),
    ),
    PrimeCareScreen(
      title: 'Feature Adoption',
      route: CorporateRoutes.ctoFeatureAdoption,
      builder: (context) => CtoFeatureAdoptionScreen(),
    ),
    PrimeCareScreen(
      title: 'Api Monitoring',
      route: CorporateRoutes.ctoApiMonitoring,
      builder: (context) => CtoApiMonitoringScreen(),
    ),
    PrimeCareScreen(
      title: 'Integrations',
      route: CorporateRoutes.ctoIntegrations,
      builder: (context) => CtoIntegrationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Audit Logs',
      route: CorporateRoutes.ctoAuditLogs,
      builder: (context) => CtoAuditLogsScreen(),
    ),
    PrimeCareScreen(
      title: 'Access Control',
      route: CorporateRoutes.ctoAccessControl,
      builder: (context) => CtoAccessControlScreen(),
    ),
    PrimeCareScreen(
      title: 'Release Management',
      route: CorporateRoutes.ctoReleaseManagement,
      builder: (context) => CtoReleaseManagementScreen(),
    ),
    PrimeCareScreen(
      title: 'Issue Tracking',
      route: CorporateRoutes.ctoIssueTracking,
      builder: (context) => CtoIssueTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Infrastructure',
      route: CorporateRoutes.ctoInfrastructure,
      builder: (context) => CtoInfrastructureScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.ctoReports,
      builder: (context) => CtoReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Verification Hub',
      route: CorporateRoutes.ctoVerificationHub,
      builder: (context) => CtoVerificationHubScreen(),
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: CorporateRoutes.systemVerificationDashboard,
      builder: (context) => CtoSystemVerificationScreen(),
    ),
  ];
}
class ComplianceManagerModule extends PlatformModule {
  @override
  String get moduleId => 'compliance_manager_module';

  @override
  String get name => 'ComplianceManager Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.complianceManager];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.complianceManagerDashboard,
      builder: (context) => ComplianceManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Cases',
      route: CorporateRoutes.complianceManagerComplianceCases,
      builder: (context) => ComplianceManagerComplianceCasesScreen(),
    ),
    PrimeCareScreen(
      title: 'Policies',
      route: CorporateRoutes.complianceManagerPolicies,
      builder: (context) => ComplianceManagerPoliciesScreen(),
    ),
    PrimeCareScreen(
      title: 'Audits',
      route: CorporateRoutes.complianceManagerAudits,
      builder: (context) => ComplianceManagerAuditsScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Review',
      route: CorporateRoutes.complianceManagerIncidentReview,
      builder: (context) => ComplianceManagerIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Credential Tracking',
      route: CorporateRoutes.complianceManagerCredentialTracking,
      builder: (context) => ComplianceManagerCredentialTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Document Expiry',
      route: CorporateRoutes.complianceManagerDocumentExpiry,
      builder: (context) => ComplianceManagerDocumentExpiryScreen(),
    ),
    PrimeCareScreen(
      title: 'Risk Register',
      route: CorporateRoutes.complianceManagerRiskRegister,
      builder: (context) => ComplianceManagerRiskRegisterScreen(),
    ),
    PrimeCareScreen(
      title: 'Corrective Actions',
      route: CorporateRoutes.complianceManagerCorrectiveActions,
      builder: (context) => ComplianceManagerCorrectiveActionsScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Compliance',
      route: CorporateRoutes.complianceManagerTrainingCompliance,
      builder: (context) => ComplianceManagerTrainingComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.complianceManagerReports,
      builder: (context) => ComplianceManagerReportsScreen(),
    ),
  ];
}
class HeadOfBusDevModule extends PlatformModule {
  @override
  String get moduleId => 'head_of_bus_dev_module';

  @override
  String get name => 'HeadOfBusDev Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.headOfBusDev];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.headOfBusDevDashboard,
      builder: (context) => HeadOfBusDevDashboardScreen(),
    ),
  ];
}
class HeadOfMarketingModule extends PlatformModule {
  @override
  String get moduleId => 'head_of_marketing_module';

  @override
  String get name => 'HeadOfMarketing Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.headOfMarketing];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.headOfMarketingDashboard,
      builder: (context) => HeadOfMarketingDashboardScreen(),
    ),
  ];
}
class TrainingDirectorModule extends PlatformModule {
  @override
  String get moduleId => 'training_director_module';

  @override
  String get name => 'TrainingDirector Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.trainingDirector];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.trainingDirectorDashboard,
      builder: (context) => TrainingDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Programs',
      route: CorporateRoutes.trainingDirectorTrainingPrograms,
      builder: (context) => TrainingDirectorTrainingProgramsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Training Matrix',
      route: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
      builder: (context) => TrainingDirectorStaffTrainingMatrixScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Training',
      route: CorporateRoutes.trainingDirectorComplianceTraining,
      builder: (context) => TrainingDirectorComplianceTrainingScreen(),
    ),
    PrimeCareScreen(
      title: 'Course Library',
      route: CorporateRoutes.trainingDirectorCourseLibrary,
      builder: (context) => TrainingDirectorCourseLibraryScreen(),
    ),
    PrimeCareScreen(
      title: 'Assessments',
      route: CorporateRoutes.trainingDirectorAssessments,
      builder: (context) => TrainingDirectorAssessmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Certifications',
      route: CorporateRoutes.trainingDirectorCertifications,
      builder: (context) => TrainingDirectorCertificationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Trainer Assignments',
      route: CorporateRoutes.trainingDirectorTrainerAssignments,
      builder: (context) => TrainingDirectorTrainerAssignmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.trainingDirectorReports,
      builder: (context) => TrainingDirectorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Analytics',
      route: CorporateRoutes.trainingDirectorAnalytics,
      builder: (context) => TrainingDirectorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Course Architect',
      route: CorporateRoutes.courseArchitectDashboard,
      builder: (context) => TrainingDirectorCourseArchitectScreen(),
    ),
    PrimeCareScreen(
      title: 'Hub',
      route: CorporateRoutes.trainingHubDashboard,
      builder: (context) => TrainingDirectorHubScreen(),
    ),
    PrimeCareScreen(
      title: 'Certificates',
      route: CorporateRoutes.trainingDirectorCertificates,
      builder: (context) => TrainingDirectorCertificatesScreen(),
    ),
  ];
}
class ShareholderModule extends PlatformModule {
  @override
  String get moduleId => 'shareholder_module';

  @override
  String get name => 'Shareholder Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.shareholder];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.shareholderIntelligenceDashboard,
      builder: (context) => ShareholderDashboardScreen(),
    ),
  ];
}
class FinanceDirectorModule extends PlatformModule {
  @override
  String get moduleId => 'finance_director_module';

  @override
  String get name => 'FinanceDirector Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.financeDirector];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.financeDirectorDashboard,
      builder: (context) => FinanceDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Cashflow',
      route: CorporateRoutes.financeDirectorCashFlow,
      builder: (context) => FinanceDirectorCashflowScreen(),
    ),
  ];
}
class VolunteerCoordinatorModule extends PlatformModule {
  @override
  String get moduleId => 'volunteer_coordinator_module';

  @override
  String get name => 'VolunteerCoordinator Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.volunteerCoordinator];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.volunteerCoordinatorDashboard,
      builder: (context) => VolunteerCoordinatorDashboardScreen(),
    ),
  ];
}
class HrManagerModule extends PlatformModule {
  @override
  String get moduleId => 'hr_manager_module';

  @override
  String get name => 'HrManager Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.hrManager];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.hrManagerDashboard,
      builder: (context) => HrManagerDashboardScreen(),
    ),
  ];
}
class HrHiringModule extends PlatformModule {
  @override
  String get moduleId => 'hr_hiring_module';

  @override
  String get name => 'HrHiring Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.hrHiring];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.hrHiringDashboard,
      builder: (context) => HrHiringDashboardScreen(),
    ),
  ];
}
class HrDirectorModule extends PlatformModule {
  @override
  String get moduleId => 'hr_director_module';

  @override
  String get name => 'HrDirector Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.hrDirector];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.hrDirectorDashboard,
      builder: (context) => HrDirectorDashboardScreen(),
    ),
  ];
}
class CxDirectorModule extends PlatformModule {
  @override
  String get moduleId => 'cx_director_module';

  @override
  String get name => 'CxDirector Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.cxDirector];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.cxDirectorDashboard,
      builder: (context) => CxDirectorDashboardScreen(),
    ),
  ];
}
class ItAdminModule extends PlatformModule {
  @override
  String get moduleId => 'it_admin_module';

  @override
  String get name => 'ItAdmin Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.itAdmin];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.itAdminDashboard,
      builder: (context) => ItAdminDashboardScreen(),
    ),
  ];
}
class LegalModule extends PlatformModule {
  @override
  String get moduleId => 'legal_module';

  @override
  String get name => 'Legal Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.legal];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.legalDashboard,
      builder: (context) => LegalDashboardScreen(),
    ),
  ];
}
class CisoModule extends PlatformModule {
  @override
  String get moduleId => 'ciso_module';

  @override
  String get name => 'Ciso Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.ciso];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: CorporateRoutes.cisoDashboard,
      builder: (context) => CisoDashboardScreen(),
    ),
  ];
}
class CorporateApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_corporate';
  @override
  String get name => 'PrimeCare Corporate Portal';
  String get homeRoute => CorporateRoutes.ceoDashboard;
  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
    PlatformRoleDefinition(
      role: PlatformRole.ceo,
      dashboardRoute: CorporateRoutes.ceoDashboard,
      modules: [CeoModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.owner,
      dashboardRoute: CorporateRoutes.ownerDashboard,
      modules: [OwnerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.coo,
      dashboardRoute: CorporateRoutes.cooDashboard,
      modules: [CooModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.cfo,
      dashboardRoute: CorporateRoutes.cfoDashboard,
      modules: [CfoModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.cto,
      dashboardRoute: CorporateRoutes.ctoDashboard,
      modules: [CtoModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.complianceManager,
      dashboardRoute: CorporateRoutes.complianceManagerDashboard,
      modules: [ComplianceManagerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.headOfBusDev,
      dashboardRoute: CorporateRoutes.headOfBusDevDashboard,
      modules: [HeadOfBusDevModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.headOfMarketing,
      dashboardRoute: CorporateRoutes.headOfMarketingDashboard,
      modules: [HeadOfMarketingModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.trainingDirector,
      dashboardRoute: CorporateRoutes.trainingDirectorDashboard,
      modules: [TrainingDirectorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.shareholder,
      dashboardRoute: CorporateRoutes.shareholderIntelligenceDashboard,
      modules: [ShareholderModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.financeDirector,
      dashboardRoute: CorporateRoutes.financeDirectorDashboard,
      modules: [FinanceDirectorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.volunteerCoordinator,
      dashboardRoute: CorporateRoutes.volunteerCoordinatorDashboard,
      modules: [VolunteerCoordinatorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.hrManager,
      dashboardRoute: CorporateRoutes.hrManagerDashboard,
      modules: [HrManagerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.hrHiring,
      dashboardRoute: CorporateRoutes.hrHiringDashboard,
      modules: [HrHiringModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.hrDirector,
      dashboardRoute: CorporateRoutes.hrDirectorDashboard,
      modules: [HrDirectorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.cxDirector,
      dashboardRoute: CorporateRoutes.cxDirectorDashboard,
      modules: [CxDirectorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.itAdmin,
      dashboardRoute: CorporateRoutes.itAdminDashboard,
      modules: [ItAdminModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.legal,
      dashboardRoute: CorporateRoutes.legalDashboard,
      modules: [LegalModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.ciso,
      dashboardRoute: CorporateRoutes.cisoDashboard,
      modules: [CisoModule()],
    ),
  ];
}
