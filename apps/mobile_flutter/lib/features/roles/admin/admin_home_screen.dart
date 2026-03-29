import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Admin Global Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(
              name: 'Founder Admin',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push(AppRoutes.adminRoles),
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('Access Role Matrix Configurator'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: const [
                SizedBox(child: PrimeCareStatCard(
                    title: 'Active Nodes',
                    value: '1,429',
                    icon: Icons.hub,
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(child: PrimeCareStatCard(
                    title: 'Cloudflare Latency',
                    value: '14ms',
                    icon: Icons.speed,
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(child: PrimeCareStatCard(
                    title: 'System Exceptions',
                    value: '3',
                    icon: Icons.warning_amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                SizedBox(child: PrimeCareCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Edge Network Load',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: ServerLoadGraph(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(child: PrimeCareCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Compliance Matrix',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: ComplianceExpiryGauge(
                            metrics: {'total': 500, 'compliant': 487},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Administrative Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            PrimeCareDataTable<Map<String, String>>(
              columns: const ['Timestamp', 'Admin', 'Action', 'Status'],
              data: const [
                {'time': '10:42 AM', 'user': 'System', 'action': 'Auto-scaled Worker APIs', 'status': 'Success'},
                {'time': '09:15 AM', 'user': 'Founder Admin', 'action': 'Purged Redis Cache', 'status': 'Success'},
                {'time': '08:30 AM', 'user': 'System', 'action': 'Database Snapshot', 'status': 'Success'},
                {'time': 'Yesterday', 'user': 'Superuser', 'action': 'Updated Role Matrix', 'status': 'Warning'},
              ],
              rowBuilder: (row) => [
                DataCell(Text(row['time']!)),
                DataCell(Text(row['user']!)),
                DataCell(Text(row['action']!)),
                DataCell(PrimeStatusBadge(
                  text: row['status']!,
                  color: row['status'] == 'Success' ? Colors.green : Colors.orange,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
