const fs = require('fs');
const path = require('path');

const code = fs.readFileSync('lib/routes/app_router.dart', 'utf8');

// 1. Separate global imports from specific screen imports
const importRegex = /import\s+['"]([^'"]+)['"](?:\s+as\s+(\w+))?;/g;
let match;
const globalImports = new Set();
const routeImports = [];

while ((match = importRegex.exec(code)) !== null) {
    const importPath = match[1];
    const prefix = match[2];
    
    if (!importPath.includes('../offices/')) {
        globalImports.add(match[0]);
    } else {
        routeImports.push({ path: importPath, prefix, line: match[0] });
    }
}

// Ensure the unique group lists
const groups = {
    corporate: { name: 'corporateRoutes', shellType: 'admin', imports: new Set(), routes: [] },
    business_development: { name: 'businessDevelopmentRoutes', shellType: 'admin', imports: new Set(), routes: [] },
    franchise: { name: 'franchiseRoutes', shellType: 'admin', imports: new Set(), routes: [] },
    marketing: { name: 'marketingRoutes', shellType: 'admin', imports: new Set(), routes: [] },
    clinic: { name: 'clinicRoutes', shellType: 'provider', imports: new Set(), routes: [] },
    support: { name: 'supportRoutes', shellType: 'admin', imports: new Set(), routes: [] }, // Wait, which shell type is support? Let's use 'admin' by default, the master routing logic dynamically sets it by role name anyway. 
    client: { name: 'clientRoutes', shellType: 'client', imports: new Set(), routes: [] },
    shared: { name: 'sharedRoutes', shellType: 'none', imports: new Set(), routes: [] },
    core: { name: 'coreRoutes', shellType: 'none', imports: new Set(), routes: [] }
};

// Map file structure explicitly based on path logic
function getGroupFromImport(importPath) {
    if (importPath.includes('/corporate/')) return 'corporate';
    if (importPath.includes('/business_development/')) return 'business_development';
    if (importPath.includes('/franchise/')) return 'franchise';
    if (importPath.includes('/marketing/')) return 'marketing';
    if (importPath.includes('/clinic/')) return 'clinic';
    if (importPath.includes('/support/')) return 'support';
    if (importPath.includes('/client/')) return 'client';
    if (importPath.includes('/shared_screens/')) return 'shared';
    return 'core';
}

// Map each prefix to its group for easy lookup when building routes
const prefixToGroup = {};
for (const imp of routeImports) {
    const groupNode = getGroupFromImport(imp.path);
    if (imp.prefix) {
        prefixToGroup[imp.prefix] = groupNode;
    }
    // Also store the import line associated with this group
    groups[groupNode].imports.add(imp.line);
}

