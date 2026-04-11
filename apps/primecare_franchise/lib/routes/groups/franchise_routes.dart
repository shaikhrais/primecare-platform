import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> franchiseRoutes = [
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerBranchOverview,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerStaff,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerAppointments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerClients,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerCompliance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerHiring,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDailyOperations,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerSchedule,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerShifts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerIssues,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerServiceQuality,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerStaffCoordination,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerAttendance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorBookingRequests,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorOpenShifts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAssignments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorConflicts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminInvoices,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminPayments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminClaims,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReconciliation,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminOutstandingBalances,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminRefunds,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringApplicants,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringInterviews,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOffers,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOnboarding,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringStaffDocuments,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringCredentials,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringTrainingStatus,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
