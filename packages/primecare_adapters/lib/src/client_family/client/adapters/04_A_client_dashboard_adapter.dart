// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final clientDashboardAdapterProvider =
    FutureProvider<Result<ClientDashboardViewModel>>((ref) async {
  const route = 'Client';
  const cacheKey = 'client_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel = ClientDashboardViewModel.fromDashboardMetrics(metrics);
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
        'Client Metrics Logistics Fallback Triggered',
      );
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = ClientDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(ClientDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(ClientDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});

