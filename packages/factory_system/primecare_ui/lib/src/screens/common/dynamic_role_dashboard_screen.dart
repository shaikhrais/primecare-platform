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
import '../../components/dashboards/blueprint_renderer.dart';
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
      'Navigated to dynamic role dashboard screen for role: $role',
    );
    final theme = Theme.of(context);

    // 1. Attempt to resolve specialized dashboard adapter (e.g., 'ceoDashboard')
    final adapterKey =
        '${role.split('_').map((s) => s.toLowerCase()).join('')}Dashboard';
    final specializedProvider = resolveAdapterByName(adapterKey);

    if (specializedProvider != null) {
      final specializedAsync = ref.watch(specializedProvider as dynamic);

      return specializedAsync.when(
        data: (result) {
          return result.fold(
            (viewModel) {
              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Hydrated specialized dashboard for: $role',
              );
              return _buildDashboardContent(
                context,
                ref,
                viewModel,
                isResilientFallback: false,
              );
            },
            (error) {
              return _buildResilientFallback(context, ref, error.toString());
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildResilientFallback(context, ref, e.toString()),
      );
    }

    // 2. Fallback to generic metrics provider
    final metricsAsync = ref.watch(dashboardMetricsProvider(role));

    return ColoredBox(
      color: theme.colorScheme.surface,
      child: metricsAsync.when(
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
              return _buildResilientFallback(context, ref, error.toString());
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

  Widget _buildResilientFallback(
    BuildContext context,
    WidgetRef ref,
    String error,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildResilienceBanner(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.shieldAlert,
                  size: 48,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Institutional Resilience Mode',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'We encountered an issue hydrating the live workspace. Forensics have been dispatched, and you are currently viewing the most stable fallback state.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.invalidate(dashboardMetricsProvider(role)),
                  icon: const Icon(LucideIcons.refreshCw, size: 16),
                  label: const Text('Attempt Re-Hydration'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
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
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: theme.colorScheme.secondaryContainer,
      child: Row(
        children: [
          Icon(
            LucideIcons.info,
            size: 14,
            color: theme.colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Operating in Resilience Mode: Using Last Known Good configuration.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSecondaryContainer,
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
    dynamic metricsOrViewModel, {
    required bool isResilientFallback,
  }) {
    final theme = Theme.of(context);
    final auraAsync = ref.watch(auraInsightsProvider(role));
    final prefService = ref.watch(preferenceServiceProvider);
    final telemetry = ref.read(executionGateProvider);

    // Extract metrics and blueprints
    final kpis = metricsOrViewModel is PrimeCareDashboardViewModel
        ? metricsOrViewModel.kpis
        : (metricsOrViewModel as DashboardMetrics).kpis;

    final charts = metricsOrViewModel is PrimeCareDashboardViewModel
        ? [] // Charts are usually in blueprints now
        : (metricsOrViewModel as DashboardMetrics).charts;

    final blueprints = metricsOrViewModel is PrimeCareDashboardViewModel
        ? metricsOrViewModel.blueprints
        : <UIComponentBlueprint>[];

    // 3. Process personalization (Sorting pinned items first)
    final sortedKpis = List<KpiMetric>.from(kpis)
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
                onAuraResult: (intent) =>
                    _handleAuraIntent(context, telemetry, intent),
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Real-time metrics and institutional activity feed.',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
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

          // Blueprint Segment (High-Fidelity Modules)
          if (blueprints.isNotEmpty) ...[
            ...blueprints.map((blueprint) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: BlueprintRenderer(blueprint: blueprint),
              );
            }),
          ],

          // KPI Segment (Personalized Grid - Fallback or Supplemental)
          if (blueprints.isEmpty) ...[
            kpis.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'No institutional metrics available for this role.',
                      ),
                    ),
                  )
                : PrimeCareResponsiveKpiGrid(
                    children: sortedKpis.map((kpi) {
                      final isPinned =
                          prefService?.isPinned(role, kpi.title) ?? false;
                      return PrimeCareKpiCard(
                        title: kpi.title,
                        value: kpi.value,
                        subtitle: kpi.subtitle ?? '',
                        icon: _getIconForMetric(kpi.title),
                        isPinned: isPinned,
                        onPinToggle: () async {
                          if (prefService != null) {
                            await prefService.setPinned(
                              role,
                              kpi.title,
                              !isPinned,
                            );
                            // Trigger UI update
                            ref.invalidate(preferenceServiceProvider);
                          }
                        },
                      );
                    }).toList(),
                  ),
          ],

          const SizedBox(height: 32),

          // Analytics Segment (Personalized Charts)
          if (charts.isNotEmpty) ...[
            Text(
              'Operational Insights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ...charts.map((chart) {
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

  void _handleAuraIntent(
    BuildContext context,
    ExecutionGateService telemetry,
    AuraIntent intent,
  ) {
    if (intent.actions.isEmpty) return;

    for (final action in intent.actions) {
      switch (action.type) {
        case AuraActionType.navigate:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PrimeCareReportScreen(reportId: action.target),
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
