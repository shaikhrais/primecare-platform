const fs = require('fs');
const path = require('path');

const rootLib = path.join(__dirname, 'apps', 'primecare_v4', 'lib');
const appRoutesPath = path.join(rootLib, 'routes', 'app_routes.dart');
const appRouterPath = path.join(rootLib, 'routes', 'app_router.dart');

const structure = {
  // 1. Corporate / Head Office
  'corporate/roles/ceo': ['ceo_dashboard.dart', 'ceo_layout.dart', 'ceo_sidebar.dart', 'ceo_topbar.dart', 'ceo_settings.dart', 'analytics_dashboard.dart', 'financial_overview.dart'],
  'corporate/roles/coo': ['coo_dashboard.dart', 'coo_layout.dart', 'operations_overview.dart'],
  'corporate/roles/cfo': ['cfo_dashboard.dart', 'cfo_layout.dart', 'financial_reports.dart'],
  'corporate/roles/cto': ['cto_dashboard.dart', 'cto_layout.dart', 'system_settings.dart'],
  'corporate/roles/compliance_manager': ['compliance_dashboard.dart', 'compliance_tracking.dart', 'compliance_layout.dart'],
  'corporate/roles/head_of_bus_dev': ['bus_dev_dashboard.dart', 'global_leads.dart'],
  'corporate/roles/head_of_marketing': ['marketing_overview.dart'],
  'corporate/roles/training_director': ['training_admin_dashboard.dart'],

  // 2. Business Development Team
  'business_development/roles/regional_manager_ontario': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/regional_manager_usa': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/franchise_sales_manager': ['pipeline_dashboard.dart', 'franchise_pipeline.dart'],
  'business_development/roles/partnership_manager': ['partner_management.dart'],
  'business_development/roles/territory_expansion_manager': ['expansion_dashboard.dart'],

  // 3. Franchise Level
  'franchise/roles/franchise_owner': ['owner_dashboard.dart', 'daily_operations.dart', 'franchise_layout.dart'],
  'franchise/roles/operations_manager': ['ops_manager_dashboard.dart', 'staff_management.dart'],
  'franchise/roles/scheduler': ['scheduling_dashboard.dart', 'master_schedule.dart'],
  'franchise/roles/billing_admin': ['billing_dashboard.dart', 'invoices.dart'],
  'franchise/roles/hr_hiring': ['hr_dashboard.dart', 'candidate_pipeline.dart'],

  // 4. Clinical Team
  'clinic/roles/rn': ['rn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart', 'rn_layout.dart'],
  'clinic/roles/rpn': ['rpn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart'],
  'clinic/roles/rmt': ['rmt_dashboard.dart', 'treatment_notes.dart', 'rmt_layout.dart'],
  'clinic/roles/psw': ['psw_dashboard.dart', 'daily_logs.dart'],

  // 5. Support Team
  'support/roles/customer_support': ['support_dashboard.dart', 'tickets.dart', 'issue_tracking.dart', 'support_layout.dart'],
  'support/roles/intake_coordinator': ['intake_dashboard.dart', 'client_intake_forms.dart'],
  'support/roles/quality_assurance': ['qa_dashboard.dart', 'qa_reports.dart'],
  'support/roles/training_coordinator': ['training_modules.dart'],

  // 6. Marketing and Local Growth
  'marketing/roles/local_marketing_manager': ['local_campaigns.dart', 'marketing_layout.dart'],
  'marketing/roles/community_outreach': ['community_events.dart'],
  'marketing/roles/territory_sales_manager': ['lead_generation.dart'],

  // 7. Client Side
  'client/roles/client': ['client_dashboard.dart', 'book_appointment.dart', 'view_schedule.dart', 'chat_with_provider.dart', 'payments.dart', 'client_layout.dart'],
  'client/roles/family_member': ['family_dashboard.dart', 'linked_accounts.dart'],
};

