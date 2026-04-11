import '../../../../config/offline_fallback_state.dart';
class TrainingDirectorDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<TrainingKpi> kpis;

  const TrainingDirectorDashboardViewModel({
    this.isOfflineFallback = false,required this.kpis, this.recentActivity = const []});
}

class TrainingKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const TrainingKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class TrainingDirectorDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const TrainingDirectorDashboardKpi({this.title, this.value, this.trend, this.status});
}

class TrainingDirectorDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const TrainingDirectorDashboardActivity({this.title, this.subtitle, this.timestamp});
}
