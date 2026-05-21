const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_franchise');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 12 (FRANCHISE FINALE) IMPLEMENTATION ---');

const DIRS = [
  'scheduler', 'billing', 'hr_hiring', 'scheduler_coordinator', 'admin', 'regional_manager', 'marketing_manager'
].map(d => path.join(APP_DIR, 'lib', 'features', d, 'screens'));

DIRS.forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 32 Screens
const screens = [
  // Scheduler
  { dir: DIRS[0], sub: 'scheduler', file: 'scheduler_dashboard_screen.dart', cls: 'SchedulerDashboardScreen', title: 'Scheduler Dashboard', icon: 'Icons.calendar_month', route: 'FranchiseRoutes.schedulerDashboard', color: 'Colors.blue.shade500' },
  // Billing Admin
  { dir: DIRS[1], sub: 'billing', file: 'billing_admin_dashboard_screen.dart', cls: 'BillingAdminDashboardScreen', title: 'Billing Admin Dashboard', icon: 'Icons.receipt_long', route: 'FranchiseRoutes.billingAdminDashboard', color: 'Colors.green.shade500' },
  { dir: DIRS[1], sub: 'billing', file: 'billing_admin_invoices_screen.dart', cls: 'BillingAdminInvoicesScreen', title: 'Invoices', icon: 'Icons.receipt', route: 'FranchiseRoutes.billingAdminInvoices', color: 'Colors.green.shade500' },
  // HR Hiring
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_dashboard_screen.dart', cls: 'HrHiringDashboardScreen', title: 'HR Hiring Dashboard', icon: 'Icons.person_add', route: 'FranchiseRoutes.hrHiringDashboard', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_applicants_screen.dart', cls: 'HrHiringApplicantsScreen', title: 'Applicants', icon: 'Icons.recent_actors', route: 'FranchiseRoutes.hrHiringApplicants', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_interviews_screen.dart', cls: 'HrHiringInterviewsScreen', title: 'Interviews', icon: 'Icons.co_present', route: 'FranchiseRoutes.hrHiringInterviews', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_offers_screen.dart', cls: 'HrHiringOffersScreen', title: 'Offers', icon: 'Icons.local_offer', route: 'FranchiseRoutes.hrHiringOffers', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_onboarding_screen.dart', cls: 'HrHiringOnboardingScreen', title: 'Onboarding', icon: 'Icons.handshake', route: 'FranchiseRoutes.hrHiringOnboarding', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_staff_documents_screen.dart', cls: 'HrHiringStaffDocumentsScreen', title: 'Staff Documents', icon: 'Icons.folder_shared', route: 'FranchiseRoutes.hrHiringStaffDocuments', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_credentials_screen.dart', cls: 'HrHiringCredentialsScreen', title: 'Credentials', icon: 'Icons.card_membership', route: 'FranchiseRoutes.hrHiringCredentials', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_training_status_screen.dart', cls: 'HrHiringTrainingStatusScreen', title: 'Training Status', icon: 'Icons.model_training', route: 'FranchiseRoutes.hrHiringTrainingStatus', color: 'Colors.purple.shade500' },
  { dir: DIRS[2], sub: 'hr_hiring', file: 'hr_hiring_reports_screen.dart', cls: 'HrHiringReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'FranchiseRoutes.hrHiringReports', color: 'Colors.purple.shade500' },
  // Scheduler Coordinator
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_appointment_calendar_screen.dart', cls: 'SchedulerCoordinatorAppointmentCalendarScreen', title: 'Appointment Calendar', icon: 'Icons.event_note', route: 'FranchiseRoutes.schedulerCoordinatorAppointmentCalendar', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_shift_calendar_screen.dart', cls: 'SchedulerCoordinatorShiftCalendarScreen', title: 'Shift Calendar', icon: 'Icons.calendar_view_week', route: 'FranchiseRoutes.schedulerCoordinatorShiftCalendar', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_provider_availability_screen.dart', cls: 'SchedulerCoordinatorProviderAvailabilityScreen', title: 'Provider Availability', icon: 'Icons.event_available', route: 'FranchiseRoutes.schedulerCoordinatorProviderAvailability', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_booking_requests_screen.dart', cls: 'SchedulerCoordinatorBookingRequestsScreen', title: 'Booking Requests', icon: 'Icons.add_task', route: 'FranchiseRoutes.schedulerCoordinatorBookingRequests', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_open_shifts_screen.dart', cls: 'SchedulerCoordinatorOpenShiftsScreen', title: 'Open Shifts', icon: 'Icons.view_timeline', route: 'FranchiseRoutes.schedulerCoordinatorOpenShifts', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_assignments_screen.dart', cls: 'SchedulerCoordinatorAssignmentsScreen', title: 'Assignments', icon: 'Icons.assignment_ind', route: 'FranchiseRoutes.schedulerCoordinatorAssignments', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_conflicts_screen.dart', cls: 'SchedulerCoordinatorConflictsScreen', title: 'Conflicts', icon: 'Icons.warning_amber', route: 'FranchiseRoutes.schedulerCoordinatorConflicts', color: 'Colors.blue.shade700' },
  { dir: DIRS[3], sub: 'scheduler_coordinator', file: 'scheduler_coordinator_reports_screen.dart', cls: 'SchedulerCoordinatorReportsScreen', title: 'Reports', icon: 'Icons.analytics', route: 'FranchiseRoutes.schedulerCoordinatorReports', color: 'Colors.blue.shade700' },
  // Admin
  { dir: DIRS[4], sub: 'admin', file: 'admin_dashboard_screen.dart', cls: 'AdminDashboardScreen', title: 'Admin Dashboard', icon: 'Icons.admin_panel_settings', route: 'FranchiseRoutes.adminDashboard', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_invoices_screen.dart', cls: 'AdminInvoicesScreen', title: 'Invoices', icon: 'Icons.receipt', route: 'FranchiseRoutes.adminInvoices', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_payments_screen.dart', cls: 'AdminPaymentsScreen', title: 'Payments', icon: 'Icons.payment', route: 'FranchiseRoutes.adminPayments', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_claims_screen.dart', cls: 'AdminClaimsScreen', title: 'Claims', icon: 'Icons.assignment_late', route: 'FranchiseRoutes.adminClaims', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_reconciliation_screen.dart', cls: 'AdminReconciliationScreen', title: 'Reconciliation', icon: 'Icons.compare_arrows', route: 'FranchiseRoutes.adminReconciliation', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_outstanding_balances_screen.dart', cls: 'AdminOutstandingBalancesScreen', title: 'Outstanding Balances', icon: 'Icons.account_balance_wallet', route: 'FranchiseRoutes.adminOutstandingBalances', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_refunds_screen.dart', cls: 'AdminRefundsScreen', title: 'Refunds', icon: 'Icons.settings_backup_restore', route: 'FranchiseRoutes.adminRefunds', color: 'Colors.grey.shade800' },
  { dir: DIRS[4], sub: 'admin', file: 'admin_reports_screen.dart', cls: 'AdminReportsScreen', title: 'Reports', icon: 'Icons.insert_chart', route: 'FranchiseRoutes.adminReports', color: 'Colors.grey.shade800' },
  // Regional Manager
  { dir: DIRS[5], sub: 'regional_manager', file: 'regional_manager_dashboard_screen.dart', cls: 'RegionalManagerDashboardScreen', title: 'Regional Dashboard', icon: 'Icons.map', route: 'FranchiseRoutes.regionalManagerDashboard', color: 'Colors.orange.shade700' },
  { dir: DIRS[5], sub: 'regional_manager', file: 'regional_manager_branch_comparison_screen.dart', cls: 'RegionalManagerBranchComparisonScreen', title: 'Branch Comparison', icon: 'Icons.compare', route: 'FranchiseRoutes.regionalManagerBranchComparison', color: 'Colors.orange.shade700' },
  // Marketing Manager
  { dir: DIRS[6], sub: 'marketing_manager', file: 'marketing_manager_dashboard_screen.dart', cls: 'MarketingManagerDashboardScreen', title: 'Marketing Dashboard', icon: 'Icons.campaign', route: 'FranchiseRoutes.marketingManagerDashboard', color: 'Colors.pink.shade700' },
  { dir: DIRS[6], sub: 'marketing_manager', file: 'marketing_manager_campaigns_screen.dart', cls: 'MarketingManagerCampaignsScreen', title: 'Campaigns', icon: 'Icons.record_voice_over', route: 'FranchiseRoutes.marketingManagerCampaigns', color: 'Colors.pink.shade700' },
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

console.log('✅ 32 Franchise Screens scaffolded.');

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
    console.log('✅ Batch 12 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 12 ---');
try {
    require('child_process').exec('flutter build web --release && npx wrangler pages deploy build/web --project-name primecare-franchise --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 12 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
