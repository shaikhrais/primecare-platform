import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class TrainingAdminDashboard extends ConsumerWidget {
  const TrainingAdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Training & Curriculum Leadership',
        subtitle: 'Orchestrating clinical education, certification paths, and staff development.',
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
              // LEFT: Curriculum Management
              Expanded(
                flex: 2,
                child: ClinicalGlassPanel(
                  title: 'Active Curriculum Development',
                  icon: LucideIcons.bookOpen,
                  child: Column(
                    children: [
                      _buildTrainingModule(
                        'Advanced Wound Care v2.4',
                        'Clinical Protocol',
                        'DRAFT',
                        LucideIcons.microscope,
                      ),
                      const SizedBox(height: 16),
                      _buildTrainingModule(
                        'Patient Privacy (AODA 2026)',
                        'Compliance',
                        'ACTIVE',
                        LucideIcons.gavel,
                        isLive: true,
                      ),
                      const SizedBox(height: 16),
                      _buildTrainingModule(
                        'Crisis Intervention Hub',
                        'Psychological Care',
                        'REVIEW',
                        LucideIcons.headset,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // RIGHT: Certification Stream
              Expanded(
                flex: 1,
                child: ClinicalGlassPanel(
                  title: 'Credentialing Audit Feed',
                  icon: LucideIcons.shieldCheck,
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

  Widget _buildTrainingModule(
    String title,
    String category,
    String status,
    IconData icon, {
    bool isLive = false,
  }) {
    final statusColor = isLive ? Colors.teal : AppTheme.primary;
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
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
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
                  category,
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
    if (title.contains('Certif')) return LucideIcons.graduationCap;
    if (title.contains('Module')) return LucideIcons.bookOpen;
    if (title.contains('Score') || title.contains('Auto'))
      return LucideIcons.barChart2;
    if (title.contains('Recert') || title.contains('Due'))
      return LucideIcons.refreshCw;
    return LucideIcons.activity;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.award;
      case 'warning':
        return LucideIcons.alertTriangle;
      case 'path':
        return LucideIcons.gitBranch;
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
