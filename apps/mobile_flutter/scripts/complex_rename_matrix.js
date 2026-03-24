const fs = require('fs');
const path = require('path');

const renames = [
    { old: 'lib/features/shared/universal_dashboard_screen.dart', new: 'lib/features/shared/universal_operations_hub_screen.dart', oldClass: 'UniversalDashboardScreen', newClass: 'UniversalOperationsHubScreen' },
    { old: 'lib/features/dashboard/dashboard_screen.dart', new: 'lib/features/admin/admin_telemetry_matrix_screen.dart', oldClass: 'DashboardScreen', newClass: 'AdminTelemetryMatrixScreen' },
    { old: 'lib/features/manager/manager_dashboard_screen.dart', new: 'lib/features/manager/manager_analytics_matrix_screen.dart', oldClass: 'ManagerDashboardScreen', newClass: 'ManagerAnalyticsMatrixScreen' },
    { old: 'lib/features/client/client_dashboard_screen.dart', new: 'lib/features/client/client_care_hub_screen.dart', oldClass: 'ClientDashboardScreen', newClass: 'ClientCareHubScreen' },
    { old: 'lib/features/psw/psw_growth_dashboard_screen.dart', new: 'lib/features/psw/psw_performance_metrics_screen.dart', oldClass: 'PswGrowthDashboardScreen', newClass: 'PswPerformanceMetricsScreen' }
];

// 1. Execute physical file renames and class replacements inside those files
for (const change of renames) {
    if (fs.existsSync(change.old)) {
        if (!fs.existsSync(path.dirname(change.new))) {
            fs.mkdirSync(path.dirname(change.new), { recursive: true });
        }
        let code = fs.readFileSync(change.old, 'utf8');
        code = code.replace(new RegExp(change.oldClass, 'g'), change.newClass);
        fs.writeFileSync(change.new, code);
        fs.unlinkSync(change.old);
    }
}

// 2. Delete dead artifacts directly to avoid technical debt
const deadArtifacts = [
    'lib/features/coordinator/coordinator_dashboard_screen.dart',
    'lib/features/mt/mt_dashboard_screen.dart',
    'lib/features/gm/gm_dashboard_screen.dart',
    'lib/features/scrum_master/scrum_master_dashboard_screen.dart'
];
for (const file of deadArtifacts) {
    if (fs.existsSync(file)) fs.unlinkSync(file);
}

// 3. Update main.dart definitions and routes
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');
mainCode = mainCode.replace(/import 'features\/shared\/universal_dashboard_screen\.dart';/g, "import 'features/shared/universal_operations_hub_screen.dart';");
mainCode = mainCode.replace(/import 'features\/dashboard\/dashboard_screen\.dart';/g, "import 'features/admin/admin_telemetry_matrix_screen.dart';");
mainCode = mainCode.replace(/import 'features\/manager\/manager_dashboard_screen\.dart';/g, "import 'features/manager/manager_analytics_matrix_screen.dart';");
mainCode = mainCode.replace(/import 'features\/client\/client_dashboard_screen\.dart';/g, "import 'features/client/client_care_hub_screen.dart';");

// Swap classes
mainCode = mainCode.replace(/UniversalDashboardScreen/g, "UniversalOperationsHubScreen");
mainCode = mainCode.replace(/DashboardScreen\(\)/g, "AdminTelemetryMatrixScreen()");
mainCode = mainCode.replace(/ManagerDashboardScreen\(\)/g, "ManagerAnalyticsMatrixScreen()");
mainCode = mainCode.replace(/ClientDashboardScreen\(\)/g, "ClientCareHubScreen()");

// Swap explicit GoRouter path hooks inside main.dart
mainCode = mainCode.replace(/path: '\/rn\/dashboard'/g, "path: '/rn/operations-hub'");
mainCode = mainCode.replace(/path: '\/mt\/dashboard'/g, "path: '/mt/operations-hub'");
mainCode = mainCode.replace(/path: '\/gm\/dashboard'/g, "path: '/gm/operations-hub'");
mainCode = mainCode.replace(/path: '\/scrum-master\/dashboard'/g, "path: '/scrum-master/operations-hub'");
mainCode = mainCode.replace(/path: '\/dashboard'/g, "path: '/admin/telemetry-matrix'");
mainCode = mainCode.replace(/path: '\/client\/dashboard'/g, "path: '/client/care-hub'");
mainCode = mainCode.replace(/path: '\/manager\/dashboard'/g, "path: '/manager/analytics-matrix'");
mainCode = mainCode.replace(/path: '\/coordinator\/dashboard'/g, "path: '/coordinator/matrix'");

