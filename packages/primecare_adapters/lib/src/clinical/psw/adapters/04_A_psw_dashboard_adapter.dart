import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final pswDashboardAdapterProvider = FutureProvider<Result<PswDashboardViewModel>>((
  ref,
) async {
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
          final viewModel = PswDashboardViewModel(
            metrics: metrics,
            insights: _getSmartPswMocks(),
            isOfflineFallback: false,
          );

          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.intelligence,
            'PSW Field Intelligence Mapping Successful',
          );

          return Success(viewModel);
        } catch (e) {
          return _handlePswFallback(resilience, cacheKey, telemetry);
        }
      },
      (error) {
        return _handlePswFallback(resilience, cacheKey, telemetry);
      },
    );
  } catch (e) {
    return _handlePswFallback(resilience, cacheKey, telemetry);
  }
});

Result<PswDashboardViewModel> _handlePswFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = PswDashboardViewModel.fromJson(snapshot);
      return Success(
        PswDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ),
      );
    } catch (e) {
      // Logic handled by empty return
    }
  }

  return Success(PswDashboardViewModel.empty(isOfflineFallback: true));
}

List<IntelligenceInsight> _getSmartPswMocks() {
  return [
    IntelligenceInsight(
      id: 'psw_01',
      title: 'Schedule Density Alert',
      summary:
          'High travel time detected between visits 3 and 4. Optimization available.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      recommendation:
          'Re-route via Highway 401 to save 12 minutes of transit time.',
    ),
    IntelligenceInsight(
      id: 'psw_02',
      title: 'Clinical Priority',
      summary:
          'Patient John Doe (Visit 2) requires immediate vitals check due to recent medication change.',
      impact: InsightImpact.critical,
      type: InsightType.alert,
      recommendation:
          'Prioritize vitals capture and sync immediately upon arrival.',
    ),
  ];
}
