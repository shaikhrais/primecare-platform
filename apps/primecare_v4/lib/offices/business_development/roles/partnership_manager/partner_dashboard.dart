import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../providers/dashboard_providers.dart';

class PartnerDashboard extends ConsumerWidget {
  const PartnerDashboard({super.key});

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
                    'Strategic Partnerships Hub',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                      fontFamily: 'Manrope',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Managing B2B referral networks and clinical alliance performance.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // PARTNERSHIP KPI ROW
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
                      // LEFT: Partner Performance Ranking
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Partner Performance Ranking',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildPartnerRow(
                                    'East River General',
                                    'Platinum',
                                    '420 Referrals',
                                    Colors.teal,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildPartnerRow(
                                    'City Care Group',
                                    'Gold',
                                    '280 Referrals',
                                    Colors.indigo,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 24,
                                    thickness: 0.1,
                                  ),
                                  _buildPartnerRow(
                                    'Westside Clinic',
                                    'Silver',
                                    '115 Referrals',
                                    Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Recent Engagement
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alliance Engagement',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Manrope',
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

  Widget _buildPartnerRow(
    String name,
    String tier,
    String metric,
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
            child: Icon(Icons.business_outlined, color: color, size: 20),
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
                  'Tier: $tier',
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            metric,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Partnerships')) return Icons.handshake_outlined;
    if (title.contains('Volume')) return Icons.trending_up_outlined;
    if (title.contains('Alignment')) return Icons.center_focus_strong_outlined;
    if (title.contains('Influence')) return Icons.monetization_on_outlined;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return Icons.verified_user_outlined;
      case 'lock':
        return Icons.lock_outline;
      case 'cloud_done':
        return Icons.cloud_done_outlined;
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
