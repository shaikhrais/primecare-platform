import os
import json

root_lib = os.path.join(os.path.dirname(__file__), 'apps', 'primecare_v4', 'lib')
app_routes_path = os.path.join(root_lib, 'routes', 'app_routes.dart')
app_router_path = os.path.join(root_lib, 'routes', 'app_router.dart')

structure = {
  'corporate/roles/ceo': ['ceo_dashboard.dart', 'ceo_layout.dart', 'ceo_sidebar.dart', 'ceo_topbar.dart', 'ceo_settings.dart', 'analytics_dashboard.dart', 'financial_overview.dart'],
  'corporate/roles/coo': ['coo_dashboard.dart', 'coo_layout.dart', 'operations_overview.dart'],
  'corporate/roles/cfo': ['cfo_dashboard.dart', 'cfo_layout.dart', 'financial_reports.dart'],
  'corporate/roles/cto': ['cto_dashboard.dart', 'cto_layout.dart', 'system_settings.dart'],
  'corporate/roles/compliance_manager': ['compliance_dashboard.dart', 'compliance_tracking.dart', 'compliance_layout.dart'],
  'corporate/roles/head_of_bus_dev': ['bus_dev_dashboard.dart', 'global_leads.dart'],
  'corporate/roles/head_of_marketing': ['marketing_overview.dart'],
  'corporate/roles/training_director': ['training_admin_dashboard.dart'],

  'business_development/roles/regional_manager_ontario': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/regional_manager_usa': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/franchise_sales_manager': ['pipeline_dashboard.dart', 'franchise_pipeline.dart'],
  'business_development/roles/partnership_manager': ['partner_management.dart'],
  'business_development/roles/territory_expansion_manager': ['expansion_dashboard.dart'],

  'franchise/roles/franchise_owner': ['owner_dashboard.dart', 'daily_operations.dart', 'franchise_layout.dart'],
  'franchise/roles/operations_manager': ['ops_manager_dashboard.dart', 'staff_management.dart'],
  'franchise/roles/scheduler': ['scheduling_dashboard.dart', 'master_schedule.dart'],
  'franchise/roles/billing_admin': ['billing_dashboard.dart', 'invoices.dart'],
  'franchise/roles/hr_hiring': ['hr_dashboard.dart', 'candidate_pipeline.dart'],

  'clinic/roles/rn': ['rn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart', 'rn_layout.dart'],
  'clinic/roles/rpn': ['rpn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart'],
  'clinic/roles/rmt': ['rmt_dashboard.dart', 'treatment_notes.dart', 'rmt_layout.dart'],
  'clinic/roles/psw': ['psw_dashboard.dart', 'daily_logs.dart'],

  'support/roles/customer_support': ['support_dashboard.dart', 'tickets.dart', 'issue_tracking.dart', 'support_layout.dart'],
  'support/roles/intake_coordinator': ['intake_dashboard.dart', 'client_intake_forms.dart'],
  'support/roles/quality_assurance': ['qa_dashboard.dart', 'qa_reports.dart'],
  'support/roles/training_coordinator': ['training_modules.dart'],

  'marketing/roles/local_marketing_manager': ['local_campaigns.dart', 'marketing_layout.dart'],
  'marketing/roles/community_outreach': ['community_events.dart'],
  'marketing/roles/territory_sales_manager': ['lead_generation.dart'],

  'client/roles/client': ['client_dashboard.dart', 'book_appointment.dart', 'view_schedule.dart', 'chat_with_provider.dart', 'payments.dart', 'client_layout.dart'],
  'client/roles/family_member': ['family_dashboard.dart', 'linked_accounts.dart'],
}

def to_camel(s):
    parts = s.split('_')
    return parts[0] + ''.join(word.capitalize() for word in parts[1:])

def to_pascal(s):
    camel = to_camel(s)
    return camel[0].upper() + camel[1:]

routes_content = """class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  static const String globalSettings = '/common/settings';
  static const String globalProfile = '/common/profile';
  static const String notificationCenter = '/common/notifications';
  static const String messagingHub = '/common/messages';
  static const String documentVault = '/common/documents';

"""

router_imports = """import 'package:flutter/material.dart';
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

"""

shell_admin = []
shell_provider = []
shell_client = []

for folder, files in structure.items():
    office = folder.split('/')[0]
    role = folder.split('/')[2]
    
    dash_file = next((f for f in files if 'dashboard.dart' in f), files[0])
    dash_name = dash_file.replace('.dart', '')
    
    route_var_name = to_camel(role) + 'Dashboard'
    path_val = f'/offices/{office}/roles/{role}/dashboard'
    
    routes_content += f"  static const String {route_var_name} = '{path_val}';\n"
    
    alias = to_pascal(role) + 'Dash'
    router_imports += f"import '../offices/{office}/roles/{role}/{dash_file}' as {alias};\n"
    
    go_route_block = f"""        GoRoute(
          path: AppRoutes.{route_var_name},
          builder: (context, state) => const {alias}.PlaceholderScreen(),
        ),"""
        
    if office in ['corporate', 'franchise', 'marketing', 'business_development']:
        shell_admin.append(go_route_block)
    elif office in ['clinic', 'support']:
        shell_provider.append(go_route_block)
    else:
        shell_client.append(go_route_block)

routes_content += "}\n"

router_content = router_imports + """
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
""" + '\n'.join(shell_admin) + """
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.provider, child: child),
        routes: [
""" + '\n'.join(shell_provider) + """
        ],
      ),
      
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.client, child: child),
        routes: [
""" + '\n'.join(shell_client) + """
        ],
      ),
    ],
  );
});
"""

with open(app_routes_path, 'w') as f:
    f.write(routes_content)
print('Successfully generated app_routes.dart')

with open(app_router_path, 'w') as f:
    f.write(router_content)
print('Successfully generated app_router.dart')
