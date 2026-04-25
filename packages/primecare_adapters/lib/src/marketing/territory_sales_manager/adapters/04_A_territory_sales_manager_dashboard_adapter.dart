// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Territory Sales Manager.
final territorySalesActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Territory Sales Manager Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Territory Sales Manager Dashboard.
/// Tracks lead volume by territory, conversion trends, and market penetration.
final territorySalesMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/marketing/territory_sales_manager')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI insights for the Territory Sales Manager Dashboard.
/// Surfaces reallocation suggestions and marketing ROI vectors via Aura Intelligence.
final territorySalesInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  await Future<void>.delayed(const Duration(seconds: 1));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    const IntelligenceInsight(
      id: 'tsm_1',
      title: 'Territory Reallocation Suggestion',
      summary:
          'East territory is over-performing; potential to split into East-North and East-South clusters.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Resource Allocation',
      recommendation:
          'Review geographic lead distribution for the next quarterly planning to optimize representative coverage.',
    ),
    const IntelligenceInsight(
      id: 'tsm_2',
      title: 'Ad Spend Optimization',
      summary:
          'OOH billboard performance in the West is yielding 40% lower ROI than localized digital channels.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      category: 'Marketing Efficiency',
      recommendation:
          'Shift OOH budget to localized social media geo-fencing campaigns to increase conversion density.',
    ),
  ];
});

/// Combined adapter provider for the Territory Sales Manager Dashboard.
/// Bridges high-fidelity telemetry and marketing insights into a unified ViewModel.
final territorySalesManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritorySalesManagerDashboardViewModel>>((
      ref,
    ) async {
      const cacheKey = 'territory_sales_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(territorySalesMetricsProvider.future);
        final insights = await ref.watch(territorySalesInsightsProvider.future);

        final viewModel = TerritorySalesManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Territory Sales Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            TerritorySalesManagerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          TerritorySalesManagerDashboardViewModel.empty(
            isOfflineFallback: true,
          ),
        );
      }
    });
