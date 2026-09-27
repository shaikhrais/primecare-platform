// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart'
    hide
        SchedulerDashboardScreen,
        BillingAdminDashboardScreen,
        BillingAdminInvoicesScreen,
        HrHiringDashboardScreen,
        HrHiringApplicantsScreen,
        HrHiringInterviewsScreen,
        HrHiringOffersScreen,
        HrHiringOnboardingScreen,
        HrHiringStaffDocumentsScreen,
        HrHiringCredentialsScreen,
        HrHiringTrainingStatusScreen,
        HrHiringReportsScreen,
        SchedulerCoordinatorAppointmentCalendarScreen,
        SchedulerCoordinatorShiftCalendarScreen,
        SchedulerCoordinatorProviderAvailabilityScreen,
        SchedulerCoordinatorBookingRequestsScreen,
        SchedulerCoordinatorOpenShiftsScreen,
        SchedulerCoordinatorAssignmentsScreen,
        SchedulerCoordinatorConflictsScreen,
        SchedulerCoordinatorReportsScreen,
        AdminDashboardScreen,
        AdminInvoicesScreen,
        AdminPaymentsScreen,
        AdminClaimsScreen,
        AdminReconciliationScreen,
        AdminOutstandingBalancesScreen,
        AdminRefundsScreen,
        AdminReportsScreen,
        RegionalManagerDashboardScreen,
        RegionalManagerBranchComparisonScreen,
        MarketingManagerDashboardScreen,
        MarketingManagerCampaignsScreen,
        FranchiseOwnerDashboardScreen,
        FranchiseOwnerBranchOverviewScreen,
        FranchiseOwnerFinancialSnapshotScreen,
        FranchiseOwnerStaffScreen,
        FranchiseOwnerAppointmentsScreen,
        FranchiseOwnerClientsScreen,
        FranchiseOwnerComplianceScreen,
        FranchiseOwnerReportsScreen,
        FranchiseOwnerHiringScreen,
        OperationsManagerDashboardScreen,
        OperationsManagerDailyOperationsScreen,
        OperationsManagerScheduleScreen,
        OperationsManagerShiftsScreen,
        OperationsManagerIssuesScreen,
        OperationsManagerServiceQualityScreen,
        OperationsManagerStaffCoordinationScreen,
        OperationsManagerAttendanceScreen,
        OperationsManagerReportsScreen;
import '../../features/owner/screens/franchise_owner_dashboard_screen.dart';
import '../../features/owner/screens/franchise_owner_branch_overview_screen.dart';
import '../../features/owner/screens/franchise_owner_financial_snapshot_screen.dart';
import '../../features/owner/screens/franchise_owner_staff_screen.dart';
import '../../features/owner/screens/franchise_owner_appointments_screen.dart';
import '../../features/owner/screens/franchise_owner_clients_screen.dart';
import '../../features/owner/screens/franchise_owner_compliance_screen.dart';
import '../../features/owner/screens/franchise_owner_reports_screen.dart';
import '../../features/owner/screens/franchise_owner_hiring_screen.dart';
import '../../features/ops/screens/operations_manager_dashboard_screen.dart';
import '../../features/ops/screens/operations_manager_daily_operations_screen.dart';
import '../../features/ops/screens/operations_manager_schedule_screen.dart';
import '../../features/ops/screens/operations_manager_shifts_screen.dart';
import '../../features/ops/screens/operations_manager_issues_screen.dart';
import '../../features/ops/screens/operations_manager_service_quality_screen.dart';
import '../../features/ops/screens/operations_manager_staff_coordination_screen.dart';
import '../../features/ops/screens/operations_manager_attendance_screen.dart';
import '../../features/ops/screens/operations_manager_reports_screen.dart';

