import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/primecare_core.dart';
import '../../components/cards/primecare_aura_card.dart';
import '../../components/charts/prime_care_bar_chart.dart';
import '../../components/charts/prime_care_line_chart.dart';
import '../../components/charts/prime_care_pie_chart.dart';
import '../../components/dashboards/prime_care_kpi_card.dart';
import '../../components/dashboards/prime_care_responsive_kpi_grid.dart';
import 'primecare_report_screen.dart';

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}

class DynamicRoleDashboardScreen extends ConsumerWidget {
  final String role;

  const DynamicRoleDashboardScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider(role));
    final auraAsync = ref.watch(auraInsightsProvider(role));
    final prefService = ref.watch(preferenceServiceProvider);

    // 4. Aura Action Dispatcher
    void handleAuraIntent(AuraIntent intent) {
      if (intent.actions.isEmpty) return;

      for (final action in intent.actions) {
        switch (action.type) {
          case AuraActionType.navigate:
            // Institutional Navigation to Drill-Down Reports
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PrimeCareReportScreen(reportId: action.target),
              ),
            );
            break;
          case AuraActionType.filter:
            // Placeholder for real-time chart filtering logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Aura: Applying institutional filter for ${action.target}',
                ),
              ),
            );
            break;
          default:
            break;
        }
      }
    }

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
                // 1. Intelligence Synthesis Strip
                auraAsync.when(
                  data: (insights) => Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: PrimeCareAuraCard(
                      insights: insights,
                      onAuraResult: handleAuraIntent,
                    ),
                  ),
                  loading: () => const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                ),

                // Header Segment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${role.split('_').map((s) => s.capitalize()).join(' ')} Workspace',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Real-time metrics and institutional activity feed.',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
                  ...metrics.charts.map((chart) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: _buildChart(chart),
                    );
                  }),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Institutional Error: $e')),
      ),
    );
  }

  Widget _buildChart(AnalyticsChart chart) {
    switch (chart.type) {
      case ChartType.line:
        return PrimeCareLineChart(chart: chart);
      case ChartType.bar:
        return PrimeCareBarChart(chart: chart);
      case ChartType.pie:
        return PrimeCarePieChart(chart: chart);
    }
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return LucideIcons.users;
    if (t.contains('claim') || t.contains('revenue'))
      return LucideIcons.dollarSign;
    if (t.contains('staff') || t.contains('capacity'))
      return LucideIcons.userCheck;
    if (t.contains('alert')) return LucideIcons.alertCircle;
    return LucideIcons.activity;
  }
}
