// Governance - Category: view | Purpose: UI Screen component rendering the Write Support Screens workspace interface.
const fs = require('fs');

const itAdmin = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ItAdministratorDashboardScreen extends StatefulWidget {
  const ItAdministratorDashboardScreen({super.key});

  @override
  State<ItAdministratorDashboardScreen> createState() => _ItAdministratorDashboardScreenState();
}

class _ItAdministratorDashboardScreenState extends State<ItAdministratorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Administrator Dashboard'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _SystemMetric(title: 'System Uptime', value: '99.98%', icon: LucideIcons.server, color: Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _SystemMetric(title: 'Active Alerts', value: '3', icon: LucideIcons.alertTriangle, color: Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _SystemMetric(title: 'Pending Permissions', value: '14', icon: LucideIcons.shield, color: Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _SystemMetric(title: 'Open Tickets', value: '28', icon: LucideIcons.ticket, color: Colors.purple)),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Recent Server Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            color: Colors.black,
                            width: double.infinity,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('[INFO] 10:45 AM - Database backup completed successfully.', style: TextStyle(color: Colors.greenAccent, fontFamily: 'monospace')),
                                Text('[WARN] 10:42 AM - High latency detected on Patient API endpoint.', style: TextStyle(color: Colors.orangeAccent, fontFamily: 'monospace')),
                                Text('[ERROR] 10:30 AM - Failed login attempt (IP: 192.168.1.45)', style: TextStyle(color: Colors.redAccent, fontFamily: 'monospace')),
                                Text('[INFO] 09:15 AM - New container deployed: primecare_auth_v2', style: TextStyle(color: Colors.greenAccent, fontFamily: 'monospace')),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ActionButton(label: 'Manage Permissions', icon: LucideIcons.key),
                          _ActionButton(label: 'Restart Auth Service', icon: LucideIcons.power),
                          _ActionButton(label: 'View Full Logs', icon: LucideIcons.fileText),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SystemMetric extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SystemMetric({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ActionButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16), alignment: Alignment.centerLeft),
      ),
    );
  }
}
`;

const qa = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QualityAssuranceDashboardScreen extends StatefulWidget {
  const QualityAssuranceDashboardScreen({super.key});

  @override
  State<QualityAssuranceDashboardScreen> createState() => _QualityAssuranceDashboardScreenState();
}

class _QualityAssuranceDashboardScreenState extends State<QualityAssuranceDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quality Assurance Dashboard'),
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: const [
                          Icon(LucideIcons.checkCircle, size: 48, color: Colors.green),
                          SizedBox(height: 16),
                          Text('94%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          Text('Audit Completion Rate', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: const [
                          Icon(LucideIcons.alertOctagon, size: 48, color: Colors.orange),
                          SizedBox(height: 16),
                          Text('12', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          Text('Incidents Pending Review', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: const [
                          Icon(LucideIcons.activity, size: 48, color: Colors.blue),
                          SizedBox(height: 16),
                          Text('98%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          Text('Clinical Outcome Target', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent Incident Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Location')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Severity')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: [
                        _incidentRow('Oct 15', 'Toronto Clinic', 'Medication Error', 'Medium', 'Under Review'),
                        _incidentRow('Oct 14', 'Vancouver Hub', 'Slip and Fall', 'Low', 'Resolved'),
                        _incidentRow('Oct 12', 'Home Care (Region 4)', 'Protocol Breach', 'High', 'Investigation'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DataRow _incidentRow(String date, String location, String category, String severity, String status) {
    Color severityColor = Colors.orange;
    if (severity == 'High') severityColor = Colors.red;
    if (severity == 'Low') severityColor = Colors.yellow.shade800;

    return DataRow(cells: [
      DataCell(Text(date)),
      DataCell(Text(location)),
      DataCell(Text(category)),
      DataCell(Chip(label: Text(severity, style: const TextStyle(color: Colors.white)), backgroundColor: severityColor)),
      DataCell(Text(status, style: const TextStyle(fontWeight: FontWeight.bold))),
    ]);
  }
}
`;

const training = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TrainingCoordinatorDashboardScreen extends StatefulWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  State<TrainingCoordinatorDashboardScreen> createState() => _TrainingCoordinatorDashboardScreenState();
}

class _TrainingCoordinatorDashboardScreenState extends State<TrainingCoordinatorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Coordinator Dashboard'),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: Colors.indigo[50], shape: BoxShape.circle),
                            child: const Icon(LucideIcons.graduationCap, color: Color(0xFF4F46E5)),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Active Trainees', style: TextStyle(color: Colors.grey)),
                              Text('45', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
                            child: const Icon(LucideIcons.alertTriangle, color: Colors.red),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Overdue Certifications', style: TextStyle(color: Colors.grey)),
                              Text('12', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
                            child: const Icon(LucideIcons.checkSquare, color: Colors.green),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Course Completion Rate', style: TextStyle(color: Colors.grey)),
                              Text('88%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Hire Onboarding Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _OnboardingRow(name: 'Sarah Jenkins', role: 'Registered Nurse', progress: 0.9),
                    _OnboardingRow(name: 'Kevin Hart', role: 'Personal Support Worker', progress: 0.4),
                    _OnboardingRow(name: 'David Smith', role: 'Physiotherapist', progress: 0.1),
                    _OnboardingRow(name: 'Amanda Brooks', role: 'Administrative Assistant', progress: 1.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OnboardingRow extends StatelessWidget {
  final String name;
  final String role;
  final double progress;

  const _OnboardingRow({required this.name, required this.role, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(LucideIcons.user, color: Colors.black54)),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: LinearProgressIndicator(value: progress, minHeight: 8, backgroundColor: Colors.grey[200], color: const Color(0xFF4F46E5))),
                const SizedBox(width: 16),
                Text('\${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/support/screens/it_administrator_dashboard_screen.dart', itAdmin);
fs.writeFileSync('lib/features/support/screens/quality_assurance_dashboard_screen.dart', qa);
fs.writeFileSync('lib/features/support/screens/training_coordinator_dashboard_screen.dart', training);

// Update app_router.dart to include these screens in publicRoutes
let router = fs.readFileSync('lib/core/routing/app_router.dart', 'utf8');

const imports = "import '../../features/support/screens/it_administrator_dashboard_screen.dart';\\nimport '../../features/support/screens/quality_assurance_dashboard_screen.dart';\\nimport '../../features/support/screens/training_coordinator_dashboard_screen.dart';";

if (!router.includes('it_administrator_dashboard_screen.dart')) {
  router = router.replace("import '../../features/support/screens/escalation_dashboard_screen.dart';", "import '../../features/support/screens/escalation_dashboard_screen.dart';\\n" + imports);
}

const routes = "      GoRoute(path: '/support/it-admin/dashboard', builder: (context, state) => const ItAdministratorDashboardScreen()),\\n      GoRoute(path: '/support/qa/dashboard', builder: (context, state) => const QualityAssuranceDashboardScreen()),\\n      GoRoute(path: '/support/training/dashboard', builder: (context, state) => const TrainingCoordinatorDashboardScreen()),";

if (!router.includes('/support/it-admin/dashboard')) {
  router = router.replace("publicRoutes: [", "publicRoutes: [\\n" + routes);
}

fs.writeFileSync('lib/core/routing/app_router.dart', router);
