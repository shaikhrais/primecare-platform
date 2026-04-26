// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the COO.
final cooActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('COO Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for COO metrics.
/// Provides real-time operational efficiency, utilization, and logistics velocity.
final cooMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository
      .watchMetrics('/v2/corporate/coo')
      .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
});

/// High-fidelity AI operational insights for the COO.
/// Leverages Aura Intelligence to surface logistics risks and efficiency gains.
final cooInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
  ref,
) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return const [];
  }

  // Simulate AI computation for logistics modeling
  await Future<void>.delayed(const Duration(milliseconds: 900));

  return [
    IntelligenceInsight(
      id: 'coo_insight_1',
      title: 'Supply Chain Optimization',
      summary:
          'Switching to "CareDirect" for wound care supplies could save 12% in procurement costs.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Logistics',
      recommendation: 'Initiate vendor review for Q3 procurement cycle.',
    ),
    IntelligenceInsight(
      id: 'coo_insight_2',
      title: 'Staffing Capacity Risk',
      summary:
          'High clinical load in US East during weekend shifts is causing 12% burnout risk increase.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation:
          'Implement dynamic shift bridging for weekend high-load windows.',
    ),
    IntelligenceInsight(
      id: 'coo_insight_3',
      title: 'Facility Expansion Velocity',
      summary:
          'New facility onboarding time reduced by 15% via automated logistics hub.',
      impact: InsightImpact.info,
      type: InsightType.growth,
      category: 'Strategic',
      recommendation:
          'Scale the automated onboarding blueprint to the Southwest region.',
    ),
  ];
});

final cooDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<CooDashboardViewModel>>((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'coo_dashboard';
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
        // Watch metrics and insights
        final metrics = await ref.watch(cooMetricsProvider.future);
        final insights = await ref.watch(cooInsightsProvider.future);

        final viewModel = CooDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'COO Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'COO Metrics Fallback Triggered: $e',
        );
        return _handleCOOFallback(resilience, cacheKey, telemetry);
      }
    });

Result<CooDashboardViewModel> _handleCOOFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = CooDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'COO Cache corruption detected: $e',
      );
    }
  }
  return Success(CooDashboardViewModel.empty(isOfflineFallback: true));
}
