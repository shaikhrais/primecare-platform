import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class FranchisePipelineView extends ConsumerWidget {
  const FranchisePipelineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Strategic Franchise Expansion',
        subtitle: 'Overview and analytical breakdown for Strategic Franchise Expansion.',
        kpiCards: metrics.kpis
            .map(
              (kpi) => KpiStatCard(
                title: kpi.title,
                value: kpi.value,
                subtitle: kpi.subtitle,
                icon: _getLucideIcon(kpi.title),
                iconColor: _getStatusColor(kpi.status),
              ),
            )
            .toList(),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT: Franchise Pipeline Ledger
              Expanded(
                flex: 2,
                child: ClinicalGlassPanel(
                  title: 'Strategic Franchise Expansion Ledger',
                  icon: LucideIcons.briefcase,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final dataAsync = ref.watch(
                        dynamicPageProvider('officeFranchisePipelineView'),
                      );
                      return dataAsync.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, st) => Text('Error: $e'),
                        data: (items) {
                          if (items.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text(
                                'No records found.',
                                style: TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
                              ),
                            );
                          }
                          return Column(
                            children: items.map((item) {
                              return Column(
                                children: [
                                  _buildLedgerRow(
                                    LucideIcons.briefcase,
                                    item['title'] ?? 'Record',
                                    item['status'] ?? 'Active',
                                    AppTheme.emeraldTeal,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // RIGHT: Change Log
              Expanded(
                flex: 1,
                child: ClinicalGlassPanel(
                  title: 'Change Log',
                  icon: LucideIcons.history,
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


  Widget _buildLedgerRow(
    IconData icon,
    String title,
    String subtitle,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            key: const Key('data-status-id=business-franchise-franchise-action-1'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor.withOpacity(0.1),
              foregroundColor: statusColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('View', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }



  IconData _getLucideIcon(String title) {
    if (title.contains('Activity')) return LucideIcons.trendingUp;
    if (title.contains('Pending')) return LucideIcons.clock;
    if (title.contains('Sync')) return LucideIcons.refreshCcw;
    if (title.contains('Alert')) return LucideIcons.alertCircle;
    return LucideIcons.activity;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'history':
        return LucideIcons.history;
      case 'warning':
        return LucideIcons.alertTriangle;
      default:
        return LucideIcons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'teal':
        return AppTheme.emeraldTeal;
      case 'warning':
      case 'orange':
        return AppTheme.amberWarning;
      case 'danger':
      case 'red':
        return Colors.redAccent;
      case 'info':
      case 'indigo':
      case 'blue':
        return AppTheme.navyIndigo;
      default:
        return Colors.blueGrey;
    }
  }
}
