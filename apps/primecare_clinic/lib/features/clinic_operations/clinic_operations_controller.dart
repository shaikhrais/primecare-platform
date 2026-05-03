import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_operations_model.dart';


final clinicDashboardControllerProvider =
    FutureProvider<Result<ClinicOperationsModel>>((ref) async {
  const route = 'ClinicManager';
  const cacheKey = 'clinic_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    final response = await ref.read(apiClientProvider).get(
      '/dashboard-metrics',
      query: {'role': route},
    );
    final data = response.data as Map<String, dynamic>;

    final metricsRaw = data['metrics'] ?? data['kpis'] ?? <dynamic>[];
    final insightsRaw = data['insights'] ?? <dynamic>[];
    final timelineRaw = data['timeline'] ?? data['recentActivity'] ?? <dynamic>[];
    final trendsRaw = data['trends'] ?? data['charts'] ?? <dynamic>[];
    final isFallback = data['isOfflineFallback'] ?? false;

    final intlModel = IntelligenceDashboardModel.fromJson({
      'metrics': metricsRaw,
      'insights': insightsRaw,
      'timeline': timelineRaw,
      'trends': trendsRaw,
      'isOfflineFallback': isFallback,
      'lastUpdated': DateTime.now().toIso8601String(),
    });

    final dashboardMetrics = DashboardMetrics(
      kpis: intlModel.metrics,
      recentActivity: intlModel.timeline,
      charts: intlModel.trends,
      insights: intlModel.insights,
      isOfflineFallback: intlModel.isFromCache,
    );

    final mappedInsights = intlModel.insights
        .map((e) => IntelligenceInsight.fromDashboardInsight(e))
        .toList();

    final model = ClinicOperationsModel(
      metrics: dashboardMetrics,
      insights: mappedInsights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    return _handleFallback(resilience, cacheKey, telemetry, e);
  }
});

Result<ClinicOperationsModel> _handleFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
  dynamic error,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    return Success(ClinicOperationsModel.fromJson(snapshot));
  }
  return Success(ClinicOperationsModel.empty(isOfflineFallback: true));
}
