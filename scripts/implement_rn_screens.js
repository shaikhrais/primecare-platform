const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const ROUTER_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');
const CLINIC_ROUTES_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'clinic_routes.dart');

console.log('--- STARTING RN ROLE IMPLEMENTATION ---');

const RN_SCREENS_DIR = path.join(CLINIC_DIR, 'lib', 'features', 'rn', 'screens');
if (!fs.existsSync(RN_SCREENS_DIR)) {
    fs.mkdirSync(RN_SCREENS_DIR, { recursive: true });
}

// 1. Scaffold RN Screens
const dashboardContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clinical Dashboard - RN', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCard(context, 'Medications', Icons.medication, Colors.redAccent, '/clinic/rn-medications'),
                  _buildCard(context, 'Vitals', Icons.monitor_heart, Colors.green, '/clinic/rn-vitals'),
                  _buildCard(context, 'Charting', Icons.folder_shared, Colors.orange, '/clinic/rn-charting'),
                  _buildCard(context, 'Secure Messaging', Icons.message, Colors.purple, '/clinic/rn-messaging'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Card(
        elevation: 6,
        shadowColor: color.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 56, color: Colors.white),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
`;

const medsContent = `
import 'package:flutter/material.dart';

class RnMedicationsScreen extends StatelessWidget {
  const RnMedicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text('Pending Administrations', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Card(child: ListTile(leading: Icon(Icons.medication, color: Colors.red), title: Text('Amoxicillin 500mg'), subtitle: Text('Room 101 - John Doe - Due: 10:00 AM'), trailing: Icon(Icons.check_circle_outline))),
          Card(child: ListTile(leading: Icon(Icons.medication, color: Colors.red), title: Text('Lisinopril 10mg'), subtitle: Text('Room 204 - Jane Smith - Due: 12:00 PM'), trailing: Icon(Icons.check_circle_outline))),
        ],
      ),
    );
  }
}
`;

const vitalsContent = `
import 'package:flutter/material.dart';

class RnVitalsScreen extends StatelessWidget {
  const RnVitalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Log Patient Vitals', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'Patient ID', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Blood Pressure', border: OutlineInputBorder(), prefixIcon: Icon(Icons.favorite)))),
                const SizedBox(width: 16),
                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Heart Rate', border: OutlineInputBorder(), prefixIcon: Icon(Icons.monitor_heart)))),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('Save Record'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.green, foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
`;

const chartingContent = `
import 'package:flutter/material.dart';

class RnChartingScreen extends StatelessWidget {
  const RnChartingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clinical Notes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Enter comprehensive assessment notes here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit to EHR'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            )
          ],
        ),
      ),
    );
  }
}
`;

const messagingContent = `
import 'package:flutter/material.dart';

class RnMessagingScreen extends StatelessWidget {
  const RnMessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: const [
          ListTile(leading: CircleAvatar(backgroundColor: Colors.blue, child: Text('DR')), title: Text('Dr. Adams'), subtitle: Text('Please update the chart for Room 101.'), trailing: Text('10:45 AM')),
          ListTile(leading: CircleAvatar(backgroundColor: Colors.teal, child: Text('PSW')), title: Text('Sarah (PSW)'), subtitle: Text('Vitals check complete for Room 204.'), trailing: Text('9:30 AM')),
        ],
      ),
    );
  }
}
`;

fs.writeFileSync(path.join(RN_SCREENS_DIR, 'rn_dashboard_screen.dart'), dashboardContent.trim());
fs.writeFileSync(path.join(RN_SCREENS_DIR, 'rn_medications_screen.dart'), medsContent.trim());
fs.writeFileSync(path.join(RN_SCREENS_DIR, 'rn_vitals_screen.dart'), vitalsContent.trim());
fs.writeFileSync(path.join(RN_SCREENS_DIR, 'rn_charting_screen.dart'), chartingContent.trim());
fs.writeFileSync(path.join(RN_SCREENS_DIR, 'rn_messaging_screen.dart'), messagingContent.trim());
console.log('✅ RN Screens scaffolded successfully.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports
    const rnImports = `
import '../../features/rn/screens/rn_dashboard_screen.dart';
import '../../features/rn/screens/rn_medications_screen.dart';
import '../../features/rn/screens/rn_vitals_screen.dart';
import '../../features/rn/screens/rn_charting_screen.dart';
import '../../features/rn/screens/rn_messaging_screen.dart';
`;
    if (!content.includes('rn_dashboard_screen.dart')) {
        content = content.replace("import '../../features/psw/screens/psw_messaging_screen.dart';", "import '../../features/psw/screens/psw_messaging_screen.dart';\n" + rnImports);
    }
    
    // Add routes
    const rnRoutes = `
      GoRoute(path: '/clinic/rn-dashboard', builder: (context, state) => const RnDashboardScreen()),
      GoRoute(path: '/clinic/rn-medications', builder: (context, state) => const RnMedicationsScreen()),
      GoRoute(path: '/clinic/rn-vitals', builder: (context, state) => const RnVitalsScreen()),
      GoRoute(path: '/clinic/rn-charting', builder: (context, state) => const RnChartingScreen()),
      GoRoute(path: '/clinic/rn-messaging', builder: (context, state) => const RnMessagingScreen()),
    `;
    
    if (!content.includes('/clinic/rn-dashboard')) {
        // Find publicRoutes array end and inject
        content = content.replace("GoRoute(path: '/clinic/messaging', builder: (context, state) => const PswMessagingScreen()),", "GoRoute(path: '/clinic/messaging', builder: (context, state) => const PswMessagingScreen()),\n" + rnRoutes);
    }

    // Hide any potential naming collisions from primecare_ui if they exist
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart' hide ")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart' hide ", "import 'package:primecare_ui/primecare_ui.dart' hide RnDashboardScreen, RnMedicationsScreen, RnVitalsScreen, RnChartingScreen, RnMessagingScreen, ");
    } else if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' hide RnDashboardScreen, RnMedicationsScreen, RnVitalsScreen, RnChartingScreen, RnMessagingScreen;");
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ RN Routes injected into app_router.dart');
}

// 3. Purge conflicting dummy routes in clinic_routes.dart
if (fs.existsSync(CLINIC_ROUTES_FILE)) {
    let content = fs.readFileSync(CLINIC_ROUTES_FILE, 'utf8');
    // We already removed PSW, now let's aggressively remove any Rn dummy imports and route builders to avoid duplicates
    content = content.replace(/import\s+'[^']*rn\/presentation\/widgets[^']*';[\r\n]+/g, '');
    content = content.replace(/builder:\s*\(context\)\s*=>\s*const\s*Rn.*?Screen\(\),/g, 'builder: (context) => const Scaffold(body: Center(child: Text("Coming Soon"))),');
    fs.writeFileSync(CLINIC_ROUTES_FILE, content, 'utf8');
    console.log('✅ Purged RN dummy conflicts in clinic_routes.dart');
}

// 4. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING RN ROLE ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('npx wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 RN Role Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
