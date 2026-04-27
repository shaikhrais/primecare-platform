import 'package:primecare_adapters/primecare_adapters.dart';

class BizDevDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  BizDevDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  BizDevDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return BizDevDashboardModel(
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

  factory BizDevDashboardModel.fromJson(Map<String, dynamic> json) =>
      BizDevDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics']),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] ?? false,
      );

  factory BizDevDashboardModel.empty({bool isOfflineFallback = false}) =>
      BizDevDashboardModel(
        metrics: DashboardMetrics.empty(),
        insights: [],
        isOfflineFallback: isOfflineFallback,
      );
}
