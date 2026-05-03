import 'package:primecare_ui/primecare_ui.dart';

class ClinicOperationsModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  ClinicOperationsModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  factory ClinicOperationsModel.empty({bool isOfflineFallback = false}) {
    return ClinicOperationsModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };

  factory ClinicOperationsModel.fromJson(Map<String, dynamic> json) =>
      ClinicOperationsModel(
        metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      );
}

// Add other models for clinic operations here
