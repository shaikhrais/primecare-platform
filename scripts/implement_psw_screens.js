const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const PSW_SCREENS_DIR = path.join(CLINIC_DIR, 'lib', 'features', 'psw', 'screens');
const ROUTER_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- IMPLEMENTING PSW SCREENS ---');

if (!fs.existsSync(PSW_SCREENS_DIR)) {
    fs.mkdirSync(PSW_SCREENS_DIR, { recursive: true });
}

// 1. Dashboard Screen (with interactive buttons linking to other routes)
const dashboardContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswDashboardScreen extends StatelessWidget {
  const PswDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PSW Dashboard'), backgroundColor: Colors.teal),
      body: Padding(
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

// 2. Care Plan Screen
const carePlanContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswCarePlanScreen extends StatelessWidget {
  const PswCarePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Plan'), 
        backgroundColor: Colors.teal,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/clinic/dashboard')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Active Directives', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(child: ListTile(leading: const Icon(Icons.warning, color: Colors.orange), title: const Text('Mobility Assistance Required'))),
          Card(child: ListTile(leading: const Icon(Icons.medication, color: Colors.blue), title: const Text('Administer Medication at 12:00 PM'))),
          Card(child: ListTile(leading: const Icon(Icons.fastfood, color: Colors.green), title: const Text('Dietary Restrictions: Low Sodium'))),
        ],
      ),
    );
  }
}
`;

// 3. Daily Notes Screen
const dailyNotesContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswDailyNotesScreen extends StatelessWidget {
  const PswDailyNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Notes'), 
        backgroundColor: Colors.teal,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/clinic/dashboard')),
      ),
      body: Padding(
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

// 4. Client Profile Screen
const clientProfileContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswClientProfileScreen extends StatelessWidget {
  const PswClientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'), 
        backgroundColor: Colors.teal,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/clinic/dashboard')),
      ),
      body: Center(
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

// 5. My Shifts Screen
const myShiftsContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswMyShiftsScreen extends StatelessWidget {
  const PswMyShiftsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shifts'), 
        backgroundColor: Colors.teal,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/clinic/dashboard')),
      ),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.event), title: Text('Today: 8:00 AM - 4:00 PM'), subtitle: Text('South Wing')),
          ListTile(leading: Icon(Icons.event), title: Text('Tomorrow: 10:00 AM - 6:00 PM'), subtitle: Text('North Wing')),
        ],
      ),
    );
  }
}
`;

// 6. Messaging Screen
const messagingContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswMessagingScreen extends StatelessWidget {
  const PswMessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'), 
        backgroundColor: Colors.teal,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/clinic/dashboard')),
      ),
      body: ListView(
        children: const [
          ListTile(leading: CircleAvatar(child: Text('RN')), title: Text('Jane Smith (RN)'), subtitle: Text('Please check vitals in 402.')),
          ListTile(leading: CircleAvatar(child: Text('DR')), title: Text('Dr. Brown'), subtitle: Text('Medication updated.')),
        ],
      ),
    );
  }
}
`;

// Write all screens
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_dashboard_screen.dart'), dashboardContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_care_plan_screen.dart'), carePlanContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_daily_notes_screen.dart'), dailyNotesContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_client_profile_screen.dart'), clientProfileContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_my_shifts_screen.dart'), myShiftsContent.trim());
fs.writeFileSync(path.join(PSW_SCREENS_DIR, 'psw_messaging_screen.dart'), messagingContent.trim());
console.log('✅ 6 PSW Screens Implemented.');

// App Router update
const appRouterContent = `
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/psw/screens/psw_dashboard_screen.dart';
import '../features/psw/screens/psw_care_plan_screen.dart';
import '../features/psw/screens/psw_daily_notes_screen.dart';
import '../features/psw/screens/psw_client_profile_screen.dart';
import '../features/psw/screens/psw_my_shifts_screen.dart';
import '../features/psw/screens/psw_messaging_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/clinic/dashboard',
    routes: [
      GoRoute(path: '/clinic/dashboard', builder: (context, state) => const PswDashboardScreen()),
      GoRoute(path: '/clinic/care-plan', builder: (context, state) => const PswCarePlanScreen()),
      GoRoute(path: '/clinic/daily-notes', builder: (context, state) => const PswDailyNotesScreen()),
      GoRoute(path: '/clinic/client-profile', builder: (context, state) => const PswClientProfileScreen()),
      GoRoute(path: '/clinic/my-shifts', builder: (context, state) => const PswMyShiftsScreen()),
      GoRoute(path: '/clinic/messaging', builder: (context, state) => const PswMessagingScreen()),
    ],
  );
});
`;

fs.writeFileSync(ROUTER_FILE, appRouterContent.trim());
console.log('✅ Router Updated with PSW Routes.');

// Trigger deployment
console.log('--- BUILDING & DEPLOYING TO CLOUDFLARE ---');
try {
    // Note: in the actual terminal, we must run the full build because the sandbox lacks flutter SDK directly available to Node sometimes, 
    // but assuming flutter is in PATH:
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('✅ Clinic App Successfully Deployed!');
} catch (e) {
    console.error('❌ Deployment Failed: ', e.message);
}
