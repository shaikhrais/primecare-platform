import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ComplianceHubModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const ComplianceHubModel({
    required this.metrics,
    this.insights = const [],
  });

  factory ComplianceHubModel.empty() {
    return ComplianceHubModel(
      metrics: DashboardMetrics.empty(),
    );
  }
}
