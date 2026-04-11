import '../../../../config/offline_fallback_state.dart';
class TrainingCoordinatorDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<TrainingCoordinatorKpi> kpis;

  const TrainingCoordinatorDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class TrainingCoordinatorKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const TrainingCoordinatorKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class TrainingCoordinatorDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const TrainingCoordinatorDashboardKpi({this.title, this.value, this.trend, this.status});
}

class TrainingCoordinatorDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const TrainingCoordinatorDashboardActivity({this.title, this.subtitle, this.timestamp});
}
