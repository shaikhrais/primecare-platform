// Layer: 05_UI_PRESENTATION
// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument, inference_failure_on_untyped_parameter
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
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

    // 1. Attempt to resolve specialized dashboard adapter (e.g., 'ceoDashboard')
    final adapterKey =
        '${role.split('_').map((s) => s.toLowerCase()).join('')}Dashboard';
    final specializedProvider = resolveAdapterByName(adapterKey);

    if (specializedProvider != null) {
      final specializedAsync = ref.watch(specializedProvider as dynamic);

      return specializedAsync.when(
        data: (result) => (result as Result).fold(
          (viewModel) => PageTemplate(
            title: '${role.split('_').map((s) => s.capitalize()).join(' ')} Workspace',
            subtitle: 'Real-time metrics and institutional activity feed.',
            body: _buildDashboardContent(context, ref, viewModel, isResilientFallback: false),
          ),
          (error) => _buildResilientFallback(context, ref, error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildResilientFallback(context, ref, e.toString()),
      );
    }

    // 2. Fallback to generic metrics provider
    final metricsAsync = ref.watch(dashboardMetricsProvider(role));

    return metricsAsync.when(
      data: (result) => result.fold(
        (metrics) => PageTemplate(
          title: '${role.split('_').map((s) => s.capitalize()).join(' ')} Workspace',
          subtitle: 'Real-time metrics and institutional activity feed.',
          body: _buildDashboardContent(context, ref, metrics, isResilientFallback: false),
        ),
        (error) => _buildResilientFallback(context, ref, error.toString()),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => _buildResilientFallback(context, ref, e.toString()),
    );
  }

  Widget _buildResilientFallback(
    BuildContext context,
    WidgetRef ref,
    String error,
  ) {
    return PageTemplate(
      title: 'Institutional Resilience',
      subtitle: 'stable fallback state active',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.shieldAlert, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              'Hydration Failure',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(error, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            PrimeCareButton(
              onPressed: () => ref.invalidate(dashboardMetricsProvider(role)),
              text: 'Retry Hydration',
              icon: LucideIcons.refreshCw,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    dynamic metricsOrViewModel, {
    required bool isResilientFallback,
  }) {
    final auraAsync = ref.watch(auraInsightsProvider(role));
    final prefService = ref.watch(preferenceServiceProvider);
    final telemetry = ref.read(executionGateProvider);

    // Extract metrics and blueprints
    final kpis = metricsOrViewModel is PrimeCareDashboardViewModel
        ? metricsOrViewModel.kpis
        : (metricsOrViewModel as DashboardMetrics).kpis;

    final charts = metricsOrViewModel is PrimeCareDashboardViewModel
        ? <AnalyticsChart>[]
        : (metricsOrViewModel as DashboardMetrics).charts;

    final blueprints = metricsOrViewModel is PrimeCareDashboardViewModel
        ? metricsOrViewModel.blueprints
        : <UIComponentBlueprint>[];

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
          auraAsync.when(
            data: (insights) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: PrimeCareAuraCard(
                insights: insights,
                onAuraResult: (intent) => _handleAuraIntent(context, telemetry, intent),
              ),
            ),
            loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
            error: (_, _) => const SizedBox.shrink(),
          ),

          if (blueprints.isNotEmpty) ...[
            ...blueprints.map((blueprint) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ComponentWarehouse.build(context, blueprint),
            )),
          ],

          if (blueprints.isEmpty) ...[
            if (kpis.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text('No metrics available.')))
            else
              PrimeCareResponsiveKpiGrid(
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
                        ref.invalidate(preferenceServiceProvider);
                      }
                    },
                  );
                }).toList(),
              ),
          ],

          if (charts.isNotEmpty) ...[
            const SizedBox(height: 32),
            const Text('Operational Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...charts.map((chart) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: _buildChart(chart),
            )),
          ],
        ],
      ),
    );
  }

  void _handleAuraIntent(BuildContext context, ExecutionGateService telemetry, AuraIntent intent) {
    if (intent.actions.isEmpty) return;
    for (final action in intent.actions) {
      if (action.type == AuraActionType.navigate) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PrimeCareReportScreen(reportId: action.target)));
      } else if (action.type == AuraActionType.filter) {
        telemetry.passGate(ExecutionGateCategory.auraEngine, 'Aura: Applying filter for ${action.target}');
      }
    }
  }

  Widget _buildChart(AnalyticsChart chart) {
    switch (chart.type) {
      case ChartType.line: return PrimeCareLineChart(chart: chart);
      case ChartType.bar: return PrimeCareBarChart(chart: chart);
      case ChartType.pie: return PrimeCarePieChart(chart: chart);
    }
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return LucideIcons.users;
    if (t.contains('claim') || t.contains('revenue')) return LucideIcons.dollarSign;
    if (t.contains('staff') || t.contains('capacity')) return LucideIcons.userCheck;
    if (t.contains('alert')) return LucideIcons.alertCircle;
    return LucideIcons.activity;
  }
}