// Utilities to convert camelCase, etc.
function toCamel(str) {
  return str.replace(/_([a-z])/g, (g) => g[1].toUpperCase());
}
function toPascal(str) {
  const camel = toCamel(str);
  return camel.charAt(0).toUpperCase() + camel.slice(1);
}

let routesFileContents = `class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Common Global Routing
  static const String globalSettings = '/common/settings';
  static const String globalProfile = '/common/profile';
  static const String notificationCenter = '/common/notifications';
  static const String messagingHub = '/common/messages';
  static const String documentVault = '/common/documents';

`;

let routerImports = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';

// Screens
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

// Shared Components
import '../shared_screens/global_settings.dart';
import '../shared_screens/global_profile.dart';
import '../shared_screens/notification_center.dart';
import '../shared_screens/messaging_hub.dart';
import '../shared_screens/document_vault.dart';

// Master Layout System
import '../components/layouts/master_layout.dart';

// Office Roles
`;

let shellAdminChildren = [];
let shellProviderChildren = [];
let shellClientChildren = [];

for (const [folder, files] of Object.entries(structure)) {
  const office = folder.split('/')[0];
  const role = folder.split('/')[2];
  
  // Find the dashboard file for this role
  let dashFile = files.find(f => f.includes('dashboard.dart')) || files[0];
  const dashName = dashFile.replace('.dart', '');
  
  const routeVarName = toCamel(role) + 'Dashboard';
  const pathVal = \`/offices/\${office}/roles/\${role}/dashboard\`;
  
  routesFileContents += \`  static const String \${routeVarName} = '\${pathVal}';\n\`;
  
  const compName = toPascal(dashName) + 'Screen'; // Assuming our scaffold uses PlaceholderScreen or similar, actually wait.
  // We scaffolded it with "PlaceholderScreen" identically for ALL of them. Let's fix that too.
  routerImports += \`import '../offices/\${office}/roles/\${role}/\${dashFile}';\n\`;
  
  // Actually, we must bind them to the correct PlaceholderScreen, but in Dart, two imports with the same class name conflict.
  // Wait, I didn't namespace the placeholder screens in the Flutter scaffold script! They are all called \`PlaceholderScreen\`!
  // I need to update the scaffold script or use \`as\` in imports!
  
  const alias = toPascal(role) + 'Dash';
  routerImports = routerImports.replace(\`import '../offices/\${office}/roles/\${role}/\${dashFile}';\n\`, \`import '../offices/\${office}/roles/\${role}/\${dashFile}' as \${alias};\n\`);
  
  const goRouteBlock = \`
        GoRoute(
          path: AppRoutes.\${routeVarName},
          builder: (context, state) => const \${alias}.PlaceholderScreen(),
        ),\`;
        
  if (['corporate', 'franchise', 'marketing'].includes(office)) {
      shellAdminChildren.push(goRouteBlock);
  } else if (['clinic', 'support'].includes(office)) {
      shellProviderChildren.push(goRouteBlock);
  } else {
      shellClientChildren.push(goRouteBlock);
  }
}

routesFileContents += '}\n';

let routerFileContents = routerImports + \`

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
      
      // Global Shared Screens (No fixed layout Shell, or explicitly none)
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

      // ADMIN SHELL ROUTES (Corporate, Franchise, Marketing)
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.admin, child: child),
        routes: [\${shellAdminChildren.join('\\n')}\n      ],
      ),
      
      // PROVIDER SHELL ROUTES (Clinic, Support)
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.provider, child: child),
        routes: [\${shellProviderChildren.join('\\n')}\n      ],
      ),
      
      // CLIENT SHELL ROUTES
      ShellRoute(
        builder: (context, state, child) => MasterLayout(shellType: AppShellType.client, child: child),
        routes: [\${shellClientChildren.join('\\n')}\n      ],
      ),
    ],
  );
});
\`;

fs.writeFileSync(appRoutesPath, routesFileContents);
console.log('Successfully generated app_routes.dart');

fs.writeFileSync(appRouterPath, routerFileContents);
console.log('Successfully generated app_router.dart');
