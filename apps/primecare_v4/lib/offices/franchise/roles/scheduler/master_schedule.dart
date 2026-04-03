import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class MasterScheduleView extends ConsumerWidget {
  const MasterScheduleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Clinical Master Timeline',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: AppTheme.primary,
          ),
        ),
      ),
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SCHEDULING HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Shift Coverage', value: '99.2%', icon: Icons.event_available, iconColor: Colors.teal, subtitle: 'Target: 100%')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Unassigned', value: '4', icon: Icons.pending_actions, iconColor: Colors.red, subtitle: 'Urgent Action')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Optimised', value: 'Yes', icon: Icons.auto_awesome, iconColor: Colors.indigo, subtitle: 'Route: Active')),
                ],
              ),

              const SizedBox(height: 32),

              // DAILY SHIFT BLOCKS
              Text('Upcoming Shift Deployments', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildShiftCard('RN Arthur Dent', 'Patient: Ford Prefect', '08:00 - 12:00', 'COMPLETED', Colors.teal),
              _buildShiftCard('PSW Tricia McMillan', 'Patient: Zaphod B.', '13:00 - 17:00', 'IN-PROGRESS', Colors.orange),
              _buildShiftCard('RN Slartibartfast', 'Patient: Marvin R.', '18:00 - 22:00', 'UPCOMING', Colors.indigo),

              const SizedBox(height: 32),

              // SCHEDULING CONTROLS
              Text('Logistics Command Center', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildControlRow('Deploy Emergency Response Team', Icons.emergency_share, Colors.red),
                    const Divider(height: 32, thickness: 0.1),
                    _buildControlRow('Optimize Regional Route Hubs', Icons.map_outlined, AppTheme.primary),
                    const Divider(height: 32, thickness: 0.1),
                    _buildControlRow('Broadcast Open Shift Alerts', Icons.notification_add_outlined, Colors.indigo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftCard(String staff, String patient, String time, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.access_time, color: color, size: 20),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(staff, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(patient, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlRow(String label, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        const Icon(Icons.chevron_right, color: Colors.blueGrey, size: 16),
      ],
    );
  }
}
