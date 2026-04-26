import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// StreamProvider for real-time operations metrics.
/// Implements high-fidelity hydration for the Operations Manager.
final operationsMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'OPERATIONS_MANAGER';
  final repository = ref.read(dashboardRepositoryProvider);

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics(route)
      .map(
        (result) => result.fold(
          (metrics) => metrics,
          (error) => DashboardMetrics.empty(),
        ),
      );
});

/// FutureProvider for AI-driven operational insights.
/// Uses a separate channel to prevent blocking the primary metrics stream.
final operationsInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  // Simulate AI computation latency for operational strategy
  await Future<void>.delayed(const Duration(milliseconds: 1500));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    IntelligenceInsight(
      id: 'ops_01',
      title: LocaleKeys
          .dashboards_operationsmanager_labels_predictive_staffing_gap
          .tr(),
      summary:
          'High intake volume predicted for Tuesday afternoon (Sector 2). Staffing model suggests a 2-hour coverage deficit.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      category: 'Resources',
      recommendation:
          'Pre-authorize 2 additional support staff hours for the 2PM-6PM window.',
    ),
    IntelligenceInsight(
      id: 'ops_02',
      title: LocaleKeys
          .dashboards_operationsmanager_labels_operational_cost_saving
          .tr(),
      summary:
          'Transitioning to "Green-Care" energy mode in the Ontario West cluster saved \$1,200 this week.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Sustainability',
      recommendation:
          'Roll out "Green-Care" automation across all Level 2 facilities by EOM.',
    ),
    IntelligenceInsight(
      id: 'ops_03',
      title: LocaleKeys
          .dashboards_operationsmanager_labels_facility_maintenance_trigger
          .tr(),
      summary:
          'Sector 4 HVAC diagnostic indicates 85% vibration threshold breach. Preventive maintenance recommended.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Maintenance',
      recommendation:
          'Dispatch facility maintenance team for Sector 4 inspection by Friday.',
    ),
  ];
});

/// Combined adapter provider for the Operations Manager Dashboard.
/// Bridges high-fidelity telemetry and operational insights into a unified ViewModel.
final operationsManagerDashboardAdapterProvider =
    FutureProvider<Result<OperationsManagerDashboardViewModel>>((ref) async {
      const cacheKey = 'operations_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(operationsMetricsProvider.future);
        final insights = await ref.watch(operationsInsightsProvider.future);

        final viewModel = OperationsManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Operations Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            OperationsManagerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          OperationsManagerDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
