const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_franchise');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 11 (FRANCHISE OWNER & OPS) IMPLEMENTATION ---');

const OWNER_DIR = path.join(APP_DIR, 'lib', 'features', 'owner', 'screens');
const OPS_DIR = path.join(APP_DIR, 'lib', 'features', 'ops', 'screens');

[OWNER_DIR, OPS_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 18 Screens
const screens = [
  // Franchise Owner
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_dashboard_screen.dart', cls: 'FranchiseOwnerDashboardScreen', title: 'Franchise Owner Dashboard', icon: 'Icons.domain', route: 'FranchiseRoutes.franchiseOwnerDashboard', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_branch_overview_screen.dart', cls: 'FranchiseOwnerBranchOverviewScreen', title: 'Branch Overview', icon: 'Icons.account_balance', route: 'FranchiseRoutes.franchiseOwnerBranchOverview', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_financial_snapshot_screen.dart', cls: 'FranchiseOwnerFinancialSnapshotScreen', title: 'Financial Snapshot', icon: 'Icons.monetization_on', route: 'FranchiseRoutes.franchiseOwnerFinancialSnapshot', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_staff_screen.dart', cls: 'FranchiseOwnerStaffScreen', title: 'Staff', icon: 'Icons.groups', route: 'FranchiseRoutes.franchiseOwnerStaff', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_appointments_screen.dart', cls: 'FranchiseOwnerAppointmentsScreen', title: 'Appointments', icon: 'Icons.event', route: 'FranchiseRoutes.franchiseOwnerAppointments', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_clients_screen.dart', cls: 'FranchiseOwnerClientsScreen', title: 'Clients', icon: 'Icons.people', route: 'FranchiseRoutes.franchiseOwnerClients', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_compliance_screen.dart', cls: 'FranchiseOwnerComplianceScreen', title: 'Compliance', icon: 'Icons.verified', route: 'FranchiseRoutes.franchiseOwnerCompliance', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_reports_screen.dart', cls: 'FranchiseOwnerReportsScreen', title: 'Reports', icon: 'Icons.insert_chart', route: 'FranchiseRoutes.franchiseOwnerReports', color: 'Colors.blue.shade900' },
  { dir: OWNER_DIR, sub: 'owner', file: 'franchise_owner_hiring_screen.dart', cls: 'FranchiseOwnerHiringScreen', title: 'Hiring', icon: 'Icons.person_add', route: 'FranchiseRoutes.franchiseOwnerHiring', color: 'Colors.blue.shade900' },

  // Operations Manager
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_dashboard_screen.dart', cls: 'OperationsManagerDashboardScreen', title: 'Operations Dashboard', icon: 'Icons.dashboard', route: 'FranchiseRoutes.operationsManagerDashboard', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_daily_operations_screen.dart', cls: 'OperationsManagerDailyOperationsScreen', title: 'Daily Operations', icon: 'Icons.settings', route: 'FranchiseRoutes.operationsManagerDailyOperations', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_schedule_screen.dart', cls: 'OperationsManagerScheduleScreen', title: 'Schedule', icon: 'Icons.schedule', route: 'FranchiseRoutes.operationsManagerSchedule', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_shifts_screen.dart', cls: 'OperationsManagerShiftsScreen', title: 'Shifts', icon: 'Icons.work', route: 'FranchiseRoutes.operationsManagerShifts', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_issues_screen.dart', cls: 'OperationsManagerIssuesScreen', title: 'Issues', icon: 'Icons.report_problem', route: 'FranchiseRoutes.operationsManagerIssues', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_service_quality_screen.dart', cls: 'OperationsManagerServiceQualityScreen', title: 'Service Quality', icon: 'Icons.star', route: 'FranchiseRoutes.operationsManagerServiceQuality', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_staff_coordination_screen.dart', cls: 'OperationsManagerStaffCoordinationScreen', title: 'Staff Coordination', icon: 'Icons.people_outline', route: 'FranchiseRoutes.operationsManagerStaffCoordination', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_attendance_screen.dart', cls: 'OperationsManagerAttendanceScreen', title: 'Attendance', icon: 'Icons.how_to_reg', route: 'FranchiseRoutes.operationsManagerAttendance', color: 'Colors.teal.shade800' },
  { dir: OPS_DIR, sub: 'ops', file: 'operations_manager_reports_screen.dart', cls: 'OperationsManagerReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'FranchiseRoutes.operationsManagerReports', color: 'Colors.teal.shade800' },
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

console.log('✅ 18 Franchise Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Inject hide classes into the existing primecare_ui import
    const hideString = "hide " + hideClasses.join(", ") + ", ";
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\n" + importStatements);
    } else if (content.includes("hide ")) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'franchise_routes.dart';", "import 'franchise_routes.dart';\n" + importStatements);
    }
    
    // Inject the exact explicit routes right into publicRoutes
    if (!content.includes(screens[0].cls)) {
        content = content.replace(
            "publicRoutes: [", 
            "publicRoutes: [\n" + routeStatements
        );
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 11 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 11 ---');
try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-franchise --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 11 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
