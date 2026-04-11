import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> franchiseRoutes = [
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const FranchiseOwnerDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDashboard,
    builder: (context, state) => const OperationsManagerDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerDashboard,
    builder: (context, state) => const SchedulerDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) => const BillingAdminDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringDashboard,
    builder: (context, state) => const HrHiringDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerBranchOverview,
    builder: (context, state) =>
        const FranchiseOwnerBranchOverviewScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
    builder: (context, state) =>
        const FranchiseOwnerFinancialSnapshotScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerStaff,
    builder: (context, state) => const FranchiseOwnerStaffScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerAppointments,
    builder: (context, state) => const FranchiseOwnerAppointmentsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerClients,
    builder: (context, state) => const FranchiseOwnerClientsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerCompliance,
    builder: (context, state) => const FranchiseOwnerComplianceScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerReports,
    builder: (context, state) => const FranchiseOwnerReportsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerHiring,
    builder: (context, state) => const FranchiseOwnerHiringScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDailyOperations,
    builder: (context, state) =>
        const OperationsManagerDailyOperationsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerSchedule,
    builder: (context, state) => const OperationsManagerScheduleScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerShifts,
    builder: (context, state) => const OperationsManagerShiftsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerIssues,
    builder: (context, state) => const OperationsManagerIssuesScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerServiceQuality,
    builder: (context, state) =>
        const OperationsManagerServiceQualityScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerStaffCoordination,
    builder: (context, state) =>
        const OperationsManagerStaffCoordinationScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerAttendance,
    builder: (context, state) =>
        const OperationsManagerAttendanceScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerReports,
    builder: (context, state) => const OperationsManagerReportsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
    builder: (context, state) =>
        const SchedulerCoordinatorAppointmentCalendarScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
    builder: (context, state) =>
        const SchedulerCoordinatorShiftCalendarScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
    builder: (context, state) =>
        const SchedulerCoordinatorProviderAvailabilityScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorBookingRequests,
    builder: (context, state) =>
        const SchedulerCoordinatorBookingRequestsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorOpenShifts,
    builder: (context, state) =>
        const SchedulerCoordinatorOpenShiftsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAssignments,
    builder: (context, state) =>
        const SchedulerCoordinatorAssignmentsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorConflicts,
    builder: (context, state) =>
        const SchedulerCoordinatorConflictsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminInvoices,
    builder: (context, state) => const FranchiseInvoicesScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminPayments,
    builder: (context, state) => const FranchisePaymentsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminClaims,
    builder: (context, state) => const FranchiseClaimsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReconciliation,
    builder: (context, state) => const FranchiseReconciliationScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminOutstandingBalances,
    builder: (context, state) => const FranchiseOutstandingBalancesScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminRefunds,
    builder: (context, state) => const FranchiseRefundsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReports,
    builder: (context, state) => const FranchiseReportsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringApplicants,
    builder: (context, state) => const HrHiringApplicantsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringInterviews,
    builder: (context, state) => const HrHiringInterviewsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOffers,
    builder: (context, state) => const HrHiringOffersScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOnboarding,
    builder: (context, state) => const HrHiringOnboardingScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringStaffDocuments,
    builder: (context, state) => const HrHiringStaffDocumentsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringCredentials,
    builder: (context, state) => const HrHiringCredentialsScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringTrainingStatus,
    builder: (context, state) => const HrHiringTrainingStatusScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringReports,
    builder: (context, state) => const HrHiringReportsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachReports,
    builder: (context, state) => const CommunityOutreachDashboard(),
  ),
];
