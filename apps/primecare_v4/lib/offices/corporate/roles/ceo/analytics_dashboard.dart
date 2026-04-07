import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../providers/dashboard_providers.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CeoAnalyticsDashboard extends ConsumerWidget {
  const CeoAnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return PageTemplate(
      title: 'Global Analytics',
      subtitle: 'Real-time intelligence across all regions, clinical outcomes, and financial integrity.',
      headerIcon: LucideIcons.pieChart,
      actions: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.download, size: 16),
          label: const Text('Export Report'),
          style: FilledButton.styleFrom(
            backgroundColor: PrimeCareTheme.emeraldTeal,
            foregroundColor: Colors.white,
          ),
        ),
      ],
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
        data: (metrics) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI ROW
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
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT: Strategic Initiatives
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    title: 'Strategic Roadmap Progress',
                    icon: LucideIcons.map,
                    child: Column(
                      children: [
                        _buildStrategyRow(
                          'Nationwide Expansion',
                          'Q2 Milestone: 84%',
                          PrimeCareTheme.emeraldTeal,
                        ),
                        Divider(
                          color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.1),
                          height: 24,
                        ),
                        _buildStrategyRow(
                          'Clinical Excellence Sync',
                          'Target reached',
                          PrimeCareTheme.navyIndigo,
                        ),
                        Divider(
                          color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.1),
                          height: 24,
                        ),
                        _buildStrategyRow(
                          'AI Diagnostics Rollout',
                          'Phase 3 (On track)',
                          Colors.amber.shade700,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // RIGHT: Executive Audit Feed
                Expanded(
                  flex: 1,
                  child: ClinicalGlassPanel(
                    title: 'Executive Audit Feed',
                    icon: LucideIcons.activity,
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
                                  iconColor: _getStatusColor(log.color),
                                ),
                                Divider(
                                  color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.1),
                                  height: 16,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
        trend: '+2.4%', // Visual indication
        trendUp: true,
      ),
    );
  }

  Widget _buildStrategyRow(String title, String status, Color color) {
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
            child: Icon(LucideIcons.trendingUp, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.4), size: 16),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Profit')) return LucideIcons.dollarSign;
    if (title.contains('Revenue')) return LucideIcons.briefcase;
    if (title.contains('Staff')) return LucideIcons.users;
    if (title.contains('Security')) return LucideIcons.shieldCheck;
    return LucideIcons.lineChart;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.shieldCheck;
      case 'lock':
        return LucideIcons.lock;
      case 'cloud_done':
        return LucideIcons.cloud;
      default:
        return LucideIcons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal':
        return PrimeCareTheme.emeraldTeal;
      case 'warning':
      case 'orange':
        return Colors.orange;
      case 'danger':
      case 'red':
        return Colors.red;
      case 'info':
      case 'indigo':
      case 'blue':
        return PrimeCareTheme.navyIndigo;
      default:
        return PrimeCareTheme.navyIndigo.withValues(alpha: 0.6);
    }
  }
}
