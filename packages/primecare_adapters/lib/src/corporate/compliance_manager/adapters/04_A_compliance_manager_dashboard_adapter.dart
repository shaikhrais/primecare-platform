// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final complianceManagerDashboardAdapterProvider =
    FutureProvider<Result<ComplianceManagerDashboardViewModel>>((ref) async {
      const route = 'ComplianceManager';
      const cacheKey = 'compliance_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
          // High-Fidelity Mapping: Combine native metrics with AI intelligence
                    final viewModel =
              ComplianceManagerDashboardViewModel.fromDashboardMetrics(
                metrics,
              );

          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Dashboard route hydrated',
      );
          return Success(viewModel);
        },
        (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'ComplianceManager Metrics Logistics Fallback Triggered',
      );
          // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              ComplianceManagerDashboardViewModel.fromJson(snapshot as Map<String, dynamic>),
            );
          }
          return Success(
            ComplianceManagerDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

