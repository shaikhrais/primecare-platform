// Governance - Category: view | Purpose: UI Screen component rendering the Clinical Director Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ClinicalDirectorDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class ClinicalDirectorDashboardScreen extends StatefulWidget {
  const ClinicalDirectorDashboardScreen({super.key});

  @override
  State<ClinicalDirectorDashboardScreen> createState() => _ClinicalDirectorDashboardScreenState();
}

class _ClinicalDirectorDashboardScreenState extends State<ClinicalDirectorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinical Director Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Clinical Quality Outcomes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatTile(icon: LucideIcons.activity, label: 'Patient Satisfaction', value: '94%'),
                        _StatTile(icon: LucideIcons.alertTriangle, label: 'Incident Reports', value: '3 Active'),
                        _StatTile(icon: LucideIcons.checkCircle, label: 'Compliance Rate', value: '98%'),
                        _StatTile(icon: LucideIcons.users, label: 'Staffing Coverage', value: '100%'),
                      ],
                    ),
                  ],
                ),
              ),
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
                          const Text('Provider Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ProviderRow(name: 'Dr. Sarah Jenkins', role: 'Physician', status: 'Excellent'),
                          _ProviderRow(name: 'Nurse Tom Riley', role: 'RN', status: 'Review Needed'),
                          _ProviderRow(name: 'Amanda Brooks', role: 'Physiotherapist', status: 'Good'),
                          _ProviderRow(name: 'Kevin Hart', role: 'PSW', status: 'Excellent'),
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
                          const Text('Compliance Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _AlertRow(message: '3 CPR Certifications expiring this week.', isUrgent: true),
                          _AlertRow(message: 'Q2 Infection Control Audit pending.', isUrgent: false),
                          _AlertRow(message: 'Protocol update for COVID-19 required.', isUrgent: true),
                        ],
                      ),
                    ),
                  ),
                ),
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

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color(0xFF0F766E)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _ProviderRow extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  const _ProviderRow({required this.name, required this.role, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(LucideIcons.user, color: Colors.black)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(role),
      trailing: Chip(
        label: Text(status, style: TextStyle(color: status == 'Review Needed' ? Colors.white : Colors.black)),
        backgroundColor: status == 'Review Needed' ? Colors.red : Colors.green[100],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  final String message;
  final bool isUrgent;
  const _AlertRow({required this.message, required this.isUrgent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUrgent ? Colors.red[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isUrgent ? Colors.red : Colors.orange),
      ),
      child: Row(
        children: [
          Icon(isUrgent ? LucideIcons.alertOctagon : LucideIcons.bell, color: isUrgent ? Colors.red : Colors.orange),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
