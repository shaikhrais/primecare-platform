// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final generalManagerDashboardAdapterProvider =
    FutureProvider<Result<GeneralManagerDashboardViewModel>>((ref) async {
      const route = 'GeneralManager';
      const cacheKey = 'general_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              GeneralManagerDashboardViewModel.fromDashboardMetrics(
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
        'GeneralManager Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
        final vm = GeneralManagerDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(GeneralManagerDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
          return Success(
            GeneralManagerDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

