import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(
      ExecutionGateCategory.navigationLayer, 
      'Navigated to dynamic role dashboard screen for role: $role'
    );
    final metricsAsync = ref.watch(dashboardMetricsProvider(role));
    // 4. Aura Action Dispatcher (Refactored to private class method _handleAuraIntent)

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: metricsAsync.when(
        data: (result) {
          return result.fold(
            (metrics) {
              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Dashboard metrics rendered successfully: $role',
              );
              return _buildDashboardContent(
                context,
                ref,
                metrics,
                isResilientFallback: false,
              );
            },
            (error) {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Render-time failure in dashboard content: $role',
                error: error,
              );
              return _buildResilientFallback(
                context, 
                ref, 
                error.toString()
              );
            },
          );
        },
        loading: () {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Awaiting dashboard metrics hydration...',
          );
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Critical provider failure for role: $role',
            error: e,
            stackTrace: st,
          );
          return _buildResilientFallback(context, ref, e.toString());
        },
      ),
    );
  }

  Widget _buildResilientFallback(BuildContext context, WidgetRef ref, String error) {
    return Column(
      children: [
        _buildResilienceBanner(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.shieldAlert, size: 48, color: Color(0xFFEAB308)),
                const SizedBox(height: 16),
                Text(
                  'Institutional Resilience Mode',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'We encountered an issue hydrating the live workspace. Forensics have been dispatched, and you are currently viewing the most stable fallback state.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: const Color(0xFF64748B)),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(dashboardMetricsProvider(role)),
                  icon: const Icon(LucideIcons.refreshCw, size: 16),
                  label: const Text('Attempt Re-Hydration'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResilienceBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color(0xFFFEF9C3), // Yellow 100
      child: Row(
        children: [
          const Icon(LucideIcons.info, size: 14, color: Color(0xFF854D0E)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Operating in Resilience Mode: Using Last Known Good configuration.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF854D0E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    DashboardMetrics metrics, {
    required bool isResilientFallback,
  }) {
    final auraAsync = ref.watch(auraInsightsProvider(role));
    final prefService = ref.watch(preferenceServiceProvider);
    final telemetry = ref.read(executionGateProvider);

    // 3. Process personalization (Sorting pinned items first)
    final sortedKpis = List<KpiMetric>.from(metrics.kpis)
      ..sort((a, b) {
        final aPinned = prefService?.isPinned(role, a.title) ?? false;
        final bPinned = prefService?.isPinned(role, b.title) ?? false;
        if (aPinned && !bPinned) return -1;
        if (!aPinned && bPinned) return 1;
        return 0;
      });

    return RefreshIndicator(
      onRefresh: () => ref.refresh(dashboardMetricsProvider(role).future),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (isResilientFallback) _buildResilienceBanner(context),
          // 1. Intelligence Synthesis Strip
          auraAsync.when(
            data: (insights) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: PrimeCareAuraCard(
                insights: insights,
                onAuraResult: (intent) => _handleAuraIntent(context, telemetry, intent),
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
            ],
          ),
          const SizedBox(height: 32),

          // KPI Segment (Personalized Grid)
          metrics.kpis.isEmpty
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No institutional metrics available for this role.'),
                ))
              : PrimeCareResponsiveKpiGrid(
                  children: sortedKpis.map((kpi) {
                    final isPinned = prefService?.isPinned(role, kpi.title) ?? false;
                    return PrimeCareKpiCard(
                      title: kpi.title,
                      value: kpi.value,
                      subtitle: kpi.subtitle ?? '',
                      icon: _getIconForMetric(kpi.title),
                      isPinned: isPinned,
                      onPinToggle: () async {
                        if (prefService != null) {
                          await prefService.setPinned(role, kpi.title, !isPinned);
                          // Trigger UI update
                          ref.invalidate(preferenceServiceProvider);
                        }
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
  }

  void _handleAuraIntent(BuildContext context, ExecutionGateService telemetry, AuraIntent intent) {
    if (intent.actions.isEmpty) return;

    for (final action in intent.actions) {
      switch (action.type) {
        case AuraActionType.navigate:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrimeCareReportScreen(reportId: action.target),
            ),
          );
          break;
        case AuraActionType.filter:
          telemetry.passGate(
            ExecutionGateCategory.auraEngine,
            'Aura: Applying filter for ${action.target}',
          );
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
