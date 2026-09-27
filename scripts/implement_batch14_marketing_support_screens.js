const fs = require('fs');
const path = require('path');

const MARKETING_APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_marketing');
const MARKETING_ROUTER_FILE = path.join(MARKETING_APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

const SUPPORT_APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_support');
const SUPPORT_ROUTER_FILE = path.join(SUPPORT_APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 14 (MARKETING & SUPPORT) IMPLEMENTATION ---');

// 1. Scaffold Marketing Screens
const MARKETING_DIR = path.join(MARKETING_APP_DIR, 'lib', 'features', 'marketing', 'screens');
if (!fs.existsSync(MARKETING_DIR)) fs.mkdirSync(MARKETING_DIR, { recursive: true });

const marketingScreens = [
  { file: 'local_marketing_manager_dashboard_screen.dart', cls: 'LocalMarketingManagerDashboardScreen', title: 'Local Marketing Dashboard', icon: 'Icons.campaign', route: 'MarketingRoutes.localMarketingManagerDashboard', color: 'Colors.pink.shade600' },
  { file: 'community_outreach_dashboard_screen.dart', cls: 'CommunityOutreachDashboardScreen', title: 'Community Outreach Dashboard', icon: 'Icons.handshake', route: 'MarketingRoutes.communityOutreachDashboard', color: 'Colors.pink.shade600' },
];

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

let marketingImports = '';
let marketingRoutes = '';
let marketingHides = [];

marketingScreens.forEach(s => {
  fs.writeFileSync(path.join(MARKETING_DIR, s.file), buildScreen(s).trim());
  marketingImports += `import '../../features/marketing/screens/${s.file}';\n`;
  marketingRoutes += `      GoRoute(path: ${s.route}, builder: (context, state) => const ${s.cls}()),\n`;
  marketingHides.push(s.cls);
});

console.log('✅ Marketing Screens scaffolded.');

if (fs.existsSync(MARKETING_ROUTER_FILE)) {
    let content = fs.readFileSync(MARKETING_ROUTER_FILE, 'utf8');
    const hideString = "hide " + marketingHides.join(", ") + ", ";
    
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\n" + marketingImports);
    } else if (content.includes("hide ")) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'marketing_routes.dart';", "import 'marketing_routes.dart';\n" + marketingImports);
    } else {
        content = content.replace("import 'marketing_routes.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\nimport 'marketing_routes.dart';\n" + marketingImports);
    }
    
    if (!content.includes(marketingScreens[0].cls)) {
        if (content.includes("publicRoutes: [")) {
            content = content.replace("publicRoutes: [", "publicRoutes: [\n" + marketingRoutes);
        } else {
            content = content.replace("    redirect: ", "    publicRoutes: [\n" + marketingRoutes + "    ],\n    redirect: ");
        }
    }
    fs.writeFileSync(MARKETING_ROUTER_FILE, content, 'utf8');
    console.log('✅ Marketing Routes injected.');
}

// 2. Scaffold Support Screens
const SUPPORT_DIR = path.join(SUPPORT_APP_DIR, 'lib', 'features', 'support', 'screens');
if (!fs.existsSync(SUPPORT_DIR)) fs.mkdirSync(SUPPORT_DIR, { recursive: true });

const supportScreens = [
  { file: 'help_desk_dashboard_screen.dart', cls: 'HelpDeskDashboardScreen', title: 'Help Desk Dashboard', icon: 'Icons.headset_mic', route: 'SupportRoutes.helpDeskDashboard', color: 'Colors.deepOrange.shade600' },
  { file: 'escalation_dashboard_screen.dart', cls: 'EscalationDashboardScreen', title: 'Escalation Dashboard', icon: 'Icons.error_outline', route: 'SupportRoutes.escalationDashboard', color: 'Colors.red.shade700' },
];

let supportImports = '';
let supportRoutes = '';
let supportHides = [];

supportScreens.forEach(s => {
  fs.writeFileSync(path.join(SUPPORT_DIR, s.file), buildScreen(s).trim());
  supportImports += `import '../../features/support/screens/${s.file}';\n`;
  supportRoutes += `      GoRoute(path: ${s.route}, builder: (context, state) => const ${s.cls}()),\n`;
  supportHides.push(s.cls);
});

console.log('✅ Support Screens scaffolded.');

if (fs.existsSync(SUPPORT_ROUTER_FILE)) {
    let content = fs.readFileSync(SUPPORT_ROUTER_FILE, 'utf8');
    const hideString = "hide " + supportHides.join(", ") + ", ";
    
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\n" + supportImports);
    } else if (content.includes("hide ")) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'support_routes.dart';", "import 'support_routes.dart';\n" + supportImports);
    } else {
        content = content.replace("import 'support_routes.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\nimport 'support_routes.dart';\n" + supportImports);
    }
    
    if (!content.includes(supportScreens[0].cls)) {
        if (content.includes("publicRoutes: [")) {
            content = content.replace("publicRoutes: [", "publicRoutes: [\n" + supportRoutes);
        } else {
            content = content.replace("    redirect: ", "    publicRoutes: [\n" + supportRoutes + "    ],\n    redirect: ");
        }
    }
    fs.writeFileSync(SUPPORT_ROUTER_FILE, content, 'utf8');
    console.log('✅ Support Routes injected.');
}

// 3. Trigger Double Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR MARKETING & SUPPORT ---');
try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-marketing --commit-dirty=true', { cwd: MARKETING_APP_DIR });
    console.log('🏆 Batch 14 Marketing Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger Marketing deployment!', e.message);
}

try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-support --commit-dirty=true', { cwd: SUPPORT_APP_DIR });
    console.log('🏆 Batch 14 Support Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger Support deployment!', e.message);
}
