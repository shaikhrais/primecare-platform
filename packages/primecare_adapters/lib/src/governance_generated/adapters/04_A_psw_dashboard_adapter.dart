import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final pswDashboardAdapterProvider =
    FutureProvider<Result<PswDashboardViewModel>>((ref) async {
  const route = 'PSW';
  const cacheKey = 'psw_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    // Watch the hardened infrastructure provider for standardized metrics fetching
    final result = await ref.watch(dashboardMetricsProvider(route).future);

    return result.fold(
      (metrics) {
        try {
          final viewModel = PswDashboardViewModel.fromDashboardMetrics(metrics);
          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          
          // Log successful hydration for telemetry and tests
          telemetry.passGate(
            ExecutionGateCategory.governance,
            'PSW Dashboard route hydrated with production metrics',
          );
          
          return Success(viewModel);
        } catch (e) {
          telemetry.failGate(
            ExecutionGateCategory.structuralIntegrity,
            'PSW ViewModel mapping failed: $e',
          );
          return _handlePswFallback(resilience, cacheKey, telemetry);
        }
      },
      (error) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'PSW Metrics Logistics Fallback Triggered: $error',
        );
        return _handlePswFallback(resilience, cacheKey, telemetry);
      },
    );
  } catch (e) {
    telemetry.failGate(
      ExecutionGateCategory.structuralIntegrity,
      'PSW Adapter critical failure: $e',
    );
    return _handlePswFallback(resilience, cacheKey, telemetry);
  }
});

Result<PswDashboardViewModel> _handlePswFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  // Fallback: Restore from local resilience cache if infrastructure is unreachable
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = PswDashboardViewModel.fromJson(snapshot);
      return Success(PswDashboardViewModel(
        metrics: vm.metrics,
        insights: vm.insights,
        blueprints: vm.blueprints,
        isOfflineFallback: true,
      ));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'PSW Cache corruption detected: $e',
      );
    }
  }

  // Final fallback to synthetic skeleton (Smart Mock Injection)
  return Success(PswDashboardViewModel.empty(isOfflineFallback: true));
}
