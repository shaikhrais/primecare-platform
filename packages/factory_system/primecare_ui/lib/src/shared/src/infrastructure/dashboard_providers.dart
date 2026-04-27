// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_service.dart';
import 'training_service.dart';
import 'api_client.dart';
import 'telemetry_service.dart';
import 'result.dart';
import 'core/dashboard_models.dart';

final trainingServiceProvider = Provider<TrainingService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch(executionGateProvider);
  return TrainingService(apiClient, telemetry);
});

final trainingSummaryProvider = FutureProvider<Result<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(trainingServiceProvider);
  return await service.getTrainingSummary();
});

final trainingActivityProvider =
    FutureProvider<Result<List<Map<String, dynamic>>>>((ref) async {
      final service = ref.watch(trainingServiceProvider);
      return await service.getRecentActivity();
    });

final trainingCurriculaProvider =
    FutureProvider<Result<List<Map<String, dynamic>>>>((ref) async {
      final service = ref.watch(trainingServiceProvider);
      return await service.getCurricula();
    });

final trainingCertificationsProvider =
    FutureProvider<Result<List<Map<String, dynamic>>>>((ref) async {
      final service = ref.watch(trainingServiceProvider);
      return await service.getCertifications();
    });

final trainingModulesProvider =
    FutureProvider<Result<List<Map<String, dynamic>>>>((ref) async {
      final service = ref.watch(trainingServiceProvider);
      return await service.listModules();
    });

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch(executionGateProvider);
  return DashboardService(apiClient, telemetry);
});

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
        (Object error) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Dashboard route hydration failed: $route',
            error: error,
          );
          // Resilience Pattern: Propagate failure for adapter recovery
          return Failure(error);
        },
      );
    });

final databaseReportProvider = FutureProvider<Result<Map<String, dynamic>>>((
  ref,
) async {
  final result = await ref.watch(
    dashboardMetricsProvider('CTO_Verification').future,
  );
  return result.map((m) => m.toJson());
});

final architecturePurposeProvider =
    FutureProvider<Result<Map<String, dynamic>>>((ref) async {
      final result = await ref.watch(
        dashboardMetricsProvider('CTO_Architecture').future,
      );
      return result.map((m) => m.toJson());
    });
