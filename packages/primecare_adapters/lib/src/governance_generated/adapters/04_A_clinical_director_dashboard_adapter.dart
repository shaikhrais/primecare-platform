import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final clinicalDirectorDashboardAdapterProvider =
    FutureProvider<Result<ClinicalDirectorDashboardViewModel>>((ref) async {
      const route = 'ClinicalDirector';
      const cacheKey = 'clinical_director_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch the hardened infrastructure provider for standardized metrics fetching
        final result = await ref.watch(dashboardMetricsProvider(route).future);

        return result.fold(
          (metrics) {
            try {
              final viewModel =
                  ClinicalDirectorDashboardViewModel.fromDashboardMetrics(
                    metrics,
                  );
              // Persist LKG snapshot for offline survival
              unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

              // Log successful hydration for telemetry and tests
              telemetry.passGate(
                ExecutionGateCategory.governance,
                'Clinical Director Dashboard route hydrated with production metrics',
              );

              return Success(viewModel);
            } catch (e) {
              telemetry.failGate(
                ExecutionGateCategory.structuralIntegrity,
                'Clinical Director ViewModel mapping failed: $e',
              );
              return _handleClinicalDirectorFallback(
                resilience,
                cacheKey,
                telemetry,
              );
            }
          },
          (error) {
            telemetry.passGate(
              ExecutionGateCategory.resilience,
              'Clinical Director Metrics Logistics Fallback Triggered: $error',
            );
            return _handleClinicalDirectorFallback(
              resilience,
              cacheKey,
              telemetry,
            );
          },
        );
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.structuralIntegrity,
          'Clinical Director Adapter critical failure: $e',
        );
        return _handleClinicalDirectorFallback(resilience, cacheKey, telemetry);
      }
    });

Result<ClinicalDirectorDashboardViewModel> _handleClinicalDirectorFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  // Fallback: Restore from local resilience cache if infrastructure is unreachable
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = ClinicalDirectorDashboardViewModel.fromJson(snapshot);
      return Success(
        ClinicalDirectorDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          incidentTrends: vm.incidentTrends,
          staffingHeatmap: vm.staffingHeatmap,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ),
      );
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Clinical Director Cache corruption detected: $e',
      );
    }
  }

  // Final fallback to synthetic skeleton (Smart Mock Injection)
  return Success(
    ClinicalDirectorDashboardViewModel.empty(isOfflineFallback: true),
  );
}
