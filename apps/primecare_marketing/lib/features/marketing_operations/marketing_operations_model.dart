import 'package:primecare_ui/primecare_ui.dart';

class MarketingDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  MarketingDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  MarketingDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return MarketingDashboardModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };

  factory MarketingDashboardModel.fromJson(Map<String, dynamic> json) =>
      MarketingDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      );

  factory MarketingDashboardModel.empty({bool isOfflineFallback = false}) =>
      MarketingDashboardModel(
        metrics: DashboardMetrics.empty(),
        insights: [],
        isOfflineFallback: isOfflineFallback,
      );
}
