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

final List<ScreenConfig> franchiseScreenRegistry = [
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerDashboard,
    titleKey: 'Franchise Owner Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerDashboard,
    titleKey: 'Operations Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerDashboard,
    titleKey: 'Scheduler Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.billingAdminDashboard,
    titleKey: 'Billing Admin Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'billingAdminDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringDashboard,
    titleKey: 'Hr Hiring Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringDashboard',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerBranchOverview,
    titleKey: 'Franchise Owner Branch Overview',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerBranchOverview',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
    titleKey: 'Franchise Owner Financial Snapshot',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerFinancialSnapshot',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerStaff,
    titleKey: 'Franchise Owner Staff',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerStaff',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerAppointments,
    titleKey: 'Franchise Owner Appointments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerAppointments',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerClients,
    titleKey: 'Franchise Owner Clients',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerClients',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerCompliance,
    titleKey: 'Franchise Owner Compliance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerCompliance',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerReports,
    titleKey: 'Franchise Owner Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerReports',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerHiring,
    titleKey: 'Franchise Owner Hiring',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseOwnerHiring',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerDailyOperations,
    titleKey: 'Operations Manager Daily Operations',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerDailyOperations',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerSchedule,
    titleKey: 'Operations Manager Schedule',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerSchedule',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerShifts,
    titleKey: 'Operations Manager Shifts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerShifts',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerIssues,
    titleKey: 'Operations Manager Issues',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerIssues',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerServiceQuality,
    titleKey: 'Operations Manager Service Quality',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerServiceQuality',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerStaffCoordination,
    titleKey: 'Operations Manager Staff Coordination',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerStaffCoordination',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerAttendance,
    titleKey: 'Operations Manager Attendance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerAttendance',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerReports,
    titleKey: 'Operations Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'operationsManagerReports',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
    titleKey: 'Scheduler Coordinator Appointment Calendar',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorAppointmentCalendar',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
    titleKey: 'Scheduler Coordinator Shift Calendar',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorShiftCalendar',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
    titleKey: 'Scheduler Coordinator Provider Availability',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorProviderAvailability',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorBookingRequests,
    titleKey: 'Scheduler Coordinator Booking Requests',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorBookingRequests',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorOpenShifts,
    titleKey: 'Scheduler Coordinator Open Shifts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorOpenShifts',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorAssignments,
    titleKey: 'Scheduler Coordinator Assignments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorAssignments',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.schedulerCoordinatorConflicts,
    titleKey: 'Scheduler Coordinator Conflicts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerCoordinatorConflicts',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminInvoices,
    titleKey: 'Admin Invoices',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminInvoices',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminPayments,
    titleKey: 'Admin Payments',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminPayments',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminClaims,
    titleKey: 'Admin Claims',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminClaims',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminReconciliation,
    titleKey: 'Admin Reconciliation',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminReconciliation',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminOutstandingBalances,
    titleKey: 'Admin Outstanding Balances',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminOutstandingBalances',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminRefunds,
    titleKey: 'Admin Refunds',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminRefunds',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.adminReports,
    titleKey: 'Admin Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'adminReports',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringApplicants,
    titleKey: 'Hr Hiring Applicants',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringApplicants',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringInterviews,
    titleKey: 'Hr Hiring Interviews',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringInterviews',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringOffers,
    titleKey: 'Hr Hiring Offers',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringOffers',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringOnboarding,
    titleKey: 'Hr Hiring Onboarding',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringOnboarding',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringStaffDocuments,
    titleKey: 'Hr Hiring Staff Documents',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringStaffDocuments',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringCredentials,
    titleKey: 'Hr Hiring Credentials',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringCredentials',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringTrainingStatus,
    titleKey: 'Hr Hiring Training Status',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringTrainingStatus',
  ),
  ScreenConfig(
    routePath: FranchiseRoutes.hrHiringReports,
    titleKey: 'Hr Hiring Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'hrHiringReports',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachReports,
    titleKey: 'Community Outreach Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachReports',
  ),
];

final List<RouteBase> franchiseRoutes = franchiseScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
