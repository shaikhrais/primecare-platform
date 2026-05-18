import 'package:primecare_ui/primecare_ui.dart' hide ShareholderDashboardScreen, FinanceDirectorDashboardScreen, VolunteerCoordinatorDashboardScreen, HrManagerDashboardScreen, HrHiringDashboardScreen, HrDirectorDashboardScreen, CxDirectorDashboardScreen, LegalDashboardScreen, CisoDashboardScreen, OwnerDashboardScreen, CooDashboardScreen, CfoDashboardScreen, CtoDashboardScreen, ComplianceManagerDashboardScreen, HeadOfBusDevDashboardScreen, HeadOfMarketingDashboardScreen, TrainingDirectorDashboardScreen;
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
      builder: (context) => const CeoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Enterprise Overview',
      route: CorporateRoutes.ceoEnterpriseOverview,
      builder: (context) => const CeoEnterpriseOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Overview',
      route: CorporateRoutes.ceoFranchiseOverview,
      builder: (context) => const CeoFranchiseOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Region Performance',
      route: CorporateRoutes.ceoRegionPerformance,
      builder: (context) => const CeoRegionPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Revenue Summary',
      route: CorporateRoutes.ceoRevenueSummary,
      builder: (context) => const CeoRevenueSummaryScreen(),
    ),
    PrimeCareScreen(
      title: 'Strategic Kpis',
      route: CorporateRoutes.ceoStrategicKpis,
      builder: (context) => const CeoStrategicKpisScreen(),
    ),
    PrimeCareScreen(
      title: 'Growth Pipeline',
      route: CorporateRoutes.ceoGrowthPipeline,
      builder: (context) => const CeoGrowthPipelineScreen(),
    ),
    PrimeCareScreen(
      title: 'Leadership Reports',
      route: CorporateRoutes.ceoLeadershipReports,
      builder: (context) => const CeoLeadershipReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Alerts And Risks',
      route: CorporateRoutes.ceoAlertsAndRisks,
      builder: (context) => const CeoAlertsAndRisksScreen(),
    ),
    PrimeCareScreen(
      title: 'Organization Map',
      route: CorporateRoutes.ceoOrganizationMap,
      builder: (context) => const CeoOrganizationMapScreen(),
    ),
    PrimeCareScreen(
      title: 'Approvals',
      route: CorporateRoutes.ceoApprovals,
      builder: (context) => const CeoApprovalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.ceoReports,
      builder: (context) => const CeoReportsScreen(),
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
      builder: (context) => const OwnerDashboardScreen(),
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
      builder: (context) => const CooDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Operations Overview',
      route: CorporateRoutes.cooOperationsOverview,
      builder: (context) => const CooOperationsOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Operations',
      route: CorporateRoutes.cooBranchOperations,
      builder: (context) => const CooBranchOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staffing Efficiency',
      route: CorporateRoutes.cooStaffingEfficiency,
      builder: (context) => const CooStaffingEfficiencyScreen(),
    ),
    PrimeCareScreen(
      title: 'Scheduling Health',
      route: CorporateRoutes.cooSchedulingHealth,
      builder: (context) => const CooSchedulingHealthScreen(),
    ),
    PrimeCareScreen(
      title: 'Service Delivery',
      route: CorporateRoutes.cooServiceDelivery,
      builder: (context) => const CooServiceDeliveryScreen(),
    ),
    PrimeCareScreen(
      title: 'Issue Escalations',
      route: CorporateRoutes.cooIssueEscalations,
      builder: (context) => const CooIssueEscalationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance View',
      route: CorporateRoutes.cooComplianceView,
      builder: (context) => const CooComplianceViewScreen(),
    ),
    PrimeCareScreen(
      title: 'Workflow Performance',
      route: CorporateRoutes.cooWorkflowPerformance,
      builder: (context) => const CooWorkflowPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Comparison',
      route: CorporateRoutes.cooBranchComparison,
      builder: (context) => const CooBranchComparisonScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.cooReports,
      builder: (context) => const CooReportsScreen(),
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
      builder: (context) => const CfoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Financial Overview',
      route: CorporateRoutes.cfoFinancialOverview,
      builder: (context) => const CfoFinancialOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Revenue',
      route: CorporateRoutes.cfoRevenue,
      builder: (context) => const CfoRevenueScreen(),
    ),
    PrimeCareScreen(
      title: 'Expenses',
      route: CorporateRoutes.cfoExpenses,
      builder: (context) => const CfoExpensesScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Financials',
      route: CorporateRoutes.cfoFranchiseFinancials,
      builder: (context) => const CfoFranchiseFinancialsScreen(),
    ),
    PrimeCareScreen(
      title: 'Payroll',
      route: CorporateRoutes.cfoPayroll,
      builder: (context) => const CfoPayrollScreen(),
    ),
    PrimeCareScreen(
      title: 'Accounts Receivable',
      route: CorporateRoutes.cfoAccountsReceivable,
      builder: (context) => const CfoAccountsReceivableScreen(),
    ),
    PrimeCareScreen(
      title: 'Accounts Payable',
      route: CorporateRoutes.cfoAccountsPayable,
      builder: (context) => const CfoAccountsPayableScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: CorporateRoutes.cfoInvoices,
      builder: (context) => const CfoInvoicesScreen(),
    ),
    PrimeCareScreen(
      title: 'Profitability',
      route: CorporateRoutes.cfoProfitability,
      builder: (context) => const CfoProfitabilityScreen(),
    ),
    PrimeCareScreen(
      title: 'Tax And Remittance',
      route: CorporateRoutes.cfoTaxAndRemittance,
      builder: (context) => const CfoTaxAndRemittanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.cfoReports,
      builder: (context) => const CfoReportsScreen(),
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
      builder: (context) => const CtoDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'System Health',
      route: CorporateRoutes.ctoSystemHealth,
      builder: (context) => const CtoSystemHealthScreen(),
    ),
    PrimeCareScreen(
      title: 'Platform Usage',
      route: CorporateRoutes.ctoPlatformUsage,
      builder: (context) => const CtoPlatformUsageScreen(),
    ),
    PrimeCareScreen(
      title: 'Feature Adoption',
      route: CorporateRoutes.ctoFeatureAdoption,
      builder: (context) => const CtoFeatureAdoptionScreen(),
    ),
    PrimeCareScreen(
      title: 'Api Monitoring',
      route: CorporateRoutes.ctoApiMonitoring,
      builder: (context) => const CtoApiMonitoringScreen(),
    ),
    PrimeCareScreen(
      title: 'Integrations',
      route: CorporateRoutes.ctoIntegrations,
      builder: (context) => const CtoIntegrationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Audit Logs',
      route: CorporateRoutes.ctoAuditLogs,
      builder: (context) => const CtoAuditLogsScreen(),
    ),
    PrimeCareScreen(
      title: 'Access Control',
      route: CorporateRoutes.ctoAccessControl,
      builder: (context) => const CtoAccessControlScreen(),
    ),
    PrimeCareScreen(
      title: 'Release Management',
      route: CorporateRoutes.ctoReleaseManagement,
      builder: (context) => const CtoReleaseManagementScreen(),
    ),
    PrimeCareScreen(
      title: 'Issue Tracking',
      route: CorporateRoutes.ctoIssueTracking,
      builder: (context) => const CtoIssueTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Infrastructure',
      route: CorporateRoutes.ctoInfrastructure,
      builder: (context) => const CtoInfrastructureScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.ctoReports,
      builder: (context) => const CtoReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Verification Hub',
      route: CorporateRoutes.ctoVerificationHub,
      builder: (context) => const CtoVerificationHubScreen(),
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: CorporateRoutes.systemVerificationDashboard,
      builder: (context) => const CtoSystemVerificationScreen(),
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
      builder: (context) => const ComplianceManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Cases',
      route: CorporateRoutes.complianceManagerComplianceCases,
      builder: (context) => const ComplianceManagerComplianceCasesScreen(),
    ),
    PrimeCareScreen(
      title: 'Policies',
      route: CorporateRoutes.complianceManagerPolicies,
      builder: (context) => const ComplianceManagerPoliciesScreen(),
    ),
    PrimeCareScreen(
      title: 'Audits',
      route: CorporateRoutes.complianceManagerAudits,
      builder: (context) => const ComplianceManagerAuditsScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Review',
      route: CorporateRoutes.complianceManagerIncidentReview,
      builder: (context) => const ComplianceManagerIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Credential Tracking',
      route: CorporateRoutes.complianceManagerCredentialTracking,
      builder: (context) => const ComplianceManagerCredentialTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Document Expiry',
      route: CorporateRoutes.complianceManagerDocumentExpiry,
      builder: (context) => const ComplianceManagerDocumentExpiryScreen(),
    ),
    PrimeCareScreen(
      title: 'Risk Register',
      route: CorporateRoutes.complianceManagerRiskRegister,
      builder: (context) => const ComplianceManagerRiskRegisterScreen(),
    ),
    PrimeCareScreen(
      title: 'Corrective Actions',
      route: CorporateRoutes.complianceManagerCorrectiveActions,
      builder: (context) => const ComplianceManagerCorrectiveActionsScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Compliance',
      route: CorporateRoutes.complianceManagerTrainingCompliance,
      builder: (context) => const ComplianceManagerTrainingComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.complianceManagerReports,
      builder: (context) => const ComplianceManagerReportsScreen(),
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
      builder: (context) => const HeadOfBusDevDashboardScreen(),
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
      builder: (context) => const HeadOfMarketingDashboardScreen(),
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
      builder: (context) => const TrainingDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Programs',
      route: CorporateRoutes.trainingDirectorTrainingPrograms,
      builder: (context) => const TrainingDirectorTrainingProgramsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Training Matrix',
      route: CorporateRoutes.trainingDirectorStaffTrainingMatrix,
      builder: (context) => const TrainingDirectorStaffTrainingMatrixScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Training',
      route: CorporateRoutes.trainingDirectorComplianceTraining,
      builder: (context) => const TrainingDirectorComplianceTrainingScreen(),
    ),
    PrimeCareScreen(
      title: 'Course Library',
      route: CorporateRoutes.trainingDirectorCourseLibrary,
      builder: (context) => const TrainingDirectorCourseLibraryScreen(),
    ),
    PrimeCareScreen(
      title: 'Assessments',
      route: CorporateRoutes.trainingDirectorAssessments,
      builder: (context) => const TrainingDirectorAssessmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Certifications',
      route: CorporateRoutes.trainingDirectorCertifications,
      builder: (context) => const TrainingDirectorCertificationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Trainer Assignments',
      route: CorporateRoutes.trainingDirectorTrainerAssignments,
      builder: (context) => const TrainingDirectorTrainerAssignmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: CorporateRoutes.trainingDirectorReports,
      builder: (context) => const TrainingDirectorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Analytics',
      route: CorporateRoutes.trainingDirectorAnalytics,
      builder: (context) => const TrainingDirectorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Course Architect',
      route: CorporateRoutes.courseArchitectDashboard,
      builder: (context) => const TrainingDirectorCourseArchitectScreen(),
    ),
    PrimeCareScreen(
      title: 'Hub',
      route: CorporateRoutes.trainingHubDashboard,
      builder: (context) => const TrainingDirectorHubScreen(),
    ),
    PrimeCareScreen(
      title: 'Certificates',
      route: CorporateRoutes.trainingDirectorCertificates,
      builder: (context) => const TrainingDirectorCertificatesScreen(),
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
      builder: (context) => const ShareholderDashboardScreen(),
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
      builder: (context) => const FinanceDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Cashflow',
      route: CorporateRoutes.financeDirectorCashFlow,
      builder: (context) => const FinanceDirectorCashflowScreen(),
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
      builder: (context) => const VolunteerCoordinatorDashboardScreen(),
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
      builder: (context) => const HrManagerDashboardScreen(),
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
      builder: (context) => const HrHiringDashboardScreen(),
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
      builder: (context) => const HrDirectorDashboardScreen(),
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
      builder: (context) => const CxDirectorDashboardScreen(),
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
      builder: (context) => const ItAdminDashboardScreen(),
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
      builder: (context) => const LegalDashboardScreen(),
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
      builder: (context) => const CisoDashboardScreen(),
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
