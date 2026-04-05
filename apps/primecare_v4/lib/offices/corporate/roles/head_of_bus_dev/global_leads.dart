import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class GlobalLeadsView extends ConsumerWidget {
  const GlobalLeadsView({super.key});

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
              // GROWTH HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Actionable Leads', value: '142', icon: Icons.stars, iconColor: Colors.indigo, subtitle: '8 High Priority')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Conversion Rate', value: '18%', icon: Icons.pie_chart, iconColor: Colors.teal, subtitle: 'Target: 20%')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Pipeline Value', value: r'$1.4M', icon: Icons.rocket_launch, iconColor: Colors.orange, subtitle: 'Q3 Forecast')),
                ],
              ),

              const SizedBox(height: 32),

              // PIPELINE STAGES
              Text('Lead Lifecycle Tracking', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildLeadRow('Toronto West Clinic Group', 'PROPOSAL SENT', '85%', Colors.teal),
              _buildLeadRow('Vancouver Health Collective', 'NEGOTIATION', '60%', Colors.orange),
              _buildLeadRow('Montreal Private Care', 'QUALIFICATION', '25%', Colors.indigo),

              const SizedBox(height: 32),

              // BUSINESS TOOLS
              Text('BizDev Command Palette', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildCmdRow('Generate Global ROI Matrix', Icons.analytics_outlined),
                    const Divider(height: 32, thickness: 0.1),
                    _buildCmdRow('Access Partnership Repository', Icons.handshake_outlined),
                    const Divider(height: 32, thickness: 0.1),
                    _buildCmdRow('Market Density Visualization', Icons.map_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildLeadRow(String client, String stage, String probability, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 6, backgroundColor: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(stage, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Text(probability, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildCmdRow(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        const Icon(Icons.chevron_right, color: Colors.blueGrey, size: 16),
      ],
    );
  }
}
