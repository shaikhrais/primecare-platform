// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_franchise/features/generated_screens/admin_claims_screen.dart' as migrated0;
import 'package:primecare_franchise/features/generated_screens/admin_dashboard_screen.dart' as migrated1;
import 'package:primecare_franchise/features/generated_screens/admin_invoices_screen.dart' as migrated2;
import 'package:primecare_franchise/features/generated_screens/admin_outstanding_balances_screen.dart' as migrated3;
import 'package:primecare_franchise/features/generated_screens/admin_payments_screen.dart' as migrated4;
import 'package:primecare_franchise/features/generated_screens/admin_reconciliation_screen.dart' as migrated5;
import 'package:primecare_franchise/features/generated_screens/admin_refunds_screen.dart' as migrated6;
import 'package:primecare_franchise/features/generated_screens/admin_reports_screen.dart' as migrated7;
import 'package:primecare_franchise/features/generated_screens/billing_admin_invoices_screen.dart' as migrated8;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_contracts_screen.dart' as migrated9;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_discovery_calls_screen.dart' as migrated10;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_follow_ups_screen.dart' as migrated11;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_leads_screen.dart' as migrated12;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_proposals_screen.dart' as migrated13;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_prospects_screen.dart' as migrated14;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_reports_screen.dart' as migrated15;
import 'package:primecare_franchise/features/generated_screens/franchise_sales_manager_sales_pipeline_screen.dart' as migrated16;
import 'package:primecare_franchise/features/generated_screens/regional_bdm_franchise_pipeline_screen.dart' as migrated17;
import 'package:primecare_franchise/features/hr_hiring/screens/hr_hiring_reports_screen.dart' as migrated18;
import 'package:primecare_franchise/features/hr_hiring/screens/hr_hiring_staff_documents_screen.dart' as migrated19;
import 'package:primecare_franchise/features/hr_hiring/screens/hr_hiring_training_status_screen.dart' as migrated20;
import 'package:primecare_franchise/features/marketing_manager/screens/marketing_manager_campaigns_screen.dart' as migrated21;
import 'package:primecare_franchise/features/marketing_manager/screens/marketing_manager_dashboard_screen.dart' as migrated22;
import 'package:primecare_franchise/features/ops/screens/operations_manager_attendance_screen.dart' as migrated23;
import 'package:primecare_franchise/features/ops/screens/operations_manager_daily_operations_screen.dart' as migrated24;
import 'package:primecare_franchise/features/ops/screens/operations_manager_issues_screen.dart' as migrated25;
import 'package:primecare_franchise/features/ops/screens/operations_manager_reports_screen.dart' as migrated26;
import 'package:primecare_franchise/features/ops/screens/operations_manager_schedule_screen.dart' as migrated27;
import 'package:primecare_franchise/features/ops/screens/operations_manager_service_quality_screen.dart' as migrated28;
import 'package:primecare_franchise/features/ops/screens/operations_manager_shifts_screen.dart' as migrated29;
import 'package:primecare_franchise/features/ops/screens/operations_manager_staff_coordination_screen.dart' as migrated30;
import 'package:primecare_franchise/features/owner/screens/franchise_owner_dashboard_screen.dart' as migrated31;
import 'package:primecare_franchise/features/owner/screens/franchise_owner_financial_snapshot_screen.dart' as migrated32;
import 'package:primecare_franchise/features/owner/screens/franchise_owner_hiring_screen.dart' as migrated33;
import 'package:primecare_franchise/features/regional_manager/screens/regional_manager_branch_comparison_screen.dart' as migrated34;
import 'package:primecare_franchise/features/regional_manager/screens/regional_manager_dashboard_screen.dart' as migrated35;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_appointment_calendar_screen.dart' as migrated36;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_assignments_screen.dart' as migrated37;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_booking_requests_screen.dart' as migrated38;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_conflicts_screen.dart' as migrated39;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_open_shifts_screen.dart' as migrated40;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_provider_availability_screen.dart' as migrated41;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_reports_screen.dart' as migrated42;
import 'package:primecare_franchise/features/scheduler_coordinator/screens/scheduler_coordinator_shift_calendar_screen.dart' as migrated43;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.AdminClaimsScreenState,
    migrated1.AdminDashboardScreenState,
    migrated2.AdminInvoicesScreenState,
    migrated3.AdminOutstandingBalancesScreenState,
    migrated4.AdminPaymentsScreenState,
    migrated5.AdminReconciliationScreenState,
    migrated6.AdminRefundsScreenState,
    migrated7.AdminReportsScreenState,
    migrated8.BillingAdminInvoicesScreenState,
    migrated9.FranchiseSalesManagerContractsScreenState,
    migrated10.FranchiseSalesManagerDiscoveryCallsScreenState,
    migrated11.FranchiseSalesManagerFollowUpsScreenState,
    migrated12.FranchiseSalesManagerLeadsScreenState,
    migrated13.FranchiseSalesManagerProposalsScreenState,
    migrated14.FranchiseSalesManagerProspectsScreenState,
    migrated15.FranchiseSalesManagerReportsScreenState,
    migrated16.FranchiseSalesManagerSalesPipelineScreenState,
    migrated17.RegionalBdmFranchisePipelineScreenState,
    migrated18.HrHiringReportsScreenState,
    migrated19.HrHiringStaffDocumentsScreenState,
    migrated20.HrHiringTrainingStatusScreenState,
    migrated21.MarketingManagerCampaignsScreenState,
    migrated22.MarketingManagerDashboardScreenState,
    migrated23.OperationsManagerAttendanceScreenState,
    migrated24.OperationsManagerDailyOperationsScreenState,
    migrated25.OperationsManagerIssuesScreenState,
    migrated26.OperationsManagerReportsScreenState,
    migrated27.OperationsManagerScheduleScreenState,
    migrated28.OperationsManagerServiceQualityScreenState,
    migrated29.OperationsManagerShiftsScreenState,
    migrated30.OperationsManagerStaffCoordinationScreenState,
    migrated31.FranchiseOwnerDashboardScreenState,
    migrated32.FranchiseOwnerFinancialSnapshotScreenState,
    migrated33.FranchiseOwnerHiringScreenState,
    migrated34.RegionalManagerBranchComparisonScreenState,
    migrated35.RegionalManagerDashboardScreenState,
    migrated36.SchedulerCoordinatorAppointmentCalendarScreenState,
    migrated37.SchedulerCoordinatorAssignmentsScreenState,
    migrated38.SchedulerCoordinatorBookingRequestsScreenState,
    migrated39.SchedulerCoordinatorConflictsScreenState,
    migrated40.SchedulerCoordinatorOpenShiftsScreenState,
    migrated41.SchedulerCoordinatorProviderAvailabilityScreenState,
    migrated42.SchedulerCoordinatorReportsScreenState,
    migrated43.SchedulerCoordinatorShiftCalendarScreenState,
    ];
    expect(migratedTypes, hasLength(44));
  });
}
