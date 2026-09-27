const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_corporate');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 7 (CORPORATE EXEC) IMPLEMENTATION ---');

const CEO_DIR = path.join(APP_DIR, 'lib', 'features', 'ceo', 'screens');
const OWNER_DIR = path.join(APP_DIR, 'lib', 'features', 'owner', 'screens');
const COO_DIR = path.join(APP_DIR, 'lib', 'features', 'coo', 'screens');

[CEO_DIR, OWNER_DIR, COO_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 24 Screens
const screens = [
  // CEO
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_dashboard_screen.dart', cls: 'CeoDashboardScreen', title: 'CEO Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.ceoDashboard', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_enterprise_overview_screen.dart', cls: 'CeoEnterpriseOverviewScreen', title: 'Enterprise Overview', icon: 'Icons.business', route: 'CorporateRoutes.ceoEnterpriseOverview', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_franchise_overview_screen.dart', cls: 'CeoFranchiseOverviewScreen', title: 'Franchise Overview', icon: 'Icons.storefront', route: 'CorporateRoutes.ceoFranchiseOverview', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_region_performance_screen.dart', cls: 'CeoRegionPerformanceScreen', title: 'Region Performance', icon: 'Icons.map', route: 'CorporateRoutes.ceoRegionPerformance', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_revenue_summary_screen.dart', cls: 'CeoRevenueSummaryScreen', title: 'Revenue Summary', icon: 'Icons.attach_money', route: 'CorporateRoutes.ceoRevenueSummary', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_strategic_kpis_screen.dart', cls: 'CeoStrategicKpisScreen', title: 'Strategic KPIs', icon: 'Icons.show_chart', route: 'CorporateRoutes.ceoStrategicKpis', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_growth_pipeline_screen.dart', cls: 'CeoGrowthPipelineScreen', title: 'Growth Pipeline', icon: 'Icons.trending_up', route: 'CorporateRoutes.ceoGrowthPipeline', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_leadership_reports_screen.dart', cls: 'CeoLeadershipReportsScreen', title: 'Leadership Reports', icon: 'Icons.people', route: 'CorporateRoutes.ceoLeadershipReports', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_alerts_and_risks_screen.dart', cls: 'CeoAlertsAndRisksScreen', title: 'Alerts And Risks', icon: 'Icons.warning', route: 'CorporateRoutes.ceoAlertsAndRisks', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_organization_map_screen.dart', cls: 'CeoOrganizationMapScreen', title: 'Organization Map', icon: 'Icons.account_tree', route: 'CorporateRoutes.ceoOrganizationMap', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_approvals_screen.dart', cls: 'CeoApprovalsScreen', title: 'Approvals', icon: 'Icons.check_circle', route: 'CorporateRoutes.ceoApprovals', color: 'Colors.blue.shade900' },
  { dir: CEO_DIR, sub: 'ceo', file: 'ceo_reports_screen.dart', cls: 'CeoReportsScreen', title: 'Reports', icon: 'Icons.insert_chart', route: 'CorporateRoutes.ceoReports', color: 'Colors.blue.shade900' },

  // Owner
  { dir: OWNER_DIR, sub: 'owner', file: 'owner_dashboard_screen.dart', cls: 'OwnerDashboardScreen', title: 'Owner Dashboard', icon: 'Icons.domain', route: 'CorporateRoutes.ownerDashboard', color: 'Colors.deepPurple' },

  // COO
  { dir: COO_DIR, sub: 'coo', file: 'coo_dashboard_screen.dart', cls: 'CooDashboardScreen', title: 'COO Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.cooDashboard', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_operations_overview_screen.dart', cls: 'CooOperationsOverviewScreen', title: 'Operations Overview', icon: 'Icons.settings', route: 'CorporateRoutes.cooOperationsOverview', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_branch_operations_screen.dart', cls: 'CooBranchOperationsScreen', title: 'Branch Operations', icon: 'Icons.apartment', route: 'CorporateRoutes.cooBranchOperations', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_staffing_efficiency_screen.dart', cls: 'CooStaffingEfficiencyScreen', title: 'Staffing Efficiency', icon: 'Icons.groups', route: 'CorporateRoutes.cooStaffingEfficiency', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_scheduling_health_screen.dart', cls: 'CooSchedulingHealthScreen', title: 'Scheduling Health', icon: 'Icons.event_available', route: 'CorporateRoutes.cooSchedulingHealth', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_service_delivery_screen.dart', cls: 'CooServiceDeliveryScreen', title: 'Service Delivery', icon: 'Icons.local_shipping', route: 'CorporateRoutes.cooServiceDelivery', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_issue_escalations_screen.dart', cls: 'CooIssueEscalationsScreen', title: 'Issue Escalations', icon: 'Icons.report', route: 'CorporateRoutes.cooIssueEscalations', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_compliance_view_screen.dart', cls: 'CooComplianceViewScreen', title: 'Compliance View', icon: 'Icons.verified', route: 'CorporateRoutes.cooComplianceView', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_workflow_performance_screen.dart', cls: 'CooWorkflowPerformanceScreen', title: 'Workflow Performance', icon: 'Icons.timeline', route: 'CorporateRoutes.cooWorkflowPerformance', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_branch_comparison_screen.dart', cls: 'CooBranchComparisonScreen', title: 'Branch Comparison', icon: 'Icons.compare_arrows', route: 'CorporateRoutes.cooBranchComparison', color: 'Colors.teal.shade900' },
  { dir: COO_DIR, sub: 'coo', file: 'coo_reports_screen.dart', cls: 'CooReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'CorporateRoutes.cooReports', color: 'Colors.teal.shade900' },
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

console.log('✅ 24 CEO/Owner/COO Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Replace primecare_ui import with hide classes to avoid collision
    const hideString = " hide " + hideClasses.join(", ");
    if (!content.includes(hideClasses[0])) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart'" + hideString + ";\n" + importStatements);
    }
    
    // Inject the exact explicit routes right before SsoRedirectView
    if (!content.includes(screens[0].cls)) {
        content = content.replace(
            "publicRoutes: [", 
            "publicRoutes: [\n" + routeStatements
        );
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 7 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 7 ---');
try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-corporate --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 7 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
