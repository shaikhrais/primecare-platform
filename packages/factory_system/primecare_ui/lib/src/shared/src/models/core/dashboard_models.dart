// Layer: 02_MODELS_FOUNDATION
import 'ui_blueprint.dart';

class PrimeCareLabel {
  final String en;
  final String? fr;
  final String? es;

  const PrimeCareLabel(this.en, {this.fr, this.es});

  factory PrimeCareLabel.fromJson(Map<String, dynamic> json) {
    return PrimeCareLabel(
      json['en'] as String? ?? '',
      fr: json['fr'] as String?,
      es: json['es'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'en': en, if (fr != null) 'fr': fr, if (es != null) 'es': es};
  }

  String get(String langCode) {
    switch (langCode.toLowerCase()) {
      case 'fr':
        return fr ?? en;
      case 'es':
        return es ?? en;
      default:
        return en;
    }
  }
}

enum InsightImpact {
  positive,
  caution,
  info,
  alert,
  growth,
  warning,
  critical,
  standard,
  success,
  high,
  medium,
  low,
}

enum KpiStatus {
  positive,
  negative,
  neutral,
  warning,
  critical,
  success,
  healthy,
  error,
}

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
      title: (json['title'] ?? '').toString(),
      value: (json['value'] ?? '').toString(),
      subtitle: json['subtitle']?.toString(),
      trend: json['trend']?.toString(),
      status: (json['status'] ?? 'neutral').toString(),
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

class DashboardInsight {
  final String title;
  final String description;
  final String type;
  final InsightImpact? impact;
  final Map<String, dynamic>? metadata;
  String get summary => description;

  DashboardInsight({
    required this.title,
    required this.description,
    required this.type,
    this.impact,
    this.metadata,
  });

