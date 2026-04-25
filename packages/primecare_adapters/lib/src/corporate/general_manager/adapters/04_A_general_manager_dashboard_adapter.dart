// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the General Manager Dashboard.
final generalManagerActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('General Manager Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the General Manager.
/// Tracks strategic P&L velocity, capital allocation, and regional operations.
final generalManagerMetricsProvider =
    StreamProvider.autoDispose<DashboardMetrics>((ref) {
      final repository = ref.watch(dashboardRepositoryProvider);
      return repository
          .watchMetrics('/v2/corporate/general_manager')
          .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
    });

/// High-fidelity AI strategic insights for the General Manager.
/// Surfaces growth opportunities and operational risks via Aura Intelligence.
final generalManagerInsightsProvider =
    FutureProvider.autoDispose<List<IntelligenceInsight>>((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );
      if (!canExecute) {
        return const [];
      }

      await Future<void>.delayed(const Duration(seconds: 1));

      return [
        const IntelligenceInsight(
          id: 'gm_01',
          title: 'Capital Inefficiency Detected',
          summary:
              'Equipment utilization at Facility B is underperforming by 30% against the quarterly benchmark.',
          impact: InsightImpact.warning,
          type: InsightType.efficiency,
          category: 'Operations',
          recommendation: 'Initiate asset reallocation audit for Facility B.',
        ),
        const IntelligenceInsight(
          id: 'gm_02',
          title: 'Regional P&L Overperformance',
          summary:
              'The Northern Region exceeded Q2 revenue targets by 12% due to optimized staffing ratios.',
          impact: InsightImpact.positive,
          type: InsightType.growth,
          category: 'Financial',
          recommendation:
              'Standardize the Northern Region staffing model across all territories.',
        ),
      ];
    });

/// Combined adapter provider for the General Manager Dashboard.
/// Bridges high-fidelity telemetry and strategic insights into a unified ViewModel.
final generalManagerDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<GeneralManagerDashboardViewModel>>((
      ref,
    ) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'general_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );

      try {
        if (!canExecute) {
          throw Exception('Metrics subsystem is degraded or offline');
        }
        final metrics = await ref.watch(generalManagerMetricsProvider.future);
        final insights = await ref.watch(generalManagerInsightsProvider.future);

        final viewModel = GeneralManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'General Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            GeneralManagerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          GeneralManagerDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
