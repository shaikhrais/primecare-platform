// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final ceoDashboardAdapterProvider =
    FutureProvider<Result<CeoDashboardViewModel>>((ref) async {
  const route = 'CEO';
  const cacheKey = 'ceo_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    // Watch the hardened infrastructure provider for standardized metrics fetching
    final result = await ref.watch(dashboardMetricsProvider(route).future);

    return result.fold(
      (metrics) {
        try {
          final viewModel = CeoDashboardViewModel.fromDashboardMetrics(metrics);
          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          
          // Log successful hydration for telemetry and tests
          telemetry.passGate(
            ExecutionGateCategory.governance,
            'CEO Dashboard route hydrated with production metrics',
          );
          
          return Success(viewModel);
        } catch (e) {
          telemetry.failGate(
            ExecutionGateCategory.structuralIntegrity,
            'CEO ViewModel mapping failed: $e',
          );
          return _handleCeoFallback(resilience, cacheKey, telemetry);
        }
      },
      (error) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'CEO Metrics Logistics Fallback Triggered: $error',
        );
        return _handleCeoFallback(resilience, cacheKey, telemetry);
      },
    );
  } catch (e) {
    telemetry.failGate(
      ExecutionGateCategory.structuralIntegrity,
      'CEO Adapter critical failure: $e',
    );
    return _handleCeoFallback(resilience, cacheKey, telemetry);
  }
});

Result<CeoDashboardViewModel> _handleCeoFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  // Fallback: Restore from local resilience cache if infrastructure is unreachable
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = CeoDashboardViewModel.fromJson(snapshot);
      return Success(CeoDashboardViewModel(
        metrics: vm.metrics,
        insights: vm.insights,
        blueprints: vm.blueprints,
        isOfflineFallback: true,
      ));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'CEO Cache corruption detected: $e',
      );
    }
  }

  // Final fallback to synthetic skeleton (Smart Mock Injection)
  return Success(CeoDashboardViewModel.empty(isOfflineFallback: true));
}
