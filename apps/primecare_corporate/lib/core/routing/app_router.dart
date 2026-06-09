// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart'
    hide
        HeadOfBusDevDashboardScreen,
        HeadOfMarketingDashboardScreen,
        ShareholderDashboardScreen,
        FinanceDirectorDashboardScreen,
        FinanceDirectorCashflowScreen,
        VolunteerCoordinatorDashboardScreen,
        HrManagerDashboardScreen,
        HrHiringDashboardScreen,
        HrDirectorDashboardScreen,
        CxDirectorDashboardScreen,
        ItAdminDashboardScreen,
        LegalDashboardScreen,
        CisoDashboardScreen,
        ComplianceManagerDashboardScreen,
        ComplianceManagerComplianceCasesScreen,
        ComplianceManagerPoliciesScreen,
        ComplianceManagerAuditsScreen,
        ComplianceManagerIncidentReviewScreen,
        ComplianceManagerCredentialTrackingScreen,
        ComplianceManagerDocumentExpiryScreen,
        ComplianceManagerRiskRegisterScreen,
        ComplianceManagerCorrectiveActionsScreen,
        ComplianceManagerTrainingComplianceScreen,
        ComplianceManagerReportsScreen,
        TrainingDirectorDashboardScreen,
        TrainingDirectorTrainingProgramsScreen,
        TrainingDirectorStaffTrainingMatrixScreen,
        TrainingDirectorComplianceTrainingScreen,
        TrainingDirectorCourseLibraryScreen,
        TrainingDirectorAssessmentsScreen,
        TrainingDirectorCertificationsScreen,
        TrainingDirectorTrainerAssignmentsScreen,
        TrainingDirectorReportsScreen,
        TrainingDirectorAnalyticsScreen,
        TrainingDirectorCourseArchitectScreen,
        TrainingDirectorHubScreen,
        TrainingDirectorCertificatesScreen,
        CfoDashboardScreen,
        CfoFinancialOverviewScreen,
        CfoRevenueScreen,
        CfoExpensesScreen,
        CfoFranchiseFinancialsScreen,
        CfoPayrollScreen,
        CfoAccountsReceivableScreen,
        CfoAccountsPayableScreen,
        CfoInvoicesScreen,
        CfoProfitabilityScreen,
        CfoTaxAndRemittanceScreen,
        CfoReportsScreen,
        CtoDashboardScreen,
        CtoSystemHealthScreen,
        CtoPlatformUsageScreen,
        CtoFeatureAdoptionScreen,
        CtoApiMonitoringScreen,
        CtoIntegrationsScreen,
        CtoAuditLogsScreen,
        CtoAccessControlScreen,
        CtoReleaseManagementScreen,
        CtoIssueTrackingScreen,
        CtoInfrastructureScreen,
        CtoReportsScreen,
        CtoVerificationHubScreen,
        CtoSystemVerificationScreen,
        CeoDashboardScreen,
        CeoEnterpriseOverviewScreen,
        CeoFranchiseOverviewScreen,
        CeoRegionPerformanceScreen,
        CeoRevenueSummaryScreen,
        CeoStrategicKpisScreen,
        CeoGrowthPipelineScreen,
        CeoLeadershipReportsScreen,
        CeoAlertsAndRisksScreen,
        CeoOrganizationMapScreen,
        CeoApprovalsScreen,
        CeoReportsScreen,
        OwnerDashboardScreen,
        CooDashboardScreen,
        CooOperationsOverviewScreen,
        CooBranchOperationsScreen,
        CooStaffingEfficiencyScreen,
        CooSchedulingHealthScreen,
        CooServiceDeliveryScreen,
        CooIssueEscalationsScreen,
        CooComplianceViewScreen,
        CooWorkflowPerformanceScreen,
        CooBranchComparisonScreen,
        CooReportsScreen;
import '../../features/ceo/screens/ceo_dashboard_screen.dart';
import '../../features/ceo/screens/ceo_enterprise_overview_screen.dart';
import '../../features/ceo/screens/ceo_franchise_overview_screen.dart';
import '../../features/ceo/screens/ceo_region_performance_screen.dart';
import '../../features/ceo/screens/ceo_revenue_summary_screen.dart';
import '../../features/ceo/screens/ceo_strategic_kpis_screen.dart';
import '../../features/ceo/screens/ceo_growth_pipeline_screen.dart';
import '../../features/ceo/screens/ceo_leadership_reports_screen.dart';
import '../../features/ceo/screens/ceo_alerts_and_risks_screen.dart';
import '../../features/ceo/screens/ceo_organization_map_screen.dart';
import '../../features/ceo/screens/ceo_approvals_screen.dart';
import '../../features/ceo/screens/ceo_reports_screen.dart';
import '../../features/owner/screens/owner_dashboard_screen.dart';
import '../../features/coo/screens/coo_dashboard_screen.dart';
import '../../features/coo/screens/coo_operations_overview_screen.dart';
import '../../features/coo/screens/coo_branch_operations_screen.dart';
import '../../features/coo/screens/coo_staffing_efficiency_screen.dart';
import '../../features/coo/screens/coo_scheduling_health_screen.dart';
import '../../features/coo/screens/coo_service_delivery_screen.dart';
import '../../features/coo/screens/coo_issue_escalations_screen.dart';
import '../../features/coo/screens/coo_compliance_view_screen.dart';
import '../../features/coo/screens/coo_workflow_performance_screen.dart';
import '../../features/coo/screens/coo_branch_comparison_screen.dart';
import '../../features/coo/screens/coo_reports_screen.dart';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/foundation.dart';

