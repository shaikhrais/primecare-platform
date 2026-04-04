import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';
import '../components/generic_feature_screen.dart';

import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

import '../offices/shared_screens/global_settings.dart';
import '../offices/shared_screens/global_profile.dart';
import '../offices/shared_screens/notification_center.dart';
import '../offices/shared_screens/messaging_hub.dart';
import '../offices/shared_screens/document_vault.dart';

import '../components/layouts/master_layout.dart';

import '../offices/corporate/roles/ceo/analytics_dashboard.dart' as ceo_dash;
import '../offices/corporate/roles/coo/coo_dashboard.dart' as coo_dash;
import '../offices/corporate/roles/cfo/cfo_dashboard.dart' as cfo_dash;
import '../offices/corporate/roles/cto/cto_dashboard.dart' as cto_dash;
import '../offices/corporate/roles/compliance_manager/compliance_dashboard.dart' as compliance_manager_dash;
import '../offices/corporate/roles/head_of_bus_dev/bus_dev_dashboard.dart' as head_of_bus_dev_dash;
import '../offices/marketing/roles/head_of_marketing/marketing_director_dashboard.dart' as head_of_marketing_dash;
import '../offices/corporate/roles/training_director/training_admin_dashboard.dart' as training_director_dash;
import '../offices/business_development/roles/regional_manager_ontario/region_dashboard.dart' as regional_manager_ontario_dash;
import '../offices/business_development/roles/regional_manager_usa/region_dashboard.dart' as regional_manager_usa_dash;
import '../offices/business_development/roles/franchise_sales_manager/pipeline_dashboard.dart' as franchise_sales_manager_dash;
import '../offices/business_development/roles/general_manager/ops_dashboard.dart' as general_manager_dash;
import '../offices/business_development/roles/partnership_manager/partner_dashboard.dart' as partnership_manager_dash;
import '../offices/business_development/roles/territory_expansion_manager/expansion_analytics_dashboard.dart' as territory_expansion_manager_dash;
import '../offices/franchise/roles/franchise_owner/owner_dashboard.dart' as franchise_owner_dash;
import '../offices/franchise/roles/operations_manager/ops_manager_dashboard.dart' as operations_manager_dash;
import '../offices/franchise/roles/scheduler/scheduling_dashboard.dart' as scheduler_dash;
import '../offices/franchise/roles/billing_admin/billing_dashboard.dart' as billing_admin_dash;
import '../offices/franchise/roles/hr_hiring/hr_dashboard.dart' as hr_hiring_dash;
import '../offices/clinic/roles/rn/rn_dashboard.dart' as rn_dash;
import '../offices/clinic/roles/rpn/rpn_dashboard.dart' as rpn_dash;
import '../offices/clinic/roles/rmt/rmt_dashboard.dart' as rmt_dash;
import '../offices/clinic/roles/psw/psw_dashboard.dart' as psw_dash;
import '../offices/support/roles/customer_support/support_dashboard.dart' as customer_support_dash;
import '../offices/support/roles/intake_coordinator/intake_dashboard.dart' as intake_coordinator_dash;
import '../offices/support/roles/quality_assurance/qa_dashboard.dart' as quality_assurance_dash;
import '../offices/support/roles/training_coordinator/training_modules.dart' as training_coordinator_dash;
import '../offices/marketing/roles/local_marketing_manager/local_marketing_dashboard.dart' as local_marketing_manager_dash;
import '../offices/marketing/roles/community_outreach/community_dashboard.dart' as community_outreach_dash;
import '../offices/marketing/roles/territory_sales_manager/sales_dashboard.dart' as territory_sales_manager_dash;
import '../offices/client/roles/client/client_dashboard.dart' as patient_dash;
import '../offices/client/roles/family_member/family_dashboard.dart' as family_member_dash;
import '../offices/clinic/roles/physio/physio_dashboard.dart' as physio_dash;
import '../offices/clinic/roles/chiro/chiro_dashboard.dart' as chiro_dash;
import '../offices/clinic/roles/occupational_therapist/ot_dashboard.dart' as ot_dash;
import '../offices/clinic/roles/speech_pathologist/slp_dashboard.dart' as slp_dash;
import '../offices/system/roles/guest/guest_dashboard.dart' as guest_dash;
import '../offices/system/roles/scrum_master/scrum_master_dashboard.dart' as scrum_master_dash;

