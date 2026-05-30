const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_corporate');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 10 (DIRECTORS & SPECIALIZED OPS) IMPLEMENTATION ---');

const DIRS = [
  'busdev', 'marketing', 'shareholder', 'finance', 'volunteer', 'hr', 'cx', 'itadmin', 'legal', 'ciso'
].map(d => path.join(APP_DIR, 'lib', 'features', d, 'screens'));

DIRS.forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 13 Screens
const screens = [
  { dir: DIRS[0], sub: 'busdev', file: 'head_of_bus_dev_dashboard_screen.dart', cls: 'HeadOfBusDevDashboardScreen', title: 'Business Dev Dashboard', icon: 'Icons.handshake', route: 'CorporateRoutes.headOfBusDevDashboard', color: 'Colors.blue.shade600' },
  { dir: DIRS[1], sub: 'marketing', file: 'head_of_marketing_dashboard_screen.dart', cls: 'HeadOfMarketingDashboardScreen', title: 'Marketing Dashboard', icon: 'Icons.campaign', route: 'CorporateRoutes.headOfMarketingDashboard', color: 'Colors.pink.shade600' },
  { dir: DIRS[2], sub: 'shareholder', file: 'shareholder_dashboard_screen.dart', cls: 'ShareholderDashboardScreen', title: 'Shareholder Intelligence', icon: 'Icons.insights', route: 'CorporateRoutes.shareholderIntelligenceDashboard', color: 'Colors.amber.shade800' },
  { dir: DIRS[3], sub: 'finance', file: 'finance_director_dashboard_screen.dart', cls: 'FinanceDirectorDashboardScreen', title: 'Finance Dashboard', icon: 'Icons.account_balance_wallet', route: 'CorporateRoutes.financeDirectorDashboard', color: 'Colors.green.shade600' },
  { dir: DIRS[3], sub: 'finance', file: 'finance_director_cashflow_screen.dart', cls: 'FinanceDirectorCashflowScreen', title: 'Cashflow Management', icon: 'Icons.money', route: 'CorporateRoutes.financeDirectorCashFlow', color: 'Colors.green.shade600' },
  { dir: DIRS[4], sub: 'volunteer', file: 'volunteer_coordinator_dashboard_screen.dart', cls: 'VolunteerCoordinatorDashboardScreen', title: 'Volunteer Coordination', icon: 'Icons.volunteer_activism', route: 'CorporateRoutes.volunteerCoordinatorDashboard', color: 'Colors.red.shade400' },
  { dir: DIRS[5], sub: 'hr', file: 'hr_manager_dashboard_screen.dart', cls: 'HrManagerDashboardScreen', title: 'HR Manager Dashboard', icon: 'Icons.badge', route: 'CorporateRoutes.hrManagerDashboard', color: 'Colors.purple.shade600' },
  { dir: DIRS[5], sub: 'hr', file: 'hr_hiring_dashboard_screen.dart', cls: 'HrHiringDashboardScreen', title: 'Hiring Dashboard', icon: 'Icons.person_add', route: 'CorporateRoutes.hrHiringDashboard', color: 'Colors.purple.shade600' },
  { dir: DIRS[5], sub: 'hr', file: 'hr_director_dashboard_screen.dart', cls: 'HrDirectorDashboardScreen', title: 'HR Director Dashboard', icon: 'Icons.groups', route: 'CorporateRoutes.hrDirectorDashboard', color: 'Colors.purple.shade800' },
  { dir: DIRS[6], sub: 'cx', file: 'cx_director_dashboard_screen.dart', cls: 'CxDirectorDashboardScreen', title: 'CX Director Dashboard', icon: 'Icons.sentiment_very_satisfied', route: 'CorporateRoutes.cxDirectorDashboard', color: 'Colors.cyan.shade600' },
  { dir: DIRS[7], sub: 'itadmin', file: 'it_admin_dashboard_screen.dart', cls: 'ItAdminDashboardScreen', title: 'IT Admin Dashboard', icon: 'Icons.admin_panel_settings', route: 'CorporateRoutes.itAdminDashboard', color: 'Colors.blueGrey.shade900' },
  { dir: DIRS[8], sub: 'legal', file: 'legal_dashboard_screen.dart', cls: 'LegalDashboardScreen', title: 'Legal Counsel Dashboard', icon: 'Icons.gavel', route: 'CorporateRoutes.legalDashboard', color: 'Colors.brown.shade600' },
  { dir: DIRS[9], sub: 'ciso', file: 'ciso_dashboard_screen.dart', cls: 'CisoDashboardScreen', title: 'CISO Dashboard', icon: 'Icons.security', route: 'CorporateRoutes.cisoDashboard', color: 'Colors.red.shade900' },
];

let importStatements = '';
let routeStatements = '';
let hideClasses = [];

const buildScreen = (s) => `
import 'package:flutter/material.dart';

class ${s.cls} extends StatelessWidget {
  const ${s.cls}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(${s.icon}, size: 40, color: ${s.color}),
                const SizedBox(width: 16),
                Text("${s.title}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${s.color})),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(${s.icon}, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("${s.title} actively running.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
`;

screens.forEach(s => {
  fs.writeFileSync(path.join(s.dir, s.file), buildScreen(s).trim());
  importStatements += `import '../../features/${s.sub}/screens/${s.file}';\n`;
  routeStatements += `      GoRoute(path: ${s.route}, builder: (context, state) => const ${s.cls}()),\n`;
  hideClasses.push(s.cls);
});

console.log('✅ 13 Director/Operations Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Inject hide classes into the existing primecare_ui import
    const hideString = "hide " + hideClasses.join(", ") + ", ";
    if (!content.includes(hideClasses[0])) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'corporate_routes.dart';", "import 'corporate_routes.dart';\n" + importStatements);
    }
    
    // Inject the exact explicit routes right into publicRoutes
    if (!content.includes(screens[0].cls)) {
        content = content.replace(
            "publicRoutes: [", 
            "publicRoutes: [\n" + routeStatements
        );
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 10 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 10 ---');
try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-corporate --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 10 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
