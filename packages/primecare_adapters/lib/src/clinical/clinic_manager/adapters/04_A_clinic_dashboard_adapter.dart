// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final clinicDashboardAdapterProvider =
    FutureProvider<Result<ClinicDashboardViewModel>>((ref) async {
      const route = 'ClinicManager';
      const cacheKey = 'clinic_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
          
          final viewModel = ClinicDashboardViewModel.fromDashboardMetrics(
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
        'Clinic Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
        final vm = ClinicDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(ClinicDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
          return Success(ClinicDashboardViewModel.empty(isOfflineFallback: true));
        },
      );
    });

