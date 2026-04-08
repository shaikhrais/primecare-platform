import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import 'package:primecare_core/theme/app_theme.dart';
import 'package:primecare_core/providers/dashboard_providers.dart';

class TerritorySalesDashboard extends ConsumerWidget {
  const TerritorySalesDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
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
                    'Territory Performance: Sales & Pipeline',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monitoring lead generation, conversion pipelines, and regional sales representative performance.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // SALES KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200
                          ? (constraints.maxWidth - 48) / 4
                          : (constraints.maxWidth > 600
                                ? (constraints.maxWidth - 16) / 2
                                : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: metrics.kpis
                            .map(
                              (kpi) => _buildKpi(
                                cardWidth,
                                kpi.title,
                                kpi.value,
                                _getIcon(kpi.title),
                                _getStatusColor(kpi.status),
                                kpi.subtitle,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Sales Leaderboard
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Regional Team Leaderboard',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildRepRow(
                                    'Sarah Johnson',
                                    'West Coast Territory',
                                    '112%',
                                    Colors.teal,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildRepRow(
                                    'Michael Chen',
                                    'Ontario Central',
                                    '98%',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildRepRow(
                                    'Alex Rivera',
                                    'Quebec Regional',
                                    '84%',
                                    Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Lead Heatmap Summary
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Territory Lead Density',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _buildRegionRow(
                                    'Toronto Hub',
                                    '42 Leads',
                                    Colors.teal,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  _buildRegionRow(
                                    'Vancouver Hub',
                                    '28 Leads',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 16,
                                    thickness: 0.1,
                                  ),
                                  _buildRegionRow(
                                    'Montreal Hub',
                                    '14 Leads',
                                    Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpi(
    double width,
    String title,
    String value,
    IconData icon,
    Color color, [
    String? subtitle,
  ]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(
        title: title,
        value: value,
        subtitle: subtitle,
        icon: icon,
        iconColor: color,
      ),
    );
  }

  Widget _buildRepRow(
    String name,
    String territory,
    String quota,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.person_pin_outlined, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  territory,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                quota,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
              const Text(
                'Quota',
                style: TextStyle(color: Colors.blueGrey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionRow(String region, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 8),
              Text(region, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(
            count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Leads')) return Icons.leaderboard_outlined;
    if (title.contains('Pipeline')) return Icons.account_tree_outlined;
    if (title.contains('Quota')) return Icons.track_changes_outlined;
    if (title.contains('Cycle')) return Icons.speed_outlined;
    return Icons.insights;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal':
        return Colors.teal;
      case 'warning':
      case 'orange':
        return Colors.orange;
      case 'danger':
      case 'red':
        return Colors.red;
      case 'info':
      case 'indigo':
      case 'blue':
        return Colors.indigo;
      default:
        return Colors.blueGrey;
    }
  }
}
