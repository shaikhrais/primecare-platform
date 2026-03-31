import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';

import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

import '../shared_screens/global_settings.dart';
import '../shared_screens/global_profile.dart';
import '../shared_screens/notification_center.dart';
import '../shared_screens/messaging_hub.dart';
import '../shared_screens/document_vault.dart';

import '../components/layouts/master_layout.dart';

import '../offices/corporate/roles/ceo/ceo_dashboard.dart' as CeoDash;
import '../offices/corporate/roles/coo/coo_dashboard.dart' as CooDash;
import '../offices/corporate/roles/cfo/cfo_dashboard.dart' as CfoDash;
import '../offices/corporate/roles/cto/cto_dashboard.dart' as CtoDash;
import '../offices/corporate/roles/compliance_manager/compliance_dashboard.dart' as ComplianceManagerDash;
import '../offices/corporate/roles/head_of_bus_dev/bus_dev_dashboard.dart' as HeadOfBusDevDash;
import '../offices/corporate/roles/head_of_marketing/marketing_overview.dart' as HeadOfMarketingDash;
import '../offices/corporate/roles/training_director/training_admin_dashboard.dart' as TrainingDirectorDash;
import '../offices/business_development/roles/regional_manager_ontario/region_dashboard.dart' as RegionalManagerOntarioDash;
import '../offices/business_development/roles/regional_manager_usa/region_dashboard.dart' as RegionalManagerUsaDash;
import '../offices/business_development/roles/franchise_sales_manager/pipeline_dashboard.dart' as FranchiseSalesManagerDash;
import '../offices/business_development/roles/partnership_manager/partner_management.dart' as PartnershipManagerDash;
import '../offices/business_development/roles/territory_expansion_manager/expansion_dashboard.dart' as TerritoryExpansionManagerDash;
import '../offices/franchise/roles/franchise_owner/owner_dashboard.dart' as FranchiseOwnerDash;
import '../offices/franchise/roles/operations_manager/ops_manager_dashboard.dart' as OperationsManagerDash;
import '../offices/franchise/roles/scheduler/scheduling_dashboard.dart' as SchedulerDash;
import '../offices/franchise/roles/billing_admin/billing_dashboard.dart' as BillingAdminDash;
import '../offices/franchise/roles/hr_hiring/hr_dashboard.dart' as HrHiringDash;
import '../offices/clinic/roles/rn/rn_dashboard.dart' as RnDash;
import '../offices/clinic/roles/rpn/rpn_dashboard.dart' as RpnDash;
import '../offices/clinic/roles/rmt/rmt_dashboard.dart' as RmtDash;
import '../offices/clinic/roles/psw/psw_dashboard.dart' as PswDash;
import '../offices/support/roles/customer_support/support_dashboard.dart' as CustomerSupportDash;
import '../offices/support/roles/intake_coordinator/intake_dashboard.dart' as IntakeCoordinatorDash;
import '../offices/support/roles/quality_assurance/qa_dashboard.dart' as QualityAssuranceDash;
import '../offices/support/roles/training_coordinator/training_modules.dart' as TrainingCoordinatorDash;
import '../offices/marketing/roles/local_marketing_manager/local_campaigns.dart' as LocalMarketingManagerDash;
import '../offices/marketing/roles/community_outreach/community_events.dart' as CommunityOutreachDash;
import '../offices/marketing/roles/territory_sales_manager/lead_generation.dart' as TerritorySalesManagerDash;
import '../offices/client/roles/client/client_dashboard.dart' as ClientDash;
import '../offices/client/roles/family_member/family_dashboard.dart' as FamilyMemberDash;

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login || 
                           state.matchedLocation == AppRoutes.signup || 
                           state.matchedLocation == AppRoutes.forgotPassword;
      
      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }
      
      if (isLoggedIn && isLoggingIn) {
        return AuthNotifier.getDashboardRouteForRole(role);
      }
      
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.signup, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: AppRoutes.forgotPassword, builder: (context, state) => const ForgotPasswordScreen()),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.none, child: child),
        routes: [
          GoRoute(path: AppRoutes.globalSettings, builder: (context, state) => const GlobalSettingsScreen()),
          GoRoute(path: AppRoutes.globalProfile, builder: (context, state) => const GlobalProfileScreen()),
          GoRoute(path: AppRoutes.notificationCenter, builder: (context, state) => const NotificationCenterScreen()),
          GoRoute(path: AppRoutes.messagingHub, builder: (context, state) => const MessagingHubScreen()),
          GoRoute(path: AppRoutes.documentVault, builder: (context, state) => const DocumentVaultScreen()),
        ]
      ),

      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.admin, child: child),
        routes: [
        GoRoute(
          path: AppRoutes.ceoDashboard,
          builder: (context, state) => const CeoDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.cooDashboard,
          builder: (context, state) => const CooDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.cfoDashboard,
          builder: (context, state) => const CfoDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.ctoDashboard,
          builder: (context, state) => const CtoDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.complianceManagerDashboard,
          builder: (context, state) => const ComplianceManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.headOfBusDevDashboard,
          builder: (context, state) => const HeadOfBusDevDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.headOfMarketingDashboard,
          builder: (context, state) => const HeadOfMarketingDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.trainingDirectorDashboard,
          builder: (context, state) => const TrainingDirectorDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.regionalManagerOntarioDashboard,
          builder: (context, state) => const RegionalManagerOntarioDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.regionalManagerUsaDashboard,
          builder: (context, state) => const RegionalManagerUsaDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.franchiseSalesManagerDashboard,
          builder: (context, state) => const FranchiseSalesManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.partnershipManagerDashboard,
          builder: (context, state) => const PartnershipManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.territoryExpansionManagerDashboard,
          builder: (context, state) => const TerritoryExpansionManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.franchiseOwnerDashboard,
          builder: (context, state) => const FranchiseOwnerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.operationsManagerDashboard,
          builder: (context, state) => const OperationsManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.schedulerDashboard,
          builder: (context, state) => const SchedulerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.billingAdminDashboard,
          builder: (context, state) => const BillingAdminDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.hrHiringDashboard,
          builder: (context, state) => const HrHiringDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.localMarketingManagerDashboard,
          builder: (context, state) => const LocalMarketingManagerDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.communityOutreachDashboard,
          builder: (context, state) => const CommunityOutreachDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.territorySalesManagerDashboard,
          builder: (context, state) => const TerritorySalesManagerDash.PlaceholderScreen(),
        ),
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.provider, child: child),
        routes: [
        GoRoute(
          path: AppRoutes.rnDashboard,
          builder: (context, state) => const RnDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.rpnDashboard,
          builder: (context, state) => const RpnDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.rmtDashboard,
          builder: (context, state) => const RmtDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.pswDashboard,
          builder: (context, state) => const PswDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.customerSupportDashboard,
          builder: (context, state) => const CustomerSupportDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.intakeCoordinatorDashboard,
          builder: (context, state) => const IntakeCoordinatorDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.qualityAssuranceDashboard,
          builder: (context, state) => const QualityAssuranceDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.trainingCoordinatorDashboard,
          builder: (context, state) => const TrainingCoordinatorDash.PlaceholderScreen(),
        ),
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.client, child: child),
        routes: [
        GoRoute(
          path: AppRoutes.clientDashboard,
          builder: (context, state) => const ClientDash.PlaceholderScreen(),
        ),
        GoRoute(
          path: AppRoutes.familyMemberDashboard,
          builder: (context, state) => const FamilyMemberDash.PlaceholderScreen(),
        ),
        ],
      ),
    ],
  );
});
