import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class MarketingOverview extends ConsumerWidget {
  const MarketingOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Global Brand & Growth Marketing',
        subtitle: 'Orchestrating regional outreach, lead velocity, and institutional brand authority.',
        kpiCards: metrics.kpis
            .map(
              (kpi) => KpiStatCard(
                title: kpi.title,
                value: kpi.value,
                subtitle: kpi.subtitle,
                icon: _getIcon(kpi.title),
                iconColor: _getStatusColor(kpi.status),
              ),
            )
            .toList(),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT: Regional Campaigns
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Expansion Campaigns',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClinicalGlassPanel(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildCampaignRow(
                            'Healthy Aging: NY Cluster',
                            'Paid Search / Meta',
                            'ACTIVE',
                            '4.2k Leads',
                          ),
                          const SizedBox(height: 24),
                          _buildCampaignRow(
                            'PrimeCare Discovery: ON',
                            'Local Outreach',
                            'ACTIVE',
                            '2.1k Leads',
                          ),
                          const SizedBox(height: 24),
                          _buildCampaignRow(
                            'Post-Op Mobility: FLA',
                            'Affiliate / Clinic Hub',
                            'PAUSED',
                            '0.4k Leads',
                            isPaused: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // RIGHT: Market Trends
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marketing Audit Trail',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClinicalGlassPanel(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: metrics.recentActivity
                            .map(
                              (log) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: AuditLogTile(
                                  title: log.title,
                                  subtitle: log.subtitle,
                                  timestamp: log.timestamp,
                                  icon: _getActivityIcon(log.icon),
                                  iconColor: _getStatusColor(
                                    log.color,
                                  ),
                                ),
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
    );
  }


  Widget _buildCampaignRow(
    String title,
    String type,
    String status,
    String performance, {
    bool isPaused = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isPaused
                ? Colors.blueGrey.withValues(alpha: 0.1)
                : AppTheme.primary.withValues(alpha: 0.1),
            child: Icon(
              LucideIcons.share2,
              color: isPaused ? Colors.blueGrey : AppTheme.primary,
              size: 20,
            ),
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
                  type,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                performance,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPaused ? Colors.blueGrey : Colors.teal,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Reach')) return LucideIcons.megaphone;
    if (title.contains('Cost')) return LucideIcons.coins;
    if (title.contains('Velocity')) return LucideIcons.zap;
    if (title.contains('Equity')) return LucideIcons.star;
    if (title.contains('ROI')) return LucideIcons.trendingUp;
    return LucideIcons.activity;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.badgeCheck;
      case 'video':
        return LucideIcons.video;
      case 'savings':
        return LucideIcons.piggyBank;
      case 'warning':
        return LucideIcons.alertTriangle;
      default:
        return LucideIcons.history;
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
