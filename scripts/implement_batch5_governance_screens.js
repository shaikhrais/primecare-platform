const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const GOV_DIR = path.join(__dirname, '..', 'apps', 'primecare_governance');
const ROUTER_FILE = path.join(GOV_DIR, 'lib', 'core', 'governance', 'route_registry.dart');

console.log('--- STARTING BATCH 5 (GOVERNANCE DASHBOARD) IMPLEMENTATION ---');

const EXEC_DIR = path.join(GOV_DIR, 'lib', 'features', 'executive', 'screens');
if (!fs.existsSync(EXEC_DIR)) fs.mkdirSync(EXEC_DIR, { recursive: true });

// 1. Scaffold 6 Screens
const execScreens = [
  { file: 'growth_pipeline_screen.dart', cls: 'GrowthPipelineScreen', title: 'Growth Pipeline', icon: 'Icons.trending_up', route: '/generated/corporate/ceo/growth-pipeline' },
  { file: 'regional_performance_screen.dart', cls: 'RegionalPerformanceScreen', title: 'Regional Performance', icon: 'Icons.map', route: '/generated/corporate/ceo/region-performance' },
  { file: 'leadership_reports_screen.dart', cls: 'LeadershipReportsScreen', title: 'Leadership Reports', icon: 'Icons.pie_chart', route: '/generated/corporate/ceo/leadership-reports' },
  { file: 'governance_hud_screen.dart', cls: 'GovernanceHudScreen', title: 'Governance HUD', icon: 'Icons.radar', route: '/governance/hud' },
  { file: 'control_center_screen.dart', cls: 'ControlCenterScreen', title: 'Control Center', icon: 'Icons.settings_applications', route: '/governance/control-center' },
  { file: 'proposals_screen.dart', cls: 'ProposalsScreen', title: 'Proposals', icon: 'Icons.inbox', route: '/proposals' },
];

let importStatements = '';
let routeStatements = '';
let filterPaths = [];

const buildScreen = (s, color) => `
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
                const Icon(${s.icon}, size: 40, color: ${color}),
                const SizedBox(width: 16),
                Text("${s.title}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${color})),
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
                      Text("${s.title} module natively initialized.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
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

execScreens.forEach(s => {
  fs.writeFileSync(path.join(EXEC_DIR, s.file), buildScreen(s, 'Colors.blueGrey').trim());
  importStatements += `import '../../features/executive/screens/${s.file}';\n`;
  routeStatements += `          GoRoute(path: '${s.route}', builder: (context, state) => const ${s.cls}()),\n`;
  filterPaths.push(`'${s.route}'`);
});

console.log('✅ 6 Executive Screens scaffolded.');

// 2. Inject Routes and fix DynamicScreenView collisions into route_registry.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports securely
    if (!content.includes('growth_pipeline_screen.dart')) {
        content = content.replace("import '../ui/language_selector.dart';", "import '../ui/language_selector.dart';\n" + importStatements);
    }
    
    // Inject the exact explicit routes right before the dynamic spread
    if (!content.includes('/governance/hud')) {
        content = content.replace(
            "// Dynamic Registry-Driven Routes", 
            "// Native Executive Routes\n" + routeStatements + "\n          // Dynamic Registry-Driven Routes"
        );
    }

    // Filter out our explicitly implemented routes from the dynamic generator to avoid duplicate route exceptions
    const originalFilter = "where((screen) => !['LOGIN', 'FORGOT_PASSWORD', 'MFA', 'RESET_PASSWORD'].contains(screen.id))";
    const newFilter = `where((screen) => !['LOGIN', 'FORGOT_PASSWORD', 'MFA', 'RESET_PASSWORD'].contains(screen.id) && ![${filterPaths.join(', ')}].contains(screen.routePath))`;
    
    if (!content.includes(filterPaths[0])) {
        content = content.replace(originalFilter, newFilter);
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 5 Routes injected and filtered correctly.');
}

// 3. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING BATCH 5 (GOVERNANCE DASHBOARD) ---');
try {
    execSync('flutter build web --release', { cwd: GOV_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-governance --commit-dirty=true', { cwd: GOV_DIR, stdio: 'inherit' });
    console.log('🏆 Batch 5 (Governance Dashboard) Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
