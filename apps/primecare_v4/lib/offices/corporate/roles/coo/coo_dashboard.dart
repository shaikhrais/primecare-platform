import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/health_indicator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class CooDashboard extends ConsumerWidget {
  const CooDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading metrics: $err')),
      data: (metrics) => PageTemplate(
        title: 'COO Operations Dashboard',
        subtitle: 'Real-time metrics across top franchise territories.',
        kpiCards: metrics.kpis
            .take(3)
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
            // LEFT COLUMN: Branch Performance
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Branch Operational Performance',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBranchMetric('Ontario South', 0.92, '92% Capacity'),
                          const SizedBox(height: 24),
                          _buildBranchMetric('New York Metro', 0.78, '78% Capacity'),
                          const SizedBox(height: 24),
                          _buildBranchMetric('Texas Central', 0.85, '85% Capacity'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Staffing Efficiency Heatmap',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClinicalGlassPanel(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              LucideIcons.map,
                              size: 48,
                              color: AppTheme.primary.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Interactive Staffing Heatmap Placeholder',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // RIGHT COLUMN: Critical Issues & Health
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Critical Issues',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...metrics.recentActivity
                      .where(
                        (log) =>
                            log.color == 'warning' ||
                            log.color == 'danger' ||
                            log.color == 'red' ||
                            log.color == 'orange',
                      )
                      .map(
                        (log) => _buildCriticalIssueCard(
                          log.title,
                          log.subtitle,
                          log.timestamp,
                          _getStatusColor(log.color),
                        ),
                      ),
                  const SizedBox(height: 32),
                  Text(
                    'Service Delivery Health',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aggregated delivery success rates across all service lines (Last 30 Days)',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDeliveryMetric('Nursing Visits', 0.98),
                          const SizedBox(height: 16),
                          _buildDeliveryMetric('PSW Care', 0.84),
                          const SizedBox(height: 16),
                          _buildDeliveryMetric('Therapy Services', 0.91),
                        ],
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

  Widget _buildBranchMetric(String name, double progress, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        HealthIndicator(progress: progress, height: 10),
      ],
    );
  }

  Widget _buildCriticalIssueCard(
    String title,
    String category,
    String status,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClinicalGlassPanel(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
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
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      '$category • $status',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryMetric(String name, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        HealthIndicator(progress: progress, height: 8),
      ],
    );
  }

  IconData _getLucideIcon(String title) {
    if (title.contains('Efficiency')) return LucideIcons.users;
    if (title.contains('Accuracy')) return LucideIcons.calendarCheck;
    if (title.contains('Incident')) return LucideIcons.alertTriangle;
    if (title.contains('Revenue')) return LucideIcons.dollarSign;
    if (title.contains('Staff')) return LucideIcons.users;
    return LucideIcons.activity;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'green':
      case 'teal':
        return AppTheme.emeraldTeal;
      case 'warning':
      case 'orange':
        return AppTheme.amberWarning;
      case 'danger':
      case 'red':
        return Colors.redAccent;
      case 'info':
      case 'blue':
      case 'indigo':
        return AppTheme.navyIndigo;
      default:
        return Colors.blueGrey;
    }
  }
}
