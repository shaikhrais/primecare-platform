// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final headOfBusDevDashboardAdapterProvider =
    FutureProvider<Result<HeadOfBusDevDashboardViewModel>>((ref) async {
      const route = 'HeadOfBusDev';
      const cacheKey = 'head_of_bus_dev_dashboard_corporate';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel = HeadOfBusDevDashboardViewModel.fromDashboardMetrics(
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
        'HeadOfBusDev Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
        final vm = HeadOfBusDevDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(HeadOfBusDevDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
          return Success(
            HeadOfBusDevDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

