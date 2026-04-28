import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ArchitecturalPlanningModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const ArchitecturalPlanningModel({
    required this.metrics,
    this.insights = const [],
  });

  factory ArchitecturalPlanningModel.empty() {
    return ArchitecturalPlanningModel(metrics: DashboardMetrics.empty());
  }
}