  factory DashboardInsight.fromJson(Map<String, dynamic> json) {
    return DashboardInsight(
      title: (json['title'] ?? json['label'] ?? 'Untitled Insight').toString(),
      description: (json['description'] ?? json['summary'] ?? '').toString(),
      type: (json['type'] ?? 'info').toString(),
      impact: json['impact'] != null
          ? InsightImpact.values.firstWhere(
              (e) => e.name == json['impact'],
              orElse: () => InsightImpact.info,
            )
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'impact': impact?.name,
      'metadata': metadata,
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
      title: (json['title'] ?? '').toString(),
      subtitle: (json['subtitle'] ?? '').toString(),
      timestamp: (json['timestamp'] ?? '').toString(),
      icon: (json['icon'] ?? 'info').toString(),
      color: (json['color'] ?? 'blue').toString(),
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

  const FinancialMetric({
    required this.label,
    required this.value,
    required this.status,
    this.trend,
  });

  factory FinancialMetric.fromJson(Map<String, dynamic> json) {
    return FinancialMetric(
      label: (json['label'] ?? '').toString(),
      value: (json['value'] ?? '').toString(),
      status: (json['status'] ?? 'neutral').toString(),
      trend: json['trend']?.toString(),
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
      label: (json['label'] ?? '').toString(),
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      color: json['color']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'value': value, 'color': color};
  }
}

class AnalyticsChartDataset {
  final String label;
  final List<double> data;
  final String? color;

  const AnalyticsChartDataset({
    required this.label,
    required this.data,
    this.color,
  });

  factory AnalyticsChartDataset.fromJson(Map<String, dynamic> json) {
    return AnalyticsChartDataset(
      label: json['label'] as String? ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'data': data, 'color': color};
  }
}

class AnalyticsChart {
  final String id;
  final String title;
  final ChartType type;
  final List<ChartDataPoint> dataPoints;
  final List<String> labels;
  final List<AnalyticsChartDataset> datasets;
  final List<ChartDataPoint>? forecastDataPoints;
  final String? reportId;

  AnalyticsChart({
    required this.id,
    required this.title,
    required this.type,
    this.dataPoints = const [],
    this.labels = const [],
    this.datasets = const [],
    this.forecastDataPoints,
    this.reportId,
  });

  factory AnalyticsChart.empty() {
    return AnalyticsChart(
      id: 'empty_${DateTime.now().millisecondsSinceEpoch}',
      title: '',
      type: ChartType.bar,
      dataPoints: [],
      labels: [],
      datasets: [],
    );
  }

  factory AnalyticsChart.fromJson(Map<String, dynamic> json) {
    final dataPointsRaw =
        json['dataPoints'] ??
        json['data_points'] as List<dynamic>? ??
        <dynamic>[];
    final forecastRaw =
        json['forecastDataPoints'] ??
        json['forecast_data_points'] as List<dynamic>?;
    final labelsRaw = json['labels'] as List<dynamic>? ?? [];
    final datasetsRaw = json['datasets'] as List<dynamic>? ?? [];

    return AnalyticsChart(
      id:
          json['id'] as String? ??
          'chart_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Analytics',
      type: ChartType.values.firstWhere(
        (e) => e.name == (json['type'] as String? ?? 'bar').toLowerCase(),
        orElse: () => ChartType.bar,
      ),
      dataPoints:
          (dataPointsRaw as List<dynamic>)
              .map((e) => ChartDataPoint.fromJson(e as Map<String, dynamic>))
              .toList(),
      labels: labelsRaw.map((e) => e.toString()).toList(),
      datasets:
          (datasetsRaw)
              .map(
                (e) =>
                    AnalyticsChartDataset.fromJson(e as Map<String, dynamic>),
              )
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
      'labels': labels,
      'datasets': datasets.map((d) => d.toJson()).toList(),
      'forecastDataPoints': forecastDataPoints?.map((p) => p.toJson()).toList(),
      'reportId': reportId,
    };
  }
}

class DashboardMetrics {
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<AnalyticsChart> charts;
  final List<DashboardInsight> insights;
  final bool isOfflineFallback;

  const DashboardMetrics({
    required this.kpis,
    required this.recentActivity,
    this.charts = const [],
    this.insights = const [],
    this.isOfflineFallback = false,
  });

  DashboardMetrics copyWith({
    List<KpiMetric>? kpis,
    List<DashboardActivity>? recentActivity,
    List<AnalyticsChart>? charts,
    List<DashboardInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return DashboardMetrics(
      kpis: kpis ?? this.kpis,
      recentActivity: recentActivity ?? this.recentActivity,
      charts: charts ?? this.charts,
      insights: insights ?? this.insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      kpis:
          (json['kpis'] as List?)
              ?.map((i) => KpiMetric.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      recentActivity:
          (json['recentActivity'] as List?)
              ?.map(
                (i) => DashboardActivity.fromJson(i as Map<String, dynamic>),
              )
              .toList() ??
          [],
      charts: json['charts'] != null
          ? (json['charts'] as List)
                .map((i) => AnalyticsChart.fromJson(i as Map<String, dynamic>))
                .toList()
          : [],
      insights:
          (json['insights'] as List?)
              ?.map((i) => DashboardInsight.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory DashboardMetrics.empty() {
    return DashboardMetrics(
      kpis: [],
      recentActivity: [],
      charts: [],
      insights: [],
      isOfflineFallback: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kpis': kpis.map((k) => k.toJson()).toList(),
      'recentActivity': recentActivity.map((a) => a.toJson()).toList(),
      'charts': charts.map((c) => c.toJson()).toList(),
      'insights': insights.map((i) => i.toJson()).toList(),
      'isOfflineFallback': isOfflineFallback,
    };
  }
}

extension DashboardMetricsX on DashboardMetrics {
  /// Looks up a KPI value by title. Returns the fallback if not found.
  String kpiValue(String title, [String fallback = '—']) {
    try {
      return kpis
          .firstWhere(
            (k) => k.title.toLowerCase().contains(title.toLowerCase()),
          )
          .value;
    } catch (_) {
      return fallback;
    }
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
      month: (json['month'] ?? '').toString(),
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      costs: (json['costs'] as num?)?.toDouble() ?? 0.0,
      patients: (json['patients'] as num?)?.toInt() ?? 0,
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
      quarterlyRevenue: (json['quarterlyRevenue'] as num?)?.toDouble() ?? 0.0,
      projectedGrowth: (json['projectedGrowth'] as num?)?.toDouble() ?? 0.0,
      marginEfficiency: (json['marginEfficiency'] as num?)?.toDouble() ?? 0.0,
      projectedAdmissions: (json['projectedAdmissions'] as num?)?.toInt() ?? 0,
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

class UniversalKpi extends KpiMetric {
  @override
  final String title;
  @override
  final String value;
  final double trendValue;
  @override
  final String status;

  UniversalKpi({
    required this.title,
    required this.value,
    this.trendValue = 0.0,
    required KpiStatus status,
  }) : status = status.name,
       super(title: title, value: value, status: status.name);

  factory UniversalKpi.fromJson(Map<String, dynamic> json) {
    return UniversalKpi(
      title: json['title'] as String? ?? '',
      value: json['value'] as String? ?? '0',
      trendValue: (json['trend'] as num?)?.toDouble() ?? 0.0,
      status: mapStatus(json['status'] as String?),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'trend': trendValue,
      'status': status,
    };
  }

  static KpiStatus mapStatus(String? legacyStatus) {
    if (legacyStatus == null) return KpiStatus.neutral;
    switch (legacyStatus.toUpperCase()) {
      case 'POSITIVE':
      case 'HEALTHY':
      case 'UP':
      case 'SUCCESS':
        return KpiStatus.positive;
      case 'NEGATIVE':
      case 'CRITICAL':
      case 'DOWN':
      case 'ERROR':
        return KpiStatus.negative;
      case 'WARNING':
        return KpiStatus.warning;
      default:
        return KpiStatus.neutral;
    }
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