final appRouterProvider = Provider<GoRouter>((ref) {
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
      GoRoute(path: AppRoutes.signup, builder: (context, state) => const SignupScreen()),
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
          path: AppRoutes.guestDashboard,
          builder: (context, state) => const guest_dash.GuestDashboard(),
        ),
        GoRoute(
          path: AppRoutes.ceoDashboard,
          builder: (context, state) => const ceo_dash.CeoAnalyticsDashboard(),
        ),
        GoRoute(
          path: AppRoutes.cooDashboard,
          builder: (context, state) => const coo_dash.CooDashboard(),
        ),
        GoRoute(
          path: AppRoutes.cfoDashboard,
          builder: (context, state) => const cfo_dash.CfoDashboard(),
        ),
        GoRoute(
          path: AppRoutes.ctoDashboard,
          builder: (context, state) => const cto_dash.CtoDashboard(),
        ),
        GoRoute(
          path: AppRoutes.complianceManagerDashboard,
          builder: (context, state) => const compliance_manager_dash.ComplianceDashboard(),
        ),
        GoRoute(
          path: AppRoutes.headOfBusDevDashboard,
          builder: (context, state) => const head_of_bus_dev_dash.BusDevDashboard(),
        ),
        GoRoute(
          path: AppRoutes.headOfMarketingDashboard,
          builder: (context, state) => const head_of_marketing_dash.HeadOfMarketingDashboard(),
        ),
        GoRoute(
          path: AppRoutes.trainingDirectorDashboard,
          builder: (context, state) => const training_director_dash.TrainingAdminDashboard(),
        ),
        GoRoute(
          path: AppRoutes.regionalManagerOntarioDashboard,
          builder: (context, state) => const regional_manager_ontario_dash.RegionDashboard(),
        ),
        GoRoute(
          path: AppRoutes.regionalManagerUsaDashboard,
          builder: (context, state) => const regional_manager_usa_dash.RegionDashboard(),
        ),
        GoRoute(
          path: AppRoutes.franchiseSalesManagerDashboard,
          builder: (context, state) => const franchise_sales_manager_dash.FranchiseSalesDashboard(),
        ),
        GoRoute(
          path: AppRoutes.generalManagerDashboard,
          builder: (context, state) => const general_manager_dash.OpsDashboard(),
        ),
        GoRoute(
          path: AppRoutes.partnershipManagerDashboard,
          builder: (context, state) => const partnership_manager_dash.PartnerDashboard(),
        ),
        GoRoute(
          path: AppRoutes.territoryExpansionManagerDashboard,
          builder: (context, state) => const territory_expansion_manager_dash.ExpansionAnalyticsDashboard(),
        ),
        GoRoute(
          path: AppRoutes.franchiseOwnerDashboard,
          builder: (context, state) => const franchise_owner_dash.OwnerDashboard(),
        ),
        GoRoute(
          path: AppRoutes.operationsManagerDashboard,
          builder: (context, state) => const operations_manager_dash.OpsManagerDashboard(),
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
          path: AppRoutes.localMarketingManagerDashboard,
          builder: (context, state) => const local_marketing_manager_dash.LocalMarketingDashboard(),
        ),
        GoRoute(
          path: AppRoutes.communityOutreachDashboard,
          builder: (context, state) => const community_outreach_dash.CommunityOutreachDashboard(),
        ),
        GoRoute(
          path: AppRoutes.territorySalesManagerDashboard,
          builder: (context, state) => const territory_sales_manager_dash.TerritorySalesDashboard(),
        ),
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.provider, child: child),
        routes: [
                GoRoute(
          path: '/provider/feature/:id',
          builder: (context, state) => GenericFeatureScreen(featureId: state.pathParameters['id'] ?? 'feature'),
        ),
GoRoute(
          path: AppRoutes.rnDashboard,
          builder: (context, state) => const rn_dash.RnDashboard(),
        ),
        GoRoute(
          path: AppRoutes.rpnDashboard,
          builder: (context, state) => const rpn_dash.RpnDashboard(),
        ),
        GoRoute(
          path: AppRoutes.rmtDashboard,
          builder: (context, state) => const rmt_dash.RmtDashboard(),
        ),
        GoRoute(
          path: AppRoutes.pswDashboard,
          builder: (context, state) => const psw_dash.PswDashboard(),
        ),
        GoRoute(
          path: AppRoutes.customerSupportDashboard,
          builder: (context, state) => const customer_support_dash.SupportDashboard(),
        ),
        GoRoute(
          path: AppRoutes.intakeCoordinatorDashboard,
          builder: (context, state) => const intake_coordinator_dash.IntakeDashboard(),
        ),
        GoRoute(
          path: AppRoutes.qualityAssuranceDashboard,
          builder: (context, state) => const quality_assurance_dash.QaDashboard(),
        ),
        GoRoute(
          path: AppRoutes.trainingCoordinatorDashboard,
          builder: (context, state) => const training_coordinator_dash.TrainingCoordinatorDashboard(),
        ),
        GoRoute(
          path: AppRoutes.physioDashboard,
          builder: (context, state) => const physio_dash.PhysioDashboard(),
        ),
        GoRoute(
          path: AppRoutes.chiroDashboard,
          builder: (context, state) => const chiro_dash.ChiroDashboard(),
        ),
        GoRoute(
          path: AppRoutes.occupationalTherapistDashboard,
          builder: (context, state) => const ot_dash.OtDashboard(),
        ),
        GoRoute(
          path: AppRoutes.speechPathologistDashboard,
          builder: (context, state) => const slp_dash.SlpDashboard(),
        ),
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.client, child: child),
        routes: [
        GoRoute(
          path: AppRoutes.patientDashboard,
          builder: (context, state) => const patient_dash.ClientDashboard(),
        ),
        GoRoute(
          path: AppRoutes.familyMemberDashboard,
          builder: (context, state) => const family_member_dash.FamilyDashboard(),
        ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.admin, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.scrumMasterDashboard,
            builder: (context, state) => const scrum_master_dash.ScrumMasterDashboard(),
          ),
        ],
      ),
    ],
  );
});
