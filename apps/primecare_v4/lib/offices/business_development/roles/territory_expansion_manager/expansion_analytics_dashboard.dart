import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../providers/dashboard_providers.dart';

class ExpansionAnalyticsDashboard extends ConsumerWidget {
  const ExpansionAnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
        data: (metrics) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market Growth & Expansion',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF001F3F),
                        fontFamily: 'Manrope',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Strategizing territory readiness, demographics, and real estate acquisition pipelines.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // EXPANSION KPI ROW
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: metrics.kpis.map((kpi) => _buildKpi(
                            cardWidth, 
                            kpi.title, 
                            kpi.value, 
                            _getIcon(kpi.title), 
                            _getStatusColor(kpi.status), 
                            kpi.subtitle
                          )).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Market Readiness Map Heatmap Summary
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Territory Readiness Heatmap', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildTerritoryRow('Southeast Hub', 'Ready', '88%', Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildTerritoryRow('Midwest Division', 'LOI Stage', '74%', Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildTerritoryRow('Pacific North', 'Sourcing', '42%', Colors.orange),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: Acquisition Stage Funnel
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Acquisition Pipeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildFunnelStage('Sourcing Sites', '12', Colors.blueGrey),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    _buildFunnelStage('Under Review (LOI)', '6', Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    _buildFunnelStage('Lease Negotiation', '4', Colors.orange),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    _buildFunnelStage('Active Buildout', '2', Colors.teal),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildTerritoryRow(String region, String stage, String score, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.map_outlined, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(region, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Current Stage: $stage', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
              const Text('Readiness', style: TextStyle(color: Colors.blueGrey, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(String stage, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 8),
              Text(stage, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Territories')) return Icons.location_on_outlined;
    if (title.contains('Score')) return Icons.analytics_outlined;
    if (title.contains('Pipeline')) return Icons.leaderboard_outlined;
    if (title.contains('Growth')) return Icons.trending_up_outlined;
    return Icons.insights;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal': return Colors.teal;
      case 'warning':
      case 'orange': return Colors.orange;
      case 'danger':
      case 'red': return Colors.red;
      case 'info':
      case 'indigo':
      case 'blue': return Colors.indigo;
      default: return Colors.blueGrey;
    }
  }
}
