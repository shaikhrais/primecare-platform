import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class BusDevDashboard extends ConsumerWidget {
  const BusDevDashboard({super.key});

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
                    'Business Development Leadership',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Strategic orchestration of franchise expansion and clinical partnership growth.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BUSDEV KPI ROW
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
                      // LEFT: Partner Pipeline
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Franchise Acquisition Pipeline',
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
                                  _buildPipelineItem(
                                    'Brampton South',
                                    'Negotiation Phase',
                                    '\$450k Peak',
                                    '60% PROBABILITY',
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildPipelineItem(
                                    'Mississauga East',
                                    'Discovery Call',
                                    'N/A',
                                    'HOT LEAD',
                                    isHot: true,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildPipelineItem(
                                    'Oakville Central',
                                    'Agreement Signed',
                                    '\$720k Peak',
                                    'CLOSED WON',
                                    isWon: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Market Logs
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Growth Audit Trail',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: metrics.recentActivity
                                    .map(
                                      (log) => Column(
                                        children: [
                                          AuditLogTile(
                                            title: log.title,
                                            subtitle: log.subtitle,
                                            timestamp: log.timestamp,
                                            icon: _getActivityIcon(log.icon),
                                            iconColor: _getStatusColor(
                                              log.color,
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.blueGrey,
                                            height: 16,
                                            thickness: 0.1,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
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

  Widget _buildPipelineItem(
    String location,
    String stage,
    String value,
    String status, {
    bool isHot = false,
    bool isWon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isWon
                ? Colors.teal.withValues(alpha: 0.1)
                : (isHot
                      ? Colors.orange.withValues(alpha: 0.1)
                      : AppTheme.primary.withValues(alpha: 0.1)),
            child: Icon(
              isWon
                  ? Icons.check_circle_outline
                  : (isHot
                        ? Icons.whatshot_outlined
                        : Icons.corporate_fare_outlined),
              color: isWon
                  ? Colors.teal
                  : (isHot ? Colors.orange : AppTheme.primary),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  stage,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isWon
                      ? Colors.teal
                      : (isHot ? Colors.orange : AppTheme.primary),
                  fontSize: 11,
                ),
              ),
              if (value != 'N/A')
                Text(
                  value,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 10),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Lead')) return Icons.account_tree_outlined;
    if (title.contains('Franchise')) return Icons.add_home_work_outlined;
    if (title.contains('Revenue') || title.contains('Deal'))
      return Icons.payments_outlined;
    if (title.contains('Conversion')) return Icons.trending_up;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return Icons.verified;
      case 'person_add':
        return Icons.person_add_alt_1_outlined;
      case 'lock':
        return Icons.lock_outline;
      default:
        return Icons.history;
    }
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
