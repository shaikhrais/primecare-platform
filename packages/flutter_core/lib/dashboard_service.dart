import 'config/api_config.dart';
import 'package:dio/dio.dart';
import 'network/api_client.dart';
import 'network/result.dart';
import 'src/factory_floor/ui_blueprint.dart';
import 'src/utils/prime_logger.dart';
import 'telemetry_service.dart';
export 'src/factory_floor/ui_blueprint.dart';

class KpiMetric {
  final String title;
  String get label => title;
  final String value;
  final String? subtitle;
  final String? trend;
  final String status;

  KpiMetric({
    required this.title,
    required this.value,
    this.subtitle,
    this.trend,
    required this.status,
  });

  factory KpiMetric.fromJson(Map<String, dynamic> json) {
    return KpiMetric(
      title: json['title'] as String,
      value: json['value'] as String,
      subtitle: json['subtitle'] as String?,
      trend: json['trend'] as String?,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'subtitle': subtitle,
      'trend': trend,
      'status': status,
    };
  }
}

class DashboardActivity {
  final String title;
  final String subtitle;
  final String timestamp;
  final String icon;
  final String color;

  DashboardActivity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.color,
  });

  factory DashboardActivity.fromJson(Map<String, dynamic> json) {
    return DashboardActivity(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      timestamp: json['timestamp'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'timestamp': timestamp,
      'icon': icon,
      'color': color,
    };
  }
}

class FinancialMetric {
  final String label;
  final String value;
  final String status;
  final String? trend;

  FinancialMetric({
    required this.label,
    required this.value,
    required this.status,
    this.trend,
  });

  factory FinancialMetric.fromJson(Map<String, dynamic> json) {
    return FinancialMetric(
      label: json['label'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      trend: json['trend'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'value': value, 'status': status, 'trend': trend};
  }
}

enum ChartType { bar, line, pie }

class ChartDataPoint {
  final String label;
  final double value;
  final String? color;

  ChartDataPoint({required this.label, required this.value, this.color});

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'value': value, 'color': color};
  }
}

class AnalyticsChart {
  final String id;
  final String title;
  final ChartType type;
  final List<ChartDataPoint> dataPoints;
  final List<ChartDataPoint>? forecastDataPoints;
  final String? reportId;

  AnalyticsChart({
    required this.id,
    required this.title,
    required this.type,
    required this.dataPoints,
    this.forecastDataPoints,
    this.reportId,
  });

  factory AnalyticsChart.fromJson(Map<String, dynamic> json) {
    final dataPointsRaw =
        json['dataPoints'] ?? json['data_points'] as List<dynamic>? ?? [];
    final forecastRaw =
        json['forecastDataPoints'] ??
        json['forecast_data_points'] as List<dynamic>?;

    return AnalyticsChart(
      id:
          json['id'] as String? ??
          'chart_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Analytics',
      type: ChartType.values.firstWhere(
        (e) => e.name == (json['type'] as String? ?? 'bar').toLowerCase(),
        orElse: () => ChartType.bar,
      ),
      dataPoints: (dataPointsRaw as List)
          .map((i) => ChartDataPoint.fromJson(i as Map<String, dynamic>))
          .toList(),
      forecastDataPoints: forecastRaw != null
          ? (forecastRaw as List)
                .map((i) => ChartDataPoint.fromJson(i as Map<String, dynamic>))
                .toList()
          : null,
      reportId: json['reportId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.name,
      'dataPoints': dataPoints.map((p) => p.toJson()).toList(),
      'forecastDataPoints': forecastDataPoints?.map((p) => p.toJson()).toList(),
      'reportId': reportId,
    };
  }
}

class DashboardMetrics {
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<AnalyticsChart> charts;

  DashboardMetrics({
    required this.kpis,
    required this.recentActivity,
    this.charts = const [],
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      kpis: (json['kpis'] as List)
          .map((i) => KpiMetric.fromJson(i as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List)
          .map((i) => DashboardActivity.fromJson(i as Map<String, dynamic>))
          .toList(),
      charts: json['charts'] != null
          ? (json['charts'] as List)
                .map((i) => AnalyticsChart.fromJson(i as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  factory DashboardMetrics.empty() {
    return DashboardMetrics(kpis: [], recentActivity: [], charts: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'kpis': kpis.map((k) => k.toJson()).toList(),
      'recentActivity': recentActivity.map((a) => a.toJson()).toList(),
      'charts': charts.map((c) => c.toJson()).toList(),
    };
  }
}

class AIAnalyticsForecastingData {
  final List<ForecastingProjection> projections;
  final ForecastingKPIs kpis;
  final double confidenceScore;
  final List<String> insights;

  AIAnalyticsForecastingData({
    required this.projections,
    required this.kpis,
    required this.confidenceScore,
    required this.insights,
  });

  factory AIAnalyticsForecastingData.fromJson(Map<String, dynamic> json) {
    return AIAnalyticsForecastingData(
      projections: (json['projections'] as List)
          .map((i) => ForecastingProjection.fromJson(i as Map<String, dynamic>))
          .toList(),
      kpis: ForecastingKPIs.fromJson(json['kpis'] as Map<String, dynamic>),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      insights: List<String>.from(json['insights'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projections': projections.map((i) => i.toJson()).toList(),
      'kpis': kpis.toJson(),
      'confidenceScore': confidenceScore,
      'insights': insights,
    };
  }
}

class ForecastingProjection {
  final String month;
  final double revenue;
  final double costs;
  final int patients;

  ForecastingProjection({
    required this.month,
    required this.revenue,
    required this.costs,
    required this.patients,
  });

  factory ForecastingProjection.fromJson(Map<String, dynamic> json) {
    return ForecastingProjection(
      month: json['month'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      costs: (json['costs'] as num).toDouble(),
      patients: json['patients'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'revenue': revenue,
      'costs': costs,
      'patients': patients,
    };
  }
}

class ForecastingKPIs {
  final double quarterlyRevenue;
  final double projectedGrowth;
  final double marginEfficiency;
  final int projectedAdmissions;

  ForecastingKPIs({
    required this.quarterlyRevenue,
    required this.projectedGrowth,
    required this.marginEfficiency,
    required this.projectedAdmissions,
  });

  factory ForecastingKPIs.fromJson(Map<String, dynamic> json) {
    return ForecastingKPIs(
      quarterlyRevenue: (json['quarterlyRevenue'] as num).toDouble(),
      projectedGrowth: (json['projectedGrowth'] as num).toDouble(),
      marginEfficiency: (json['marginEfficiency'] as num).toDouble(),
      projectedAdmissions: json['projectedAdmissions'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quarterlyRevenue': quarterlyRevenue,
      'projectedGrowth': projectedGrowth,
      'marginEfficiency': marginEfficiency,
      'projectedAdmissions': projectedAdmissions,
    };
  }
}

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
