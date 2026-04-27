import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CeoDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const CeoDashboardModel({
    required this.metrics,
    this.insights = const [],
  });

  factory CeoDashboardModel.empty() {
    return CeoDashboardModel(
      metrics: DashboardMetrics.empty(),
    );
  }
}
