import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/page_template.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class ComplianceDashboard extends ConsumerWidget {
  const ComplianceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'Compliance & Risk Governance',
        subtitle: 'Ensuring institutional integrity through automated audit and risk oversight.',
        kpiCards: metrics.kpis
            .map(
              (kpi) => _buildKpiCard(
                kpi.title,
                kpi.value,
                _getLucideIcon(kpi.title),
                _getStatusColor(kpi.status),
                kpi.subtitle,
              ),
            )
            .toList(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: Audit Queue
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Institutional Audit Queue',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClinicalGlassPanel(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          _buildAuditItem(
                            'Hamilton Clinic',
                            'Annual Safety Review',
                            'IN PROGRESS',
                            '88%',
                          ),
                          const Divider(
                            color: Colors.blueGrey,
                            height: 24,
                            thickness: 0.1,
                          ),
                          _buildAuditItem(
                            'Toronto West',
                            'Medication Storage Audit',
                            'URGENT',
                            '42%',
                            isUrgent: true,
                          ),
                          const Divider(
                            color: Colors.blueGrey,
                            height: 24,
                            thickness: 0.1,
                          ),
                          _buildAuditItem(
                            'Ottawa Region',
                            'Credentialing Verification',
                            'COMPLETED',
                            '100%',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // RIGHT: Risk Feed
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Incident Mitigation Feed',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClinicalGlassPanel(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: metrics.recentActivity
                            .map(
                              (log) => Column(
                                children: [
                                  _buildAuditLogTile(
                                    log.title,
                                    log.subtitle,
                                    log.timestamp,
                                    _getActivityIcon(log.icon),
                                    _getStatusColor(log.color),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color, [String? subtitle]) {
    return ClinicalGlassPanel(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+1.2%',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAuditItem(
    String facility,
    String title,
    String status,
    String progress, {
    bool isUrgent = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUrgent
                  ? Colors.redAccent.withOpacity(0.1)
                  : AppTheme.emeraldTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isUrgent ? LucideIcons.alertOctagon : LucideIcons.checkSquare,
              color: isUrgent ? Colors.redAccent : AppTheme.emeraldTeal,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  facility,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                progress,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isUrgent ? Colors.redAccent : AppTheme.emeraldTeal,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: Colors.blueGrey,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLogTile(
    String title,
    String subtitle,
    String timestamp,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
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
                    fontSize: 14,
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
          Text(
            timestamp,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  IconData _getLucideIcon(String title) {
    if (title.contains('Audit')) return LucideIcons.shieldCheck;
    if (title.contains('Risk')) return LucideIcons.alertTriangle;
    if (title.contains('Policy')) return LucideIcons.bookOpen;
    if (title.contains('License')) return LucideIcons.award;
    return LucideIcons.activity;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified':
        return LucideIcons.listChecks;
      case 'lock':
        return LucideIcons.shield;
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

