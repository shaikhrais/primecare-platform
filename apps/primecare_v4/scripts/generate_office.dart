import 'dart:io';

const Map<String, List<String>> structure = {
  'corporate': [
    'founder_ceo',
    'coo',
    'cfo',
    'cto',
    'compliance_manager',
    'head_business_development',
    'head_marketing',
    'training_director',
  ],
  'business_development': [
    'regional_manager_on',
    'regional_manager_us',
    'franchise_sales_manager',
    'partnership_manager',
    'territory_expansion_manager',
  ],
  'franchise': [
    'franchise_owner',
    'operations_manager',
    'scheduler_coordinator',
    'billing_admin',
    'hr_hiring',
  ],
  'clinical': ['rn', 'rpn', 'rmt', 'psw'],
  'support': [
    'customer_support',
    'intake_coordinator',
    'quality_assurance',
    'training_coordinator',
  ],
  'marketing': [
    'local_marketing_manager',
    'community_outreach',
    'territory_sales_manager',
  ],
  'client': ['client', 'family_member'],
};

String toPascalCase(String word) {
  if (word.isEmpty) return word;
  return word
      .split('_')
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join('');
}

String toCamelCase(String word) {
  if (word.isEmpty) return word;
  final parts = word.split('_');
  return parts[0] +
      parts.skip(1).map((s) => s[0].toUpperCase() + s.substring(1)).join('');
}

void main() async {
  final libDir = Directory('lib/office');
  if (!await libDir.exists()) {
    await libDir.create(recursive: true);
  }

  // 1. Generate Layouts
  final layoutDir = Directory('lib/office/layouts');
  if (!await layoutDir.exists()) await layoutDir.create(recursive: true);

  await File('lib/office/layouts/master_layout.dart').writeAsString('''
import 'package:flutter/material.dart';
import 'sidebar_layout.dart';
import 'top_bar_layout.dart';

class MasterLayout extends StatelessWidget {
  final Widget child;
  const MasterLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarLayout(),
      body: Row(
        children: [
          const SidebarLayout(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
''');

  await File('lib/office/layouts/sidebar_layout.dart').writeAsString('''
import 'package:flutter/material.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: const [
          ListTile(title: Text('Menu Item 1')),
          ListTile(title: Text('Common Dashboard')),
        ],
      ),
    );
  }
}
''');

  await File('lib/office/layouts/top_bar_layout.dart').writeAsString('''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';

class TopBarLayout extends ConsumerWidget implements PreferredSizeWidget {
  const TopBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('PrimeCare Office'),
      actions: [
        const Icon(Icons.notifications),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
             ref.read(authProvider.notifier).logout();
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
''');

  // 2. Generate Role Screens and tracking for routing
  List<String> routeVariables = [];
  List<String> importStatements = [];
  List<String> goRoutes = [];

  for (final entry in structure.entries) {
    final department = entry.key;
    final roles = entry.value;

    final deptDir = Directory('lib/office/$department');
    if (!await deptDir.exists()) await deptDir.create(recursive: true);

    for (final role in roles) {
      final className = '${toPascalCase(role)}DashboardScreen';
      final fileName = '${role}_dashboard.dart';
      final routeVarName = '${toCamelCase(role)}Dashboard';
      final routePath = '/office/$department/$role';

      await File('lib/office/$department/$fileName').writeAsString('''
import 'package:flutter/material.dart';
import '../layouts/master_layout.dart';

class $className extends StatelessWidget {
  const $className({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$className', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text('Welcome to your personalized workspace.'),
          ],
        ),
      ),
    );
  }
}
''');

      routeVariables.add("  static const String $routeVarName = '$routePath';");
      importStatements.add("import '../office/$department/$fileName';");
      goRoutes.add('''
      GoRoute(
        path: AppRoutes.$routeVarName,
        builder: (context, state) => const $className(),
      ),''');
    }
  }

  // 3. Generate app_routes.dart
  final routesDir = Directory('lib/routes');
  if (!await routesDir.exists()) await routesDir.create(recursive: true);

  await File('lib/routes/app_routes.dart').writeAsString('''
class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

${routeVariables.join('\n')}
}
''');

  // 4. Generate app_router.dart
  await File('lib/routes/app_router.dart').writeAsString('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

${importStatements.join('\n')}

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
${goRoutes.join('\n')}
    ],
  );
});
''');

  stdout.writeln(
    'Successfully generated the 36-role PrimeCare V4 architecture!',
  );
}
