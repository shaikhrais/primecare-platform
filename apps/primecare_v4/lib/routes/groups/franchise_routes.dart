import 'package:go_router/go_router.dart';
import '../app_routes.dart';
import '../../components/generic_feature_screen.dart';

import '../../offices/franchise/roles/franchise_owner/owner_dashboard.dart'
    as franchise_owner_dash;
import '../../offices/franchise/roles/operations_manager/ops_manager_dashboard.dart'
    as operations_manager_dash;
import '../../offices/franchise/roles/scheduler/scheduling_dashboard.dart'
    as scheduler_dash;
import '../../offices/franchise/roles/billing_admin/billing_dashboard.dart'
    as billing_admin_dash;
import '../../offices/franchise/roles/hr_hiring/hr_dashboard.dart'
    as hr_hiring_dash;
import '../../offices/franchise/roles/franchise_owner/branch_overview.dart'
    as franchise_owner_branch_overview;
import '../../offices/franchise/roles/franchise_owner/financial_snapshot.dart'
    as franchise_owner_financial_snapshot;
import '../../offices/franchise/roles/franchise_owner/staff.dart'
    as franchise_owner_staff;
import '../../offices/franchise/roles/franchise_owner/appointments.dart'
    as franchise_owner_appointments;
import '../../offices/franchise/roles/franchise_owner/clients.dart'
    as franchise_owner_clients;
import '../../offices/franchise/roles/franchise_owner/compliance.dart'
    as franchise_owner_compliance;
import '../../offices/franchise/roles/franchise_owner/reports.dart'
    as franchise_owner_reports;
import '../../offices/franchise/roles/franchise_owner/hiring.dart'
    as franchise_owner_hiring;
import '../../offices/franchise/roles/operations_manager/daily_operations.dart'
    as operations_manager_daily_operations;
import '../../offices/franchise/roles/operations_manager/schedule.dart'
    as operations_manager_schedule;
import '../../offices/franchise/roles/operations_manager/shifts.dart'
    as operations_manager_shifts;
import '../../offices/franchise/roles/operations_manager/issues.dart'
    as operations_manager_issues;
import '../../offices/franchise/roles/operations_manager/service_quality.dart'
    as operations_manager_service_quality;
import '../../offices/franchise/roles/operations_manager/staff_coordination.dart'
    as operations_manager_staff_coordination;
import '../../offices/franchise/roles/operations_manager/attendance.dart'
    as operations_manager_attendance;
import '../../offices/franchise/roles/operations_manager/reports.dart'
    as operations_manager_reports;
import '../../offices/franchise/roles/scheduler_coordinator/appointment_calendar.dart'
    as scheduler_coordinator_appointment_calendar;
import '../../offices/franchise/roles/scheduler_coordinator/shift_calendar.dart'
    as scheduler_coordinator_shift_calendar;
import '../../offices/franchise/roles/scheduler_coordinator/provider_availability.dart'
    as scheduler_coordinator_provider_availability;
import '../../offices/franchise/roles/scheduler_coordinator/booking_requests.dart'
    as scheduler_coordinator_booking_requests;
import '../../offices/franchise/roles/scheduler_coordinator/open_shifts.dart'
    as scheduler_coordinator_open_shifts;
import '../../offices/franchise/roles/scheduler_coordinator/assignments.dart'
    as scheduler_coordinator_assignments;
import '../../offices/franchise/roles/scheduler_coordinator/conflicts.dart'
    as scheduler_coordinator_conflicts;
import '../../offices/franchise/roles/scheduler_coordinator/reports.dart'
    as scheduler_coordinator_reports;
import '../../offices/franchise/roles/admin/invoices.dart' as admin_invoices;
import '../../offices/franchise/roles/admin/payments.dart' as admin_payments;
import '../../offices/franchise/roles/admin/claims.dart' as admin_claims;
import '../../offices/franchise/roles/admin/reconciliation.dart'
    as admin_reconciliation;
import '../../offices/franchise/roles/admin/outstanding_balances.dart'
    as admin_outstanding_balances;
import '../../offices/franchise/roles/admin/refunds.dart' as admin_refunds;
import '../../offices/franchise/roles/admin/reports.dart' as admin_reports;
import '../../offices/franchise/roles/hr_hiring/applicants.dart'
    as hr_hiring_applicants;
import '../../offices/franchise/roles/hr_hiring/interviews.dart'
    as hr_hiring_interviews;
import '../../offices/franchise/roles/hr_hiring/offers.dart'
    as hr_hiring_offers;
import '../../offices/franchise/roles/hr_hiring/onboarding.dart'
    as hr_hiring_onboarding;
import '../../offices/franchise/roles/hr_hiring/staff_documents.dart'
    as hr_hiring_staff_documents;
import '../../offices/franchise/roles/hr_hiring/credentials.dart'
    as hr_hiring_credentials;