import 'package:flutter_core/flutter_core.dart';
import 'franchise_routes.dart';
import '../../features/scheduler/screens/scheduler_dashboard_screen.dart';
import '../../features/billing/screens/billing_admin_dashboard_screen.dart';
import '../../features/billing/screens/billing_admin_invoices_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_dashboard_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_applicants_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_interviews_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_offers_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_onboarding_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_staff_documents_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_credentials_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_training_status_screen.dart';
import '../../features/hr_hiring/screens/hr_hiring_reports_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_appointment_calendar_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_shift_calendar_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_provider_availability_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_booking_requests_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_open_shifts_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_assignments_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_conflicts_screen.dart';
import '../../features/scheduler_coordinator/screens/scheduler_coordinator_reports_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/admin_invoices_screen.dart';
import '../../features/admin/screens/admin_payments_screen.dart';
import '../../features/admin/screens/admin_claims_screen.dart';
import '../../features/admin/screens/admin_reconciliation_screen.dart';
import '../../features/admin/screens/admin_outstanding_balances_screen.dart';
import '../../features/admin/screens/admin_refunds_screen.dart';
import '../../features/admin/screens/admin_reports_screen.dart';
import '../../features/regional_manager/screens/regional_manager_dashboard_screen.dart';
import '../../features/regional_manager/screens/regional_manager_branch_comparison_screen.dart';
import '../../features/marketing_manager/screens/marketing_manager_dashboard_screen.dart';
import '../../features/marketing_manager/screens/marketing_manager_campaigns_screen.dart';

import 'package:flutter/foundation.dart';

final franchiseApplicationProvider = Provider<FranchiseApplication>((ref) {
  return FranchiseApplication();
});

final activeRoleProvider = Provider<PlatformRole>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isInitialized || !authState.isAuthenticated) {
    return PlatformRole.guest;
  }
  return PlatformRole.fromName(authState.role);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final activeRole = ref.watch(activeRoleProvider);
  final application = ref.read(franchiseApplicationProvider);

  final authState = ref.watch(authProvider);
  final dashboardRoute = !authState.isAuthenticated
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            AuthNotifier.getDashboardRouteForRole(authState.role ?? '');

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      // If the authentication system has not completed its initial session restoration check yet,
      // DO NOT redirect the user! Prevent early redirects and let the startup check finalize.
      if (!authState.isInitialized) {
        return null;
      }

      final requestedRoute = state.uri.path;

      // Ensure SSO Portal URL is configured (this normally goes in app initialization)
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
        'SSO_PORTAL_URL',
        defaultValue: 'https://primecare-auth.pages.dev',
      );

      // If trying to hit root/login/callback while authenticated, redirect to dashboard immediately
      final isAtLanding =
          requestedRoute == '/' ||
          requestedRoute == CommonRoutes.login ||
          requestedRoute == CommonRoutes.language ||
          requestedRoute == CommonRoutes.authCallback;
      if (authState.isAuthenticated && isAtLanding) {
        return dashboardRoute;
      }

      final result = RouteGuard.verify(
        requestedRoute: requestedRoute,
        isLoggedIn: authState.isAuthenticated,
        userRole: authState.role,
      );

      if (!result.isAllowed) {
        if (result.externalRedirectUrl != null) {
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(result.externalRedirectUrl!)}';
        }
        return result.redirectRoute;
      }

      return null;
    },
    publicRoutes: [
      GoRoute(
        path: CommonRoutes.language,
        builder: (context, state) => const AppShellBoundary(
          child: LanguageSelectionView(),
        ),
      ),
      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url =
              state.uri.queryParameters['url'] ??
              'https://primecare-auth.pages.dev';
          return AppShellBoundary(child: SsoRedirectView(redirectUrl: url));
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        redirect: (context, state) {
          // If a user hits /login directly, force them to the SSO redirect
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
            'SSO_PORTAL_URL',
            defaultValue: 'https://primecare-auth.pages.dev',
          );
          final defaultRedirectUri = const String.fromEnvironment(
            'APP_BASE_URL',
            defaultValue: 'https://primecare-franchise.pages.dev',
          );
          final redirectUri = kIsWeb
              ? defaultRedirectUri
              : 'primecare://auth/callback';
          final target =
              '${RouteGuard.ssoPortalUrl}/login?redirect_uri=${Uri.encodeComponent(redirectUri)}';
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(target)}';
        },
      ),
    ],
  );
});
