import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class VerificationHubModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const VerificationHubModel({required this.metrics, this.insights = const []});

  factory VerificationHubModel.empty() {
    return VerificationHubModel(metrics: DashboardMetrics.empty());
  }
}
