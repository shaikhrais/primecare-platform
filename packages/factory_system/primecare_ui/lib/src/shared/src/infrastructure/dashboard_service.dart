// Layer: 01_INFRASTRUCTURE
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'core/dashboard_models.dart';
import 'core/ui_blueprint.dart';
import '../infrastructure/result.dart';
import '../infrastructure/telemetry_service.dart';

class DashboardService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  DashboardService(this._apiClient, this._telemetry);

  Future<Result<DashboardMetrics>> getMetrics(String route) async {
    return Result.guardFuture<DashboardMetrics>(() async {
      final response = await _apiClient.get('/dashboard-metrics?route=$route');
      if (response.statusCode == 200) {
        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Dashboard metrics fetched for route: $route',
          silent: true,
        );
        return DashboardMetrics.fromJson(response.data as Map<String, dynamic>);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    });
  }

  Future<Result<ClinicalIntelligenceViewModel>> getClinicalIntelligence(
    String route,
  ) async {
    _telemetry.passGate(
      ExecutionGateCategory.clinical,
      'Fetching clinical intelligence',
      silent: true,
    );
    return Result.guardFuture<ClinicalIntelligenceViewModel>(() async {
      final response = await _apiClient.get(
        '/clinical-intelligence?route=$route',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final blueprintsJson = data['blueprints'] as List<dynamic>? ?? [];

        final blueprints = blueprintsJson.map((json) {
          final jsonMap = json as Map<String, dynamic>;
          final type = jsonMap['componentType'] as String;
          final payload = jsonMap['dataPayload'];

          switch (type) {
            case 'stat_card_grid':
              return StatGridBlueprint(dataPayload: payload);
            case 'clinical_metric':
              return ClinicalMetricBlueprint(dataPayload: payload);
            case 'activity_feed':
              return ActivityFeedBlueprint(dataPayload: payload);
            case 'analytics_chart':
              final chart = AnalyticsChart.fromJson(
                payload as Map<String, dynamic>,
              );
              return ChartBlueprint(dataPayload: chart);
            case 'financial_rail':
              final metrics = (payload as List<dynamic>)
                  .map(
                    (m) => FinancialMetric.fromJson(m as Map<String, dynamic>),
                  )
                  .toList();
              return FinancialRailBlueprint(dataPayload: metrics);
            case 'aura_dashboard_hud':
              return AuraDashboardHudBlueprint(dataPayload: payload);
            default:
              _telemetry.failGate(
                ExecutionGateCategory.ui,
                'Unknown blueprint type: $type',
              );
              return StatGridBlueprint(dataPayload: payload); // Fallback
          }
        }).toList();

        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Clinical intelligence blueprints hydrated: ${blueprints.length}',
          silent: true,
        );
        return ClinicalIntelligenceViewModel(blueprints: blueprints);
      }

      return ClinicalIntelligenceViewModel(blueprints: []);
    });
  }

  Future<Result<AIAnalyticsForecastingData>> getAIAnalyticsForecasting() async {
    return Result.guardFuture<AIAnalyticsForecastingData>(() async {
      final response = await _apiClient.get(
        '/clinical/ai-analytics/q3-extrapolations',
      );
      if (response.statusCode == 200) {
        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'AI Analytics forecasting data fetched',
          silent: true,
        );
        return AIAnalyticsForecastingData.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    });
  }
}
