import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../providers/dashboard_providers.dart';

class StaffManagementView extends ConsumerWidget {
  const StaffManagementView({super.key});

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
              Text('Operational Staff Management', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Staff Retention', value: '94%', icon: Icons.group_add, iconColor: Colors.teal, subtitle: 'Top Tier')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Overtime Rate', value: '4.2%', icon: Icons.timer, iconColor: Colors.orange, subtitle: 'Within Goal')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Clinician NPS', value: '8.4', icon: Icons.favorite, iconColor: Colors.red, subtitle: 'Luminous Sentiment')),
                ],
              ),
              const SizedBox(height: 32),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildStaffRow('Arthur RN', 'Registered Nurse', 'ACTIVE', Colors.teal),
                    const Divider(height: 32, thickness: 0.1),
                    _buildStaffRow('Ford PSW', 'Personal Support', 'ON SHIFT', Colors.orange),
                    const Divider(height: 32, thickness: 0.1),
                    _buildStaffRow('Tricia RMT', 'Massage Therapist', 'AVAILABLE', Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildStaffRow(String name, String role, String status, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 18, backgroundColor: color.withValues(alpha: 0.1), child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(role, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
            ],
          ),
        ),
        Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
      ],
    );
  }
}
