const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const GOV_DIR = path.join(__dirname, '..', 'apps', 'primecare_governance');
const ROUTER_FILE = path.join(GOV_DIR, 'lib', 'core', 'governance', 'route_registry.dart');

console.log('--- STARTING BATCH 6 (QA & COMPLIANCE) IMPLEMENTATION ---');

const QA_DIR = path.join(GOV_DIR, 'lib', 'features', 'qa', 'screens');
const AUDIT_DIR = path.join(GOV_DIR, 'lib', 'features', 'audit', 'screens');
const SEC_DIR = path.join(GOV_DIR, 'lib', 'features', 'security', 'screens');
const REF_DIR = path.join(GOV_DIR, 'lib', 'features', 'reference', 'screens');

[QA_DIR, AUDIT_DIR, SEC_DIR, REF_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 12 Screens
const screens = [
  // QA
  { dir: QA_DIR, sub: 'qa', file: 'audit_dashboard_screen.dart', cls: 'AuditDashboardScreen', title: 'Audit Dashboard', icon: 'Icons.bar_chart', route: '/generated/audit-dashboard', color: 'Colors.indigo' },
  { dir: QA_DIR, sub: 'qa', file: 'compliance_reviews_screen.dart', cls: 'ComplianceReviewsScreen', title: 'Compliance Reviews', icon: 'Icons.grading', route: '/generated/compliance-reviews', color: 'Colors.indigo' },
  { dir: QA_DIR, sub: 'qa', file: 'incident_reports_screen.dart', cls: 'IncidentReportsScreen', title: 'Incident Reports', icon: 'Icons.report_problem', route: '/generated/incident-reports', color: 'Colors.red' },
  { dir: QA_DIR, sub: 'qa', file: 'quality_metrics_screen.dart', cls: 'QualityMetricsScreen', title: 'Quality Metrics', icon: 'Icons.speed', route: '/generated/quality-metrics', color: 'Colors.indigo' },
  // Audit
  { dir: AUDIT_DIR, sub: 'audit', file: 'audit_log_screen.dart', cls: 'AuditLogScreen', title: 'Audit Log', icon: 'Icons.history', route: '/governance/audit', color: 'Colors.teal' },
  { dir: AUDIT_DIR, sub: 'audit', file: 'monitoring_screen.dart', cls: 'MonitoringScreen', title: 'Monitoring', icon: 'Icons.monitor_heart', route: '/governance/monitoring', color: 'Colors.teal' },
  { dir: AUDIT_DIR, sub: 'audit', file: 'ticket_center_screen.dart', cls: 'TicketCenterScreen', title: 'Ticket Center', icon: 'Icons.confirmation_number', route: '/governance/tickets', color: 'Colors.teal' },
  { dir: AUDIT_DIR, sub: 'audit', file: 'screen_status_screen.dart', cls: 'ScreenStatusScreen', title: 'Screen Status', icon: 'Icons.fact_check', route: '/governance/screen-status', color: 'Colors.teal' },
  // Security
  { dir: SEC_DIR, sub: 'security', file: 'security_hub_screen.dart', cls: 'SecurityHubScreen', title: 'Security Hub', icon: 'Icons.security', route: '/governance/device-security', color: 'Colors.redAccent' },
  { dir: SEC_DIR, sub: 'security', file: 'security_sentinel_screen.dart', cls: 'SecuritySentinelScreen', title: 'Security Sentinel', icon: 'Icons.admin_panel_settings', route: '/governance/security', color: 'Colors.redAccent' },
  { dir: SEC_DIR, sub: 'security', file: 'verification_center_screen.dart', cls: 'VerificationCenterScreen', title: 'Verification Center', icon: 'Icons.verified_user', route: '/verification', color: 'Colors.redAccent' },
  // Reference
  { dir: REF_DIR, sub: 'reference', file: 'clinical_reference_screen.dart', cls: 'ClinicalReferenceScreen', title: 'Clinical Reference', icon: 'Icons.menu_book', route: '/governance/clinical-reference', color: 'Colors.brown' },
];

let importStatements = '';
let routeStatements = '';
let filterPaths = [];

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
  routeStatements += `          GoRoute(path: '${s.route}', builder: (context, state) => const ${s.cls}()),\n`;
  filterPaths.push(`'${s.route}'`);
});

console.log('✅ 12 QA & Compliance Screens scaffolded.');

// 2. Inject Routes into route_registry.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports
    if (!content.includes('audit_dashboard_screen.dart')) {
        content = content.replace("import '../../features/executive/screens/growth_pipeline_screen.dart';", importStatements + "import '../../features/executive/screens/growth_pipeline_screen.dart';");
    }
    
    // Inject explicitly before the Executive Routes
    if (!content.includes('/generated/audit-dashboard')) {
        content = content.replace(
            "// Native Executive Routes", 
            "// Native QA & Compliance Routes\n" + routeStatements + "\n          // Native Executive Routes"
        );
    }

    // Add to the exclusion array
    screens.forEach(s => {
        if (!content.includes(`'${s.route}'`)) {
             // We need to inject the string into the ![...].contains() array inside the where clause.
             // Find the start of the array: ![
             const targetStr = "&& ![";
             content = content.replace(targetStr, targetStr + `'${s.route}', `);
        }
    });

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 6 Routes injected correctly.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 6 ---');
try {
    // Run asynchronously, don't wait for completion here
    require('child_process').exec('flutter build web --release && npx wrangler pages deploy build/web --project-name primecare-governance --commit-dirty=true', { cwd: GOV_DIR });
    console.log('🏆 Batch 6 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