import '../../offices/franchise/roles/hr_hiring/training_status.dart'
    as hr_hiring_training_status;
import '../../offices/franchise/roles/hr_hiring/reports.dart'
    as hr_hiring_reports;

final List<RouteBase> franchiseRoutes = [
  GoRoute(
    path: AppRoutes.franchiseOwnerDashboard,
    builder: (context, state) =>
        const franchise_owner_dash.OwnerDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerDashboard,
    builder: (context, state) =>
        const operations_manager_dash.OpsManagerDashboard(),
  ),
  GoRoute(
    path: AppRoutes.schedulerDashboard,
    builder: (context, state) => const scheduler_dash.SchedulingDashboard(),
  ),
  GoRoute(
    path: AppRoutes.billingAdminDashboard,
    builder: (context, state) => const billing_admin_dash.BillingDashboard(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringDashboard,
    builder: (context, state) => const hr_hiring_dash.HrDashboard(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerBranchOverview,
    builder: (context, state) =>
        const franchise_owner_branch_overview.BranchOverviewScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerFinancialSnapshot,
    builder: (context, state) =>
        const franchise_owner_financial_snapshot.FinancialSnapshotScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerStaff,
    builder: (context, state) => const franchise_owner_staff.StaffScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerAppointments,
    builder: (context, state) =>
        const franchise_owner_appointments.AppointmentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerClients,
    builder: (context, state) => const franchise_owner_clients.ClientsScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerCompliance,
    builder: (context, state) =>
        const franchise_owner_compliance.ComplianceScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerHiring,
    builder: (context, state) => const franchise_owner_hiring.HiringScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerDailyOperations,
    builder: (context, state) =>
        const operations_manager_daily_operations.DailyOperationsScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerSchedule,
    builder: (context, state) =>
        const operations_manager_schedule.ScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerShifts,
    builder: (context, state) => const operations_manager_shifts.ShiftsScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerIssues,
    builder: (context, state) => const operations_manager_issues.IssuesScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerServiceQuality,
    builder: (context, state) =>
        const operations_manager_service_quality.ServiceQualityScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerStaffCoordination,
    builder: (context, state) =>
        const operations_manager_staff_coordination.StaffCoordinationScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerAttendance,
    builder: (context, state) =>
        const operations_manager_attendance.AttendanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.operationsManagerReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorAppointmentCalendar,
    builder: (context, state) =>
        const scheduler_coordinator_appointment_calendar.AppointmentCalendarScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorShiftCalendar,
    builder: (context, state) =>
        const scheduler_coordinator_shift_calendar.ShiftCalendarScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorProviderAvailability,
    builder: (context, state) =>
        const scheduler_coordinator_provider_availability.ProviderAvailabilityScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorBookingRequests,
    builder: (context, state) =>
        const scheduler_coordinator_booking_requests.BookingRequestsScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorOpenShifts,
    builder: (context, state) =>
        const scheduler_coordinator_open_shifts.OpenShiftsScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorAssignments,
    builder: (context, state) =>
        const scheduler_coordinator_assignments.AssignmentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorConflicts,
    builder: (context, state) =>
        const scheduler_coordinator_conflicts.ConflictsScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminInvoices,
    builder: (context, state) => const admin_invoices.FranchiseInvoicesScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminPayments,
    builder: (context, state) => const admin_payments.FranchisePaymentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminClaims,
    builder: (context, state) => const admin_claims.FranchiseClaimsScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminReconciliation,
    builder: (context, state) =>
        const admin_reconciliation.FranchiseReconciliationScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminOutstandingBalances,
    builder: (context, state) =>
        const admin_outstanding_balances.FranchiseOutstandingBalancesScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminRefunds,
    builder: (context, state) => const admin_refunds.FranchiseRefundsScreen(),
  ),
  GoRoute(
    path: AppRoutes.adminReports,
    builder: (context, state) => const admin_reports.FranchiseReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringApplicants,
    builder: (context, state) => const hr_hiring_applicants.ApplicantsScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringInterviews,
    builder: (context, state) => const hr_hiring_interviews.InterviewsScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringOffers,
    builder: (context, state) => const hr_hiring_offers.OffersScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringOnboarding,
    builder: (context, state) => const hr_hiring_onboarding.OnboardingScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringStaffDocuments,
    builder: (context, state) =>
        const hr_hiring_staff_documents.StaffDocumentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringCredentials,
    builder: (context, state) =>
        const hr_hiring_credentials.CredentialsScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringTrainingStatus,
    builder: (context, state) =>
        const hr_hiring_training_status.TrainingStatusScreen(),
  ),
  GoRoute(
    path: AppRoutes.hrHiringReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
];
