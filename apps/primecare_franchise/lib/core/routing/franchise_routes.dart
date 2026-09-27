// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart' hide HrHiringDashboardScreen, OperationsManagerDashboardScreen, SchedulerDashboardScreen, BillingAdminDashboardScreen, FranchiseOwnerBranchOverviewScreen, FranchiseOwnerStaffScreen, FranchiseOwnerAppointmentsScreen, FranchiseOwnerClientsScreen, FranchiseOwnerComplianceScreen, FranchiseOwnerReportsScreen, HrHiringApplicantsScreen, HrHiringInterviewsScreen, HrHiringOffersScreen, HrHiringOnboardingScreen, HrHiringCredentialsScreen;
import 'package:flutter_core/flutter_core.dart';
import '../../features/franchise/presentation/widgets/widgets.dart';

class FranchiseOwnerModule extends PlatformModule {
  @override
  String get moduleId => 'franchise_owner_module';

  @override
  String get name => 'FranchiseOwner Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.franchiseOwner];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.franchiseOwnerDashboard,
      builder: (context) => FranchiseOwnerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Overview',
      route: FranchiseRoutes.franchiseOwnerBranchOverview,
      builder: (context) => FranchiseOwnerBranchOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Financial Snapshot',
      route: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
      builder: (context) => FranchiseOwnerFinancialSnapshotScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff',
      route: FranchiseRoutes.franchiseOwnerStaff,
      builder: (context) => FranchiseOwnerStaffScreen(),
    ),
    PrimeCareScreen(
      title: 'Appointments',
      route: FranchiseRoutes.franchiseOwnerAppointments,
      builder: (context) => FranchiseOwnerAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clients',
      route: FranchiseRoutes.franchiseOwnerClients,
      builder: (context) => FranchiseOwnerClientsScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance',
      route: FranchiseRoutes.franchiseOwnerCompliance,
      builder: (context) => FranchiseOwnerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.franchiseOwnerReports,
      builder: (context) => FranchiseOwnerReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Hiring',
      route: FranchiseRoutes.franchiseOwnerHiring,
      builder: (context) => FranchiseOwnerHiringScreen(),
    ),
  ];
}

class OperationsManagerModule extends PlatformModule {
  @override
  String get moduleId => 'operations_manager_module';

  @override
  String get name => 'OperationsManager Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.operationsManager];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.operationsManagerDashboard,
      builder: (context) => OperationsManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Daily Operations',
      route: FranchiseRoutes.operationsManagerDailyOperations,
      builder: (context) => OperationsManagerDailyOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Schedule',
      route: FranchiseRoutes.operationsManagerSchedule,
      builder: (context) => OperationsManagerScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Shifts',
      route: FranchiseRoutes.operationsManagerShifts,
      builder: (context) => OperationsManagerShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Issues',
      route: FranchiseRoutes.operationsManagerIssues,
      builder: (context) => OperationsManagerIssuesScreen(),
    ),
    PrimeCareScreen(
      title: 'Service Quality',
      route: FranchiseRoutes.operationsManagerServiceQuality,
      builder: (context) => OperationsManagerServiceQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Coordination',
      route: FranchiseRoutes.operationsManagerStaffCoordination,
      builder: (context) => OperationsManagerStaffCoordinationScreen(),
    ),
    PrimeCareScreen(
      title: 'Attendance',
      route: FranchiseRoutes.operationsManagerAttendance,
      builder: (context) => OperationsManagerAttendanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.operationsManagerReports,
      builder: (context) => OperationsManagerReportsScreen(),
    ),
  ];
}

class SchedulerModule extends PlatformModule {
  @override
  String get moduleId => 'scheduler_module';

  @override
  String get name => 'Scheduler Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.scheduler];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.schedulerDashboard,
      builder: (context) => SchedulerDashboardScreen(),
    ),
  ];
}

class BillingAdminModule extends PlatformModule {
  @override
  String get moduleId => 'billing_admin_module';

  @override
  String get name => 'BillingAdmin Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.billingAdmin];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.billingAdminDashboard,
      builder: (context) => BillingAdminDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: FranchiseRoutes.billingAdminInvoices,
      builder: (context) => BillingAdminInvoicesScreen(),
    ),
  ];
}

class HrHiringModule extends PlatformModule {
  @override
  String get moduleId => 'hr_hiring_module';

  @override
  String get name => 'HrHiring Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.hrHiring];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.hrHiringDashboard,
      builder: (context) => HrHiringDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Applicants',
      route: FranchiseRoutes.hrHiringApplicants,
      builder: (context) => HrHiringApplicantsScreen(),
    ),
    PrimeCareScreen(
      title: 'Interviews',
      route: FranchiseRoutes.hrHiringInterviews,
      builder: (context) => HrHiringInterviewsScreen(),
    ),
    PrimeCareScreen(
      title: 'Offers',
      route: FranchiseRoutes.hrHiringOffers,
      builder: (context) => HrHiringOffersScreen(),
    ),
    PrimeCareScreen(
      title: 'Onboarding',
      route: FranchiseRoutes.hrHiringOnboarding,
      builder: (context) => HrHiringOnboardingScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Documents',
      route: FranchiseRoutes.hrHiringStaffDocuments,
      builder: (context) => HrHiringStaffDocumentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Credentials',
      route: FranchiseRoutes.hrHiringCredentials,
      builder: (context) => HrHiringCredentialsScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Status',
      route: FranchiseRoutes.hrHiringTrainingStatus,
      builder: (context) => HrHiringTrainingStatusScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.hrHiringReports,
      builder: (context) => HrHiringReportsScreen(),
    ),
  ];
}

