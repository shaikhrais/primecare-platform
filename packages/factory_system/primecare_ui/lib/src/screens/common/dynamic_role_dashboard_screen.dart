import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/cards/primecare_kpi_card.dart';
import '../../components/cards/primecare_chart_card.dart';
import '../../components/charts/prime_care_bar_chart.dart';
import '../../components/charts/prime_care_line_chart.dart';
import '../../components/charts/prime_care_pie_chart.dart';
import '../../components/primecare_responsive_kpi_grid.dart';

/// Centralized Role-Based Dashboard Screen.
/// Aggregates metrics via the DataLogisticsHub and integrates PreferenceService for
/// role-specific personalization (PINing/Favorites).
class DynamicRoleDashboardScreen extends ConsumerWidget {
  const DynamicRoleDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Identify current role for data binding & personalization
    final authState = ref.watch(authProvider);
    final role = authState.role ?? 'guest';

    // 2. Hydrate metrics via the global resilient provider
    final metricsAsync = ref.watch(dashboardMetricsProvider(role));
    final prefService = ref.watch(preferenceServiceProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: metricsAsync.when(
        data: (metrics) {
          // 3. Process personalization (Sorting pinned items first)
          final sortedKpis = List<KpiMetric>.from(metrics.kpis)
            ..sort((a, b) {
              final aPinned = prefService.isPinned(role, a.title);
              final bPinned = prefService.isPinned(role, b.title);
              if (aPinned && !bPinned) return -1;
              if (!aPinned && bPinned) return 1;
              return 0;
            });

          return RefreshIndicator(
            onRefresh: () => ref.refresh(dashboardMetricsProvider(role).future),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Header Segment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${role.split('_').map((s) => s.capitalize()).join(' ')} Workspace',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Real-time metrics and institutional activity feed.',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    if (metricsAsync.isRefreshing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // KPI Segment (Personalized Grid)
                PrimeCareResponsiveKpiGrid(
                  children: sortedKpis.map((kpi) {
                    final isPinned = prefService.isPinned(role, kpi.title);
                    return PrimeCareKpiCard(
                      title: kpi.title,
                      value: kpi.value,
                      subtitle: kpi.subtitle ?? '',
                      icon: _getIconForMetric(kpi.title),
                      isPinned: isPinned,
                      onPinToggle: () async {
                        await prefService.setPinned(role, kpi.title, !isPinned);
                        // Trigger UI update
                        ref.invalidate(preferenceServiceProvider);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                // Analytics Segment (Personalized Charts)
                if (metrics.charts.isNotEmpty) ...[
                  const Text(
                    'Operational Insights',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...(() {
                    final sortedCharts =
                        List<AnalyticsChart>.from(metrics.charts)..sort((a, b) {
                          final aPinned = prefService.isPinned(
                            role,
                            'chart_${a.id}',
                          );
                          final bPinned = prefService.isPinned(
                            role,
                            'chart_${b.id}',
                          );
                          if (aPinned && !bPinned) return -1;
                          if (!aPinned && bPinned) return 1;
                          return 0;
                        });

                    return sortedCharts.map((chart) {
                      final isPinned = prefService.isPinned(
                        role,
                        'chart_${chart.id}',
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: PrimeCareChartCard(
                          title: chart.title,
                          isPinned: isPinned,
                          onPinToggle: () async {
                            await prefService.setPinned(
                              role,
                              'chart_${chart.id}',
                              !isPinned,
                            );
                            ref.invalidate(preferenceServiceProvider);
                          },
                          chart: _buildChart(chart),
                        ),
                      );
                    });
                  })(),
                ],

                const SizedBox(height: 32),

                // Activity Feed Segment (Blueprints or direct render)
                if (metrics.recentActivity.isNotEmpty) ...[
                  const Text(
                    'Institutional Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: metrics.recentActivity.map((activity) {
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(
                                int.parse(
                                  activity.color.replaceAll('#', '0xFF'),
                                ),
                              ).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getIconForActivity(activity.icon),
                              size: 20,
                              color: Color(
                                int.parse(
                                  activity.color.replaceAll('#', '0xFF'),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            activity.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${activity.subtitle} • ${activity.timestamp}',
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading dashboard: $err')),
      ),
    );
  }

  Widget _buildChart(AnalyticsChart chart) {
    switch (chart.type) {
      case ChartType.bar:
        return PrimeCareBarChart(chart: chart);
      case ChartType.line:
        return PrimeCareLineChart(chart: chart);
      case ChartType.pie:
        return PrimeCarePieChart(chart: chart);
    }
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('sales'))
      return LucideIcons.dollarSign;
    if (t.contains('staff')) return LucideIcons.briefcase;
    if (t.contains('task')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  IconData _getIconForActivity(String iconName) {
    switch (iconName) {
      case 'user':
        return LucideIcons.user;
      case 'alert':
        return LucideIcons.alertTriangle;
      case 'check':
        return LucideIcons.checkCircle;
      default:
        return LucideIcons.info;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
