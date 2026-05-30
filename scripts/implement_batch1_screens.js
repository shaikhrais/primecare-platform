const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const ROUTER_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 1 ROLE IMPLEMENTATION ---');

const SHARED_SCREENS_DIR = path.join(CLINIC_DIR, 'lib', 'features', 'shared', 'screens');
if (!fs.existsSync(SHARED_SCREENS_DIR)) {
    fs.mkdirSync(SHARED_SCREENS_DIR, { recursive: true });
}

// 1. Scaffold the 2 Missing Shared Screens
const incidentReportContent = `
import 'package:flutter/material.dart';

class ClinicIncidentReportScreen extends StatelessWidget {
  const ClinicIncidentReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Safety Incident Report', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Incident Title', border: OutlineInputBorder(), prefixIcon: Icon(Icons.warning))),
            const SizedBox(height: 16),
            const Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Detailed Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Submit to Safety Officer'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
`;

const historyLogsContent = `
import 'package:flutter/material.dart';

class ClinicHistoryLogsScreen extends StatelessWidget {
  const ClinicHistoryLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clinical History Logs', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.history)),
                    title: Text('System Audit Event #\${1000 - index}'),
                    subtitle: Text('Performed by System \\n\${DateTime.now().subtract(Duration(hours: index)).toString()}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
`;

fs.writeFileSync(path.join(SHARED_SCREENS_DIR, 'clinic_incident_report_screen.dart'), incidentReportContent.trim());
fs.writeFileSync(path.join(SHARED_SCREENS_DIR, 'clinic_history_logs_screen.dart'), historyLogsContent.trim());
console.log('✅ Batch 1 Screens scaffolded successfully.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports
    const batch1Imports = `
import '../../features/shared/screens/clinic_incident_report_screen.dart';
import '../../features/shared/screens/clinic_history_logs_screen.dart';
`;
    if (!content.includes('clinic_incident_report_screen.dart')) {
        content = content.replace("import '../../features/rn/screens/rn_messaging_screen.dart';", "import '../../features/rn/screens/rn_messaging_screen.dart';\n" + batch1Imports);
    }
    
    // Add routes
    const batch1Routes = `
      GoRoute(path: '/clinic/incident-report', builder: (context, state) => const ClinicIncidentReportScreen()),
      GoRoute(path: '/clinic/history-logs', builder: (context, state) => const ClinicHistoryLogsScreen()),
    `;
    
    if (!content.includes('/clinic/incident-report')) {
        content = content.replace("GoRoute(path: '/clinic/rn-messaging', builder: (context, state) => const RnMessagingScreen()),", "GoRoute(path: '/clinic/rn-messaging', builder: (context, state) => const RnMessagingScreen()),\n" + batch1Routes);
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 1 Routes injected into app_router.dart');
}

// 3. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING BATCH 1 ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Batch 1 Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
