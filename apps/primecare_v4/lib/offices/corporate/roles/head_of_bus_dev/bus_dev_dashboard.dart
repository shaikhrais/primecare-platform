import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
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
      data: (metrics) => PageTemplate(
        title: 'Business Development Leadership',
        subtitle: 'Strategic orchestration of franchise expansion and clinical partnership growth.',
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
                    ClinicalGlassPanel(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildPipelineItem(
                            'Brampton South',
                            'Negotiation Phase',
                            r'$450k Peak',
                            '60% PROBABILITY',
                          ),
                          const SizedBox(height: 24),
                          _buildPipelineItem(
                            'Mississauga East',
                            'Discovery Call',
                            'N/A',
                            'HOT LEAD',
                            isHot: true,
                          ),
                          const SizedBox(height: 24),
                          _buildPipelineItem(
                            'Oakville Central',
                            'Agreement Signed',
                            r'$720k Peak',
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
                  ? LucideIcons.checkCircle2
                  : (isHot
                        ? LucideIcons.flame
                        : LucideIcons.building2),
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
    if (title.contains('Lead')) return LucideIcons.users;
    if (title.contains('Franchise')) return LucideIcons.home;
    if (title.contains('Revenue') || title.contains('Deal'))
      return LucideIcons.coins;
    if (title.contains('Conversion')) return LucideIcons.trendingUp;
    return LucideIcons.activity;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.badgeCheck;
      case 'person_add':
        return LucideIcons.userPlus;
      case 'lock':
        return LucideIcons.lock;
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
