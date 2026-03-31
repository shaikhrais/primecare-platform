import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

import '../office/corporate/founder_ceo_dashboard.dart';
import '../office/corporate/coo_dashboard.dart';
import '../office/corporate/cfo_dashboard.dart';
import '../office/corporate/cto_dashboard.dart';
import '../office/corporate/compliance_manager_dashboard.dart';
import '../office/corporate/head_business_development_dashboard.dart';
import '../office/corporate/head_marketing_dashboard.dart';
import '../office/corporate/training_director_dashboard.dart';
import '../office/business_development/regional_manager_on_dashboard.dart';
import '../office/business_development/regional_manager_us_dashboard.dart';
import '../office/business_development/franchise_sales_manager_dashboard.dart';
import '../office/business_development/partnership_manager_dashboard.dart';
import '../office/business_development/territory_expansion_manager_dashboard.dart';
import '../office/franchise/franchise_owner_dashboard.dart';
import '../office/franchise/operations_manager_dashboard.dart';
import '../office/franchise/scheduler_coordinator_dashboard.dart';
import '../office/franchise/billing_admin_dashboard.dart';
import '../office/franchise/hr_hiring_dashboard.dart';
import '../office/clinical/rn_dashboard.dart';
import '../office/clinical/rpn_dashboard.dart';
import '../office/clinical/rmt_dashboard.dart';
import '../office/clinical/psw_dashboard.dart';
import '../office/support/customer_support_dashboard.dart';
import '../office/support/intake_coordinator_dashboard.dart';
import '../office/support/quality_assurance_dashboard.dart';
import '../office/support/training_coordinator_dashboard.dart';
import '../office/marketing/local_marketing_manager_dashboard.dart';
import '../office/marketing/community_outreach_dashboard.dart';
import '../office/marketing/territory_sales_manager_dashboard.dart';
import '../office/client/client_dashboard.dart';
import '../office/client/family_member_dashboard.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authNotifier,
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
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.founderCeoDashboard,
        builder: (context, state) => const FounderCeoDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.cooDashboard,
        builder: (context, state) => const CooDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.cfoDashboard,
        builder: (context, state) => const CfoDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.ctoDashboard,
        builder: (context, state) => const CtoDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.complianceManagerDashboard,
        builder: (context, state) => const ComplianceManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.headBusinessDevelopmentDashboard,
        builder: (context, state) => const HeadBusinessDevelopmentDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.headMarketingDashboard,
        builder: (context, state) => const HeadMarketingDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.trainingDirectorDashboard,
        builder: (context, state) => const TrainingDirectorDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.regionalManagerOnDashboard,
        builder: (context, state) => const RegionalManagerOnDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.regionalManagerUsDashboard,
        builder: (context, state) => const RegionalManagerUsDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.franchiseSalesManagerDashboard,
        builder: (context, state) => const FranchiseSalesManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.partnershipManagerDashboard,
        builder: (context, state) => const PartnershipManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.territoryExpansionManagerDashboard,
        builder: (context, state) => const TerritoryExpansionManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.franchiseOwnerDashboard,
        builder: (context, state) => const FranchiseOwnerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.operationsManagerDashboard,
        builder: (context, state) => const OperationsManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.schedulerCoordinatorDashboard,
        builder: (context, state) => const SchedulerCoordinatorDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.billingAdminDashboard,
        builder: (context, state) => const BillingAdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.hrHiringDashboard,
        builder: (context, state) => const HrHiringDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.rnDashboard,
        builder: (context, state) => const RnDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.rpnDashboard,
        builder: (context, state) => const RpnDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.rmtDashboard,
        builder: (context, state) => const RmtDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.pswDashboard,
        builder: (context, state) => const PswDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerSupportDashboard,
        builder: (context, state) => const CustomerSupportDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.intakeCoordinatorDashboard,
        builder: (context, state) => const IntakeCoordinatorDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.qualityAssuranceDashboard,
        builder: (context, state) => const QualityAssuranceDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.trainingCoordinatorDashboard,
        builder: (context, state) => const TrainingCoordinatorDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.localMarketingManagerDashboard,
        builder: (context, state) => const LocalMarketingManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.communityOutreachDashboard,
        builder: (context, state) => const CommunityOutreachDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.territorySalesManagerDashboard,
        builder: (context, state) => const TerritorySalesManagerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.clientDashboard,
        builder: (context, state) => const ClientDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.familyMemberDashboard,
        builder: (context, state) => const FamilyMemberDashboardScreen(),
      ),
    ],
  );
});