import 'corporate_routes.dart';
import '../../features/busdev/screens/head_of_bus_dev_dashboard_screen.dart';
import '../../features/marketing/screens/head_of_marketing_dashboard_screen.dart';
import '../../features/shareholder/screens/shareholder_dashboard_screen.dart';
import '../../features/finance/screens/finance_director_dashboard_screen.dart';
import '../../features/finance/screens/finance_director_cashflow_screen.dart';
import '../../features/volunteer/screens/volunteer_coordinator_dashboard_screen.dart';
import '../../features/hr/screens/hr_manager_dashboard_screen.dart';
import '../../features/hr/screens/hr_hiring_dashboard_screen.dart';
import '../../features/hr/screens/hr_director_dashboard_screen.dart';
import '../../features/cx/screens/cx_director_dashboard_screen.dart';
import '../../features/itadmin/screens/it_admin_dashboard_screen.dart';
import '../../features/legal/screens/legal_dashboard_screen.dart';
import '../../features/ciso/screens/ciso_dashboard_screen.dart';

import '../../features/compliance/screens/compliance_manager_dashboard_screen.dart';
import '../../features/compliance/screens/compliance_cases_screen.dart';
import '../../features/compliance/screens/policies_screen.dart';
import '../../features/compliance/screens/audits_screen.dart';
import '../../features/compliance/screens/incident_review_screen.dart';
import '../../features/compliance/screens/credential_tracking_screen.dart';
import '../../features/compliance/screens/document_expiry_screen.dart';
import '../../features/compliance/screens/risk_register_screen.dart';
import '../../features/compliance/screens/corrective_actions_screen.dart';
import '../../features/compliance/screens/training_compliance_screen.dart';
import '../../features/compliance/screens/compliance_reports_screen.dart';
import '../../features/training/screens/training_director_dashboard_screen.dart';
import '../../features/training/screens/training_programs_screen.dart';
import '../../features/training/screens/staff_training_matrix_screen.dart';
import '../../features/training/screens/compliance_training_screen.dart';
import '../../features/training/screens/course_library_screen.dart';
import '../../features/training/screens/assessments_screen.dart';
import '../../features/training/screens/certifications_screen.dart';
import '../../features/training/screens/trainer_assignments_screen.dart';
import '../../features/training/screens/training_reports_screen.dart';
import '../../features/training/screens/training_analytics_screen.dart';
import '../../features/training/screens/course_architect_screen.dart';
import '../../features/training/screens/training_hub_screen.dart';
import '../../features/training/screens/certificates_screen.dart';

import '../../features/cfo/screens/cfo_dashboard_screen.dart';
import '../../features/cfo/screens/cfo_financial_overview_screen.dart';
import '../../features/cfo/screens/cfo_revenue_screen.dart';
import '../../features/cfo/screens/cfo_expenses_screen.dart';
import '../../features/cfo/screens/cfo_franchise_financials_screen.dart';
import '../../features/cfo/screens/cfo_payroll_screen.dart';
import '../../features/cfo/screens/cfo_accounts_receivable_screen.dart';
import '../../features/cfo/screens/cfo_accounts_payable_screen.dart';
import '../../features/cfo/screens/cfo_invoices_screen.dart';
import '../../features/cfo/screens/cfo_profitability_screen.dart';
import '../../features/cfo/screens/cfo_tax_and_remittance_screen.dart';
import '../../features/cfo/screens/cfo_reports_screen.dart';
import '../../features/cto/screens/cto_dashboard_screen.dart';
import '../../features/cto/screens/cto_system_health_screen.dart';
import '../../features/cto/screens/cto_platform_usage_screen.dart';
import '../../features/cto/screens/cto_feature_adoption_screen.dart';
import '../../features/cto/screens/cto_api_monitoring_screen.dart';
import '../../features/cto/screens/cto_integrations_screen.dart';
import '../../features/cto/screens/cto_audit_logs_screen.dart';
import '../../features/cto/screens/cto_access_control_screen.dart';
import '../../features/cto/screens/cto_release_management_screen.dart';
import '../../features/cto/screens/cto_issue_tracking_screen.dart';
import '../../features/cto/screens/cto_infrastructure_screen.dart';
import '../../features/cto/screens/cto_reports_screen.dart';
import '../../features/cto/screens/cto_verification_hub_screen.dart';
import '../../features/cto/screens/cto_system_verification_screen.dart';

final corporateApplicationProvider = Provider<CorporateApplication>((ref) {
  return CorporateApplication();
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
  final application = ref.read(corporateApplicationProvider);

  final dashboardRoute = !ref.watch(authProvider).isAuthenticated
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            CommonRoutes.login;

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
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url =
              state.uri.queryParameters['url'] ??
              'https://primecare-auth.pages.dev';
          return SsoRedirectView(redirectUrl: url);
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        redirect: (context, state) {
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
            'SSO_PORTAL_URL',
            defaultValue: 'https://primecare-auth.pages.dev',
          );
          final defaultRedirectUri = const String.fromEnvironment(
            'APP_BASE_URL',
            defaultValue: 'https://primecare-corporate.pages.dev',
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