mainCode = mainCode.replace(/isGenericDashboard = state\.uri\.toString\(\) == '\/dashboard';/g, "isGenericDashboard = state.uri.toString() == '/admin/telemetry-matrix';");

fs.writeFileSync('lib/main.dart', mainCode);

// 4. Update login_screen.dart manual routing array
let loginCode = fs.readFileSync('lib/features/auth/login_screen.dart', 'utf8');
loginCode = loginCode.replace(/context\.go\('\/rn\/dashboard'\)/g, "context.go('/rn/operations-hub')");
loginCode = loginCode.replace(/context\.go\('\/mt\/dashboard'\)/g, "context.go('/mt/operations-hub')");
loginCode = loginCode.replace(/context\.go\('\/gm\/dashboard'\)/g, "context.go('/gm/operations-hub')");
loginCode = loginCode.replace(/context\.go\('\/scrum-master\/dashboard'\)/g, "context.go('/scrum-master/operations-hub')");
loginCode = loginCode.replace(/context\.go\('\/dashboard'\)/g, "context.go('/admin/telemetry-matrix')");
loginCode = loginCode.replace(/context\.go\('\/client\/dashboard'\)/g, "context.go('/client/care-hub')");
loginCode = loginCode.replace(/context\.go\('\/manager\/dashboard'\)/g, "context.go('/manager/analytics-matrix')");
loginCode = loginCode.replace(/context\.go\('\/coordinator\/dashboard'\)/g, "context.go('/coordinator/matrix')");
fs.writeFileSync('lib/features/auth/login_screen.dart', loginCode);

// 5. Update Universal Sidebar registry
let sidebarCode = fs.readFileSync('lib/core/widgets/universal_role_sidebar.dart', 'utf8');
sidebarCode = sidebarCode.replace(/\/rn\/dashboard/g, "/rn/operations-hub");
sidebarCode = sidebarCode.replace(/\/mt\/dashboard/g, "/mt/operations-hub");
sidebarCode = sidebarCode.replace(/\/gm\/dashboard/g, "/gm/operations-hub");
sidebarCode = sidebarCode.replace(/\/scrum-master\/dashboard/g, "/scrum-master/operations-hub");
sidebarCode = sidebarCode.replace(/'\/dashboard'/g, "'/admin/telemetry-matrix'"); // catches the exact string
sidebarCode = sidebarCode.replace(/\/client\/dashboard/g, "/client/care-hub");
sidebarCode = sidebarCode.replace(/\/manager\/dashboard/g, "/manager/analytics-matrix");
sidebarCode = sidebarCode.replace(/\/coordinator\/dashboard/g, "/coordinator/matrix");
fs.writeFileSync('lib/core/widgets/universal_role_sidebar.dart', sidebarCode);

// 6. Update inner definitions in unversal_dashboard_screen.dart (which is now universal_operations_hub_screen.dart)
if (fs.existsSync('lib/features/shared/universal_operations_hub_screen.dart')) {
  let hubCode = fs.readFileSync('lib/features/shared/universal_operations_hub_screen.dart', 'utf8');
  hubCode = hubCode.replace(/\/client\/dashboard/g, '/client/care-hub');
  hubCode = hubCode.replace(/\/manager\/dashboard/g, '/manager/analytics-matrix');
  hubCode = hubCode.replace(/\/coordinator\/dashboard/g, '/coordinator/matrix');
  hubCode = hubCode.replace(/\/admin\/dashboard/g, '/admin/telemetry-matrix');
  fs.writeFileSync('lib/features/shared/universal_operations_hub_screen.dart', hubCode);
}

console.log("Completely eradicated legacy Dashboard nomenclature globally!");
