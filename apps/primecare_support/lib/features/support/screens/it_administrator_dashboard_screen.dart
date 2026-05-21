import 'package:flutter/material.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
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