// 2. Extract GoRoutes
// We can find routes matching `GoRoute( path: AppRoutes.X, builder: (context, state) => ... )`
// Since Dart formatting can vary, we'll iterate with a parenthesis balancer
let inRoutes = code.indexOf('routes: [');
let routesBlock = code.substring(inRoutes);
// Actually it's easier to find all GoRoute configurations and map them
let routeMatches = [];
let idx = 0;
while (true) {
    const routeIndex = code.indexOf('GoRoute(', idx);
    if (routeIndex === -1) break;
    
    // balance parentheses
    let open = 0;
    let endIdx = routeIndex;
    let foundOpen = false;
    for (let i = routeIndex; i < code.length; i++) {
        if (code[i] === '(') { open++; foundOpen = true; }
        if (code[i] === ')') { open--; }
        if (foundOpen && open === 0) {
            endIdx = i + 1;
            break;
        }
    }
    
    const slice = code.substring(routeIndex, endIdx);
    
    // figure out which group it belongs to by looking at its content
    // we match `prefix.Component()`
    let group = 'core';
    for (const prefix of Object.keys(prefixToGroup)) {
        if (slice.includes(prefix + '.') || slice.includes('GenericFeatureScreen')) {
            // generic features don't have a prefix, we'd need to guess based on AppRoutes
            // But if it uses a prefix, it's definitely that group.
        }
    }
    
    // Let's refine grouping based on AppRoutes paths!
    let pathMatch = slice.match(/path:\s*AppRoutes\.([a-zA-Z0-9_]+)/);
    if (pathMatch) {
        const pathName = pathMatch[1].toLowerCase();
        if (pathName.includes('ceo') || pathName.includes('coo') || pathName.includes('cfo') || pathName.includes('cto') || pathName.includes('compliance') || pathName.includes('trainingdirector')) {
            group = 'corporate';
        } else if (pathName.includes('regional') || pathName.includes('territory') || pathName.includes('generalmanager') || pathName.includes('franchisesalesmanager') || pathName.includes('partnership')) {
            group = 'business_development';
        } else if (pathName.includes('franchiseowner') || pathName.includes('schedule') || pathName.includes('hr') || pathName.includes('billingadmin') || pathName.includes('operationsmanager')) {
            group = 'franchise'; // 'scheduler' goes to franchise?
        } else if (pathName.includes('marketing') || pathName.includes('community')) {
            group = 'marketing';
        } else if (pathName.includes('rn') || pathName.includes('rpn') || pathName.includes('rmt') || pathName.includes('psw') || pathName.includes('physio') || pathName.includes('chiro') || pathName.includes('speechpath') || pathName.includes('occupational')) {
            group = 'clinic';
        } else if (pathName.includes('support') || pathName.includes('qa') || pathName.includes('intake') || pathName.includes('quality') || pathName.includes('trainingcoordinator')) {
            group = 'support';
        } else if (pathName.includes('client') || pathName.includes('patient') || pathName.includes('familymember') || pathName.includes('lovedone')) {
            group = 'client';
        } else if (pathName.includes('global') || pathName.includes('notification') || pathName.includes('message') || pathName.includes('vault') || pathName.includes('messaginghub') || pathName.includes('documentvault')) {
            group = 'shared';
        } else {
            group = 'core';
        }

        // Fix overlaps. For instance "territorysamesmanager" is business_development, but marketing has territory too?
        // Let's use the explicit `import as xxx` mapping as source of truth when possible
        for (const [prefix, mappedGroup] of Object.entries(prefixToGroup)) {
            if (slice.includes(prefix + '.')) {
                group = mappedGroup;
                break;
            }
        }
    }
    
    // Add slice to group
    // Ensure we avoid duplicates
    let cleanSlice = slice.trim();
    
    if (!groups[group].routes.some(existing => existing === cleanSlice)) {
        groups[group].routes.push(cleanSlice);
    }
    
    idx = endIdx;
}

// 3. Write individual files
for (const [groupKey, groupData] of Object.entries(groups)) {
    if (groupKey === 'core') continue; // core logic stays in app_router.dart or is rebuilt
    
    // Adjust imports for depth: group files are in lib/routes/groups, which is 1 deeper than lib/routes
    let mappedImports = [...groupData.imports].map(line => {
        return line.replace(/import\s+['"]\.\.\//g, "import '../../"); // go up an extra level
    });
    
    // Bring global dependencies
    let fileContent = `import 'package:go_router/go_router.dart';
import '../app_routes.dart';
import '../../components/generic_feature_screen.dart';

${mappedImports.join('\n')}

final List<RouteBase> ${groupData.name} = [
  ${groupData.routes.join(',\n  ')}
];
`;
    fs.writeFileSync(`lib/routes/groups/${groupKey}_routes.dart`, fileContent);
}

// 4. Regenerate app_router.dart skeleton
const newRouterContent = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../components/layouts/master_layout.dart';

import 'groups/corporate_routes.dart';
import 'groups/business_development_routes.dart';
import 'groups/franchise_routes.dart';
import 'groups/marketing_routes.dart';
import 'groups/clinic_routes.dart';
import 'groups/support_routes.dart';
import 'groups/client_routes.dart';
import 'groups/shared_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.forgotPassword;
      final isSplash = state.matchedLocation == AppRoutes.splash;

      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      if (isSplash) return null;

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
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          final role = authState.role ?? '';
          AppShellType type = AppShellType.none;
          if (role == 'ceo' ||
              role.endsWith('manager') ||
              role == 'scrum_master' || role.endsWith('director')) {
            type = AppShellType.admin;
          } else if (role == 'client' || role == 'family_member') {
            type = AppShellType.client;
          } else if (role.isNotEmpty) {
            type = AppShellType.provider;
          }
          return MasterLayout(shellType: type, child: child);
        },
        routes: [
          ...sharedRoutes,
          ...corporateRoutes,
          ...businessDevelopmentRoutes,
          ...marketingRoutes,
          ...franchiseRoutes,
          ...clinicRoutes,
          ...supportRoutes,
          ...clientRoutes,
        ],
      ),
    ],
  );
});
`;

fs.writeFileSync('lib/routes/app_router.dart', newRouterContent);
console.log('Successfully completed router replacement');
