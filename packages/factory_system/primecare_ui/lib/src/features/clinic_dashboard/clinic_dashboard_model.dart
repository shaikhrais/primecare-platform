import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ClinicDashboardModel {
  final DashboardMetrics metrics;
  final List<DashboardActivity> recentActivity;

  const ClinicDashboardModel({
    required this.metrics,
    this.recentActivity = const [],
  });

  factory ClinicDashboardModel.empty() {
    return ClinicDashboardModel(metrics: DashboardMetrics.empty());
  }
}
