// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final complianceManagerDashboardAdapterProvider =
    FutureProvider<Result<ComplianceManagerDashboardViewModel>>((ref) async {
      const route = 'ComplianceManager';
      const cacheKey = 'compliance_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

    return metricsResult.fold(
      (metrics) {
        try {
          // High-Fidelity Mapping: Combine native metrics with AI intelligence
          final viewModel = ComplianceManagerDashboardViewModel.fromDashboardMetrics(metrics);

          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.governance,
            'Compliance Manager Dashboard route hydrated with production metrics',
          );
          return Success(viewModel);
        } catch (e) {
          telemetry.failGate(
            ExecutionGateCategory.structuralIntegrity,
            'Compliance Manager ViewModel mapping failed: $e',
          );
          return _handleComplianceManagerFallback(resilience, cacheKey, telemetry);
        }
      },
      (error) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Compliance Manager Metrics Logistics Fallback Triggered: $error',
        );
        return _handleComplianceManagerFallback(resilience, cacheKey, telemetry);
      },
    );
  } catch (e) {
    telemetry.failGate(
      ExecutionGateCategory.structuralIntegrity,
      'Compliance Manager Adapter critical failure: $e',
    );
    return _handleComplianceManagerFallback(resilience, cacheKey, telemetry);
  }
});

Result<ComplianceManagerDashboardViewModel> _handleComplianceManagerFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      return Success(ComplianceManagerDashboardViewModel.fromJson(snapshot));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Compliance Manager Cache corruption detected: $e',
      );
    }
  }
  return Success(
    ComplianceManagerDashboardViewModel.empty(isOfflineFallback: true),
  );
}