class SchedulerCoordinatorModule extends PlatformModule {
  @override
  String get moduleId => 'scheduler_coordinator_module';

  @override
  String get name => 'SchedulerCoordinator Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.scheduler];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Appointment Calendar',
      route: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
      builder: (context) => SchedulerCoordinatorAppointmentCalendarScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Calendar',
      route: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
      builder: (context) => SchedulerCoordinatorShiftCalendarScreen(),
    ),
    PrimeCareScreen(
      title: 'Provider Availability',
      route: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
      builder: (context) => SchedulerCoordinatorProviderAvailabilityScreen(),
    ),
    PrimeCareScreen(
      title: 'Booking Requests',
      route: FranchiseRoutes.schedulerCoordinatorBookingRequests,
      builder: (context) => SchedulerCoordinatorBookingRequestsScreen(),
    ),
    PrimeCareScreen(
      title: 'Open Shifts',
      route: FranchiseRoutes.schedulerCoordinatorOpenShifts,
      builder: (context) => SchedulerCoordinatorOpenShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Assignments',
      route: FranchiseRoutes.schedulerCoordinatorAssignments,
      builder: (context) => SchedulerCoordinatorAssignmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Conflicts',
      route: FranchiseRoutes.schedulerCoordinatorConflicts,
      builder: (context) => SchedulerCoordinatorConflictsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.schedulerCoordinatorReports,
      builder: (context) => SchedulerCoordinatorReportsScreen(),
    ),
  ];
}

class AdminModule extends PlatformModule {
  @override
  String get moduleId => 'admin_module';

  @override
  String get name => 'Admin Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.itAdmin];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.adminDashboard,
      builder: (context) => AdminDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: FranchiseRoutes.adminInvoices,
      builder: (context) => AdminInvoicesScreen(),
    ),
    PrimeCareScreen(
      title: 'Payments',
      route: FranchiseRoutes.adminPayments,
      builder: (context) => AdminPaymentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Claims',
      route: FranchiseRoutes.adminClaims,
      builder: (context) => AdminClaimsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reconciliation',
      route: FranchiseRoutes.adminReconciliation,
      builder: (context) => AdminReconciliationScreen(),
    ),
    PrimeCareScreen(
      title: 'Outstanding Balances',
      route: FranchiseRoutes.adminOutstandingBalances,
      builder: (context) => AdminOutstandingBalancesScreen(),
    ),
    PrimeCareScreen(
      title: 'Refunds',
      route: FranchiseRoutes.adminRefunds,
      builder: (context) => AdminRefundsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.adminReports,
      builder: (context) => AdminReportsScreen(),
    ),
  ];
}

class RegionalManagerModule extends PlatformModule {
  @override
  String get moduleId => 'regional_manager_module';

  @override
  String get name => 'RegionalManager Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.regionalManagerOntario];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.regionalManagerDashboard,
      builder: (context) => RegionalManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Comparison',
      route: FranchiseRoutes.regionalManagerBranchComparison,
      builder: (context) => RegionalManagerBranchComparisonScreen(),
    ),
  ];
}

class MarketingManagerModule extends PlatformModule {
  @override
  String get moduleId => 'marketing_manager_module';

  @override
  String get name => 'MarketingManager Dashboard';

  @override
  IconData get icon => LucideIcons.building;

  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.localMarketingManager];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Dashboard',
      route: FranchiseRoutes.marketingManagerDashboard,
      builder: (context) => MarketingManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Campaigns',
      route: FranchiseRoutes.marketingManagerCampaigns,
      builder: (context) => MarketingManagerCampaignsScreen(),
    ),
  ];
}

class FranchiseApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_franchise';
  @override
  String get name => 'PrimeCare Franchise Portal';
  String get homeRoute => FranchiseRoutes.franchiseOwnerDashboard;
  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
    PlatformRoleDefinition(
      role: PlatformRole.franchiseOwner,
      dashboardRoute: FranchiseRoutes.franchiseOwnerDashboard,
      modules: [FranchiseOwnerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.operationsManager,
      dashboardRoute: FranchiseRoutes.operationsManagerDashboard,
      modules: [OperationsManagerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.scheduler,
      dashboardRoute: FranchiseRoutes.schedulerDashboard,
      modules: [SchedulerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.billingAdmin,
      dashboardRoute: FranchiseRoutes.billingAdminDashboard,
      modules: [BillingAdminModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.hrHiring,
      dashboardRoute: FranchiseRoutes.hrHiringDashboard,
      modules: [HrHiringModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.scheduler,
      dashboardRoute: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
      modules: [SchedulerCoordinatorModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.itAdmin,
      dashboardRoute: FranchiseRoutes.adminDashboard,
      modules: [AdminModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.regionalManagerOntario,
      dashboardRoute: FranchiseRoutes.regionalManagerDashboard,
      modules: [RegionalManagerModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.localMarketingManager,
      dashboardRoute: FranchiseRoutes.marketingManagerDashboard,
      modules: [MarketingManagerModule()],
    ),
  ];
}
