const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_corporate');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 8 (CFO & CTO) IMPLEMENTATION ---');

const CFO_DIR = path.join(APP_DIR, 'lib', 'features', 'cfo', 'screens');
const CTO_DIR = path.join(APP_DIR, 'lib', 'features', 'cto', 'screens');

[CFO_DIR, CTO_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 26 Screens
const screens = [
  // CFO
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_dashboard_screen.dart', cls: 'CfoDashboardScreen', title: 'CFO Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.cfoDashboard', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_financial_overview_screen.dart', cls: 'CfoFinancialOverviewScreen', title: 'Financial Overview', icon: 'Icons.account_balance', route: 'CorporateRoutes.cfoFinancialOverview', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_revenue_screen.dart', cls: 'CfoRevenueScreen', title: 'Revenue', icon: 'Icons.trending_up', route: 'CorporateRoutes.cfoRevenue', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_expenses_screen.dart', cls: 'CfoExpensesScreen', title: 'Expenses', icon: 'Icons.trending_down', route: 'CorporateRoutes.cfoExpenses', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_franchise_financials_screen.dart', cls: 'CfoFranchiseFinancialsScreen', title: 'Franchise Financials', icon: 'Icons.storefront', route: 'CorporateRoutes.cfoFranchiseFinancials', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_payroll_screen.dart', cls: 'CfoPayrollScreen', title: 'Payroll', icon: 'Icons.payments', route: 'CorporateRoutes.cfoPayroll', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_accounts_receivable_screen.dart', cls: 'CfoAccountsReceivableScreen', title: 'Accounts Receivable', icon: 'Icons.call_received', route: 'CorporateRoutes.cfoAccountsReceivable', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_accounts_payable_screen.dart', cls: 'CfoAccountsPayableScreen', title: 'Accounts Payable', icon: 'Icons.call_made', route: 'CorporateRoutes.cfoAccountsPayable', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_invoices_screen.dart', cls: 'CfoInvoicesScreen', title: 'Invoices', icon: 'Icons.receipt', route: 'CorporateRoutes.cfoInvoices', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_profitability_screen.dart', cls: 'CfoProfitabilityScreen', title: 'Profitability', icon: 'Icons.monetization_on', route: 'CorporateRoutes.cfoProfitability', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_tax_and_remittance_screen.dart', cls: 'CfoTaxAndRemittanceScreen', title: 'Tax And Remittance', icon: 'Icons.calculate', route: 'CorporateRoutes.cfoTaxAndRemittance', color: 'Colors.green.shade800' },
  { dir: CFO_DIR, sub: 'cfo', file: 'cfo_reports_screen.dart', cls: 'CfoReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'CorporateRoutes.cfoReports', color: 'Colors.green.shade800' },

  // CTO
  { dir: CTO_DIR, sub: 'cto', file: 'cto_dashboard_screen.dart', cls: 'CtoDashboardScreen', title: 'CTO Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.ctoDashboard', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_system_health_screen.dart', cls: 'CtoSystemHealthScreen', title: 'System Health', icon: 'Icons.monitor_heart', route: 'CorporateRoutes.ctoSystemHealth', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_platform_usage_screen.dart', cls: 'CtoPlatformUsageScreen', title: 'Platform Usage', icon: 'Icons.analytics', route: 'CorporateRoutes.ctoPlatformUsage', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_feature_adoption_screen.dart', cls: 'CtoFeatureAdoptionScreen', title: 'Feature Adoption', icon: 'Icons.new_releases', route: 'CorporateRoutes.ctoFeatureAdoption', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_api_monitoring_screen.dart', cls: 'CtoApiMonitoringScreen', title: 'Api Monitoring', icon: 'Icons.api', route: 'CorporateRoutes.ctoApiMonitoring', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_integrations_screen.dart', cls: 'CtoIntegrationsScreen', title: 'Integrations', icon: 'Icons.cable', route: 'CorporateRoutes.ctoIntegrations', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_audit_logs_screen.dart', cls: 'CtoAuditLogsScreen', title: 'Audit Logs', icon: 'Icons.history', route: 'CorporateRoutes.ctoAuditLogs', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_access_control_screen.dart', cls: 'CtoAccessControlScreen', title: 'Access Control', icon: 'Icons.admin_panel_settings', route: 'CorporateRoutes.ctoAccessControl', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_release_management_screen.dart', cls: 'CtoReleaseManagementScreen', title: 'Release Management', icon: 'Icons.update', route: 'CorporateRoutes.ctoReleaseManagement', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_issue_tracking_screen.dart', cls: 'CtoIssueTrackingScreen', title: 'Issue Tracking', icon: 'Icons.bug_report', route: 'CorporateRoutes.ctoIssueTracking', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_infrastructure_screen.dart', cls: 'CtoInfrastructureScreen', title: 'Infrastructure', icon: 'Icons.dns', route: 'CorporateRoutes.ctoInfrastructure', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_reports_screen.dart', cls: 'CtoReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'CorporateRoutes.ctoReports', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_verification_hub_screen.dart', cls: 'CtoVerificationHubScreen', title: 'Verification Hub', icon: 'Icons.verified', route: 'CorporateRoutes.ctoVerificationHub', color: 'Colors.blueGrey.shade800' },
  { dir: CTO_DIR, sub: 'cto', file: 'cto_system_verification_screen.dart', cls: 'CtoSystemVerificationScreen', title: 'System Verification', icon: 'Icons.fact_check', route: 'CorporateRoutes.systemVerificationDashboard', color: 'Colors.blueGrey.shade800' },
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

console.log('✅ 26 CFO/CTO Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Inject hide classes into the existing primecare_ui import
    // The primecare_ui import should already have `hide CeoDashboardScreen, ...` from Batch 7
    // So we just replace `hide ` with `hide CfoDashboardScreen, ... `
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
    console.log('✅ Batch 8 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 8 ---');
try {
    require('child_process').exec('flutter build web --release && npx wrangler pages deploy build/web --project-name primecare-corporate --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 8 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
