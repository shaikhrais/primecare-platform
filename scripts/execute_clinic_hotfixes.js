const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const ROUTER_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING CLINIC HOTFIXES ---');

// 1. Rewrite the 6 PSW screens to remove Scaffold and AppBar
const PSW_SCREENS_DIR = path.join(CLINIC_DIR, 'lib', 'features', 'psw', 'screens');
if (!fs.existsSync(PSW_SCREENS_DIR)) {
    fs.mkdirSync(PSW_SCREENS_DIR, { recursive: true });
}

const dashboardContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswDashboardScreen extends StatelessWidget {
  const PswDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(context, 'My Shifts', Icons.schedule, '/clinic/my-shifts'),
            _buildCard(context, 'Care Plan', Icons.assignment, '/clinic/care-plan'),
            _buildCard(context, 'Daily Notes', Icons.note_add, '/clinic/daily-notes'),
            _buildCard(context, 'Client Profile', Icons.person, '/clinic/client-profile'),
            _buildCard(context, 'Messaging', Icons.message, '/clinic/messaging'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.teal),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`;

const carePlanContent = `
import 'package:flutter/material.dart';

class PswCarePlanScreen extends StatelessWidget {
  const PswCarePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text('Active Directives', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Card(child: ListTile(leading: Icon(Icons.warning, color: Colors.orange), title: Text('Mobility Assistance Required'))),
          Card(child: ListTile(leading: Icon(Icons.medication, color: Colors.blue), title: Text('Administer Medication at 12:00 PM'))),
          Card(child: ListTile(leading: Icon(Icons.fastfood, color: Colors.green), title: Text('Dietary Restrictions: Low Sodium'))),
        ],
      ),
    );
  }
}
`;

const dailyNotesContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswDailyNotesScreen extends StatelessWidget {
  const PswDailyNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Enter observation notes here...', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notes Saved!')));
                context.go('/clinic/dashboard');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Save Note', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
`;

const clientProfileContent = `
import 'package:flutter/material.dart';

class PswClientProfileScreen extends StatelessWidget {
  const PswClientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(radius: 60, child: Icon(Icons.person, size: 60)),
            SizedBox(height: 16),
            Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Room 402 - High Priority', style: TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
`;

const myShiftsContent = `
import 'package:flutter/material.dart';

class PswMyShiftsScreen extends StatelessWidget {
  const PswMyShiftsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: const [
          ListTile(leading: Icon(Icons.event), title: Text('Today: 8:00 AM - 4:00 PM'), subtitle: Text('South Wing')),
          ListTile(leading: Icon(Icons.event), title: Text('Tomorrow: 10:00 AM - 6:00 PM'), subtitle: Text('North Wing')),
        ],
      ),
    );
  }
}
`;

const messagingContent = `
import 'package:flutter/material.dart';

class PswMessagingScreen extends StatelessWidget {
  const PswMessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: const [
          ListTile(leading: CircleAvatar(child: Text('RN')), title: Text('Jane Smith (RN)'), subtitle: Text('Please check vitals in 402.')),
          ListTile(leading: CircleAvatar(child: Text('DR')), title: Text('Dr. Brown'), subtitle: Text('Medication updated.')),
        ],
      ),
    );
  }
}
`;

fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_dashboard_screen.dart'), dashboardContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_care_plan_screen.dart'), carePlanContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_daily_notes_screen.dart'), dailyNotesContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_client_profile_screen.dart'), clientProfileContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_my_shifts_screen.dart'), myShiftsContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_messaging_screen.dart'), messagingContent.trim());
console.log('✅ Strip Duplicate AppBars Complete.');

// 2. Fix Riverpod Compiler Errors
function patchControllers(dir) {
    if (!fs.existsSync(dir)) return;
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            patchControllers(fullPath);
        } else if (file.endsWith('_controller.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            if (content.includes('state = ') && !content.includes('package:flutter_riverpod/flutter_riverpod.dart')) {
                content = `import 'package:flutter_riverpod/flutter_riverpod.dart';\n` + content;
                fs.writeFileSync(fullPath, content, 'utf8');
                console.log(`Patched compiler error in: ${file}`);
            }
        }
    }
}
patchControllers(path.join(CLINIC_DIR, 'lib', 'features'));
console.log('✅ Riverpod Controller Imports Patched.');

// 3. Inject PSW Routes into original app_router.dart
let routerContent = fs.readFileSync(ROUTER_FILE, 'utf8');

const pswImports = `
import '../features/psw/screens/psw_dashboard_screen.dart';
import '../features/psw/screens/psw_care_plan_screen.dart';
import '../features/psw/screens/psw_daily_notes_screen.dart';
import '../features/psw/screens/psw_client_profile_screen.dart';
import '../features/psw/screens/psw_my_shifts_screen.dart';
import '../features/psw/screens/psw_messaging_screen.dart';
`;

if (!routerContent.includes('psw_dashboard_screen.dart')) {
    // Inject imports below primecare_ui
    routerContent = routerContent.replace("import 'clinic_routes.dart';", "import 'clinic_routes.dart';\n" + pswImports);

    // Inject routes into publicRoutes array
    const pswRoutes = `
      GoRoute(path: '/clinic/dashboard', builder: (context, state) => const PswDashboardScreen()),
      GoRoute(path: '/clinic/care-plan', builder: (context, state) => const PswCarePlanScreen()),
      GoRoute(path: '/clinic/daily-notes', builder: (context, state) => const PswDailyNotesScreen()),
      GoRoute(path: '/clinic/client-profile', builder: (context, state) => const PswClientProfileScreen()),
      GoRoute(path: '/clinic/my-shifts', builder: (context, state) => const PswMyShiftsScreen()),
      GoRoute(path: '/clinic/messaging', builder: (context, state) => const PswMessagingScreen()),
    `;
    
    routerContent = routerContent.replace("publicRoutes: [", "publicRoutes: [" + pswRoutes);
    fs.writeFileSync(ROUTER_FILE, routerContent, 'utf8');
    console.log('✅ AppRouter Injected with PSW Routes.');
}

// 4. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Master Hotfix Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
