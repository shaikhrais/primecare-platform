import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class SalesDashboard extends ConsumerWidget {
  const SalesDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Franchise Sales & Acquisition Hub',
        subtitle: 'Managing the discovery pipeline, disclosure documentation, and new partner onboarding.',
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
              // LEFT: Sales Pipeline
              Expanded(
                flex: 2,
                child: ClinicalGlassPanel(
                  title: 'Franchise Partner Pipeline',
                  icon: LucideIcons.building2,
                  child: Column(
                    children: [
                      _buildPipelineRow(
                        'John Doe (Hamilton)',
                        'FDD Signed',
                        r'$45k Dep',
                        'LEGAL REVIEW',
                      ),
                      const SizedBox(height: 16),
                      _buildPipelineRow(
                        'Jane Smith (Vaughan)',
                        'Discovery Day',
                        'N/A',
                        'QUALIFIED',
                        isHot: true,
                      ),
                      const SizedBox(height: 16),
                      _buildPipelineRow(
                        'Bob Wilson (Toronto)',
                        'Initial Inquiry',
                        'N/A',
                        'CONTACTED',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // RIGHT: Sales Logs
              Expanded(
                flex: 1,
                child: ClinicalGlassPanel(
                  title: 'Acquisition Audit Feed',
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

  Widget _buildPipelineRow(
    String name,
    String stage,
    String deposit,
    String status, {
    bool isHot = false,
  }) {
    final statusColor = isHot ? Colors.orange : AppTheme.primary;
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
              LucideIcons.building,
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
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$stage | $deposit',
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
                fontSize: 11,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Inquiry')) return LucideIcons.messageSquare;
    if (title.contains('Discovery')) return LucideIcons.calendar;
    if (title.contains('FDD')) return LucideIcons.fileSignature;
    if (title.contains('Target')) return LucideIcons.target;
    return LucideIcons.barChart2;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'check_circle':
        return LucideIcons.checkCircle;
      case 'public':
        return LucideIcons.globe;
      case 'event':
        return LucideIcons.calendarCheck;
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
