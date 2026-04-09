import 'package:flutter_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';














































final List<RouteBase> franchiseRoutes = [
  GoRoute(
    path: AppRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const FranchiseOwnerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerDashboard,
    builder: (context, state) => const OperationsManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerDashboard,
    builder: (context, state) => const SchedulerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.billingAdminDashboard,
    builder: (context, state) => const BillingAdminDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringDashboard,
    builder: (context, state) => const HrHiringDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerBranchOverview,
    builder: (context, state) => const FranchiseOwnerBranchOverviewScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerFinancialSnapshot,
    builder: (context, state) => const FranchiseOwnerFinancialSnapshotScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerStaff,
    builder: (context, state) => const FranchiseOwnerStaffScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerAppointments,
    builder: (context, state) => const FranchiseOwnerAppointmentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerClients,
    builder: (context, state) => const FranchiseOwnerClientsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerCompliance,
    builder: (context, state) => const FranchiseOwnerComplianceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerReports,
    builder: (context, state) => const FranchiseOwnerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerHiring,
    builder: (context, state) => const FranchiseOwnerHiringScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerDailyOperations,
    builder: (context, state) => const OperationsManagerDailyOperationsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerSchedule,
    builder: (context, state) => const OperationsManagerScheduleScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerShifts,
    builder: (context, state) => const OperationsManagerShiftsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerIssues,
    builder: (context, state) => const OperationsManagerIssuesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerServiceQuality,
    builder: (context, state) => const OperationsManagerServiceQualityScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerStaffCoordination,
    builder: (context, state) => const OperationsManagerStaffCoordinationScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerAttendance,
    builder: (context, state) => const OperationsManagerAttendanceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerReports,
    builder: (context, state) => const OperationsManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorAppointmentCalendar,
    builder: (context, state) => const SchedulerCoordinatorAppointmentCalendarScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorShiftCalendar,
    builder: (context, state) => const SchedulerCoordinatorShiftCalendarScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorProviderAvailability,
    builder: (context, state) => const SchedulerCoordinatorProviderAvailabilityScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorBookingRequests,
    builder: (context, state) => const SchedulerCoordinatorBookingRequestsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorOpenShifts,
    builder: (context, state) => const SchedulerCoordinatorOpenShiftsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorAssignments,
    builder: (context, state) => const SchedulerCoordinatorAssignmentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorConflicts,
    builder: (context, state) => const SchedulerCoordinatorConflictsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminInvoices,
    builder: (context, state) => const AdminInvoicesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminPayments,
    builder: (context, state) => const AdminPaymentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminClaims,
    builder: (context, state) => const AdminClaimsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminReconciliation,
    builder: (context, state) => const AdminReconciliationScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminOutstandingBalances,
    builder: (context, state) => const AdminOutstandingBalancesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminRefunds,
    builder: (context, state) => const AdminRefundsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.adminReports,
    builder: (context, state) => const AdminReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringApplicants,
    builder: (context, state) => const HrHiringApplicantsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringInterviews,
    builder: (context, state) => const HrHiringInterviewsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringOffers,
    builder: (context, state) => const HrHiringOffersScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringOnboarding,
    builder: (context, state) => const HrHiringOnboardingScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringStaffDocuments,
    builder: (context, state) => const HrHiringStaffDocumentsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringCredentials,
    builder: (context, state) => const HrHiringCredentialsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringTrainingStatus,
    builder: (context, state) => const HrHiringTrainingStatusScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringReports,
    builder: (context, state) => const HrHiringReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachReports,
    builder: (context, state) => const CommunityOutreachReportsScreenStitch(),
  ),
];
