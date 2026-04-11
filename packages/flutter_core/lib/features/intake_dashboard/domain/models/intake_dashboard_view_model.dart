import '../../../../config/offline_fallback_state.dart';
class IntakeDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<IntakeKpi> kpis;

  const IntakeDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class IntakeKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const IntakeKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class IntakeDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const IntakeDashboardKpi({this.title, this.value, this.trend, this.status});
}

class IntakeDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const IntakeDashboardActivity({this.title, this.subtitle, this.timestamp});
}
