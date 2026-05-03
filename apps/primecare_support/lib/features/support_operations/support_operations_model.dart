import 'package:primecare_ui/primecare_ui.dart';

class SupportDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  SupportDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  SupportDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return SupportDashboardModel(
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

  factory SupportDashboardModel.fromJson(Map<String, dynamic> json) =>
      SupportDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      );

  factory SupportDashboardModel.empty({bool isOfflineFallback = false}) =>
      SupportDashboardModel(
        metrics: DashboardMetrics.empty(),
        insights: [],
        isOfflineFallback: isOfflineFallback,
      );
}
