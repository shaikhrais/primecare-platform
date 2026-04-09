import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';














































final List<RouteBase> franchiseRoutes = [
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const FranchiseOwnerDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDashboard,
    builder: (context, state) => const OperationsManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerDashboard,
    builder: (context, state) => const SchedulerDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) => const BillingAdminDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringDashboard,
    builder: (context, state) => const HrHiringDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerBranchOverview,
    builder: (context, state) => const FranchiseOwnerBranchOverviewScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
    builder: (context, state) => const FranchiseOwnerFinancialSnapshotScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerStaff,
    builder: (context, state) => const FranchiseOwnerStaffScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerAppointments,
    builder: (context, state) => const FranchiseOwnerAppointmentsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerClients,
    builder: (context, state) => const FranchiseOwnerClientsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerCompliance,
    builder: (context, state) => const FranchiseOwnerComplianceScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerReports,
    builder: (context, state) => const FranchiseOwnerReportsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerHiring,
    builder: (context, state) => const FranchiseOwnerHiringScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerDailyOperations,
    builder: (context, state) => const OperationsManagerDailyOperationsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerSchedule,
    builder: (context, state) => const OperationsManagerScheduleScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerShifts,
    builder: (context, state) => const OperationsManagerShiftsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerIssues,
    builder: (context, state) => const OperationsManagerIssuesScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerServiceQuality,
    builder: (context, state) => const OperationsManagerServiceQualityScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerStaffCoordination,
    builder: (context, state) => const OperationsManagerStaffCoordinationScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerAttendance,
    builder: (context, state) => const OperationsManagerAttendanceScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.operationsManagerReports,
    builder: (context, state) => const OperationsManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAppointmentCalendar,
    builder: (context, state) => const SchedulerCoordinatorAppointmentCalendarScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorShiftCalendar,
    builder: (context, state) => const SchedulerCoordinatorShiftCalendarScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorProviderAvailability,
    builder: (context, state) => const SchedulerCoordinatorProviderAvailabilityScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorBookingRequests,
    builder: (context, state) => const SchedulerCoordinatorBookingRequestsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorOpenShifts,
    builder: (context, state) => const SchedulerCoordinatorOpenShiftsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorAssignments,
    builder: (context, state) => const SchedulerCoordinatorAssignmentsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.schedulerCoordinatorConflicts,
    builder: (context, state) => const SchedulerCoordinatorConflictsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminInvoices,
    builder: (context, state) => const AdminInvoicesScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminPayments,
    builder: (context, state) => const AdminPaymentsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminClaims,
    builder: (context, state) => const AdminClaimsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReconciliation,
    builder: (context, state) => const AdminReconciliationScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminOutstandingBalances,
    builder: (context, state) => const AdminOutstandingBalancesScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminRefunds,
    builder: (context, state) => const AdminRefundsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.adminReports,
    builder: (context, state) => const AdminReportsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringApplicants,
    builder: (context, state) => const HrHiringApplicantsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringInterviews,
    builder: (context, state) => const HrHiringInterviewsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOffers,
    builder: (context, state) => const HrHiringOffersScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringOnboarding,
    builder: (context, state) => const HrHiringOnboardingScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringStaffDocuments,
    builder: (context, state) => const HrHiringStaffDocumentsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringCredentials,
    builder: (context, state) => const HrHiringCredentialsScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringTrainingStatus,
    builder: (context, state) => const HrHiringTrainingStatusScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.hrHiringReports,
    builder: (context, state) => const HrHiringReportsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachReports,
    builder: (context, state) => const CommunityOutreachReportsScreenStitch(),
  ),
];

