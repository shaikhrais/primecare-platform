// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'config/api_config.dart';
import 'package:dio/dio.dart';
import 'network/api_client.dart';
import 'network/result.dart';
import 'src/factory_floor/ui_blueprint.dart';
import 'src/utils/prime_logger.dart';
import 'telemetry_service.dart';
import 'src/models/dashboard_models.dart';

export 'src/factory_floor/ui_blueprint.dart';
export 'src/models/dashboard_models.dart';

class ClinicalIntelligenceViewModel {
  final List<UIComponentBlueprint> blueprints;
  final bool isOfflineFallback;

  ClinicalIntelligenceViewModel({
    required this.blueprints,
    this.isOfflineFallback = false,
  });

  factory ClinicalIntelligenceViewModel.empty({bool isOffline = true}) {
    return ClinicalIntelligenceViewModel(
      blueprints: [],
      isOfflineFallback: isOffline,
    );
  }
}

class DashboardService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  DashboardService(this._apiClient, this._telemetry);

  Future<Result<DashboardMetrics>> getMetrics(String route) async {
    return Result.guardFuture<DashboardMetrics>(() async {
      final endpoint = ApiConfig.endpoints['providerMetrics']!;
      final response = await _apiClient.get('$endpoint?route=$route');
      if (response.statusCode == 200) {
        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Dashboard metrics fetched for route: $route',
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
    PrimeLogger.clinical(
      'Fetching clinical intelligence',
      tag: 'DashboardService',
    );
    return Result.guardFuture<ClinicalIntelligenceViewModel>(() async {
      final response = await _apiClient.get(
        '/clinical-intelligence?route=$route',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final blueprintsJson = data['blueprints'] as List<dynamic>? ?? [];

        final blueprints = blueprintsJson.map((json) {
          final type = json['componentType'] as String;
          final payload = json['dataPayload'];

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
              PrimeLogger.warning(
                'Unknown blueprint type: $type',
                tag: 'DashboardService',
              );
              return StatGridBlueprint(dataPayload: payload); // Fallback
          }
        }).toList();

        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Clinical intelligence blueprints hydrated: ${blueprints.length}',
        );
        return ClinicalIntelligenceViewModel(blueprints: blueprints);
      }

      _telemetry.passGate(
        ExecutionGateCategory.metricsLayer,
        'Clinical intelligence blueprints returned empty',
      );
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
