import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../providers/dashboard_providers.dart';

class QaReportsView extends ConsumerWidget {
  const QaReportsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // COMPLIANCE HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Audit Readiness', value: '98%', icon: Icons.verified_user, iconColor: Colors.teal, subtitle: 'High Integrity')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Training Completion', value: '92%', icon: Icons.school, iconColor: Colors.indigo, subtitle: 'Across all staff')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Open Incidents', value: '2', icon: Icons.emergency, iconColor: Colors.orange, subtitle: 'Pending Review')),
                ],
              ),

              const SizedBox(height: 32),

              // DEPARTMENTAL AUDIT LOGS
              Text('Departmental Compliance Logs', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildAuditEntry('Clinical Cluster: Medication Reconciliation', 'Verified 142 records. 0 discrepancies.', '2h ago', Colors.teal),
                    const Divider(height: 16, thickness: 0.1, color: Colors.blueGrey),
                    _buildAuditEntry('Marketing Cluster: Lead Qualification', 'Audit of 45 high-priority leads. Verified ROI.', '5h ago', Colors.indigo),
                    const Divider(height: 16, thickness: 0.1, color: Colors.blueGrey),
                    _buildAuditEntry('Franchise Cluster: General Ops Audit', 'Checked facility compliance for Toronto West.', 'Yesterday', Colors.orange),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // RECENT INVENTORY STATUS
              Text('Compliance Inventory Repositories', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildInventoryItem('Staff Certification Registry', '1,421 Active', Colors.teal),
              _buildInventoryItem('Incident Management Repository', '4 Pending Resolution', Colors.orange),
              _buildInventoryItem('External Regulatory Feedback', 'Stable (Latest: Health Canada)', Colors.indigo),
            ],
          ),
        ),
      );
  }

  Widget _buildAuditEntry(String title, String status, String time, Color color) {
    return AuditLogTile(
      title: title, 
      subtitle: status, 
      timestamp: time, 
      icon: Icons.assignment_turned_in_outlined, 
      iconColor: color
    );
  }

  Widget _buildInventoryItem(String title, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(Icons.inventory_2_outlined, color: color, size: 20),
            const SizedBox(width: 24),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
