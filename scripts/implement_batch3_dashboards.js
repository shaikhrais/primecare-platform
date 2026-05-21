const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const ROUTER_FILE = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 3 (ALLIED & SUPPORT) IMPLEMENTATION ---');

const SHARED_DIR = path.join(CLINIC_DIR, 'lib', 'features', 'shared', 'screens');
if (!fs.existsSync(SHARED_DIR)) {
    fs.mkdirSync(SHARED_DIR, { recursive: true });
}

// 1. Scaffold the 9 Dashboards
const dashboards = [
  { file: 'clinical_director_dashboard_screen.dart', cls: 'ClinicalDirectorDashboardScreen', title: 'Clinical Director Hub', icon: 'Icons.local_hospital', route: '/offices/clinical/roles/clinical_director/dashboard', color: 'Colors.blueGrey' },
  { file: 'intake_coordinator_dashboard_screen.dart', cls: 'IntakeCoordinatorDashboardScreen', title: 'Intake Command Center', icon: 'Icons.assignment_ind', route: '/offices/clinical/roles/intake_coordinator/dashboard', color: 'Colors.indigo' },
  { file: 'qa_dashboard_screen.dart', cls: 'QualityAssuranceDashboardScreen', title: 'Quality Assurance Desk', icon: 'Icons.verified_user', route: '/offices/support/roles/quality_assurance/dashboard', color: 'Colors.deepPurple' },
  { file: 'training_coordinator_dashboard_screen.dart', cls: 'TrainingCoordinatorDashboardScreen', title: 'Training Hub', icon: 'Icons.school', route: '/offices/support/roles/training_coordinator/dashboard', color: 'Colors.amber' },
  { file: 'receptionist_dashboard_screen.dart', cls: 'ReceptionistDashboardScreen', title: 'Front Desk Portal', icon: 'Icons.front_desk', route: '/dynamic/receptionistDashboard', color: 'Colors.pink' },
  { file: 'rmt_dashboard_screen.dart', cls: 'RmtDashboardScreen', title: 'Massage Therapy (RMT)', icon: 'Icons.spa', route: '/offices/clinical/roles/rmt/dashboard', color: 'Colors.green' },
  { file: 'chiropractor_dashboard_screen.dart', cls: 'ChiropractorDashboardScreen', title: 'Chiropractic Care', icon: 'Icons.accessibility_new', route: '/offices/clinical/roles/chiropractor/dashboard', color: 'Colors.teal' },
  { file: 'physiotherapist_dashboard_screen.dart', cls: 'PhysiotherapistDashboardScreen', title: 'Physiotherapy Center', icon: 'Icons.directions_run', route: '/offices/clinical/roles/physiotherapist/dashboard', color: 'Colors.cyan' },
  { file: 'social_worker_dashboard_screen.dart', cls: 'SocialWorkerDashboardScreen', title: 'Social Work Hub', icon: 'Icons.family_restroom', route: '/offices/clinical/roles/social_worker/dashboard', color: 'Colors.purple' }
];

let importStatements = '';
let routeStatements = '';

dashboards.forEach(d => {
  const content = `
import 'package:flutter/material.dart';

class ${d.cls} extends StatelessWidget {
  const ${d.cls}({Key? key}) : super(key: key);

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
                Icon(${d.icon}, size: 40, color: ${d.color}),
                const SizedBox(width: 16),
                Text('${d.title}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${d.color})),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildMetricCard('Today\\'s Appointments', '12', Icons.calendar_today, ${d.color}),
                  _buildMetricCard('Pending Tasks', '5', Icons.pending_actions, ${d.color}),
                  _buildMetricCard('Unread Messages', '3', Icons.mail, ${d.color}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, MaterialColor color) {
    return Card(
      elevation: 6,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(value, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
  `;
  fs.writeFileSync(path.join(SHARED_DIR, d.file), content.trim());
  importStatements += `import '../../features/shared/screens/${d.file}';\n`;
  routeStatements += `      GoRoute(path: '${d.route}', builder: (context, state) => const ${d.cls}()),\n`;
});
console.log('✅ 9 Dashboards scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports securely
    if (!content.includes('clinical_director_dashboard_screen.dart')) {
        content = content.replace("import '../../features/psw/screens/psw_help_support_screen.dart';", "import '../../features/psw/screens/psw_help_support_screen.dart';\n" + importStatements);
    }
    
    // Add routes securely
    if (!content.includes('/offices/clinical/roles/clinical_director/dashboard')) {
        content = content.replace("GoRoute(path: '/offices/clinical/roles/psw/help-support', builder: (context, state) => const PswHelpSupportScreen()),", "GoRoute(path: '/offices/clinical/roles/psw/help-support', builder: (context, state) => const PswHelpSupportScreen()),\n" + routeStatements);
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 3 Routes injected.');
}

// 3. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING BATCH 3 ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('npx wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Batch 3 (Allied & Support) Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
