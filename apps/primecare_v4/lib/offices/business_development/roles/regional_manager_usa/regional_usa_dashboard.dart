import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class RegionalUsaDashboard extends ConsumerWidget {
  const RegionalUsaDashboard({super.key});

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
                      'Regional Operations: USA Cluster',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Managing state licensing, CMS compliance, and interstate growth across US markets.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // USA KPI ROW
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
                        // LEFT: State Performance
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('USA Division Pipeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildStateRow('New York State', 'CMS Level IV', '42 Active Hubs', 'EXCELLENT'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildStateRow('Florida Region', 'State License v3', '38 Active Hubs', 'STABLE'),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildStateRow('Texas Cluster', 'Interstate Audit', 'In Progress', 'WARNING', isWarning: true),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: Activity
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Interstate Sync', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: metrics.recentActivity.map((log) => Column(
                                    children: [
                                      AuditLogTile(
                                        title: log.title, 
                                        subtitle: log.subtitle, 
                                        timestamp: log.timestamp, 
                                        icon: _getActivityIcon(log.icon), 
                                        iconColor: _getStatusColor(log.color)
                                      ),
                                      const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    ],
                                  )).toList(),
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

  Widget _buildStateRow(String state, String compliance, String volume, String status, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           CircleAvatar(
            backgroundColor: isWarning ? Colors.orange.withValues(alpha: 0.1) : AppTheme.primary.withValues(alpha: 0.1),
            child: Icon(Icons.public_outlined, color: isWarning ? Colors.orange : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('$compliance | $volume', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: isWarning ? Colors.orange : Colors.teal, fontSize: 11)),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('State')) return Icons.map_outlined;
    if (title.contains('CMS')) return Icons.fact_check_outlined;
    if (title.contains('Growth')) return Icons.trending_up;
    if (title.contains('Revenue')) return Icons.monetization_on_outlined;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'public': return Icons.public;
      case 'verified': return Icons.verified_user_outlined;
      case 'auto_graph': return Icons.auto_graph;
      default: return Icons.history;
    }
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
