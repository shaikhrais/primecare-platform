// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart'
    hide
        RegionalManagerOntarioDashboardScreen,
        RegionalManagerUsaDashboardScreen,
        GeneralManagerDashboardScreen,
        RegionalBdmDashboardScreen,
        RegionalBdmLeadsScreen,
        RegionalBdmFranchisePipelineScreen,
        RegionalBdmTerritoryGrowthScreen,
        RegionalBdmMeetingsScreen,
        RegionalBdmDealTrackerScreen,
        RegionalBdmPartnersScreen,
        RegionalBdmCompetitorNotesScreen,
        RegionalBdmTasksScreen,
        RegionalBdmReportsScreen,
        FranchiseSalesManagerDashboardScreen,
        FranchiseSalesManagerLeadsScreen,
        FranchiseSalesManagerProspectsScreen,
        FranchiseSalesManagerDiscoveryCallsScreen,
        FranchiseSalesManagerProposalsScreen,
        FranchiseSalesManagerSalesPipelineScreen,
        FranchiseSalesManagerContractsScreen,
        FranchiseSalesManagerFollowUpsScreen,
        FranchiseSalesManagerReportsScreen,
        PartnershipManagerDashboardScreen,
        PartnershipManagerPartnersScreen,
        PartnershipManagerOutreachScreen,
        PartnershipManagerActiveDealsScreen,
        PartnershipManagerProposalsScreen,
        PartnershipManagerRenewalsScreen,
        PartnershipManagerReportsScreen,
        TerritoryExpansionManagerDashboardScreen,
        TerritoryExpansionManagerTerritoryMapScreen,
        TerritoryExpansionManagerMarketResearchScreen,
        TerritoryExpansionManagerDemographicsScreen,
        TerritoryExpansionManagerOpenTerritoriesScreen,
        TerritoryExpansionManagerExpansionPlansScreen,
        TerritoryExpansionManagerSiteSelectionScreen,
        TerritoryExpansionManagerForecastScreen,
        TerritoryExpansionManagerReportsScreen;
import '../../features/regional/screens/regional_manager_ontario_dashboard_screen.dart';
import '../../features/regional/screens/regional_manager_usa_dashboard_screen.dart';
import '../../features/general/screens/general_manager_dashboard_screen.dart';
import '../../features/bdm/screens/regional_bdm_dashboard_screen.dart';
import '../../features/bdm/screens/regional_bdm_leads_screen.dart';
import '../../features/bdm/screens/regional_bdm_franchise_pipeline_screen.dart';
import '../../features/bdm/screens/regional_bdm_territory_growth_screen.dart';
import '../../features/bdm/screens/regional_bdm_meetings_screen.dart';
import '../../features/bdm/screens/regional_bdm_deal_tracker_screen.dart';
import '../../features/bdm/screens/regional_bdm_partners_screen.dart';
import '../../features/bdm/screens/regional_bdm_competitor_notes_screen.dart';
import '../../features/bdm/screens/regional_bdm_tasks_screen.dart';
import '../../features/bdm/screens/regional_bdm_reports_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_dashboard_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_leads_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_prospects_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_discovery_calls_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_proposals_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_sales_pipeline_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_contracts_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_follow_ups_screen.dart';
import '../../features/sales/screens/franchise_sales_manager_reports_screen.dart';
import '../../features/partnership/screens/partnership_manager_dashboard_screen.dart';
import '../../features/partnership/screens/partnership_manager_partners_screen.dart';
import '../../features/partnership/screens/partnership_manager_outreach_screen.dart';
import '../../features/partnership/screens/partnership_manager_active_deals_screen.dart';
import '../../features/partnership/screens/partnership_manager_proposals_screen.dart';
import '../../features/partnership/screens/partnership_manager_renewals_screen.dart';
import '../../features/partnership/screens/partnership_manager_reports_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_dashboard_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_territory_map_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_market_research_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_demographics_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_open_territories_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_expansion_plans_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_site_selection_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_forecast_screen.dart';
import '../../features/expansion/screens/territory_expansion_manager_reports_screen.dart';

import 'package:flutter_core/flutter_core.dart';
import 'business_development_routes.dart';
import 'package:flutter/foundation.dart';

final businessDevelopmentApplicationProvider =
    Provider<BusinessDevelopmentApplication>((ref) {
      return BusinessDevelopmentApplication();
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
  final application = ref.read(businessDevelopmentApplicationProvider);

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
            defaultValue: 'https://primecare-business-development.pages.dev',
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
