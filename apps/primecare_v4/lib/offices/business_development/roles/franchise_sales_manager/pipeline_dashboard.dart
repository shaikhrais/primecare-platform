import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class FranchiseSalesDashboard extends ConsumerWidget {
  const FranchiseSalesDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Franchise Growth: Expansion Pipeline',
        subtitle: 'Monitor potential franchise partners, discovery day conversions, and regional territory sales.',
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
              // LEFT: Sales Funnel
              Expanded(
                flex: 2,
                child: ClinicalGlassPanel(
                  title: 'Active Prospect Pipeline',
                  icon: LucideIcons.funnel,
                  child: Column(
                    children: [
                      _buildProspectRow(
                        'Discovery Day: Toronto',
                        '8 Qualified Leads',
                        'HIGH PRIORITY',
                        Colors.teal,
                      ),
                      const SizedBox(height: 16),
                      _buildProspectRow(
                        'Territory Sale: Vancouver',
                        'Ref: #BC-202',
                        'PENDING SIG',
                        Colors.indigo,
                      ),
                      const SizedBox(height: 16),
                      _buildProspectRow(
                        'Partner Inquiry: Florida',
                        'Web Lead v4',
                        'FOLLOW UP',
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // RIGHT: Sales Audit Feed
              Expanded(
                flex: 1,
                child: ClinicalGlassPanel(
                  title: 'Lead Activity Feed',
                  icon: LucideIcons.activity,
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
                              iconColor: _getStatusColor(log.color),
                            ),
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
    );
  }

  Widget _buildProspectRow(
    String title,
    String subtitle,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16), // xl rounding
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              LucideIcons.rocket,
              color: statusColor,
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
                  subtitle,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: statusColor,
                fontSize: 10,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Leads')) return LucideIcons.filter;
    if (title.contains('Conversion')) return LucideIcons.target;
    if (title.contains('Pipeline')) return LucideIcons.network;
    if (title.contains('Proposals')) return LucideIcons.fileText;
    return LucideIcons.barChart2;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.shieldCheck;
      case 'lock':
        return LucideIcons.lock;
      case 'cloud_done':
        return LucideIcons.cloudLightning;
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

