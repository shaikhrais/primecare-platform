import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Layout & Dynamic Routing Modules
import 'package:primecare_mobile/core/layouts/master_layout.dart';
import 'package:primecare_mobile/features/master/auth/login_screen.dart';
import 'package:primecare_mobile/features/master/auth/forgot_password_screen.dart';
import 'package:primecare_mobile/core/routing/screen_registry.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';

// Global Pointer for Database Routes (Phase 24)
List<GoRoute> globalDatabaseRoutes = [];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    errorBuilder: (context, state) {
      return Scaffold(
        body: MasterLayout(
          currentPath: state.uri.toString(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.warning_amber_rounded, size: 80, color: Colors.orangeAccent),
                SizedBox(height: 24),
                Text('404 - Content Not Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                SizedBox(height: 8),
                Text('The requested page does not exist in the role matrix.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ),
      );
    },
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasToken = prefs.containsKey('auth_token');
      final isLoggingIn = state.uri.toString() == AppRoutes.login;
      final isRoot = state.uri.toString() == '/';

      if (!hasToken && !isLoggingIn) return AppRoutes.login;

      if (hasToken && (isLoggingIn || isRoot)) {
        final role = prefs.getString('user_role') ?? 'psw_granular';
        switch (role) {
          case 'founder_ceo': return AppRoutes.founderCeoDashboard;
          case 'coo': return AppRoutes.cooDashboard;
          case 'cfo': return AppRoutes.cfoDashboard;
          case 'cto': return AppRoutes.ctoDashboard;
          case 'compliance': return AppRoutes.complianceDashboard;
          case 'head_bd': return AppRoutes.headBdDashboard;
          case 'head_marketing': return AppRoutes.headMarketingDashboard;
          case 'training_director': return AppRoutes.trainingDirectorDashboard;
          case 'bd_team': return AppRoutes.bdTeamDashboard;
          case 'regional_bd_on': return AppRoutes.regionalBdOnDashboard;
          case 'regional_bd_usa': return AppRoutes.regionalBdUsaDashboard;
          case 'franchise_sales': return AppRoutes.franchiseSalesDashboard;
          case 'partnership_mgr': return AppRoutes.partnershipMgrDashboard;
          case 'territory_expansion': return AppRoutes.territoryExpansionDashboard;
          case 'franchise_level': return AppRoutes.franchiseLevelDashboard;
          case 'franchise_owner': return AppRoutes.franchiseOwnerDashboard;
          case 'operations_mgr': return AppRoutes.operationsMgrDashboard;
          case 'scheduler': return AppRoutes.schedulerDashboard;
          case 'billing': return AppRoutes.billingDashboard;
          case 'hr': return AppRoutes.hrDashboard;
          case 'clinical_team': return AppRoutes.clinicalTeamDashboard;
          case 'rn':
          case 'rn_granular': return AppRoutes.rnGranularDashboard;
          case 'rpn': return AppRoutes.rpnDashboard;
          case 'rmt': return AppRoutes.rmtDashboard;
          case 'psw':
          case 'psw_granular': return AppRoutes.pswGranularDashboard;
          case 'support_team': return AppRoutes.supportTeamDashboard;
          case 'customer_support': return AppRoutes.customerSupportDashboard;
          case 'intake_coordinator': return AppRoutes.intakeCoordinatorDashboard;
          case 'quality_assurance': return AppRoutes.qualityAssuranceDashboard;
          case 'training_coordinator': return AppRoutes.trainingCoordinatorDashboard;
          case 'marketing_growth': return AppRoutes.marketingGrowthDashboard;
          case 'local_marketing': return AppRoutes.localMarketingDashboard;
          case 'community_outreach': return AppRoutes.communityOutreachDashboard;
          case 'territory_sales': return AppRoutes.territorySalesDashboard;
          case 'client':
          case 'client_side': return AppRoutes.clientSideDashboard;
          case 'client_granular': return AppRoutes.clientGranularDashboard;
          case 'family_member': return AppRoutes.familyMemberDashboard;
          // Fallback Mappings for legacy JWT tokens natively routed reliably
          case 'admin': return AppRoutes.founderCeoDashboard;
          case 'manager': return AppRoutes.operationsMgrDashboard;
          case 'coordinator': return AppRoutes.schedulerDashboard;
          case 'gm': return AppRoutes.franchiseOwnerDashboard;
          default: return AppRoutes.pswGranularDashboard;
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // Immersive Communication Suites (Bypass Master Layout)
      GoRoute(
        path: AppRoutes.universalChat,
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_chat', state.pathParameters)
      ),
      GoRoute(
        path: AppRoutes.universalTelehealth,
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_telehealth', {
          'role': state.pathParameters['role'] ?? 'universal',
          'sessionType': state.uri.queryParameters['sessionType'] ?? 'audio',
          'peerId': state.uri.queryParameters['peerId'] ?? ''
        })
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MasterLayout(
            currentPath: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          // The static layout arrays have been entirely decoupled!
          ...globalDatabaseRoutes,
        ],
      ),
    ],
  );
});
