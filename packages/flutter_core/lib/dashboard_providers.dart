import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_service.dart';
import 'api_providers.dart';
import 'src/factory_floor/data_logistics_hub.dart';
import 'src/utils/prime_logger.dart';
import 'telemetry_service.dart';
import 'network/result.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch(executionGateProvider);
  return DashboardService(apiClient, telemetry);
});

final clinicIntelligenceProvider =
    FutureProvider.family<ClinicalIntelligenceViewModel, String>((
      ref,
      route,
    ) async {
      final service = ref.watch(dashboardServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final serviceResult = await service.getClinicalIntelligence(route);
      return serviceResult.fold(
        (data) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Hydrated clinical intelligence for: $route',
          );
          return data;
        },
        (error) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Clinical intelligence hydration failed for: $route',
            error: error,
          );
          PrimeLogger.error(
            'Failed to fetch clinical intelligence',
            error: error,
            tag: 'ClinicIntelligenceProvider',
          );
          return DataLogisticsHub.getClinicIntelligenceMetrics();
        },
      );
    });

// Using a family provider to support fetching distinct metrics per route/role with resilient hydration
final dashboardMetricsProvider =
    FutureProvider.family<Result<DashboardMetrics>, String>((ref, route) async {
      final service = ref.watch(dashboardServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final serviceResult = await service.getMetrics(route);
      return serviceResult.fold(
        (metrics) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Dashboard route hydrated: $route',
            metadata: {
              'charts': metrics.charts.length,
              'activities': metrics.recentActivity.length,
            },
          );
          return Success(metrics);
        },
        (error) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Dashboard route hydration failed: $route',
            error: error,
          );
          PrimeLogger.error(
            'Failed to fetch dashboard metrics for route: $route',
            error: error,
            tag: 'DashboardMetricsProvider',
          );
          // Standardized Resilience Pattern: Propagate the failure.
          // The UI adapter layer is responsible for persistence-based LKG recovery.
          return Failure(error);
        },
      );
    });

final aiAnalyticsForecastingProvider =
    FutureProvider<Result<AIAnalyticsForecastingData>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);
      return await service.getAIAnalyticsForecasting();
    });

/// Standardized family provider for AI forecasting to match dashboardMetricsProvider pattern.
final forecastingProvider =
    FutureProvider.family<Result<AIAnalyticsForecastingData>, String>((
      ref,
      route,
    ) async {
      return await ref.watch(aiAnalyticsForecastingProvider.future);
    });

/// Manages the predictive "Aura" state for dashboard components.
class AuraDashboardToggleNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() => {};

  void toggle(String componentId) {
    state = {...state, componentId: !(state[componentId] ?? false)};
  }
}

final auraDashboardToggleProvider =
    NotifierProvider<AuraDashboardToggleNotifier, Map<String, bool>>(
      AuraDashboardToggleNotifier.new,
    );
