// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final billingAdminDashboardAdapterProvider =
    FutureProvider<Result<BillingAdminDashboardViewModel>>((ref) async {
      const route = 'BillingAdmin';
      const cacheKey = 'billing_admin_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

    return metricsResult.fold(
      (metrics) {
        try {
          final viewModel = BillingAdminDashboardViewModel.fromDashboardMetrics(metrics);
          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          
          // Log successful hydration for telemetry and tests
          telemetry.passGate(
            ExecutionGateCategory.governance,
            'Billing Admin Dashboard route hydrated with production metrics',
          );
          
          return Success(viewModel);
        } catch (e) {
          telemetry.failGate(
            ExecutionGateCategory.structuralIntegrity,
            'Billing Admin ViewModel mapping failed: $e',
          );
          return _handleBillingAdminFallback(resilience, cacheKey, telemetry);
        }
      },
      (error) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Billing Admin Metrics Logistics Fallback Triggered: $error',
        );
        return _handleBillingAdminFallback(resilience, cacheKey, telemetry);
      },
    );
  } catch (e) {
    telemetry.failGate(
      ExecutionGateCategory.structuralIntegrity,
      'Billing Admin Adapter critical failure: $e',
    );
    return _handleBillingAdminFallback(resilience, cacheKey, telemetry);
  }
});

Result<BillingAdminDashboardViewModel> _handleBillingAdminFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  // Fallback: Restore from local resilience cache if infrastructure is unreachable
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = BillingAdminDashboardViewModel.fromJson(snapshot);
      return Success(BillingAdminDashboardViewModel(
        metrics: vm.metrics,
        insights: vm.insights,
        blueprints: vm.blueprints,
        isOfflineFallback: true,
      ));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Billing Admin Cache corruption detected: $e',
      );
    }
  }

  // Final fallback to synthetic skeleton (Smart Mock Injection)
  return Success(BillingAdminDashboardViewModel.empty(isOfflineFallback: true));
}

