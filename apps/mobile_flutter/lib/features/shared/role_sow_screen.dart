import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_provider.dart';
import 'widgets/page_template.dart';

class RoleSowScreen extends ConsumerWidget {
  const RoleSowScreen({super.key});

  Map<String, dynamic> _getRoleData(String role) {
    switch (role.toLowerCase()) {
      case 'superuser':
        return {
          'title': 'Platform Founder (Superuser)',
          'color': Colors.purple,
          'icon': Icons.public,
          'scope': 'Master Franchisor. Responsible for scaling the global PrimeCare footprint, executing macro-financial governance, and managing the ultimate Cloudflare edge computing infrastructure.',
          'daily': [
            'Market and sell geographical territories to prospective agency owners.',
            'Execute "Zero-Touch" Franchise Provisioning on the Territory Map.',
            'Monitor the automated Master Ledger and verify 5-8% Royalties.',
            'Review cross-tenant Audit Logs for global anomalies or DDoS mitigations.'
          ],
          'key_interactions': 'Interacts primarily with Franchise General Managers and the Master System Ledger.'
        };
      case 'admin':
        return {
          'title': 'Network Admin',
          'color': Colors.deepPurple,
          'icon': Icons.admin_panel_settings,
          'scope': 'Technical oversight and support. Responsible for maintaining regional tenant health, reviewing system errors, and executing technical overrides when franchisees need Tier-3 support.',
          'daily': [
            'Monitor the global SOS & API error indices.',
            'Assist General Managers with complex data migration or integrations.',
            'Execute cross-tenant debugging via secure JWT isolation overrides.',
            'Train franchisee IT staff on platform constraints.'
          ],
          'key_interactions': 'Supports General Managers and reports to the Superuser.'
        };
      case 'gm':
        return {
          'title': 'General Manager',
          'color': Colors.blueGrey,
          'icon': Icons.account_balance,
          'scope': 'Franchise Owner. Responsible for the absolute profitability, compliance, and strategic expansion of their isolated regional database territory.',
          'daily': [
            'Review Double-Entry P&L Statements and localized Cash Flow forecasting.',
            'Recruit, interview, and onboard localized Managers and RNs.',
            'Approve capital expenditures and manage external banking integrations.',
            'Handle severe Phase-1 Escalations (e.g., critical legal incidents).'
          ],
          'key_interactions': 'Oversees the Operations Manager and reports Royalties to the Superuser.'
        };
      case 'manager':
        return {
          'title': 'Operations Manager',
          'color': Colors.blue,
          'icon': Icons.business_center,
          'scope': 'Logistics and HR. Responsible for running the localized agency floor, ensuring shifts are covered, managing client intakes, and resolving medium-to-high severity operations incidents.',
          'daily': [
            'Review and formally resolve branch Incidents (No-shows, Complaints).',
            'Conduct HR performance reviews for PSWs and Coordinators.',
            'Approve structural schedule shifts submitted by Coordinators.',
            'Onboard new internal staff and audit local credential compliance.'
          ],
          'key_interactions': 'Manages Coordinators & PSWs; reports to the General Manager.'
        };
      case 'coordinator':
        return {
          'title': 'Scheduling Coordinator',
          'color': Colors.orange,
          'icon': Icons.headset_mic,
          'scope': 'Logistical Dispatch. Responsible for the real-time orchestration of the PSW fleet, managing the waitlist ecosystem, and reacting instantly to call-ins or shift drops.',
          'daily': [
            'Process immediate PSW Call-ins and intelligently dispatch replacement standbys.',
            'Mutate and adjust live visit windows based on client requests.',
            'Optimize driving routes using the Haversine tracking dashboard.',
            'Monitor the Live Fleet Dashboard for PSW tardiness or missed clock-ins.'
          ],
          'key_interactions': 'Dispatches PSWs; interacts with Clients; reports to the Operations Manager.'
        };
      case 'rn':
        return {
          'title': 'Registered Nurse (RN)',
          'color': Colors.teal,
          'icon': Icons.medical_services,
          'scope': 'Clinical Supervisor. Responsible for evaluating patient health, dictating structural Care Plans, performing formal medication reconciliations, and overseeing PSW field competencies.',
          'daily': [
            'Review and Sign-off on Flagged Daily Audit entries submitted by PSWs.',
            'Perform and log comprehensive Medication Reconciliations (Med Recon).',
            'Update dynamic Care Plans based on active wound care or fall risks.',
            'Provide direct clinical supervision and feedback scaling to PSW CareCoins.'
          ],
          'key_interactions': 'Supervises PSW clinical execution; interacts physically with Clients.'
        };
      case 'psw':
        return {
          'title': 'Personal Support Worker (PSW)',
          'color': Colors.green,
          'icon': Icons.healing,
          'scope': 'Direct Care Provider. Responsible for safely rendering care in the client’s home according to the RN’s Care Plan, maintaining precise time-logs, and documenting daily clinical observations.',
          'daily': [
            'Geofence Clock-in and Clock-out of assigned scheduled visits.',
            'Complete all Care Plan Checklist items during the active visit.',
            'Submit Daily Log entries detailing patient mood, vitals, and highlights.',
            'Report Incidents (e.g., patient hazard) immediately to the Coordinator.'
          ],
          'key_interactions': 'Provides care to Clients; managed by Coordinators; clinically supervised by RNs.'
        };
      case 'client':
      case 'family':
        return {
          'title': 'Client / Family Advocate',
          'color': Colors.pink,
          'icon': Icons.family_restroom,
          'scope': 'Care Recipient. Utilize the portal to strictly monitor familial health progression, communicate proactively with the agency, and handle financial invoices securely.',
          'daily': [
            'Review the upcoming Visit Schedule and request time modifications.',
            'Read the latest PSW Daily Logs to stay informed on patient status.',
            'Pay active invoices via the integrated Stripe gateway.',
            'Communicate via secure Universal Chat with the agency Coordinator.'
          ],
          'key_interactions': 'Receives care from PSWs; coordinates logistics with the branch Coordinator.'
        };
      default:
        return {
          'title': 'System Role',
          'color': Colors.grey,
          'icon': Icons.person,
          'scope': 'Scope not defined for this specific role.',
          'daily': ['No standard daily operations defined.'],
          'key_interactions': 'None.'
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).role ?? 'psw';
    final data = _getRoleData(role);
    final dailyTasks = data['daily'] as List<String>;

    return PageTemplate(
      title: 'Standard Operating Procedure',
      subtitle: 'Review your formal Scope of Work and Daily Objectives',
      icon: data['icon'] as IconData,
      headerGradientColors: [data['color'] as Color, (data['color'] as Color).withOpacity(0.6)],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(data['icon'] as IconData, size: 40, color: data['color'] as Color),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        data['title'] as String,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32, thickness: 2),
                const Text('Scope of Role', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 8),
                Text(data['scope'] as String, style: const TextStyle(fontSize: 16, height: 1.5)),
                const SizedBox(height: 24),
                
                const Text('Key Personnel Interactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.handshake, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(data['key_interactions'] as String, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic))),
                  ],
                ),
                const SizedBox(height: 24),

                const Text('Day-to-Day Activities Checklist', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 12),
                ...dailyTasks.map((task) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_box_outlined, color: data['color'] as Color),
                      const SizedBox(width: 12),
                      Expanded(child: Text(task, style: const TextStyle(fontSize: 16, height: 1.4))),
                    ],
                  ),
                )).toList(),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('SOP officially reviewed for today. Thank you.'), backgroundColor: Colors.green),
                      );
                    },
                    icon: const Icon(Icons.verified),
                    label: const Text('I have reviewed my Daily Activities'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: data['color'] as Color,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
