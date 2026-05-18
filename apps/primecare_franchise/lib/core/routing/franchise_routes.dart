import 'package:primecare_ui/primecare_ui.dart' hide HrHiringDashboardScreen, OperationsManagerDashboardScreen, SchedulerDashboardScreen, BillingAdminDashboardScreen;
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
      builder: (context) => const FranchiseOwnerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Overview',
      route: FranchiseRoutes.franchiseOwnerBranchOverview,
      builder: (context) => const FranchiseOwnerBranchOverviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Financial Snapshot',
      route: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
      builder: (context) => const FranchiseOwnerFinancialSnapshotScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff',
      route: FranchiseRoutes.franchiseOwnerStaff,
      builder: (context) => const FranchiseOwnerStaffScreen(),
    ),
    PrimeCareScreen(
      title: 'Appointments',
      route: FranchiseRoutes.franchiseOwnerAppointments,
      builder: (context) => const FranchiseOwnerAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clients',
      route: FranchiseRoutes.franchiseOwnerClients,
      builder: (context) => const FranchiseOwnerClientsScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance',
      route: FranchiseRoutes.franchiseOwnerCompliance,
      builder: (context) => const FranchiseOwnerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.franchiseOwnerReports,
      builder: (context) => const FranchiseOwnerReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Hiring',
      route: FranchiseRoutes.franchiseOwnerHiring,
      builder: (context) => const FranchiseOwnerHiringScreen(),
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
      builder: (context) => const OperationsManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Daily Operations',
      route: FranchiseRoutes.operationsManagerDailyOperations,
      builder: (context) => const OperationsManagerDailyOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Schedule',
      route: FranchiseRoutes.operationsManagerSchedule,
      builder: (context) => const OperationsManagerScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Shifts',
      route: FranchiseRoutes.operationsManagerShifts,
      builder: (context) => const OperationsManagerShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Issues',
      route: FranchiseRoutes.operationsManagerIssues,
      builder: (context) => const OperationsManagerIssuesScreen(),
    ),
    PrimeCareScreen(
      title: 'Service Quality',
      route: FranchiseRoutes.operationsManagerServiceQuality,
      builder: (context) => const OperationsManagerServiceQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Coordination',
      route: FranchiseRoutes.operationsManagerStaffCoordination,
      builder: (context) => const OperationsManagerStaffCoordinationScreen(),
    ),
    PrimeCareScreen(
      title: 'Attendance',
      route: FranchiseRoutes.operationsManagerAttendance,
      builder: (context) => const OperationsManagerAttendanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.operationsManagerReports,
      builder: (context) => const OperationsManagerReportsScreen(),
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
      builder: (context) => const SchedulerDashboardScreen(),
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
      builder: (context) => const BillingAdminDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: FranchiseRoutes.billingAdminInvoices,
      builder: (context) => const BillingAdminInvoicesScreen(),
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
      builder: (context) => const HrHiringDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Applicants',
      route: FranchiseRoutes.hrHiringApplicants,
      builder: (context) => const HrHiringApplicantsScreen(),
    ),
    PrimeCareScreen(
      title: 'Interviews',
      route: FranchiseRoutes.hrHiringInterviews,
      builder: (context) => const HrHiringInterviewsScreen(),
    ),
    PrimeCareScreen(
      title: 'Offers',
      route: FranchiseRoutes.hrHiringOffers,
      builder: (context) => const HrHiringOffersScreen(),
    ),
    PrimeCareScreen(
      title: 'Onboarding',
      route: FranchiseRoutes.hrHiringOnboarding,
      builder: (context) => const HrHiringOnboardingScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Documents',
      route: FranchiseRoutes.hrHiringStaffDocuments,
      builder: (context) => const HrHiringStaffDocumentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Credentials',
      route: FranchiseRoutes.hrHiringCredentials,
      builder: (context) => const HrHiringCredentialsScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Status',
      route: FranchiseRoutes.hrHiringTrainingStatus,
      builder: (context) => const HrHiringTrainingStatusScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.hrHiringReports,
      builder: (context) => const HrHiringReportsScreen(),
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
      builder: (context) => const SchedulerCoordinatorAppointmentCalendarScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Calendar',
      route: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
      builder: (context) => const SchedulerCoordinatorShiftCalendarScreen(),
    ),
    PrimeCareScreen(
      title: 'Provider Availability',
      route: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
      builder: (context) => const SchedulerCoordinatorProviderAvailabilityScreen(),
    ),
    PrimeCareScreen(
      title: 'Booking Requests',
      route: FranchiseRoutes.schedulerCoordinatorBookingRequests,
      builder: (context) => const SchedulerCoordinatorBookingRequestsScreen(),
    ),
    PrimeCareScreen(
      title: 'Open Shifts',
      route: FranchiseRoutes.schedulerCoordinatorOpenShifts,
      builder: (context) => const SchedulerCoordinatorOpenShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Assignments',
      route: FranchiseRoutes.schedulerCoordinatorAssignments,
      builder: (context) => const SchedulerCoordinatorAssignmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Conflicts',
      route: FranchiseRoutes.schedulerCoordinatorConflicts,
      builder: (context) => const SchedulerCoordinatorConflictsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.schedulerCoordinatorReports,
      builder: (context) => const SchedulerCoordinatorReportsScreen(),
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
      builder: (context) => const AdminDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Invoices',
      route: FranchiseRoutes.adminInvoices,
      builder: (context) => const AdminInvoicesScreen(),
    ),
    PrimeCareScreen(
      title: 'Payments',
      route: FranchiseRoutes.adminPayments,
      builder: (context) => const AdminPaymentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Claims',
      route: FranchiseRoutes.adminClaims,
      builder: (context) => const AdminClaimsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reconciliation',
      route: FranchiseRoutes.adminReconciliation,
      builder: (context) => const AdminReconciliationScreen(),
    ),
    PrimeCareScreen(
      title: 'Outstanding Balances',
      route: FranchiseRoutes.adminOutstandingBalances,
      builder: (context) => const AdminOutstandingBalancesScreen(),
    ),
    PrimeCareScreen(
      title: 'Refunds',
      route: FranchiseRoutes.adminRefunds,
      builder: (context) => const AdminRefundsScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: FranchiseRoutes.adminReports,
      builder: (context) => const AdminReportsScreen(),
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
      builder: (context) => const RegionalManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Branch Comparison',
      route: FranchiseRoutes.regionalManagerBranchComparison,
      builder: (context) => const RegionalManagerBranchComparisonScreen(),
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
      builder: (context) => const MarketingManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Campaigns',
      route: FranchiseRoutes.marketingManagerCampaigns,
      builder: (context) => const MarketingManagerCampaignsScreen(),
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
